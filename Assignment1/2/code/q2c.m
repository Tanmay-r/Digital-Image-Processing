
function [image]=q2c(image_name,p) 

image = imread(image_name);

%image=single(image);

image=double(image)/255;

size1=size(image,1);
size2=size(image,2);



channels = size(image,3);


%bins=linspace(0,255,256);

p=p/2;

for ch=1:channels,
    
    img_ch = image(:,:,ch);
    histogram=zeros(size1,size2,256);
    
    histogram(1,1,floor(img_ch(1,1)*255)+1) = 1;
    
    for i=1:size1,
        for j=1:size2,
            if(i>1 && j>1)
                histogram(i,j,:)= histogram(i-1,j,:)+ histogram(i,j-1,:)- histogram(i-1,j-1,:);
                histogram(i,j,floor(img_ch(i,j)*255)+1)=histogram(i,j,floor(img_ch(i,j)*255)+1)+1;
            end
            
            if(i==1 && j>1)
                histogram(i,j,:)=histogram(i,j-1,:);
                histogram(i,j,floor(img_ch(i,j)*255)+1)=histogram(i,j,floor(img_ch(i,j)*255)+1)+1;
            end
            
            if(j==1 && i>1)
                histogram(i,j,:)=histogram(i-1,j,:);
                histogram(i,j,floor(img_ch(i,j)*255)+1)=histogram(i,j,floor(img_ch(i,j)*255)+1)+1;
            end   
            
        end
    end
    %works till here
    newhist = double(zeros(256));
     for i=1:size1,
        for j=1:size2,
            
            new_iaddp=min(i+p,size1);
            new_jminp=max(j-p-1,1);
            new_iminp=max(i-p-1,1);
            new_jaddp=min(j+p,size2);
            
            if(i-p-1 < 1 && j-p-1<1)
                newhist=histogram(new_iaddp,new_jaddp,:);
                assert(min(newhist) >= 0,'error1');
            
            end
            if(i-p-1 < 1 && j-p-1>=1)
                newhist=-histogram(new_iaddp,new_jminp,:)+histogram(new_iaddp,new_jaddp,:);
                assert(min(newhist) >= 0,'error2');
            
            end
            if(i-p-1 >= 1 && j-p-1<1)
                newhist=-histogram(new_iminp,new_jaddp,:)+histogram(new_iaddp,new_jaddp,:);
                assert(min(newhist) >= 0,'error3');
            
            end
            if(i-p-1 >=1 && j-p-1>=1)
                   newhist=-histogram(new_iaddp,new_jminp,:)-histogram(new_iminp,new_jaddp,:)+histogram(new_iaddp,new_jaddp,:)+histogram(new_iminp,new_jminp,:);
                assert(min(newhist) >= 0,'error4');
            
            end
            
            
            %newhist=newhist/((new_iaddp-new_iminp)*(new_jaddp-new_jminp));
            %i
            %j
            
            newhist=cumsum(newhist);
            
            %pause
            %size(newhist)
            %newhist=cumsum(newhist(1,1,1:image(i,j,ch)+1));
            
            %newhist = arrayfun(@(x) floor(x*255/((new_iaddp-new_iminp)*(new_jaddp-new_jminp))),newhist);
            %newhist = arrayfun(@(x) floor(x),newhist);
           
            image(i,j,ch)=newhist(floor(img_ch(i,j)*255)+1)*1/((new_iaddp-new_iminp)*(new_jaddp-new_jminp));
            %image(i,j,ch)=newhist(image(i,j,ch)+1);
        
        end
     end
    
end

filename=strcat('../images/',image_name(1:3),'_',int2str(2*p),'_mat_q2c.mat');
save(filename,'image');
image=uint8(image*255);
%image=double(image/256);
%imshow(image,'DisplayRange',[0 255])
imshow(image);

end
