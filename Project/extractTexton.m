function [ texton ] = extractTexton( image, Database)
%UNTITLED2 This function helps you extract texton from a particular texture
%   Detailed explanation goes here

   imageSize = size(image);
   height = imageSize(1);
   width = imageSize(2);
   noOfFilter = size(Database,3);
   filterheight =  size(Database,1);
   filterwidth = size(Database,2);
   texton = zeros(height,width,noOfFilter);
   imagePadded = zeros(height+filterheight, width+filterwidth);
   
   assert(filterwidth == filterheight, 'filter should be square');
   offset = (filterwidth-1)/2;
   currentPixel = 1;
   for k=1:noOfFilter 
       filter = Database(k);
       % pad image with filter size
       for i=1+offset:imageSize(1)+offset
           for j=1+offset:imageSize(2)+offset
                temp = imagePadded(i-offset:i+offset,j-offset:j+offset); 
                val = temp.*filter;
                val = sum(val(:));
                texton(currentPixel,k) = val;
                currentPixel = currentPixel +1;
           end
       end
   end
end

