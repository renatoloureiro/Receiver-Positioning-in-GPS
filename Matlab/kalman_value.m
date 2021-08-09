function K=kalman_value(P,H,R)    
    K=P*H'*pinv(H*P*H' + R);
end