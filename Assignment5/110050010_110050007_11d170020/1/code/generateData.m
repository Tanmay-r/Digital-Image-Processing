function [ Data ] = generateData(n,sigma1,sigma2)

%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    Data = zeros(2,n);
    for i=1:n
        Data(:,i) = getSample(sigma1,sigma2);
    end
    
    
% 
%     [X,Y] = meshgrid(-3:0.1:3,-3:0.1:3);
%     %X = X(:);
%     %Y = Y(:);
%     Z = 0.5*exp(-((X-0).^2+(Y-0).^2)/(2*sigma1^2))/sqrt(2*pi*sigma1^2); %+ 0.5*exp(-((X-1).^2+(Y-1).^2)/(2*sigma2^2))/(2*pi*sigma2^2); % pdf function 
%     size(Z)
%     surf(X,Y,Z); % generate surface plot
%     shading interp;
    
end

function [point] = getSample(sigma1,sigma2)
    x1 = mvnrnd([0 0],sigma1); % sample from 1st Gaussian
    x2 = mvnrnd([5 5],sigma2); % sample from 2nd Gaussian
    a = rand(1); % samples from a uniform random distribution
    if (a <= 0.4) 
        x = x1;
    else
        x = x2;
    end
    point = x;

end