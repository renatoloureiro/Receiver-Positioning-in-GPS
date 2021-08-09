function ref_A=referencia_A()

    ref_A.N=39;     % 39 degrees North - latitude of the receiver
    ref_A.W=8;      % 8 degrees West - longitude of the receiver
    ref_A.h=3500;   % h=3500m
    
    % determinar a posição xyz do ponto A
    wgs84 = wgs84Ellipsoid;
    [ref_A.ecef.x,ref_A.ecef.y,ref_A.ecef.z] = geodetic2ecef(wgs84,...
        ref_A.N,ref_A.W,ref_A.h);
    
    ref_A.ECEF_ENU=[-sin(ref_A.W), cos(ref_A.W), 0;
    -sin(ref_A.N)*cos(ref_A.W), -sin(ref_A.N)*sin(ref_A.W), cos(ref_A.N);
    cos(ref_A.N)*cos(ref_A.W), cos(ref_A.N)*sin(ref_A.W), sin(ref_A.N)];
    
end