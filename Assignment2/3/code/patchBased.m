function [imageOrig, filteredImage] = patchBased(filename, h, sigmaPatch)

load(filename);
imageOrig = double(imageOrig)/255;
filteredImage = imageOrig;

patchSize = 9;
windowSize = 25;

x=size(imageOrig,1);
y=size(imageOrig,2);

windowOffset = (windowSize - 1)/2;
patchOffset = (patchSize - 1)/2;

totalOffset = windowOffset + patchOffset;

imagePadded = zeros((patchSize-1) + (windowSize - 1) + x , (patchSize-1) + (windowSize - 1) + y);    
imagePadded((totalOffset + 1):(x + totalOffset), (totalOffset + 1):(y + totalOffset)) = imageOrig;

for i=(totalOffset + 1):(x + totalOffset)
	for j=(totalOffset + 1):(y + totalOffset)
		i
		j
		patch_p = arrayfun(@(x) exp(- x^2/(2*sigmaPatch^2)), imagePadded((i - patchOffset):(i + patchOffset), (j - patchOffset):(j + patchOffset)));
		filter = zeros(windowSize, windowSize);
		for k=(i - windowOffset):(i + windowOffset)
			for l=(j - windowOffset):(j + windowOffset)
				patch_q = imagePadded((k - patchOffset):(k + patchOffset), (l - patchOffset):(l + patchOffset));
				for m=1:patchSize
					for n=1:patchSize
						patch_q(m, n) = exp(-(patch_q(m, n)^2)/(2*sigmaPatch^2)) - patch_p(m, n);
					end
				end
 				filter(k - (i - windowOffset - 1), l - (j - windowOffset - 1)) = -norm(patch_q)/(h*h);
			end
		end
		normalize = sum(filter(:));		
        filter = filter/normalize;
        weights = imagePadded((i - windowOffset):(i + windowOffset), (j - windowOffset):(j + windowOffset));
        weights = weights.*filter;
        imagePadded(i, j) = sum(weights(:))/(windowSize^2);
	end
end

filteredImage = imagePadded((totalOffset + 1):(x + totalOffset), (totalOffset + 1):(y + totalOffset));

