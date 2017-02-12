function [ ] = concat(  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% load test_data_new_sub1
% load test_data_new_sub2
% load test_data_new_sub3
% load test_data_new_sub4
load test_data
load train_data
% load test_1600
% load train_1600
load train_data_new_sub
load test_data_new_sub

spatial_pyr_train_new=[train_data train_data_new_sub{1} train_data_new_sub{2} train_data_new_sub{3} train_data_new_sub{4}];
% save spatial_pyr_train
spatial_pyr_test_new=[test_data test_data_new_sub{1} test_data_new_sub{2} test_data_new_sub{3} test_data_new_sub{4}];
save spatial_pyr_test_new
save spatial_pyr_train_new

end

