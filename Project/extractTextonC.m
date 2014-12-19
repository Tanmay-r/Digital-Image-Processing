function [texton] = extractTextonC(image, Database)
%UNTITLED2 This function helps you extract texton from a particular texture
%   Detailed explanation goes here
% s must be even

   imageSize = size(image);
   height = imageSize(1);
   width = imageSize(2);
   noOfFilter = size(Database,3);
   texton = zeros(width,height,noOfFilter);
   filterSize = size(Database(:,:,1));
   fh = filterSize(1);
   fw = filterSize(2);
   
   F = zeros(size(Database,3),size(Database,1)*size(Database,2));
    
   for i=1:size(Database,3)
        A = Database(:,:,i);
        F(i,:) = A(:);
   end

   for k=1:noOfFilter
       filter = Database(:,:,k);
       size(filter);
       texton(:,:,k) = conv2(image,filter,'same');
   end
   
   texton = texton(fh+1:height-fh,fw+1:width-fw,:);
    % temp=texton(256,256,:);
    % temp=vec2mat(pinv(F)*temp(:),49);
    % imshow(mat2gray(temp));
    % figure()
    % imshow(mat2gray(image(232:280,232:280)));
    % pause;

end