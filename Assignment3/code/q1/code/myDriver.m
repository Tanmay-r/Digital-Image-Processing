function myDriver()
addpath('../../../common/export_fig/')
addpath('../../../common/')

dstar = 96;
[imageOrig, imageNoisy, filter, imageFiltered, RMSD] = fourier_analysis('../images/boat.mat', dstar);
save_image(imageOrig,'../images/boat_orig.png',0);
save_image(imageNoisy,'../images/boat_noisy.png',0);
filename=strcat('../images/butterworth_filter_',int2str(dstar),'.png');
save_image(filter,filename,0);
filename=strcat('../images/boat_filtered_',int2str(dstar),'.png');
save_image(imageFiltered,filename,0);
save('../images/images_butterworth.mat', 'imageOrig', 'imageNoisy', 'filter', 'imageFiltered', 'RMSD');
RMSD

[imageOrig, center, imageFiltered, RMSD, percentEnergy] = filter_circular('../images/boat.mat', 59);
save_image(imageOrig,'../images/boat_orig.png',0);
filename=strcat('../images/boat_filtered_circular.png');
save_image(imageFiltered,filename,0);
save('../images/images_circular.mat', 'imageOrig', 'imageFiltered', 'RMSD');
percentEnergy, RMSD