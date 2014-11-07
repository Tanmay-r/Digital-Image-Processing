function [ KTextons ] = generateTextons(Database,image,K)

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    %apply K-means here

    texton = extractTextonC(image,Database);
    textonVector = zeros(size(texton,1)*size(texton,2), size(texton,3));
    for i=1:size(texton,3)
        temp= texton(:,:,i);
        textonVector(:,i)  = temp(:);
    end
    
    Lx=sqrt(sum(textonVector.^2,2)); %row norm
    Lx=log(1+(Lx/0.03))./Lx; 
    textonVector=textonVector.*Lx(:,ones(1,size(textonVector,2)));
    
    %%%%%%%%%%%%%%%%%%%%%%%% Farthest Point Clustering %%%%%%%%%%%%%%%%%%%%%%%
    textonVectorCol=textonVector';
    dim1=size(textonVectorCol,1);
    dim2=size(textonVectorCol,2);
    
    initialKmeans = zeros (dim1, K);
    initialKmeans(:,1)= textonVectorCol(:,randi(dim2));
    
    dist=zeros(K,dim2);

    for i=1:K-1,
        diff=textonVectorCol-initialKmeans(:,i*ones(1,dim2));
        dist(i,:)=sum(diff.^2);  
        [~, maxind]=max(min(dist(1:i,:)));
        initialKmeans(:,i+1)=textonVectorCol(:,maxind);
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [~, KTextons] = kmeans(textonVector,K,'start', initialKmeans');
  
end

