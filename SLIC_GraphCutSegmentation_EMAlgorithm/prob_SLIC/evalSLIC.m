% Evaluate SLIC implementation

% 
% ECE 5554/4554 Computer Vision, Fall 2016
% Virgimnia Tech

addpath(genpath('BSR'));
addpath(genpath('superpixel_benchmark'));

% Run the complet benchmark
main_benchmark('evalSlicSetting.txt');

% Report the case with K = 256
load('result\slic\slic_256\benchmarkResult.mat');

avgRecall   =  mean(imRecall(:));
avgUnderseg =  mean(imUnderseg(:));
fprintf('Average boundary recall = %f for K = 256 \n' , avgRecall);
fprintf('Average underseg error  = %f for K = 256 \n' , avgUnderseg);
