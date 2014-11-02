function [image, segmentedImage] = segment(image, K)
    vec = zeros(size(image, 1)*size(image, 2), 5);
    
    for i = 1:size(image, 1)
        for j = 1:size(image, 2)
            vec((i-1)*size(image, 2) + j, 1) = i;
            vec((i-1)*size(image, 2) + j, 2) = j;
            vec((i-1)*size(image, 2) + j, 3:5) = image(i, j, :);
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%% Farthest Point Clustering %%%%%%%%%%%%%%%%%%%%%%%
    vecCol=vec';
    dim1=size(vecCol,1);
    dim2=size(vecCol,2);
    
    initialKmeans = zeros (dim1, K);
    initialKmeans(:,1)= vecCol(:,randi(dim2));
    
    dist=zeros(K,dim2);

    for i=1:K-1,
        diff=vecCol-initialKmeans(:,i*ones(1,dim2));
        dist(i,:)=sum(diff.^2);  
        [~, maxind]=max(min(dist(1:i,:)));
        initialKmeans(:,i+1)=vecCol(:,maxind);
    end 
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    [idx, centers] = kmeans(vec, K, 'start', initialKmeans');
    
    segmentedImage = zeros(size(image, 1),size(image, 2), 3);
    for i = 1:size(segmentedImage, 1)
        for j = 1:size(segmentedImage, 2)
            segmentedImage(i, j, :) = centers(idx((i-1)*size(image, 2) + j), 3:5);
        end
    end
end