function myDriver()
addpath('../../common/export_fig/')
addpath('../../common/')


spatialSigmaOpt=0.7920 %0.72
intensitySigmaOpt=0.049 %0.055
[image]=q2('../images/barbara.mat',1,spatialSigmaOpt,intensitySigmaOpt);
filename=strcat('../images/bar_',int2str(spatialSigmaOpt*1000),'_',int2str(intensitySigmaOpt*1000),'.png');
save_image(image, filename, 0);

spatialSigma=0.9*spatialSigmaOpt
intensitySigma=intensitySigmaOpt
[image]=q2('../images/barbara.mat',1,spatialSigma,intensitySigma);
filename=strcat('../images/bar_',int2str(spatialSigma*1000),'_',int2str(intensitySigma*1000),'.png');
save_image(image, filename, 0);

spatialSigma=1.1*spatialSigmaOpt
intensitySigma=intensitySigmaOpt
[image]=q2('../images/barbara.mat',1,spatialSigma,intensitySigma);
filename=strcat('../images/bar_',int2str(spatialSigma*1000),'_',int2str(intensitySigma*1000),'.png');
save_image(image, filename, 0);

spatialSigma=spatialSigmaOpt
intensitySigma=0.9*intensitySigmaOpt
[image]=q2('../images/barbara.mat',1,spatialSigma,intensitySigma);
filename=strcat('../images/bar_',int2str(spatialSigma*1000),'_',int2str(intensitySigma*1000),'.png');
save_image(image, filename, 0);

spatialSigma=spatialSigmaOpt
intensitySigma=1.1*intensitySigmaOpt
[image]=q2('../images/barbara.mat',1,spatialSigma,intensitySigma);
filename=strcat('../images/bar_',int2str(spatialSigma*1000),'_',int2str(intensitySigma*1000),'.png');
save_image(image, filename, 0);