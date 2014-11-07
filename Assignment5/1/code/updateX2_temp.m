function [x_new] = updateX2_temp(x,Data,Sigma)
    X=x(:,ones(1,size(Data,2)))
    Y = X-Data;
    sigmaInverse = inv(Sigma);
    K = exp(-sqrt((Y'*sigmaInverse*Y)/2))/(sqrt(2*pi)*det(Sigma));
    t = diag(K)';
    T = t(ones(size(Data,1),1),:);
    %x_new = exp(-sqrt(sum(T.*Data,2)));
    x_new = sum(T.*Data,2);
    z_new = sum(t);
    x_new = x_new/z_new;
end