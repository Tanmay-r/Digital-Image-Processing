function [Iterations,Clustered] = meanShiftClustering(Data,Sigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    m = size(Data,2);
    invSigma = inv(Sigma);
    Iterations = zeros(size(Data,2),1);
    Clustered = zeros(size(Data));
    A = diag(invSigma);
    A = A(:, ones(1, size(Data, 2)));
    for i=1:m
        [Iterations(i), Clustered(:,i)] = convergeForPoint(Data(:,i), Data,Sigma,A);
    end
    'minimum'
    min(Iterations)
    'maxmimum'
    max(Iterations)
    'average'
    mean(Iterations)
end

function [iteration, shiftedPoint] = convergeForPoint(x,Data,Sigma,A)
   
    firstIteration=true;
    threshold  = 0.001;
    x_prev = x;
    iteration = 0;
    while(firstIteration || norm(x_prev - x)/norm(x) > threshold)
        firstIteration = false;
        iteration = iteration+1;
        x_prev = x;
        %x1 = updateX(x,Data,Sigma);
        x = updateX2(x,Data,Sigma,A);
    end
    shiftedPoint  = x;
end


function [x_new] = updateX2(x,Data,Sigma, A)
    X=x(:,ones(1,size(Data,2)));
    Y = X-Data;
    %sigmaInverse = inv(Sigma);
    %K = exp(-sqrt((Y'*sigmaInverse*Y)/2))/(sqrt(2*pi)*det(Sigma));
    %t = diag(K)';
    
    K = sum(Y'.*(A.*Y)',2);
    
    t =  exp(-sqrt((K'/2)))/(sqrt(2*pi)*det(Sigma));
    
    T = t(ones(size(Data,1),1),:);
    %x_new = exp(-sqrt(sum(T.*Data,2)));
    x_new = sum(T.*Data,2);
    z_new = sum(t);
    x_new = x_new/z_new;
end