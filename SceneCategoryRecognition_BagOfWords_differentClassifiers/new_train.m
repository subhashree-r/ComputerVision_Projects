function [] = new_train(  )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

load clust_f
clust=clust_f;
% clust=normc(clust_f);
load gs
num_test=800;
num_train=1888;
k=300;
train_data_new=[];
h=[];

% size(clust_f)
for u=1:num_train
%     label=zeros(size(((train_D{u}))));
    temp=double(train_D{u}');
%     temp1=double(train_D');
    ind=[];
    for j=1:size(temp,1)
         [D,I] = pdist2(clust,temp(j,:),'euclidean','Smallest',1);
         ind=horzcat(ind,I);
    end
    size(ind);
    ind1=knnsearch(clust,temp,'K',300);
    size(ind1)
%     ind
%     ind
    train_data_new(u,:)=histc(ind,1:k);
    train_data_new(u,:)=train_data_new(u,:)/sum(train_data_new(u,:));
%     size(I)
%     I
%     I
%     temp(1,1)
%     size(temp)
%     size((repmat(temp(:,1),[1 300])))   
%    for i=1:size(temp,2)
% % %         for j=1:size(temp,2)
%         dist=(sum(abs(repmat(temp(:,i),[1 300])-clust_f'),1));
%         [D,I] = pdist2(clust_f,temp(:,i),'euclidean','Smallest',1);
%         [m,ind]=min(dist);
%         h=horzcat(h,ind);
%    end
%    train_data_new(u,:)=histc(h,1:k);
%    train_data_new(u,:)=train_data_new(u,:)/sum(train_data_new(u,:));
%    (h)

%     ind
% 
%     end
end
size(train_data_new);
train_data=train_data_new;
save train_data
end

