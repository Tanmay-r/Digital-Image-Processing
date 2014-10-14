function [ texton ] = myDriver(imageName)

    %UNTITLED Summary of this function goes here
    %Detailed explanation goes here
    Database = makeLMFilter();
    image = mat2gray(imread(imageName));
    texton = extractTexton(Database,image);
end

