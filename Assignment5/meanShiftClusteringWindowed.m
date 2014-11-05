function [Iterations,Clustered] = meanShiftClusteringWindowed(x,Data,h,invSigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
     [Iterations, Clustered] = convergeForPoint(x,Data,invSigma,h);
   
  
end

function [iteration, shiftedPoint] = convergeForPoint(x,h,Data,invSigma)
   
    firstIteration=true;
    threshold  = 0.001;
    x_prev = x;
    iteration = 0;
    while(firstIteration || norm(x_prev - x)/norm(x) > threshold)
        firstIteration = false;
        iteration = iteration+1;
        x_prev = x;
        %x1 = updateX(x,Data,Sigma);
        x = updateX2(x,Data(x(1)-h: x(1)+h,x(2)-h:x(2)+h),invSigma);
    end
    shiftedPoint  = x;
end

function [x_new] = updateX2(x,Data,sigmaInverse)
    X=x(:,ones(1,size(Data,2)));
    Y = X-Data;
    %sigmaInverse = inv(Sigma);
    %K = exp(-sqrt((Y'*sigmaInverse*Y)/2))/(sqrt(2*pi)*det(Sigma));
    %t = diag(K)';
    
    K = Y'*sigmaInverse*Y;
    t =  (exp(-sqrt((diag(K)'/2)))/(sqrt(2*pi)))*det(sigmaInverse);
    
    T = t(ones(size(Data,1),1),:);
    %x_new = exp(-sqrt(sum(T.*Data,2)));
    x_new = sum(T.*Data,2);
    z_new = sum(t);
    x_new = x_new/z_new;
end