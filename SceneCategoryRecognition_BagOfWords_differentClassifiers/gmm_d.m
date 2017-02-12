function [ clust ] = gmm_d( data,k )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
load gs
% load gs.train_D
% train_D
% size(data)
% k=300;
% 
t=randi(size(data,1),[1,k]);
t2=randi(size(data,1),[1,500]);
id=eye(k);
%initialization
clust=data(t,:);
X=data(t2,:);%300*128
% size(clust)
for iter=1:1
%     disp(iter);
%     new=[];
%     for i=1:size(data,1)
%         [D,I] = pdist2(clust,data(i,:),'euclidean','Smallest',1);
%         new=horzcat(new,I);
%     % (I)
%     end
%     size(new)
    obj=fitgmdist(data,300,'CovarianceType','diagonal','RegularizationValue',0.1)
    size(obj.mu)
%     o=size(obj);
%     [idx,nlogl] = cluster(obj,X);
%     idx;
%     size(idx)

%     for j=1:k
% 
%         ind=find(idx==k);
%         c=mean(data(ind,:));
%         clust(k,:)=c;
% %         size(c)
%     end
end
size(clust)
clust_gmm=obj.mu;
save clust_gmm
end





