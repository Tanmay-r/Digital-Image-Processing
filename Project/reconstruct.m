function [ new_image ] = reconstruct(Database,image,S,K)

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    %apply K-means here
    texton = extractTextonC(image,Database,S);
    [Idx, KTextons] = kmeans(texton,K);
   
    %size(texton,2) = no of pixels (S+1)*(S+1) means
    %size(texton,1) = no of Filters
    %size(F,1) = 49*49;
    %size(F,2) = no_of_filters_in_filter_bank;
    
    F = zeros(size(Database,1)*size(Database,2),size(Database,3));
    
    for i=1:size(Database,3)
        A = Database(:,:,i);
        F(:,i) = A(:);
    end
    pxTexton = zeros(size(F,1),size(KTextons,1));
    size(KTextons)
    size(pxTexton)
    'asdlfk'
    size(F)
    %F*P = T
    %F = 48X2401 
    %P = 2401X1
    %T = 48X1
    
    for i=1:size(KTextons,1)
        
        pxTexton(:,i) = F'\KTextons(i,:)';
        %size(F'\KTextons(i,:)')
        
        
    end
    
    
    new_image = zeros(S+1,S+1);
    
    for i=1:S+1
        for j =1:S+1
            new_image(i,j) = pxTexton(ceil(size(pxTexton,1)/2),Idx((i-1)*(S+1) + j));
        end
    end  
    
    imshow(new_image);  
end

