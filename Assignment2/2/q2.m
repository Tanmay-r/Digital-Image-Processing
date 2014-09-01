
function [image,img_padded]=q2a(image) 


%a=sprintf('%s',image_name);

%image = imread(image_name);

image=double(image)/255;
%oimage
channels = size(image,3);

x=size(image,1);
y=size(image,2);
%imshow(image)
w = 31; %% w odd
A = linspace(1,w,w);
col = repmat(A,[w 1]);
row = repmat(A',[1 w]);
col = col - ((w+1)/2);
row = row - ((w+1)/2);
col = col.^2;
row = row.^2;
sigmaSpatial = 0.2
sigmaIntensity = 0.2;
spatialWindow = sqrt(col+row);
spatialWindow = arrayfun(@(x) normpdf(x,0,sigmaSpatial), spatialWindow);
'hi'
max(spatialWindow(:))
spatialWindow = spatialWindow/norm(spatialWindow(:));

spatialWindow;


offset = (w-1)/2;
for ch=1:channels,
    
    img_ch = image(:,:,ch);
    img_padded = zeros((w-1) + x , (w-1) + y);
    
    img_padded((offset+ 1):(x+offset), (offset + 1):(y + offset)) =  img_ch;
    size(img_padded((offset+ 1):(x+offset), (offset + 1):(y + offset)))
    size(img_ch)
    %imshow(img_ch);
    %pause
    count =0;
    %imshow(img_padded);
    for i=(1+offset):(x+offset)
        for j=(1+offset):(y+offset)
            'I J'
            i 
            j
            small_window = img_padded((i-offset):(i+offset),(j-offset):(j+offset));
            intensityWindow = small_window;
            intensityWindow = intensityWindow - intensityWindow((w+1)/2,(w+1)/2);
            assert(intensityWindow((w+1)/2,(w+1)/2) < 1E-5,'fault fault');
            intensityWindow = arrayfun(@(x) normpdf(x,0,sigmaIntensity), intensityWindow);
    
            intensityWindow = intensityWindow/norm(intensityWindow(:));
            
            %filter = intensityWindow+spatialWindow; 
            %filter = spatialWindow; 
            filter = intensityWindow; 
            
            %pause
            size(filter);
            size(small_window);
            %assert(norm(size(filter) - size(small_window)) < 1E-5 , 'fault fault');
            value = min(1,filter(:)'*small_window(:));
            if value >1
                count = count+1;
            end
               %size(value)
            %pause
            img_padded(i,j) = value;
            %'hi'
            %assert(small_window(2,2) == img_padded(i,j), 'fault fault');
            %img_padded(i,j)
            %pause;
            %pause
        end
    end
    'count is '
    count
    
    img_ch = img_padded((offset+ 1): (x + offset), (offset + 1): (y + offset));
    image(:,:,ch) = img_ch;
end
%filename=strcat('~/Desktop/DIP/images/q2a/',image_name(1:3),'_mat_q2a.mata');
%imshow(img_padded);
'Done!!!'
imshow(image);
end

