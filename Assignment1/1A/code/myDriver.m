function myDriver(input)
addpath('../../common/export_fig/')
addpath('../../common/')

[inp_img, shrunk_img] = my_shrink(input, 2);
save_image(inp_img, '../images/inp')
save_image(shrunk_img, '../images/shrunk_2')
[~, shrunk_img] = my_shrink(input, 3);
save_image(shrunk_img, '../images/shrunk_3')
