function myDriver()
addpath('../../common/export_fig/')
addpath('../../common/')

[imageOrig, filteredImage] = patchBased('../images/barbara.mat', 1, 0.5);
save('../images/barbara_inp.mat', 'inp_img');
save('../images/barbara_sharpened.mat', 'sharpened_img');
save_image(inp_img, '../images/barbara_inp', 0)
save_image(filteredImage, '../images/barbara_sharpened', 0)