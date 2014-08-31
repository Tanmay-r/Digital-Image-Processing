
function [image]=q2b(image_name) 

image = imread(image_name);


size1=size(image,1);
size2=size(image,2);

image=double(image)/255;



channels = size(image,3);

bins=linspace(0,1,256);

for ch=1:channels,
    
    img_ch = image(:,:,ch);
    
    histogram = hist(img_ch(:),bins);
    histogram=histogram/(size1*size2);
    histogram=cumsum(histogram)*255;
    
    histogram = arrayfun(@(x) floor(x),histogram);
    
    image
    image(:,:,ch) = arrayfun(@(x) histogram(floor(x*255)+1)/255,image(:,:,ch));
    
 
    
end
filename=strcat('../images/',image_name(1:3),'_mat_q2b.mat');
image=image;
save(filename,'image');
%image=uint8(image*255);
%image=double(image/256);
%imshow(image,'DisplayRange',[0 255])
imshow(image);

end
