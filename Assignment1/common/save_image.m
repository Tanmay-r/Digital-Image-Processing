function save_image(img, outp_file_name)
myNumOfColors = 200;
myColorScale = [(0:1/(myNumOfColors-1):1)' , (0:1/(myNumOfColors-1):1)' , (0:1/(myNumOfColors-1):1)'];
imagesc(img); 
colormap (myColorScale); 
colormap gray; 
daspect ([1 1 1]); 
axis tight;
colorbar;
export_fig(outp_file_name, '-tiff')