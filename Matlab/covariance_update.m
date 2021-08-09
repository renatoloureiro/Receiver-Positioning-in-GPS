function P_upd = covariance_update(P, K, H, R)

Id=eye(size(K,1), size(H,2));

P_upd = (Id-K*H)*P*(Id-K*H)'+ K*R*K';

end