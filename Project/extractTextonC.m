function [texton] = extractTextonC(image, Database)
%UNTITLED2 This function helps you extract texton from a particular texture
%   Detailed explanation goes here
% s must be even

   imageSize = size(image);
   height = imageSize(1);
   width = imageSize(2);
   noOfFilter = size(Database,3);
   texton = zeros(width,height,noOfFilter);
   for k=1:noOfFilter
       filter = Database(:,:,k);
       size(filter);
       texton(:,:,k) = conv2(image,filter,'same');
       
    end
end