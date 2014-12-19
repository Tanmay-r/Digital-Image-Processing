function [filterBank]=preprocessFilter(filterBank)

    size(filterBank)
    for i=1:size(filterBank,3)
       temp=filterBank(:,:,i);
       temp=sqrt(sum(temp(:).^2));
       filterBank(:,:,i)=filterBank(:,:,i)/temp; 
    end
    
 
end