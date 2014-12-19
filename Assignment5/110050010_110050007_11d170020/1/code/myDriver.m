function myDriver()
    clear all
    close all
    addpath('../../common/export_fig/')
    addpath('../../common/')
    
    sigma1 = [2, 0; 0, 2];
    sigma2 = [2, 0; 0, 2];
    Data = generateData(3000,sigma1,sigma2);
    plot(Data(1,:), Data(2,:),'r.');
    print('-dpng','../images/scatterplot.png');
    
    [iteration,S1Data] = meanShiftClustering(Data, 1*eye(2));
    hold on;
    plot(S1Data(1,:), S1Data(2,:),'b*');
    print('-dpng','../images/clusterCenter.png');
end
