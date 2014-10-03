function [image, center, imageFiltered, RMSD, percentEnergy] = filter_circular(filename, radius)
load(filename);

%Normalize
imageOrig = double(imageOrig)/255;
image = imageOrig;

%fft
imageFFT = fftshift(fft2(image));
temp = abs(imageFFT).*abs(imageFFT);
totalEnergy = sum(temp(:));

%circular mask
center = [size(imageFFT, 1)/2 + 1, size(imageFFT, 2)/2 + 1];
energy = 0;
for i=1:size(imageFFT, 1)
    for j=1:size(imageFFT, 2)
       a = norm(center - [i, j]);
       if(a <= radius)
            energy = energy + abs(imageFFT(i, j))^2;
       else
           imageFFT(i, j) = 0;
       end
    end
end
percentEnergy = (energy/totalEnergy)*100;

%filter
imageFiltered = abs(ifft2(imageFFT));

%rmsd
x = size(image, 1);
y = size(image, 2);
errorFilter = image - imageFiltered;
errorFilter = errorFilter.^2;
RMSD = sqrt(sum(errorFilter(:)))/(x*y);
