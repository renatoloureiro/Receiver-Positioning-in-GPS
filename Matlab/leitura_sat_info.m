function PRN=leitura_sat_info()

fileID=fopen('almanac.txt','r');
aux=textscan(fileID,'%s','delimiter','\n');

j=1;
for i=1:15:length(aux{1,1})
    
    [aux4.ID]=sscanf(string(aux{1,1}(i+1)),'ID: %d');
    [aux4.health]=sscanf(string(aux{1,1}(i+2)),'Health:  %d');
    [aux4.Eccentricity]=sscanf(string(aux{1,1}(i+3)),'Eccentricity: %f');
    [aux4.Time]=sscanf(string(aux{1,1}(i+4)),'Time of Applicability(s): %f');
    [aux4.Inclination]=sscanf(string(aux{1,1}(i+5)),'Orbital Inclination(rad):  %f');
    [aux4.Rate_Ascen]=sscanf(string(aux{1,1}(i+6)),'Rate of Right Ascen(r/s): %f');
    [aux4.SQRT]=sscanf(string(aux{1,1}(i+7)),'SQRT(A)  (m 1/2):  %f');
    [aux4.Ascen]=sscanf(string(aux{1,1}(i+8)),'Right Ascen at Week(rad):  %f');
    [aux4.Perigee]=sscanf(string(aux{1,1}(i+9)),'Argument of Perigee(rad):  %f');
    [aux4.Anom]=sscanf(string(aux{1,1}(i+10)),'Mean Anom(rad):  %f');
    [aux4.Af0]=sscanf(string(aux{1,1}(i+11)),'Af0(s):  %f');
    [aux4.Af1]=sscanf(string(aux{1,1}(i+12)),'Af1(s/s):  %f');
    [aux4.week]=sscanf(string(aux{1,1}(1+13)),'week: %d');
    
    n=sqrt((3.986005*10^14)/(aux4.SQRT^6));
    dt_aux=0; % na simulação final este valor não deverá ser estático e deverá 
          % variar, pois representa o tempo passado desde o instante 
          % considerado no almanac
    M=aux4.Anom  + n*dt_aux;
    syms E
    eqn=M==E-aux4.Eccentricity*sin(E);
    aux4.E=double(vpasolve(eqn,E));
    
    % calculate argument of latitude, theta
    aux4.theta=atan((sqrt(1 - aux4.Eccentricity^2)*sin(aux4.E))/...
        (cos(aux4.E)-aux4.Eccentricity))+aux4.Perigee;
    
    % calculate longitude of the ascending node, gamma
    aux4.gamma=aux4.Ascen + aux4.Rate_Ascen*dt_aux - (7.292115147*10^-5)*aux4.Time;
    
    % calculate R
    aux4.R=((aux4.SQRT)^2)*(1-aux4.Eccentricity*cos(aux4.E));
    
    % calculate x, y & z
    aux4.x=aux4.R*(cos(aux4.theta)*cos(aux4.gamma)-sin(aux4.theta)*...
        sin(aux4.gamma)*cos(aux4.Inclination));
    aux4.y=aux4.R*(cos(aux4.theta)*sin(aux4.gamma)+sin(aux4.theta)*...
        cos(aux4.gamma)*cos(aux4.Inclination));
    aux4.z=aux4.R*(sin(aux4.theta)*sin(aux4.Inclination));
   
    PRN(j)=aux4; % struct with the satellite info
    j=j+1;
end

    clear aux auxaxis equal4 n M
    fclose(fileID);

end