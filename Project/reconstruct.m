function [ new_image ] = reconstruct(Database,image,K)

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    %apply K-means here

    texton = extractTextonC(image,Database);
    textonVector = zeros(size(texton,1)*size(texton,2), size(texton,3));
    for i=1:size(texton,3)
        temp= texton(:,:,i);
        textonVector(:,i)  = temp(:);
    end
    [Idx, KTextons] = kmeans(textonVector,K);
    
    'Done with K-means'
    
    
    F = zeros(size(Database,3),size(Database,1)*size(Database,2));
    
    for i=1:size(Database,3)
        A = Database(:,:,i);
        F(i,:) = A(:);
    end

    'wohafd;lfjldsj'
    pxTexton = zeros(size(F,2),size(KTextons,1));
    size(KTextons)
    size(pxTexton)
    'asdlfk'
    size(F)
    size(KTextons)
    size(pxTexton)
    for i=1:size(KTextons,1)
        pxTexton(:,i) = pinv(F)*KTextons(i,:)';
        %pxTexton(:,i) = F\KTextons(i,:)';
        
        temp=vec2mat(pxTexton(:,i),49);
        imshow(mat2gray(temp));
        pause;
        %size(F'\KTextons(i,:)')
    end
    
    
    new_image = zeros(size(image,1),size(image,2));
    
    for i=1:size(image,1)
        for j =1:size(image,2)
            new_image(i,j) = pxTexton(ceil(size(F,2)/2),Idx((j-1)*size(image,2) + i));
        end
    end  
    imshow(new_image)  
end

