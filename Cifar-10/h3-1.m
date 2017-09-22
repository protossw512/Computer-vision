% Load the training data into memory
batch_1 = load('data_batch_1.mat');
batch_2 = load('data_batch_2.mat');
batch_3 = load('data_batch_3.mat');
batch_4 = load('data_batch_4.mat');
batch_5 = load('data_batch_5.mat');
xTrainImages = [batch_1.data; batch_2.data; batch_3.data; batch_4.data; batch_5.data];
tTrain = [batch_1.labels; batch_2.labels; batch_3.labels; batch_4.labels; batch_5.labels];

rng('default') % set the random number generator seed
hiddenSize1 = 100; % set the number of hidden nodes in Layer 1
autoenc1 = trainAutoencoder(xTrainImages,hiddenSize1, ...
'MaxEpochs',400, ...
'L2WeightRegularization',0.004, ...
'SparsityRegularization',4, ...
'SparsityProportion',0.15, ...
'ScaleData', false);