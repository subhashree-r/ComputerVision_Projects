function [ output_args ] = soft_ass_train()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load clust_f
clust=clust_f;
% clust=normc(clust_f);
load gs
num_test=800;
num_train=1888;
k=300;
% train_data_new=[];
h=[];
train_data_soft=zeros(num_train,k);
s=[];

% size(clust_f)
for u=1:num_train
%     label=zeros(size(((train_D{u}))));
    temp=double(train_D{u}');
    ind=[];
    dis=[];
    for j=1:size(temp,1)
         [D] = pdist2(clust,temp(j,:));
         dis=horzcat(dis,D);
%          ind=horzcat(ind,I);
    end
%     size(dis)
%     variance=mean(var(dis,0,1));
    d_new=sort(dis,'descend');
%     distance_s=size(d_new)
%     variance=mean(d_new(1:
%     [ind1,D]=knnsearch(clust,temp,'K',300);
%     ind1
%     D
%     variance=mean(d_new(1:5));
    variance=20000;
    w=exp(-0.5*(dis.^2)./variance);
    weight=sum(w,2);
    train_data_soft(u,:)=weight';
    train_data_soft(u,:)=train_data_soft(u,:)/sum(train_data_soft(u,:));
    size(weight);
%     for p=1:size(ind1,1)
%         for q=1:k
%             s=w(p,q) + s;
%         end
    end
%   size(s)
  save train_data_soft

%     end

end


