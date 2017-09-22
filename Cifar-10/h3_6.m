deepnet = train(deepnet,xTrainImages,tTrain);
%load('deepnet-1.mat', 'deepnet');
y = deepnet(xTestImages);
plotconfusion(tTest,y);