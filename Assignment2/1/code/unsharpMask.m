function [imageOrig, sharpened_img] = unsharpMask(filename, sigma, scale)
load(filename);
gaussian_mask = fspecial('gaussian', 10, sigma);
blurred_img = imfilter(imageOrig, gaussian_mask, 'conv');
sharpened_img = imageOrig + scale*(1 - blurred_img);
max_intensity = max(sharpened_img(:));
min_intensity = min(sharpened_img(:));
sharpened_img = (sharpened_img - min_intensity)/(max_intensity - min_intensity);