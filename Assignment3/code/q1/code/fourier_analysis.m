function [image, imageNoisy, filter, imageFiltered, RMSD] = fourier_analysis(filename, d)
load(filename);

%Normalize
imageOrig = double(imageOrig)/255;
image = imageOrig;

range=max(image(:))-min(image(:));
range=0.1*range;

imageNoisy = imnoise(image, 'gaussian', 0, range*range);

%imageNoisyFFT = fftshift(fft2(imageNoisy));
imageNoisyFFT = fftshift(fft2(imageNoisy));

filter = butterworth_filter(size(imageNoisy, 1), d);
imageFiltered = imageNoisyFFT.*filter;
imageFiltered = abs(ifft2(imageFiltered));

x = size(image, 1);
y = size(image, 2);
errorFilter = image - imageFiltered;
errorFilter = errorFilter.^2;
RMSD = sqrt(sum(errorFilter(:)))/(x*y);

max_intensity = max(filter(:));
min_intensity = min(filter(:));
filter = (filter - min_intensity)/(max_intensity - min_intensity);


