function myDriver()
    addpath('../../common/export_fig/')
    addpath('../../common/')
    
    [origX, filteredImage] = smoothing('../images/flower.png', 12, 20,23);
    %[~, segmentedImage] = segment(filteredImage, 100);
    save_image(double(origX)/255, '../images/flower_original.png', 1);
    save_image(double(filteredImage)/255, '../images/flower_filtered.png', 1);
    %save_image(double(segmentedImage)/255, '../images/flower_segmented.png', 1);
    ;sdk
    [origX, filteredImage] = smoothing('../images/parrot.png', 12, 20);
    [~, segmentedImage] = segment(filteredImage, 100);
    save_image(double(origX)/255, '../images/parrot_original.png', 1);
    save_image(double(filteredImage)/255, '../images/parrot_filtered.png', 1);
    save_image(double(segmentedImage)/255, '../images/parrot_segmented.png', 1);
end