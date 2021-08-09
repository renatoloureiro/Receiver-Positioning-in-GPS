function Q=create_Q()

    global dt
    Q = zeros(8);
    c=3e8;
    q_phi = 2e-19/2; % quartz temperature-compensated oscillator
    q_f = 2 * pi^2 * 2e-20;
    q_c = 0.1; % Still to confirm
    
    for index = 1:2:6
        Q(index, index) = q_c * dt^3/3;
        Q(index, index+1) = q_c*dt^2/2; 
        Q(index+1, index) = Q(index, index+1);
        Q(index+1, index+1) = q_c*dt;
    end
    
    Q(7,7)= (q_phi + q_f*dt^3/3)*c^2;
    Q(7,8) = (q_f*dt^2/2)*c^2;
    Q(8,7) = Q(7,8);
    Q(8,8) = q_f*dt*c^2;
    
    
end