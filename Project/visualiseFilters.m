function [corr_mat]=visualiseFilters(Database)
%     dirname='./filters/';
%     for i=1:size(Database,3)
%         filename=strcat(dirname,int2str(i),'.png');
%         save_image(mat2gray(Database(:,:,i)),filename,0);
%         
%     end
    
    corr_mat=zeros(size(Database,3),size(Database,3));
    for i=1:size(Database,3)
        for j=1:size(Database,3)
        temp=Database(:,:,i).*Database(:,:,j);
        corr_mat(i,j)=sum(temp(:));
        end
    end
       
end
