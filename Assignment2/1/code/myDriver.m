function myDriver()
addpath('../../common/export_fig/')
addpath('../../common/')

[inp_img, sharpened_img] = unsharpMask('../images/lionCrop.mat', 10, 0.15);
save('../images/lionCrop_inp.mat', 'inp_img');
save('../images/lionCrop_sharpened.mat', 'sharpened_img');
save_image(inp_img, '../images/lionCrop_inp', 0)
save_image(sharpened_img, '../images/lionCrop_sharpened', 0)

[inp_img, sharpened_img] = unsharpMask('../images/superMoonCrop.mat', 10, 0.15);
save('../images/superMoonCrop_inp.mat', 'inp_img');
save('../images/superMoonCrop_sharpened.mat', 'sharpened_img');
save_image(inp_img, '../images/superMoonCrop_inp', 0)
save_image(sharpened_img, '../images/superMoonCrop_sharpened', 0)



