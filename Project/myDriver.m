function [ new_image] = myDriver(imageName,k)

    %UNTITLED Summary of this function goes here
    %Detailed explanation goes here
    Database = makeLMfilters;
    size(Database)
    image = mat2gray(imread(imageName));
    size(image)
    imshow(image);
    %image  = double(image)/255;
    %texton = extractTextonC(image,Database);
    % Database = Database(:,:,1:4);
    

    new_image = reconstruct(Database,image,k);

    
end

