function [texton] = extractTextonC( image, Database, s)
%UNTITLED2 This function helps you extract texton from a particular texture
%   Detailed explanation goes here
% s must be even

   imageSize = size(image);
   height = imageSize(1);
   width = imageSize(2);
   noOfFilter = size(Database,3);
   filterheight =  size(Database,1);
   filterwidth = size(Database,2);
   texton = zeros((s+1)*(s+1),noOfFilter);
   imagePadded = zeros(height+filterheight, width+filterwidth);
    
   assert(filterwidth == filterheight, 'filter should be square');
   offset = (filterwidth-1)/2;
   currentPixel = 1;
   offset;
   for k=1:noOfFilter
       filter = Database(:,:,k);
       n=1;
       for in=height/2-s/2:height/2+s/2
           for jn=width/2-s/2:width/2+s/2
                in;
                jn;
                small_image = image(in-offset:in+offset,jn-offset:jn+offset);
                texton(n,k) = sum(filter(:)'*small_image(:));
                n = n+1;
           end
       end
       imagesc(texton);
       %imshow(image(height/2-s:height/2+s,width/2-s:width/2+s));
       % pad image with filter size
    end
end
   



