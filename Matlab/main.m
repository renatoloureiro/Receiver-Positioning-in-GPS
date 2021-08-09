% SCT Project - Receiver positioning in GPS
%
% Authors:  Renato Loureiro, 89708
%           Santiago Rodriguez, 90360
    
fprintf('-------------------------------------\n')
fprintf('%s \n BEGIN SIMULATION  \n',datetime)
tic;

global deg dt t sigma_eure 
    sigma_eure = 7.1^2; 
    deg=pi/180;
    dt=0.5;     % sampling time       
    tfinal=490; % end time of simulation 
    fprintf(' \t Sampling time = %.3f', dt)
    fprintf(' s \n \t End time = %.3f s \n', tfinal)
    
    flag4=1;    % flag4 = 2 -> kalman filter PVA model
                % flag4 = 1 -> kalman filter PV model 
                % flag4 = 0 -> Least squares
    
for N=1:1 % número de iterações

    clearvars -except data_gps N deg dt t sigma_eure tfinal ...
         flag4 LS_iter kalman_iter 
    
    fprintf(' \t iteração %d \n', N)
    
    % auxiliar variables
    flag2=1; % for when to determine the new satellites to use
    flag3=1; % activate canyon scenario
    flag5=1; % if =1 use slow noise
    
    % 'PRN' -> struct with the info about the satellites
    PRN=leitura_sat_info();
    pos_A=referencia_A();

    % Create Dynamic matrix for PV model
    if flag4==1
        A_matrix = eye(8);
        for i=1:4
           A_matrix(i*2-1,i*2)=dt;
        end
        %Q = create_Q();
    elseif flag4==2
        beta=1;
        alpha=1;
        A_matrix = PVA_A_matrix(beta) % working
        Q = PVA_create_Q(beta,alfa); 
    end
    
    V = 0;
    for t=0:dt:tfinal
        
        if t>=335.1878 && flag3==1 %canyon scenario
            sat=canyon_scenario(flag3, PRN, pos_A,sat);
        end
        
       if flag2==1
           PRN=update_satellites_position(PRN,pos_A);
           % angle in degrees
           mask_angle=10; % in degrees   
           view_satellites=determine_view_satellites(PRN,pos_A,mask_angle);
           flag=0;
           number_of_satellites=4;
           sat=minimize_PDOP(view_satellites,pos_A,flag,number_of_satellites);
           flag2=0;
       end

       sat=update_satellites_position(sat,pos_A);

       % geração da trajetória do recetor no plano horizontal estabelacido
       % com a referencia A
       [recetor.x,recetor.y]=trajectory();
       aux=[[pos_A.ecef.x]; [pos_A.ecef.y];[pos_A.ecef.z]] + ...
           inv(pos_A.ECEF_ENU)*[recetor.x;recetor.y;0];
       recetor.ecef.x=aux(1);
       recetor.ecef.y=aux(2);
       recetor.ecef.z=aux(3);
   
       
       [pseudoranges,pseudo_noise]=cal_pseudoranges_with_noise(sat,recetor,flag5);

       % Condicoes iniciais
       if t==0 
           if flag4==1
              x = [recetor.ecef.x 0 recetor.ecef.y 0 recetor.ecef.z 0 0 0]';
              anterior=x;
              P = eye(8);
           elseif flag4==2
               
               
           else
               x = [recetor.ecef.x recetor.ecef.y recetor.ecef.z 0]'; 
           end
       end

       if flag4==1
           if flag5==1
                R = measurement_matrix([sat.elevation],sigma_eure);
           else
                R= sigma_eure*eye(length(sat));  
           end
                 

           [z, H]= observation_matrix(x, sat);
           K =kalman_value(P,H,R);
           
           x = estimate_update(x, z, pseudo_noise', K);
           P = covariance_update(P, K, H, R);

           Q = create_Q2(anterior, x);
           anterior=x;
           
           [x,P] = prediction(A_matrix,x,P,Q);
       elseif flag4==2
           
       else
          [H,pseudorange_estimated]=LS_observation_matrix(x, sat);
          delta_x=inv(H'*H)*H'*(pseudo_noise' - pseudorange_estimated');
          x=x + delta_x;
       end
       
       % save data to plot in each instant
        V=V+1;
        if exist('data_gps')
            data_gps=save_data_plot(flag4, V, data_gps, pos_A, recetor, x);
        else
            data_gps=save_data_plot(flag4, V, [], pos_A, recetor, x);
        end
    end

    if flag4==0
        data_gps=LS_data_velocities(data_gps);
    end 
    
    % dados para utilizar em processamento posterior (mean and var)
    if flag4==0
        LS_iter.x(N,:) = data_gps.LS.enu.x;
        LS_iter.y(N,:) = data_gps.LS.enu.y;
        LS_iter.z(N,:) = data_gps.LS.enu.z;
        LS_iter.vx(N,:) = data_gps.LS.enu.vx;
        LS_iter.vy(N,:) = data_gps.LS.enu.vy;
        LS_iter.vz(N,:) = data_gps.LS.enu.vz;
    else
        kalman_iter.x(N,:) = data_gps.kalman.enu.x;
        kalman_iter.y(N,:) = data_gps.kalman.enu.y;
        kalman_iter.z(N,:) = data_gps.kalman.enu.z;
        kalman_iter.vx(N,:) = data_gps.kalman.enu.vx;
        kalman_iter.vy(N,:) = data_gps.kalman.enu.vy;
        kalman_iter.vz(N,:) = data_gps.kalman.enu.vz;
    end
    
end

duration_simu=toc;
fprintf(' END OF SIMULATION \n \t Total duration = %.3f s \n',duration_simu)
clear duration_simu;
fprintf('-------------------------------------\n')


% write a file where the information can be ploted

