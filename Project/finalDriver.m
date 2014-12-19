function [minIndex]=finalDriver(param,testParam,loadParamT,loadParamH,dataParam)

    k=20;
    
    if(dataParam==1)
        Database=makeLMfilters;
    elseif(dataParam==2)
        Database=makeRFSfilters;
    else
        Database=makeSfilters;
    end
        
    
    if(param==1)
        basefile='./NormalizedBrodatz/D';
        imageSet=zeros(512,512,112);
        for i=1:112
            filename=strcat(basefile,int2str(i),'.tif');
            image = mat2gray(imread(filename));
            image = image(1:512,1:512);
            image=preprocessImage(image);
            imageSet(:,:,i)=image;
        end
    end
    textonDatabase=zeros(1,1);
    if(loadParamT==1 && param==1)
        load('./param1/textonDatabase.mat','textonDatabase');
    else
        textonDatabase=generateTextonDatabase(k,Database,imageSet);
        save('./param1/textonDatabase.mat','textonDatabase');
    end
    
    if(loadParamH==1 && param==1)
        load('./param1/histDatabase.mat','histDatabase');
    else
        histDatabase=generateHistDatabase(textonDatabase,Database,imageSet);
        save('./param1/histDatabase.mat','histDatabase');
    end
    
    
    
    
    if(testParam==1)
        basefile='./NormalizedBrodatz/D';
        testImageSet=zeros(128,128,112*5);
        for i=1:112            
            filename=strcat(basefile,int2str(i),'.tif');
            image = mat2gray(imread(filename));
            for k = 1:5
                test_image = image((k-1)*128+1:k*128,513:640);
                test_image=preprocessImage(test_image);
                testImageSet(:,:,(i-1)*5+k)=test_image;
            end
        end
    else
        basefile='./textures/1.3.';
        testImageSet=zeros(1024,1024,13);
        for i=1:13
            filename=strcat(basefile,int2str(i),'.tiff');
            image = mat2gray(imread(filename));
            image=preprocessImage(image);
            testImageSet(:,:,i)=image;
        end
    end
    
    minIndex=test(Database, histDatabase, textonDatabase, testImageSet);

end