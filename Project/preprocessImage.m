function [image]=preprocessImage(image)
    image=image-mean(image(:));
    image=image*sqrt(size(image,1)*size(image,2))/norm(image(:));
    
end