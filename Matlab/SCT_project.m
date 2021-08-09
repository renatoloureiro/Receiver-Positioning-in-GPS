global deg
deg=pi/180;

fileID=fopen('almanac.txt','r');
aux=textscan(fileID,'%s','delimiter','\n');
% aux{1,1}(1) {'******** Week 91 almanac for PRN-01 ********'}
% aux{1,1}(2) {'ID:  01'}

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
    dt=0; % na simulação final este valor não deverá ser estático e deverá 
          % variar, pois representa o tempo passado desde o instante 
          % considerado no almanac
    M=aux4.Anom + n*dt;
    syms E
    eqn=M==E-aux4.Eccentricity*sin(E);
    aux4.E=double(vpasolve(eqn,E));
    
    % calculate argument of latitude, theta
    aux4.theta=atan((sqrt(1 - aux4.Eccentricity^2)*sin(aux4.E))/...
        (cos(aux4.E)-aux4.Eccentricity))+aux4.Perigee;
    
    % calculate longitude of the ascending node, gamma
    aux4.gamma=aux4.Ascen + aux4.Rate_Ascen*dt - (7.292115147*10^-5)*aux4.Time;
    
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

% remove auxiliar variables
    clear aux auxaxis equal4 n M
    fclose(fileID);
    
% see the 3d plot of the satellite locations
scatter3([PRN.x],[PRN.y],[PRN.z]) 
%%
%next step: define a position of the body to track and determine which
%satellites are in view to then select which ones need to be considered to
%minimize the GDOP parameter (this may be solved using a iterative
%algorithm)

% Initial position: A
pos.N=39;   % 39 degrees North - latitude of the receiver
pos.W=8;    % 8 degrees West - longitude of the receiver
pos.h=3500;     % h=3500m
% determinar a posição xyz do ponto A
wgs84 = wgs84Ellipsoid;
[pos.ecef.x,pos.ecef.y,pos.ecef.z] = geodetic2ecef(wgs84,pos.N,pos.W,pos.h);
% pos.x=10^6; % just an example
% pos.y=10^6;
% pos.z=10^6;
%%
% usar o ponto A como referencia
ECEF_ENU=[-sin(pos.W), cos(pos.W), 0;
    -sin(pos.N)*cos(pos.W), -sin(pos.N)*sin(pos.W), cos(pos.N);
    cos(pos.N)*cos(pos.W), cos(pos.N)*sin(pos.W), sin(pos.N)];

for i=1:length(PRN) % enu: position relative to the reference position
    PRN(i).enu=ECEF_ENU*[PRN(i).x-pos.ecef.x;...
        PRN(i).y-pos.ecef.y;PRN(i).z-pos.ecef.z];
end

% calculate the elevation of each satellite
j=1;
for i=1:length(PRN)
   PRN(i).elevation=asin(PRN(i).enu(3)/sqrt(PRN(i).enu(1)^2 + ...
       PRN(i).enu(2)^2 + PRN(i).enu(3)^2));
   if PRN(i).elevation>10*deg
        view_index(j)=i;
        j=j+1;
   end
end

% seems to be working
for i=view_index
    scatter3([PRN(i).x],[PRN(i).y],[PRN(i).z])
    hold on
end

% A structure only having the satellites in view
for i=1:length(view_index)
   view_satellites(i)=PRN(view_index(i));
end

%% Determinação do conjunto de satelites que minimiza o PDOP
% PDOP=sqrt(h11 + h22 + h33)
% (H'H)^-1 -> onde buscar os valores anteriores
% utilizar posições no ecef (referencial da terra)
constraint(1)=1; % signals if there is a number of satellites to choose
constraint(2)=4;
IntCon = 1:length(view_satellites);
options = optimoptions('ga');
options = optimoptions(options,'MaxGenerations', 20);
options = optimoptions(options,'MaxStallGenerations', inf);
options = optimoptions(options,'FunctionTolerance', 0);
options = optimoptions(options,'ConstraintTolerance', 0);
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'PlotFcn', { @gaplotbestf });
options = optimoptions(options,'MutationFcn',{@mutationgaussian,1,.5});
[x,fval,exitflag,output,population,score] = ...
ga(@(x)cost_funct(x,view_satellites,pos, constraint),length(view_satellites),[],[],[],[],...
zeros(1,length(view_satellites)),...
ones(1,length(view_satellites)),[],IntCon,options);
disp(x); % displays the binary sequence of which satellite is working

% NOTE: como o problema é discreto e existe um gradient descent possivel 
% de aplicar, pode acontecer que às vezes poderá dar combinações diferentes
% de satelites, mas a diferença é diminuta
% para o caso de 4 satelites é 001010010010 -> PDOP=2.54512

%% only get the satellites to work with
j=1;
for i=1:length(x)
    if x(i)==1
        sat(j)=view_satellites(i);
        j=j+1;
    end
end







