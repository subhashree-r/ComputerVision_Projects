function [ ] = test_new( )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
load clust_f
clust=clust_f;
% clust=normc(clust);
load gs
load train_data_new
num_test=800;
num_train=1888;
k=300;
labels=zeros(num_test,1);
Test_data_new=[];
h=[];

for u=1:num_test
%     label=zeros(size(((train_D{u}))));

    temp=double(test_D{u}');
    ind=[];
    for j=1:size(temp,1)
         [D,I] = pdist2(clust,temp(j,:),'euclidean','Smallest',1);
         ind=horzcat(ind,I);
    end
%     ind
%     ind=knnsearch(clust,temp);
    Test_data_new(u,:)=histc(ind,1:k);
    Test_data_new(u,:)=Test_data_new(u,:)/sum(Test_data_new(u,:));
%     temp=double(test_D{u});
% %     temp(1,1)
% %     size(clust)
% %     size((repmat(temp(:,1),[1 300])))   
%    for i=1:size(temp,2)
% % %         for j=1:size(temp,2)
%         dist=(sum(abs(repmat(temp(:,i),[1 300])-clust_f'),1));
%         [m,ind]=min(dist);
%         h=horzcat(h,ind);
%    end
%    Test_data_new(u,:)=histc(h,1:k);
%    Test_data_new(u,:)=Test_data_new(u,:)/sum(Test_data_new(u,:));
%    [m,ind]=min(sum(abs(train_data_new-repmat(Test_data_new(u,:),[num_train,1])),2));
% %     size(ind)
%     labels(u) = train_gs(ind);
%     (h)

%     ind
% 
%     end
end
test_data=Test_data_new
save test_data
% accuracy = numel(find(labels == test_gs'))/num_test
end

