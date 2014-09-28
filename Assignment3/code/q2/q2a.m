function recog_rate=q2a(k,param)
    

    if(param==1)
        sizeOfImage=92*112;
        noOfFaces=35;
        countEachFace=5;
        countEachTestFace=5;
    else
        sizeOfImage=192*168;
        noOfFaces=39;
        countEachFace=2;
        countEachTestFace=3;
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
    
    
    [v,~]=eigs(L,k);
   
    eig_vec=X*v;
    eig_vec=normc(eig_vec);
    
    coeff=eig_vec'*X;
    testCoeff=eig_vec'*testImages; 
    
    
    noOfHits=0;
    for i=1:noOfTestImages
        
       temp=coeff;
       for j=1:k
          temp(:,j)=temp(:,j)-testCoeff(:,i);
       end
       temp=temp.^2;
       temp=sum(temp,1);
       [~,ind]=min(temp);
       
       if(uint16(ind-1)/countEachTestFace==uint16(i-1)/countEachTestFace)
           noOfHits=noOfHits+1;
       end
    end
    
    recog_rate=noOfHits/noOfTestImages;
 
end
