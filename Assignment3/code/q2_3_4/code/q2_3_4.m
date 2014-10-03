function [recog_rate]=q2_3_4(k,param,reconstruct,checkRecognition)
    

    if(param==1)
        sizeOfImage=92*112;
        noOfFaces=35;
        countEachFace=5;
        countEachTestFace=5;
        height = 92;
        width = 112;
    else
        sizeOfImage=192*168;
        noOfFaces=39;
        countEachFace=2;
        countEachTestFace=3;
        height = 192;
        width = 168;
    end
    
    
    if(param==2)
        noOfImages=(noOfFaces-1)*countEachFace;
        noOfTestImages=(noOfFaces-1)*countEachTestFace;
    else
        noOfImages=noOfFaces*countEachFace;
        noOfTestImages=noOfFaces*countEachTestFace;
    end
    
    
    X=zeros(sizeOfImage,noOfImages);
    testImages=zeros(sizeOfImage,noOfTestImages);
    
   
    count=1;
    testCount=1;
    
    for i=1:noOfFaces
        
        if(param==2 && i==14)
            continue;
        end
        
        if(param==1)
            dir='../../../att_faces/s';
        else
            dir='../../../CroppedYale_Subset/CroppedYale_Subset/';
        end
        
        dir=strcat(dir,int2str(i),'/');
        
        for j=1:countEachFace
            pic=strcat(dir,int2str(j),'.pgm');
            img=imread(pic);
            img=img/255;
            X(:,count)=img(:);
            count=count+1;
        end
        
        for j=1:countEachTestFace
            pic=strcat(dir,int2str(j+countEachFace),'.pgm');
            %pic=strcat(dir,int2str(j),'.pgm');
            img=imread(pic);
            img=img/255;
            %figure, imshow(mat2gray(log(1+ abs(fftshift(fft2(img))))))
            %pause
            testImages(:,testCount)=img(:);
            testCount=testCount+1;
        end 
    end
    
    meanX=mean(X,2);
   
    
    for i=1:noOfImages
        X(:,i)=X(:,i)-meanX;
    end
    
    for i=1:noOfTestImages
        testImages(:,i)=testImages(:,i)-meanX;
    end
     
    
    
    L=X'*X;
    
    
    [v,D]=eig(L);  
    [~, order] = sort(diag(D),'descend');
    v = v(:,order);
    %d
    %pause;
    eig_vec=X*v;
    eig_vec=normc(eig_vec);
    eig_vec=eig_vec(:,1:k);
    %d=diag(d);
    
    
    coeff=eig_vec'*X;
    testCoeff=eig_vec'*testImages;
    noOfHits=0;
    
    
   
    
      
    if(reconstruct==1)
        %k =1;
        noOfEigenFaces= 25;
        Fourier = zeros(noOfEigenFaces,1);
        %reconstructing X(:,k)
        
        'eigenfaces'
        set(gca, 'LooseInset', get(gca,'TightInset'))
        for i =1:noOfEigenFaces 
            subplot(5,5,i);
            prevSum = normc(eig_vec(:,i));%*sqrt(d(i));
            Fourier(i) = log(1+ norm(fft(prevSum)));
            pic=mat2gray(reshape(prevSum*255,width,height));
            imshow(pic);
            title(num2str(i));
        end
        save_image(pic,'../images/eigenfaces.png',0);
        
        
        'fourier'
        for i =1:noOfEigenFaces
             
            subplot(5,5,i);
            prevSum = normc(eig_vec(:,i));
            pic=mat2gray(log(1+ abs(fftshift(fft2(reshape(prevSum*255,width,height))))));
            imshow(pic);
        end
        save_image(pic,'../images/fourier.png',0);
        
        'reconstruction'
        recons_k = [2, 10, 20, 50, 75, 100, 125, 150, 175];
        temp=zeros(size(coeff,1),1);
        for i =1:9
            subplot(3,3,i);
            temp(1:recons_k(1,i),1)=coeff(1:recons_k(1,i),1)';
            img_rec=meanX+eig_vec*temp;
            pic=mat2gray(reshape(img_rec*255,width,height));
            imshow(pic);
        end
        save_image(pic,'../images/reconstruction.png',0);
        
        
    end
   
    for i=1:noOfTestImages
        
       temp=coeff;
       for j=1:noOfImages
          temp(:,j)=temp(:,j)-testCoeff(:,i);
       end
       %sum(temp(:,i))
       %pause;
       temp=temp.^2;
       temp=sum(temp,1);
       [~,ind]=min(temp);
       
       
       if(floor((ind-1)/countEachFace)==floor((i-1)/countEachTestFace))
           noOfHits=noOfHits+1;
       end
    end
    recog_rate=noOfHits/noOfTestImages;
   
    
   if(checkRecognition==1)
       count=1;
       for i=36:40,
            new_X=zeros(sizeOfImage,50);
            dir='../../../att_faces/s';
            dir=strcat(dir,int2str(i),'/');

            for j=1:10
                pic=strcat(dir,int2str(j),'.pgm');
                img=imread(pic);
                img=img/255;
                new_X(:,count)=img(:);
                count=count+1;
            end
       end
       
       for i=1:50
        new_X(:,i)=new_X(:,i)-meanX;
       end
    
       
       
       
       totalTestSet=zeros(sizeOfImage,225);
       totalTestSet(:,1:175)=testImages;
       totalTestSet(:,176:225)=new_X;
       totaltestCoeff=eig_vec'*totalTestSet;
       notRecognised=0;
       noOfRecognised=0;
            falsePositive =0;
            falseNegative = 0;
       
       for i=1:225
 
            temp=coeff;
            
            dotProducts = zeros(size(coeff,2),1);
            for j=1:size(coeff,2)
                dotProducts(j) = abs(sum(temp(:,j).*totaltestCoeff(:,i)))/(norm(temp(:,j))*norm(totaltestCoeff(:,i)));
                 
            end
            [~,ind]=max(dotProducts);
            
            threshold = 0.7 ;
            if(dotProducts(ind) > threshold)
                
                if(i<=175)
                    if(floor((ind-1)/5)==floor((i-1)/5))
                        noOfRecognised=noOfRecognised+1;
                    else
                        notRecognised = notRecognised+1;
                    end
                else
                    falsePositive =falsePositive+1;
                    notRecognised = notRecognised+1;
                end
                
            else
                if(i>175)
                    noOfRecognised=noOfRecognised+1;
                    
                else
                    falseNegative =falseNegative+1;
                    notRecognised = notRecognised+1;
                end
            end
       end
        
    'rate'
    rate=noOfRecognised/(noOfRecognised+notRecognised);
    rate
    'False Positive'
    falsePositive
    'False Negative'
    falseNegative
    pause
    

       

   end
 
end
