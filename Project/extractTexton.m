function [ texton ] = extractTextonP( image, Database, no_of_pixels)
%UNTITLED2 This function helps you extract texton from a particular texture
%   Detailed explanation goes here

   imageSize = size(image);
   height = imageSize(1);
   width = imageSize(2);
   noOfFilter = size(Database,3);
   filterheight =  size(Database,1);
   filterwidth = size(Database,2);
   texton = zeros(no_of_pixels,noOfFilter);
   imagePadded = zeros(height+filterheight, width+filterwidth);
    
   assert(filterwidth == filterheight, 'filter should be square');
   offset = (filterwidth-1)/2;
   currentPixel = 1;
   i =  rand(1,no_of_pixels)*(imageSize(1)-2*offset) + offset+1;
   j =  rand(1,no_of_pixels)*(imageSize(2)-2*offset) + offset+1;
   i = floor(i);
   j = floor(j);
   offset;
   for k=1:noOfFilter 
       filter = Database(:,:,k);
       
       for n=1:no_of_pixels
           in = i(n);
           jn = j(n);
           small_image = image(in-offset:in+offset,jn-offset:jn+offset);
           texton(n,k) = sum(filter(:)'*small_image(:));
       % pad image with filter size
       end
   end
   
end



