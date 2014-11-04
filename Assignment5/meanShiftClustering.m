function [Clustered] = meanShiftClustering(Data,Sigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    m = size(Data,2);
    invSigma = inv(Sigma);
    Clustered = zeros(size(Data));
    for i=1:m
        Clustered(:,i) = convergeForPoint(Data(:,i), Data,Sigma,invSigma);
        
    end
end

function [shiftedPoint] = convergeForPoint(x,Data,Sigma,invSigma)
   
    firstIteration=true;
    threshold  = 0.001;
    x_prev = x;
    while(firstIteration || norm(x_prev - x)/norm(x) > threshold)
        firstIteration = false;
        x_prev = x;
        %x1 = updateX(x,Data,Sigma);
        x = updateX2(x,Data,Sigma,invSigma);
    end
    shiftedPoint  = x;
end

function [px] = functionValue(x,Data,Sigma)

    Y = cellfun(@(x1)(kernel(x,x1,Sigma)), num2cell(Data,1), 'UniformOutput', true);
    px = sum(Y)/size(Data,2);
    
end
% 
% function [grad] = gradFunction(x,Data)
%         Y = cellfun(@(x1)(kernel(x,x1,sigma)*), num2cell(Data,1), 'UniformOutput', true);
% 
% 
% end

function [x_new] = updateX(x,Data,Sigma)
    Y = cellfun(@(x1)(kernel(x,x1,Sigma)*[x1;1]), num2cell(Data,1), 'UniformOutput', false);
    Y = cell2mat(Y);
    X = Y(1:end-1,:);
    Z = Y(end,:);
    x_new = sum(X,2)/sum(Z);
    
end

function [x_new] = updateX2(x,Data,Sigma, sigmaInverse)
    X=x(:,ones(1,size(Data,2)));
    Y = X-Data;
    %sigmaInverse = inv(Sigma);
    %K = exp(-sqrt((Y'*sigmaInverse*Y)/2))/(sqrt(2*pi)*det(Sigma));
    %t = diag(K)';
    
    K = Y'*sigmaInverse*Y;
    t =  exp(-sqrt((diag(K)'/2)))/(sqrt(2*pi)*det(Sigma));
    
    T = t(ones(size(Data,1),1),:);
    %x_new = exp(-sqrt(sum(T.*Data,2)));
    x_new = sum(T.*Data,2);
    z_new = sum(t);
    x_new = x_new/z_new;
end


function [val] = kernel(x1,x2,Sigma)
    sigmaInverse = inv(Sigma);
    %assert(Sigma*sigmaInverse == eye(size(Sigma)), 'inverse not computed correctly');
    %Sigma*sigmaInverse -eye(size(Sigma))
    %size(x1)
    val =exp(-sqrt((x1-x2)'*sigmaInverse*(x1-x2)/2))/(sqrt(2*pi)*det(Sigma));
end

