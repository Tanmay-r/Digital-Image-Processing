function [inp_img, shrunk_img] = my_shrink(filename, d)
inp_img = imread(filename, 'png');
shrunk_img = zeros(int16(floor(size(inp_img)/d)));
shrunk_x = 1;
shrunk_y = 1;
inp_size = size(inp_img);
for i=1:inp_size(1)
    if(mod(i,d) == 0)
        for j=1:inp_size(2)
            if(mod(j,d) == 0)
               shrunk_img(shrunk_x, shrunk_y) = inp_img(i, j);
               shrunk_y = shrunk_y + 1;
            end
        end
        shrunk_x = shrunk_x + 1;
        shrunk_y = 1;
    end
end
        
