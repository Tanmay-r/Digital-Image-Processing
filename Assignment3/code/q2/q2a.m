function recog_rate=q2a(k)
    

    sizeOfImage=92*112;
    noOfFaces=35;
    countEachFace=5;
    countEachTestFace=5;
    
    
    noOfImages=noOfFaces*countEachFace;
    noOfTestImages=noOfImages;
    
    X=zeros(sizeOfImage,noOfImages);
    testImages=zeros(sizeOfImage,noOfTestImages);
    
    count=1;
    testCount=1;
    
    for i=1:noOfFaces
        dir='../../att_faces/s';
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
       
       if(uint16(ind)/5==uint16(i)/5)
           noOfHits=noOfHits+1;
       end
    end
    
    recog_rate=noOfHits/noOfTestImages;
 
end
