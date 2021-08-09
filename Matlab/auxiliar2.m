
for i=1:length(LS_iter.x(1,:))
    case6.E_x(i)= mean(LS_iter.x(:,i));
    case6.Var_x(i)= var(LS_iter.x(:,i));
    
    case6.E_y(i)= mean(LS_iter.y(:,i));
    case6.Var_y(i)= var(LS_iter.y(:,i));
    
    case6.E_z(i)= mean(LS_iter.z(:,i));
    case6.Var_z(i)= var(LS_iter.z(:,i));
    
    case6.E_vx(i)= mean(LS_iter.vx(:,i));
    case6.Var_vx(i)= var(LS_iter.vx(:,i));
    
    case6.E_vy(i)= mean(LS_iter.vy(:,i));
    case6.Var_vy(i)= var(LS_iter.vy(:,i));
    
    case6.E_vz(i)= mean(LS_iter.vz(:,i));
    case6.Var_vz(i)= var(LS_iter.vz(:,i));
    
end