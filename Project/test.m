function [ hist ] = test(Database, histDatabase, textonDatabase)

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    basefile='./textures/1.2.';
%     mapArr=['01';'02';'03','04','05','06','07','08','09','10','11','12','13']
%     mapArr(1,1)
    for i=1:13
        filename=strcat(basefile,int2str(i),'.tiff');
        image = mat2gray(imread(filename));
        image = preprocessImage(image);
        image_hist=generateHist(Database, image, textonDatabase);
        chiSquareArr = zeros(1, 13);
        for j = 1:13
            chiSquareArr(j) = chiSquare(image_hist, histDatabase(j, :));
        end
        chiSquareArr
        [~, minindex] = min(chiSquareArr);
        minindex
    end  
end

