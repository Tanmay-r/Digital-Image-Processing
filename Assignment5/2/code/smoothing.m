function [origX, filteredImage] = smoothing(image, spatialSig, intensitySig, windowSize)
    [origX, ~] = imread(image);
    %origX = double(origX)/255;
    invCovMatrix = zeros(5, 5);
    invCovMatrix(1, 1) = 1/(spatialSig*spatialSig);
    invCovMatrix(2, 2) = 1/(spatialSig*spatialSig);
    invCovMatrix(3, 3) = 1/(intensitySig*intensitySig);
    invCovMatrix(4, 4) = 1/(intensitySig*intensitySig);
    invCovMatrix(5, 5) = 1/(intensitySig*intensitySig);
    vec = zeros(size(origX, 1), size(origX, 2), 5);
    newVec = zeros(size(origX, 1), size(origX, 2), 5);
    offset = (windowSize - 1)/2;
    for i = offset+1:size(origX, 1)-offset
        for j = offset+1:size(origX, 2)-offset
            vec(i, j, 1) = i;
            vec(i, j, 2) = j;
            vec(i, j, 3:5) = origX(i, j, :);
        end
    end
    
     
    for i = offset+1:size(origX, 1)-offset
        for j = offset+1:size(origX, 2)-offset
            temp = vec(i, j, :);
            [woah,newVec(i, j, :)] = meanShiftClusteringWindowed(temp(:), vec, offset, invCovMatrix);
            %size(temp)
        end
       
    end
    
    filteredImage = zeros(size(origX, 1),size(origX, 2), 3);
    for i = 1:size(origX, 1)
        for j = 1:size(origX, 2)
            filteredImage(i, j, :) = newVec(i, j, 3:5);
        end
    end    
end