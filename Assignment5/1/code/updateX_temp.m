function [x_new] = updateX_temp(x,Data,Sigma)
    Y = cellfun(@(x1)(kernel(x,x1,Sigma)*[x1;1]), num2cell(Data,1), 'UniformOutput', false);
    Y = cell2mat(Y);
    X = Y(1:end-1,:);
    Z = Y(end,:);
    %x_new = sum(X,2)/sum(Z);
    
    x_new = sum(X,2);
end


function [val] = kernel(x1,x2,Sigma)
    sigmaInverse = inv(Sigma);
    %assert(Sigma*sigmaInverse == eye(size(Sigma)), 'inverse not computed correctly');
    %Sigma*sigmaInverse -eye(size(Sigma))
    %size(x1)
    val =exp(-sqrt((x1-x2)'*sigmaInverse*(x1-x2)/2))/(sqrt(2*pi)*det(Sigma));
    %val =exp(-sqrt((x1-x2)'*sigmaInverse*(x1-x2)));
    %val = (x1-x2)'*sigmaInverse*(x1-x2);
end

