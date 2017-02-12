function [ ] = build_bag_words(  )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

load sift_desc
load DAL
num_per_img=10;
dict=[];
for i=1:1888
    des=train_D{i};
    t=randi(size(des,2),[1,num_per_img]) ;
    dict=horzcat(dict,des(:,t));
end

data=double(dict');
clust_f=k_m_1(data,1000);
save clust_f
% clust_fisher=extra_fisher(data,300);
% size(clust)
% clust=[];
% size(dict)
% % [cent,clust]=km_fun(dict,200,5);
% clust=DAL;
% clust_act=clust(:,1:200);
% 
% % d=dist2(clust,double(train_D{2}'));
% % [m,in]=min(d,[],1);
% temp=clust_act';
% temp=normc(temp);
% X=double(train_D{2}');
% Y=double(temp);
% 
% size(clust)
% % t=delaunayTriangulation(X) ;
% % [d,IDX]=nearestpoint(X,Y);
% d=dsearchn(X,Y);
% 
% size(d)
% % d
% in
% size(m)
% size(in)
% size(d)
% size(dict)
end