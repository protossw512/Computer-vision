deepnet = train(deepnet,xTrainImages,tTrain);
%load('deepnet-2.mat','deepnet');
y = deepnet(xTestImages);
plotconfusion(tTest,y);