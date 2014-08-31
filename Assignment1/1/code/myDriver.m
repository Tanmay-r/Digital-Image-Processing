function myDriver()
addpath('../../common/export_fig/')
addpath('../../common/')

% Part a
[inp_img, shrunk_img] = my_shrink('../images/circles_concentric.png', 2);
save_image(inp_img, '../images/shrink_inp', 0)
save_image(shrunk_img, '../images/shrunk_2', 0)

[inp_img, shrunk_img] = my_shrink('../images/circles_concentric.png', 3);
save_image(shrunk_img, '../images/shrunk_3', 0)

% Part b
[inp_img, enlarged_image] = bilinear_enlarge('../images/barbaraSmall.png');
save_image(inp_img, '../images/enlarged_bilinear_inp', 0);
save_image(enlarged_image, '../images/enlarged_bilinear', 0);

% Part c
[inp_img, enlarged_image] = nearest_neighbour('../images/barbaraSmall.png');
save_image(inp_img, '../images/enlarged_nearest_inp', 0);
save_image(enlarged_image, '../images/enlarged_nearest', 0);

