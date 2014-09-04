function [] = myDriver()
tic;
[imageOrig, filteredImage] = patchBased('../images/barbara.mat', 1, 0.5);
toc;