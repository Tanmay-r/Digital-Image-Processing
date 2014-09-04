function [imageOrig, corruptImage, gaussian_mask, filteredImage] = patchBased(filename, h, sigmaPatch)

load(filename);
imageOrig = double(imageOrig)/255;

%optimization on original image
gaussian_filter = fspecial('gaussian', size(imageOrig), 0.66); 
imageOrig = imfilter(imageOrig, h);
imageOrig = downsample(imageOrig, 2);
imageOrig = downsample(imageOrig', 2);
imageOrig = imageOrig';

%corrupt the image
range=max(imageOrig(:))-min(imageOrig(:));
range=0.05*range;
corruptImage = imnoise(imageOrig,'gaussian', 0 ,range*range);

patchSize = 9;
windowSize = 25;

x=size(corruptImage,1);
y=size(corruptImage,2);

windowOffset = (windowSize - 1)/2;
patchOffset = (patchSize - 1)/2;

totalOffset = windowOffset + patchOffset;

imagePadded = zeros((patchSize-1) + (windowSize - 1) + x , (patchSize-1) + (windowSize - 1) + y);    
imagePadded((totalOffset + 1):(x + totalOffset), (totalOffset + 1):(y + totalOffset)) = corruptImage;

gaussian_mask = fspecial('gaussian', patchSize, sigmaPatch);

for i=(totalOffset + 1):(x + totalOffset)
	for j=(totalOffset + 1):(y + totalOffset)
		i
		j
		for m=(i - patchOffset):(i + patchOffset)
			for n=(j - patchOffset):(j + patchOffset)
				patch_p(((m + 1) -(i - patchOffset)) , ((n + 1) - (j - patchOffset))) = imagePadded(m,n) * gaussian_mask(((m + 1) -(i - patchOffset)) , ((n + 1) - (j - patchOffset)));
			end
		end
		filter = zeros(windowSize, windowSize);
		for k=(i - windowOffset):(i + windowOffset)
			for l=(j - windowOffset):(j + windowOffset)
				patch_norm = 0;
				for m=(k - patchOffset):(k + patchOffset)
					for n=(l - patchOffset):(l + patchOffset)
						patch_norm = patch_norm + (imagePadded(m, n)*gaussian_mask(((m + 1) -(k - patchOffset)), ((n + 1) - (l - patchOffset))) - patch_p(((m + 1) -(k - patchOffset)), ((n + 1) - (l - patchOffset))))^2;
					end
				end
 				filter(k - (i - windowOffset - 1), l - (j - windowOffset - 1)) = -sqrt(patch_norm)/(h*h);
			end
		end
		normalize = sum(filter(:));	
        filter = filter/normalize;
        weights = imagePadded((i - windowOffset):(i + windowOffset), (j - windowOffset):(j + windowOffset));
        weights = weights.*filter;
        filteredImage((i - totalOffset), (j - totalOffset)) = sum(weights(:))/(windowSize^2);
	end
end

