function [inp_img, enlarged_img] = nearest_neighbour(filename)
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
    	r = mod(i-1, 3);
        s = mod(j-1, 2);
        if(r < 2)
        	if(s <= 1)
        		enlarged_img(i,j) = pt1;
        	else
        		enlarged_img(i,j) = pt4
        	end        
        else
        	if(s <= 1)
        		enlarged_img(i,j) = pt2;
        	else
        		enlarged_img(i,j) = pt3;
        	end 
        end
    end
end

