function [x2,P2]=prediction(A,x1,P1,Q)
    x2=A*x1;
    P2=A*P1*A' + Q;
end