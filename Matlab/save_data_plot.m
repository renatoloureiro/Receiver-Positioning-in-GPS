function data_gps=save_data_plot(flag4, V, data_gps, pos_A, recetor, x)

data_gps.receiver_orig.ecef.x(V) = recetor.ecef.x;
data_gps.receiver_orig.ecef.y(V) = recetor.ecef.x;
data_gps.receiver_orig.ecef.z(V) = recetor.ecef.x;

data_gps.receiver_orig.enu.x(V) = recetor.x;
data_gps.receiver_orig.enu.y(V) = recetor.y;
data_gps.receiver_orig.enu.z(V) = 0;

if flag4==1 % kalman filter case

    % coordenadas ecef que proveem do algoritmo de Kalman
%     data_gps.kalman.ecef.x(V) = x(1);
%     data_gps.kalman.ecef.y(V) = x(3);
%     data_gps.kalman.ecef.z(V) = x(5);
%     data_gps.kalman.ecef.vx(V) = x(2);
%     data_gps.kalman.ecef.vy(V) = x(4);
%     data_gps.kalman.ecef.vz(V) = x(6);
    
    aux1 = pos_A.ECEF_ENU*[x(1)-pos_A.ecef.x;x(3)-pos_A.ecef.y; ...
    x(5) - pos_A.ecef.z];

    data_gps.kalman.enu.x(V) = aux1(1); 
    data_gps.kalman.enu.y(V) = aux1(2);
    data_gps.kalman.enu.z(V) = aux1(3);

    aux1=pos_A.ECEF_ENU*[x(2); x(4); x(6)]; 
    data_gps.kalman.enu.vx(V) = aux1(1);
    data_gps.kalman.enu.vy(V) = aux1(2);
    data_gps.kalman.enu.vz(V) = aux1(3);    
else
    data_gps.LS.ecef.x(V) = x(1);
    data_gps.LS.ecef.y(V) = x(2);
    data_gps.LS.ecef.z(V) = x(3);
    
    aux1 = pos_A.ECEF_ENU*[x(1)-pos_A.ecef.x;x(2)-pos_A.ecef.y; ...
    x(3) - pos_A.ecef.z];
    data_gps.LS.enu.x(V) = aux1(1); 
    data_gps.LS.enu.y(V) = aux1(2);
    data_gps.LS.enu.z(V) = aux1(3);
    
    % as velocidades são calculadas posteriormente
    
end