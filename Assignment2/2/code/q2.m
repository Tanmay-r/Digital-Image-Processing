function [image]=q2(image_name,param,sigmaSpatial,sigmaIntensity)

load(image_name);
rng(0);
imageOrig =double(imageOrig)/255;
image=imageOrig;
channels = size(image,3);

x=size(image,1);
y=size(image,2);
range=max(image(:))-min(image(:));
range=0.05*range;

if(param==1)

    
    image = imnoise(image,'gaussian',0,range*range);

end

imageNoisy = image;
%imshow(double(imageOrig));colorbar;pause

w = 5; %% w odd
A = linspace(1,w,w);
col = repmat(A,[w 1]);
row = repmat(A',[1 w]);
col = col - ((w+1)/2);
row = row - ((w+1)/2);
col = col.^2;
row = row.^2;
%sigmaSpatial = 4;
%sigmaIntensity = 0.2;
spatialWindow = sqrt(col+row);
spatialWindow = arrayfun(@(x) exp(- x^2/(2*sigmaSpatial^2)), spatialWindow);
image_final = zeros(x,y,channels);
offset = (w-1)/2;
%imshow(double(spatialWindow));colorbar;pause
for ch=1:channels,
    
    img_ch = image(:,:,ch);
    img_padded = zeros((w-1) + x , (w-1) + y);
    
    img_padded((offset+ 1):(x+offset), (offset + 1):(y + offset)) =  img_ch;
    
    for i=(1+offset):(x+offset)
        for j=(1+offset):(y+offset)
            
            small_window = img_padded((i-offset):(i+offset),(j-offset):(j+offset));
            intensityWindow=zeros(w,w);
            centerIn = small_window((w+1)/2,(w+1)/2);
            
            for x1 = 1:w
                for y1 = 1:w
                    intensityWindow(x1,y1) = exp(-(small_window(x1,y1)-centerIn)^2/(2*sigmaIntensity^2));
                end
            end
            
            %intensityWindow = arrayfun(@(x) exp(-(x-centerIn)^2/(2*sigmaIntensity^2)), small_window);     
            filter = intensityWindow(:).*spatialWindow(:);

            img_padded(i,j) = filter'*small_window(:)/sum(filter);
        end
    end
    
    img_ch = img_padded((offset+ 1): (x + offset), (offset + 1): (y + offset));
    image_final(:,:,ch) = img_ch;
end
%filename=strcat('~/Desktop/DIP/images/q2a/',image_name(1:3),'_mat_q2a.mata');
%imshow(img_padded);
'Done!!!';
imshow(image_final);colorbar


errorNoise = imageOrig-imageNoisy;
errorNoise = errorNoise.^2;
errorNoise = sqrt(sum(errorNoise(:)))/(x*y);
'RMSD between Original and Noisy '
errorNoise

errorFilter = imageOrig -image_final;
errorFilter = errorFilter.^2;
errorFilter = sqrt(sum(errorFilter(:)))/(x*y);
'RMSD between Original and Final '
errorFilter

errorBwNoise = image_final-imageNoisy;
errorBwNoise = errorBwNoise.^2;
errorBwNoise = sqrt(sum(errorBwNoise(:)))/(x*y);
'RMSD between Noisy and Final '
errorBwNoise
end



