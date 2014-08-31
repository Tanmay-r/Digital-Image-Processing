
function [image]=q2a(image_name) 


a=sprintf('%s',image_name);

image = imread(image_name);

image=double(image)/255;
%oimage
channels = size(image,3);

x=size(image,1);
y=size(image,2);


for ch=1:channels,
    
    img_ch = image(:,:,ch);
    perc=prctile(img_ch(:),[5 95]);
    
    image(:,:,ch) = arrayfun(@(x) max(0,min((x-perc(1))*(1/(perc(2)-perc(1))),1)),image(:,:,ch));
 
    
end
filename=strcat('~/Desktop/DIP/images/q2a/',image_name(1:3),'_mat_q2a.mat');
%image=image;
%save(filename,'image');


%image=uint8(image*255);
%image=double(image/256);
%imshow(image,'DisplayRange',[0 255])
imshow(image);

end
