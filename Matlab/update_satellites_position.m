function PRN=update_satellites_position(PRN,pos)
    % na simulação final este valor não deverá ser estático e deverá 
    % variar, pois representa o tempo passado desde o instante 
    % considerado no almanac
    global t
    
    for i=1:length(PRN)
        n=sqrt((3.986005*10^14)/(PRN(i).SQRT^6));
        M=PRN(i).Anom + n*t;
        
        
       % syms E
       % eqn=M==E-PRN(i).Eccentricity*sin(E);
       % PRN(i).E=double(vpasolve(eqn,E));
        
        E=0;
        while true
            A=E - (E - PRN(i).Eccentricity*sin(E) - M)/...
                (1 - PRN(i).Eccentricity*cos(E));
           if abs(A-E)<0.001
               E=A;
               break
           end
           E=A; 
        end
        
        PRN(i).E=E;
        
        % calculate argument of latitude, theta
        PRN(i).theta=atan((sqrt(1 - PRN(i).Eccentricity^2)*sin(PRN(i).E))/...
            (cos(PRN(i).E)-PRN(i).Eccentricity))+PRN(i).Perigee;

        % calculate longitude of the ascending node, gamma
        PRN(i).gamma=PRN(i).Ascen + PRN(i).Rate_Ascen*t - (7.292115147*10^-5)*PRN(i).Time;

        % calculate R
        PRN(i).R=((PRN(i).SQRT)^2)*(1-PRN(i).Eccentricity*cos(PRN(i).E));

        % calculate x, y & z
        PRN(i).x=PRN(i).R*(cos(PRN(i).theta)*cos(PRN(i).gamma)-sin(PRN(i).theta)*...
            sin(PRN(i).gamma)*cos(PRN(i).Inclination));
        PRN(i).y=PRN(i).R*(cos(PRN(i).theta)*sin(PRN(i).gamma)+sin(PRN(i).theta)*...
            cos(PRN(i).gamma)*cos(PRN(i).Inclination));
        PRN(i).z=PRN(i).R*(sin(PRN(i).theta)*sin(PRN(i).Inclination));

        
        PRN(i).enu=pos.ECEF_ENU*[PRN(i).x-pos.ecef.x;...
            PRN(i).y-pos.ecef.y;PRN(i).z-pos.ecef.z];
        
        PRN(i).elevation=asin(PRN(i).enu(3)/sqrt(PRN(i).enu(1)^2 + ...
           PRN(i).enu(2)^2 + PRN(i).enu(3)^2));
       
    end

end