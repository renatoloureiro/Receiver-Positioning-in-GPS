function [H,pseudorange_estimate]=LS_observation_matrix(x, sat)

    for i=1:length(sat)
      r_sat = sqrt((sat(i).x - x(1))^2 + (sat(i).y - x(2))^2 + (sat(i).z - x(3))^2);
      pseudorange_estimate(i)=r_sat;
      H(i,1) = -(sat(i).x - x(1))/r_sat; 
      H(i,2) = -(sat(i).y - x(2))/r_sat;
      H(i,3) = -(sat(i).z - x(3))/r_sat;
      H(i,4) = 1; 
    end

end