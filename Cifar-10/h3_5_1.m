% Load the testing data into memory
test = load('test_batch.mat');
xTestImages = test.data;
xTestImages = transpose(xTestImages);
xTestImages = im2double(xTestImages);

ttest = test.labels;
ttest = transpose(ttest);
m = 10000;
tTest = zeros(m, 10);
for i = 1:m
    tTest(i, ttest(i) + 1) = 1;
end
tTest = transpose(tTest);

load('autoenc1.mat', 'autoenc1')
load('autoenc2.mat', 'autoenc2')
load('autoenc3.mat', 'autoenc3')
load('softnet2.mat', 'softnet')

deepnet = stack(autoenc1,autoenc2,autoenc3,softnet);
view(deepnet);

y = deepnet(xTrainImages);
plotconfusion(tTrain,y);