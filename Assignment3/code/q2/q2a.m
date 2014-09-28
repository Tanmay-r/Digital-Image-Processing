function [recog_rate]=q2a(k,param,reconstruct)
    

    if(param==1)
        sizeOfImage=92*112;
        noOfFaces=35;
        countEachFace=7;
        countEachTestFace=3;
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
            dir='../../att_faces/s';
        else
            dir='../../CroppedYale_Subset/CroppedYale_Subset/';
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
    
    
    [v,d]=eigs(L,k);
    %d
    %pause;
    eig_vec=X*v;
    eig_vec=normc(eig_vec);
    %max(meanX)
    %max(eig_vec(:,1))
  
    %imshow(reshape(meanX,width,height));
    
    %imshow(reshape(meanX + eig_vec(:,1),width,height));
    
    coeff=eig_vec'*X;
    testCoeff=eig_vec'*testImages; 
    size(testCoeff)
    size(eig_vec)
    noOfHits=0;
   
    %testCoeff = coeff;
    %size(coeff);
      prevSum=meanX;
      
    if(reconstruct==1)
        k =1;
        noOfEigenFaces= 25
        'fdjs'
        Fourier = zeros(noOfEigenFaces,1);
        %reconstructing X(:,k)
        set(gca, 'LooseInset', get(gca,'TightInset'))
        for i =1:noOfEigenFaces
            %subplot(5,5,i,'Spacing', 0.03, 'Padding', 0, 'Margin', 0);
            %axis tight
            %axis off
            
            subplot(5,5,i);
            size(coeff(:,i))
            size(eig_vec(:,i))
            prevSum = prevSum+eig_vec(:,i)*coeff(i,k);
            Fourier(i) = log(1+ norm(fft(prevSum)));
            h = imshow(reshape(prevSum,width,height));
            title(num2str(i));
            set(h, 'ButtonDownFcn',{@callback,i})
        end
    end
    figure()
    plot(Fourier);
   function callback(o,e,idx)
        %# show selected image in a new figure
        figure(2), imshow(imgs{idx})
        title(num2str(idx))
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
       
       
       if(uint16(ind-1)/countEachFace==uint16(i-1)/countEachTestFace)
           noOfHits=noOfHits+1;
       end
    end
    
    recog_rate=noOfHits/noOfTestImages;
 
end
