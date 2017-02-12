function [  ] = accur_cal(  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
load train_data
load test_data
load gs
lab=[];
% for i=1:size(Test_data_new,1)
%     [D,ind] = pdist2(train_data_new,Test_data_new(i,:),'euclidean','Smallest',1);
%     lab=horzcat(lab,train_gs(ind));
% %     ind
%     
for u=1:800
    [m,ind]=min(sum(abs(train_data-repmat(test_data(u,:),[num_train,1])),2));
%     size(ind)
    labels(u) = train_gs(ind); 
% 
% % end
% IDX=knnsearch(train_data_new,Test_data_new)
% size(IDX);
% labels=train_gs(IDX)
% % lab
% % size(lab)
% acc=sum(labels==test_gs)
end
confusion_matrix=confusionmat(test_gs',labels)
accuracy = numel(find(labels == test_gs'))/800
end
% acc=sum(lab==test_gs
