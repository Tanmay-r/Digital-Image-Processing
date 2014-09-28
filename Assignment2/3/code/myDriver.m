function myDriver()
addpath('../../common/export_fig/')
addpath('../../common/')


sigma = 1;
hOpt = 10;

[imageOrig, corruptImage, gaussian_mask, image] = patchBased('../images/barbara.mat', hOpt, sigma); 
filename=strcat('../images/bar_',int2str(sigma*100),'.png');
save_image2(image, filename, 0);
%{
save_image(imageOrig, '../images/originalImage', 0);
save_image(corruptImage, '../images/corruptImage', 0);
save_image(gaussian_mask, '../images/gaussian_mask', 0);





h=0.9*hOpt;
[~, ~, gaussian_mask, image] = patchBased('../images/barbara.mat', h, sigma); 
filename=strcat('../images/bar_',int2str(h*100),'.png');
save_image2(image, filename, 0);

h=1.1*hOpt;
[~, ~, gaussian_mask, image] = patchBased('../images/barbara.mat', h, sigma); 
filename=strcat('../images/bar_',int2str(h*100),'.png');
save_image2(image, filename, 0);
%}

