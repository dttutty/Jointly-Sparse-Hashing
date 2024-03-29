clear,clc;
dataName = '_MNIST_';
load data/mnist.mat

traindata = double(traindata);
testdata = double(testdata);
traindata = [traindata, ones(size(traindata,1),1)];
testdata = [testdata, ones(size(testdata,1),1)];
addpath(fullfile('box'));
addpath(fullfile('methods'));
bits = [  8, 16, 32, 64, 96, 128]; 

for  i = 1:length(bits)
    [~] = mnist_demo(bits(i),traindata,traingnd,testdata,testgnd,dataName);
end