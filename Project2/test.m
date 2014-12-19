function [minindex] = test(Database, histDatabase, textonDatabase, testImageSet)

    minindex=zeros(1,size(testImageSet,3));
    for i=1:size(testImageSet,3)
        i
        image_hist=generateHist(Database, testImageSet(:,:,i), textonDatabase);
        chiSquareArr = zeros(1, 13);
        for j = 1:size(histDatabase,1)
            chiSquareArr(j) = chiSquare(image_hist, histDatabase(j, :));
        end
        [~, temp] = min(chiSquareArr);
        minindex(1,i)=temp;
    end  
end

