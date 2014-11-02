function [ hist ] = generateHist(Database,image,textonDatabase)

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    %apply K-means here

    hist = zeros(1,size(textonDatabase,1));
    texton = extractTextonC(image,Database);
    textonVector = zeros(size(texton,1)*size(texton,2), size(texton,3));
    for i=1:size(texton,3)
        temp= texton(:,:,i);
        textonVector(:,i)  = temp(:);
    end
    
    
    Lx=sqrt(sum(textonVector.^2,2)); %row norm
    Lx=log(1+(Lx/0.03))./Lx; 
    textonVector=textonVector.*Lx(:,ones(1,size(textonVector,2)));
    
    
    for i=1:size(textonVector,1)
        temp=textonVector(i,:)';
        diff=textonDatabase'- temp(:,ones(1,size(textonDatabase,1)));
        [~,minIndex]=min(sum(diff.^2,1));
        hist(1,minIndex)=hist(1,minIndex)+1;
        
    end  
end

