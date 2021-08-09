function A_matrix=PVA_A_matrix(beta)
    global dt
    A_matrix = eye(11);
    
    A_matrix(1,2)=dt;
    A_matrix(4,5)=dt;
    A_matrix(7,8)=dt;
    A_matrix(10,11)=dt;
    
    A_matrix(3,3)=exp(-beta*dt);
    A_matrix(6,6)=exp(-beta*dt);
    A_matrix(9,9)=exp(-beta*dt);
    
    A_matrix(2,3)=(1/beta)*(1 - exp(-beta*dt));
    A_matrix(5,6)=(1/beta)*(1 - exp(-beta*dt));
    A_matrix(8,9)=(1/beta)*(1 - exp(-beta*dt));
    
    A_matrix(1,3)=(1/beta^2)*(exp(-beta*dt) + beta*dt -1);
    A_matrix(4,6)=(1/beta^2)*(exp(-beta*dt) + beta*dt -1);
    A_matrix(7,9)=(1/beta^2)*(exp(-beta*dt) + beta*dt -1);

end