% Load the training data into memory
batch_1 = load('data_batch_1.mat');
batch_2 = load('data_batch_2.mat');
batch_3 = load('data_batch_3.mat');
batch_4 = load('data_batch_4.mat');
batch_5 = load('data_batch_5.mat');
xTrainImages = [batch_1.data; batch_2.data; batch_3.data; batch_4.data; batch_5.data];
xTrainImages = transpose(xTrainImages);
xTrainImages = im2double(xTrainImages);

ttrain = [batch_1.labels; batch_2.labels; batch_3.labels; batch_4.labels; batch_5.labels];
ttrain = transpose(ttrain)
m = 50000
tTrain = zeros(m, 10);
for i = 1:m
    tTrain(i, ttrain(i) + 1) = 1;
end
tTrain = transpose(tTrain);

% rng('default') % set the random number generator seed
% hiddenSize1 = 200; % set the number of hidden nodes in Layer 1
% autoenc1 = trainAutoencoder(xTrainImages,hiddenSize1, ...
% 'MaxEpochs',400, 'UseGPU',false, ...
% 'EncoderTransferFunction','satlin',...
% 'DecoderTransferFunction','purelin',...
% 'L2WeightRegularization',0.004, ...
% 'SparsityRegularization',4, ...
% 'SparsityProportion',0.15, ...
% 'ScaleData', false);                                  