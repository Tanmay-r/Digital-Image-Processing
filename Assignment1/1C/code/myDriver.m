function myDriver(input)
addpath('../../common/export_fig/')
addpath('../../common/')

[inp_img, enlarged_image] = nearest_neighbour(input);
save_image(inp_img, '../images/inp');
save_image(enlarged_image, '../images/enlarged');