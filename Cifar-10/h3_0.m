% Download CIFAR-10 data to a temporary directory
cifar10Data = tempdir;
% % 
% url = 'https://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz';
% % 
% helperCIFAR10Data.download(url, cifar10Data);

% Load the CIFAR-10 training and test data.
[temptrain, ttrain, temptest, ttest] = helperCIFAR10Data.load(cifar10Data);



xTrainImages = {}
for i = 1:50000
    xTrainImages{i} = im2double(temptrain(:,:,:,i));
end

xTestImages = {}
for i = 1:10000
    xTestImages{i} = im2double(temptest(:,:,:,i));
end

ttrain = grp2idx(ttrain)
ttest = grp2idx(ttest)

ttrain = transpose(ttrain)
m = 50000;
tTrain = zeros(m, 10);
for i = 1:m
    tTrain(i, ttrain(i)) = 1;
end
tTrain = transpose(tTrain);

ttest = transpose(ttest)
n = 10000;
tTest = zeros(n, 10);
for i = 1:n
    tTest(i, ttest(i)) = 1;
end
tTest = transpose(tTest);