
function [image,img_padded]=q2a(image) 

closeall(); 
%a=sprintf('%s',image_name);

%image = imread(image_name);

image=double(image)/255;
%oimage
channels = size(image,3);

x=size(image,1);
y=size(image,2);
imshow(image)
w = 25; %% w odd
A = linspace(1,w,w);
col = repmat(A,[w 1]);
row = repmat(A',[1 w]);
col = col - ((w+1)/2);
row = row - ((w+1)/2);
col = col.^2;
row = row.^2;
sigmaSpatial = 2;
sigmaIntensity = 0.5;
spatialWindow = sqrt(col+row);
spatialWindow = arrayfun(@(x) normpdf(x,0,sigmaSpatial), spatialWindow);
patchSize =9;
spatialWindow = spatialWindow/norm(spatialWindow(:));
sigmaPatch =1;
spatialWindow;

offset = (w-1)/2;
patchOffset = (patchSize-1)/2;
h =2;
for ch=1:channels,
    
    img_ch = image(:,:,ch);
    img_padded = zeros((w-1) + x , (w-1) + y);
    
    img_padded((offset+ 1):(x+offset), (offset + 1):(y + offset)) =  img_ch;
    size(img_padded((offset+ 1):(x+offset), (offset + 1):(y + offset)))
    size(img_ch)
    %imshow(img_ch);
    %pause
    %imshow(img_padded);
    for i=(1+offset):(x+offset)
        for j=(1+offset):(y+offset)
            small_window = img_padded((i-offset):(i+offset),(j-offset):(j+offset));
            mainPatch = img_padded((i-patchOffset):(i+patchOffset),(j-patchOffset):(j+patchOffset));
            mainPatch = arrayfun(@(x) normpdf(x,0,sigmaPatch), mainPatch);
            filter = zeros(w,w);
            for k =-offset:offset+1
                for l = -offset:offset+1
                    if(k ==0 && l==0)
                        filter(k,l) = 1;         
                    else
                        currentPatch = img_padded((k+i-patchOffset):(k+i+patchOffset),(l+j-patchOffset):(l+j+patchOffset));
                        currentPatch = arrayfun(@(x) normpdf(x,0,sigmaPatch), currentPatch);
                        currentPatch = currentPatch - mainPatch;
                        currentPatch = -norm(currentPatch(:))/(h*h);
                        filter(k,l) = exp(currentPath);
                    end
                    
                end
            end
            normalize = sum(filter(:));
            filter = filter/normalize;
            
            
            %pause
            size(filter);
            size(small_window);
            assert(norm(size(filter) - size(small_window)) < 1E-5 , 'fault fault');
            
            img_padded(i,j) = filter(:)'*small_window(:);
            %'hi'
            %assert(small_window(2,2) == img_padded(i,j), 'fault fault');
            %img_padded(i,j)
            %pause;
            %pause
        end
    end
    img_ch = img_padded((offset+ 1): (x + offset), (offset + 1): (y + offset));
    image(:,:,ch) = img_ch;
end
%filename=strcat('~/Desktop/DIP/images/q2a/',image_name(1:3),'_mat_q2a.mata');
%imshow(img_padded);
imshow(image);
end

