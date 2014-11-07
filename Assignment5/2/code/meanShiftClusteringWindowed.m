function [Iterations,Clustered] = meanShiftClusteringWindowed(x,Data,h,invSigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
   
    [Iterations, Clustered] = convergeForPoint(x,h,Data,invSigma);
   
  
end

function [iteration, shiftedPoint] = convergeForPoint(x,h,Data,invSigma)
   
    firstIteration=true;
    threshold  = 0.01;
    x_prev = x;
    iteration = 0;
    
    while(firstIteration || norm(x_prev - x)/norm(x) > threshold)
        firstIteration = false;
        iteration = iteration+1;
        x_prev = x;
        %x1 = updateX(x,Data,Sigma);
       
        new_Data = Data(round(x(1))-h: round(x(1))+h,round(x(2))-h:round(x(2))+h,:);
        new_Data = reshape(new_Data,size(new_Data,1)*size(new_Data,2),size(Data,3));
        x = updateX2(x,new_Data',invSigma);
    end
    shiftedPoint  = x;
end

function [x_new] = updateX2(x,Data,sigmaInverse)
    X=x(:,ones(1,size(Data,2)));
    Y = X-Data;
    %sigmaInverse = inv(Sigma);
    %K = exp(-sqrt((Y'*sigmaInverse*Y)/2))/(sqrt(2*pi)*det(Sigma));
    %t = diag(K)';
    A = diag(sigmaInverse);
    A = A(:, ones(1, size(Data,2)));
    
    K = sum(Y'.*(A.*Y)',2);
    t =  (exp(-(K'/2))/(sqrt(2*pi)))*det(sigmaInverse);
    
    T = t(ones(size(Data,1),1),:);
    %x_new = exp(-sqrt(sum(T.*Data,2)));
    x_new = sum(T.*Data,2);
    z_new = sum(t);
    x_new = x_new/z_new;
end