function [Clustered] = meanShiftClustering(Data,Sigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    m = size(Data,2);
    Clustered = zeros(size(Data));
    for i=1:m
        Clustered(:,i) = convergeForPoint(Data(:,i), Data,Sigma);
        i
    end
end

function [shiftedPoint] = convergeForPoint(x,Data,Sigma)
   
    firstIteration=true;
    threshold  = 0.01;
    x_prev = x;
    curr_px=functionValue(x,Data,Sigma);    
    prev_px=0;
    while(firstIteration || ((norm(curr_px - prev_px)/norm(curr_px) > threshold) && norm(x_prev - x)/norm(x) > threshold))
        firstIteration = false;
        temp1 = x_prev;
        temp2 = prev_px;
        prev_px = curr_px;
        x_prev = x;
        x = updateX(x,Data,Sigma);
        curr_px = functionValue(x,Data,Sigma);
        if(prev_px > curr_px)
            %'bigger'
            %curr_px
            x = x_prev;
            x_prev  =temp1;
            curr_px = prev_px;   
            prev_px = temp2;
            break;
        end    
        curr_px;
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


function [val] = kernel(x1,x2,Sigma)
    sigmaInverse = inv(Sigma);
    %assert(Sigma*sigmaInverse == eye(size(Sigma)), 'inverse not computed correctly');
    %Sigma*sigmaInverse -eye(size(Sigma))
    %size(x1)
pl    val =exp(-sqrt((x1-x2)'*sigmaInverse*(x1-x2)/2))/(sqrt(2*pi)*det(Sigma));
end

