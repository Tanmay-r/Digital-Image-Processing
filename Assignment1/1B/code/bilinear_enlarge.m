function [inp_img, enlarged_img] = bilinear_enlarge(filename)
inp_img = imread(filename, 'png');
size_inp_img = size(inp_img);
size_enlarged_img = [3*size_inp_img(1)-2, 2*size_inp_img(2) - 1];
enlarged_img = zeros(size_enlarged_img);
for i=1:size_enlarged_img(1) - 1
    for j=1:size_enlarged_img(2) - 1        
        pt1 = inp_img(floor(i/3) + 1,floor(j/2) + 1);
        pt2 = inp_img(ceil(i/3) + 1,floor(j/2) + 1);
        pt3 = inp_img(ceil(i/3) + 1,ceil(j/2) + 1);
        pt4 = inp_img(floor(i/3) + 1,ceil(j/2) + 1);
        r = (mod(i-1, 3)/3);
        s = (mod(j-1, 2)/2);
        pt5 = r*pt1 + (1 - r)*pt2;
        pt6 = r*pt3 + (1 - r)*pt4;
        pt7 = s*pt5 + (1 - s)*pt6;
        enlarged_img(i,j) = pt7;
    end
end