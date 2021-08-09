% generates the trajectory in the horizontal plane considering the point A
% as the reference of the horizontal plane
% the input is the time in which the simulation is at


function [x,y]=trajectory()
    global t
 % maybe add a trajectory ID to know in which trajectory segment the
 % receiver

v0=sqrt(2*20*10^3 + 75^2);
R1=5*10^3;
R2=3*10^3;
w0=v0/R1;
w1=v0/R2;
t1=25*73^(1/2) - 75;
t2=pi/(2*w0);
t3=(20*10^3)/v0;
t4=(6*pi)/(4*w1);
t5=(36*10^3)/v0;
% AB
if t<= t1
    x=75*t + 0.5*t^2;
    y=0;
elseif t<=t1 + t2
% BCt5

    theta=w0*(t-t1);
    x=20*10^3 + R1*sin(theta);
    y=R1*(1-cos(theta));
elseif t<=t1 + t2 +t3
% CD
    y=R1 + v0*(t - t1 - t2);
    x=20*10^3 + R1;
elseif t<=t1 + t2 + t3 + t4 
% DE    
    theta=w1*(t -t1 - t2 - t3);
    x=(20*10^3 + R1) - R2*(1- cos(theta));
    y=(20*10^3 + R1) + R2*sin(theta);
elseif t<=t1 + t2 + t3 + t4 + t5
% EF
    x=(20*10^3  + R1 - R2) + v0*(t - t1 -t2 -t3 -t4);
    y=20*10^3  + R1 - R2;
elseif t>t1 + t2 + t3 + t4 + t5
    x=(20*10^3  + R1 - R2) + v0*(t5);
    y=20*10^3  + R1 - R2;
end

end