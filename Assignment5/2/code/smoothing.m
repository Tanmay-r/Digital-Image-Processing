function [origX, filteredImage] = smoothing(image, spatialSig, intensitySig)
    [origX, ~] = imread(image);
    %origX = double(origX)/255;
    covMatrix = zeros(5, 5);
    covMatrix(1, 1) = spatialSig*spatialSig;
    covMatrix(2, 2) = spatialSig*spatialSig;
    covMatrix(3, 3) = intensitySig*intensitySig;
    covMatrix(4, 4) = intensitySig*intensitySig;
    covMatrix(5, 5) = intensitySig*intensitySig;
    vec = zeros(size(origX, 1)*size(origX, 2), 5);
    
    for i = 1:size(origX, 1)
        for j = 1:size(origX, 2)
            vec((i-1)*size(origX, 2) + j, 1) = i;
            vec((i-1)*size(origX, 2) + j, 2) = j;
            vec((i-1)*size(origX, 2) + j, 3:5) = origX(i, j, :);
        end
    end
    
    %newVec = meanShift(vec, covMatrix);
    newVec = vec;
    
    filteredImage = zeros(size(origX, 1),size(origX, 2), 3);
    for i = 1:size(origX, 1)
        for j = 1:size(origX, 2)
            filteredImage(i, j, :) = vec((i-1)*size(origX, 2) + j, 3:5);
        end
    end    
end