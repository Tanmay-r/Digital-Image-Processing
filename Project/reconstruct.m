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
    
    filterSize = size(Database(:,:,1));
    
    fh = filterSize(1);
    fw = filterSize(2);
    
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
    [Idx, KTextons] = kmeans(textonVector,K,'start', initialKmeans');
    
    'Done with K-means'
    
    
    F = zeros(size(Database,3),size(Database,1)*size(Database,2));
    
    for i=1:size(Database,3)
        A = Database(:,:,i);
        F(i,:) = A(:);
    end

    
    pxTexton = zeros(size(F,2),size(KTextons,1));
    
    for i=1:size(KTextons,1)
         pxTexton(:,i) = pinv(F)*KTextons(i,:)';
        %pxTexton(:,i) = F\KTextons(i,:)';
        
        %temp=vec2mat(pxTexton(:,i),49);
        %imshow(mat2gray(temp));
        %pause;
        %size(F'\KTextons(i,:)')
    end
    
    
    new_image = zeros(size(image,1)-2*fh,size(image,2)-2*fw);
    fw
    'fw'
    fh
    'fh'
    
    for i=1:size(new_image,1)
        for j =1:size(new_image,2)
            new_image(i,j) = pxTexton(ceil(size(F,2)/2),Idx((j-1)*size(new_image,2)+i));
        end
    end  
    imshow(mat2gray(new_image));  
end

