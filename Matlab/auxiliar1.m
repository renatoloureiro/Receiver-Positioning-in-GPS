
for i=1:length(kalman_iter.x(1,:))
    case18.E_x(i)= mean(kalman_iter.x(:,i));
    case18.Var_x(i)= var(kalman_iter.x(:,i));
    
    case18.E_y(i)= mean(kalman_iter.y(:,i));
    case18.Var_y(i)= var(kalman_iter.y(:,i));
    
    case18.E_z(i)= mean(kalman_iter.z(:,i));
    case18.Var_z(i)= var(kalman_iter.z(:,i));
    
    case18.E_vx(i)= mean(kalman_iter.vx(:,i));
    case18.Var_vx(i)= var(kalman_iter.vx(:,i));
    
    case18.E_vy(i)= mean(kalman_iter.vy(:,i));
    case18.Var_vy(i)= var(kalman_iter.vy(:,i));
    
    case18.E_vz(i)= mean(kalman_iter.vz(:,i));
    case18.Var_vz(i)= var(kalman_iter.vz(:,i));
    
end