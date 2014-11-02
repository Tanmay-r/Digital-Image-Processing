function [new_image] = myDriver(imageName,k)

    addpath('./common/export_fig/')
    addpath('./common/')

    rng(0);
    
    %UNTITLED Summary of this function goes here
    %Detailed explanation goes here
    Database = makeLMfilters;
   
    image = mat2gray(imread(imageName));
    image=preprocessImage(image);
    Database=preprocessFilter(Database);
    
    imshow(mat2gray(image));
    %pause
   
    new_image = reconstruct(Database,image,k);
    
    filename=strcat('./result_',imageName);
    save_image(mat2gray(new_image),filename,0);

    
end

