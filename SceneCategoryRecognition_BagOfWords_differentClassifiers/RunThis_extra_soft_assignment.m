function [  ] = svm_try(  )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% load train_data_new
% load Test_data_new
% load test_data
% load train_data
load test_data_soft
load train_data_soft
% load spatial_pyr_test_new
% load spatial_pyr_train_new
load gs
out=[];
tic;
t = templateSVM('Standardize', 1); 
model=fitcecoc((train_data_soft),(train_gs'),'Learners', t);
t1=toc;
% for i=1:800
tic;
labels=predict(model,test_data_soft);
t2=toc;
size(labels)
% out=horzcat(out,labels);
% end
% out=msvm(train_data_new,train_gs,Test_data_new)
% out
% size(out)
confusion_matrix=confusionmat(test_gs',labels)
accuracy=(sum(labels'==test_gs)/800)*100
t1
t2
end


