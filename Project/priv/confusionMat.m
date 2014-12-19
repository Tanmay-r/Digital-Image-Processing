%load('minIndex.mat');
confusion_mat = zeros(size(minIndex, 2)/5, size(minIndex, 2)/5);
for i = 1:size(minIndex, 2)
    confusion_mat(floor((i-1)/5)+1, minIndex(i)) = confusion_mat(floor((i-1)/5)+1, minIndex(i)) + 1;
end

percentage = confusion_mat - 5*eye(size(minIndex, 2)/5);
sum(abs(diag(percentage)))*100/(112*5)
