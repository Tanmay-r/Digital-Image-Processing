function [hist] = rotated(Database, image, K)
    addpath('common/export_fig/')
    addpath('common/')
    
    KTextons = generateTextons(Database,image,K);
    F = zeros(size(Database,3),size(Database,1)*size(Database,2));    
    for i=1:size(Database,3)
        A = Database(:,:,i);
        F(i,:) = A(:);
    end
   
    temp_img = zeros(size(Database,1)*size(Database,2), K);
    for i = 1:K
        temp=vec2mat(pinv(F)*KTextons(i,:)',49);
        temp_img(:, i) = temp(:);
    end

    dict_pic = display_dictionary(temp_img, size(Database,1), 5);
    hist = generateHist(Database,image,KTextons);
    save_image(mat2gray(dict_pic), 'dict_pic.png', 0);
    