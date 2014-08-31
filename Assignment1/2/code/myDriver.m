function myDriver()
addpath('../../common/export_fig/')
addpath('../../common/')

% Part a
[image] = q2a('../images/barbara.png');
save_image(imread('../images/barbara.png'), '../images/barbara_Orig.png', 0)
save_image(image, '../images/barbara_A.png', 0)
[image] = q2a('../images/TEM.png');
save_image(imread('../images/TEM.png'), '../images/TEM.png', 0)
save_image(image, '../images/TEM_A.png', 0)
[image] = q2a('../images/canyon.png');
save_image(imread('../images/canyon.png'), '../images/canyon.png', 1)
save_image(image, '../images/canyon_A.png', 1)

% Part b
[image] = q2b('../images/barbara.png');
save_image(image, '../images/barbara_B.png', 0)
[image] = q2b('../images/TEM.png');
save_image(image, '../images/TEM_B.png', 0)
[image] = q2b('../images/canyon.png');
save_image(image, '../images/canyon_B.png', 1)

% Part c
[image] = q2c('../images/barbara.png', 200);
save_image(image, '../images/barbara_C.png', 0)
[image] = q2c('../images/TEM.png', 200);
save_image(image, '../images/TEM_C.png', 0)
[image] = q2c('../images/canyon.png', 200);
save_image(image, '../images/canyon_C.png', 1)

% Part d
[image] = q2d('../images/barbara.png', 200, 0.2);
save_image(image, '../images/barbara_D.png', 0)
[image] = q2d('../images/TEM.png', 200, 0.2);
save_image(image, '../images/TEM_D.png', 0)
[image] = q2d('../images/canyon.png', 200, 0.2);
save_image(image, '../images/canyon_D.png', 1)

