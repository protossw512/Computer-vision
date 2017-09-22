rng('default') % set the random number generator seed
feat3 = encode(autoenc3,feat2);
softnet = trainSoftmaxLayer(feat3,tTrain,'MaxEpochs',200);