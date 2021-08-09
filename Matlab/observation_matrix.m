function [z, H]= observation_matrix(x, sat)

    H = zeros(length(sat), 8); % 8 por causa do modelo PV, caso for P ou PVA é diferente
    h = zeros(length(sat), 1);

    for i=1:length(sat)
        r_sat = sqrt((sat(i).x - x(1))^2 + (sat(i).y - x(3))^2 + (sat(i).z - x(5))^2);
        H(i,1) = -(sat(i).x - x(1))/r_sat; 
        H(i,3) = -(sat(i).y - x(3))/r_sat;
        H(i,5) = -(sat(i).z - x(5))/r_sat;
        H(i,7) = 1;
        h(i) = r_sat + x(7); %Talvez ainda falta o x7
    end

    z = h;
end