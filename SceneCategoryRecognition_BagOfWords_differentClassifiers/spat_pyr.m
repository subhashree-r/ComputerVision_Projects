function [ ] = spat_pyr( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load clust_f
clust=clust_f;
% clust=normc(clust_f);
load gs
num_test=800;
num_train=1888;
k=300;
train_data_new_sub={};
train_data_new_sub_temp=[];
h=[];
train_D_new={};
num_sub=4;
% imgDir = dir(fullfile('C:/First_sem/CV/hw5/train', '*.jpg'));
for sub=1:4
    for n=1:num_train
        nm=sprintf('C:/First_sem/CV/hw5/train/%d.jpg',n);
%         nm=imgDir(n).name;
%         im=(imread(fullfile('C:/First_sem/CV/hw5/train', nm)));
        im=imread(nm);
        ans=size(im);
        [r,c,z]=size(im);
        ha=r;
        wa=c;
        a=floor(ha/2);
        b=floor(wa/2);
        temp=train_F{n};
        if sub==1
    %     im_1=im(1:128,384:768,:);
%             im_1=im(1:a,b+1:(wa),:);
           
%         [h,w,z]=size(im_1);
            x_ind=find(temp(1,:)<b);
            y_ind=find(temp(2,:)<a);
        elseif sub==2          
%             im_1=im(1:a,1:b,:);
%             x_ind=find(temp(1,:)<b);
%             y_ind=find(temp(2,:)<a);
            x_ind=find(temp(1,:)>b&temp(1,:)<wa);
            y_ind=find(temp(2,:)<a);
        elseif sub==3
%             im_1=im(b+1:ha,1:b,:);
            x_ind=find(temp(1,:)<b);
            y_ind=find(temp(2,:)<ha&temp(2,:)>a);
        else
%             im_1=im(b+1:ha,b+1:wa,:);
            x_ind=find(temp(1,:)>b&temp(1,:)<wa);
            y_ind=find(temp(2,:)<ha&temp(2,:)>a);
            end

%         temp=train_F{n};
%         [h,w,z]=size(im_1);
% %         x_ind=find(temp(1,:)<w);
% %         y_ind=find(temp(2,:)<h);
        index=intersect(x_ind,y_ind);
        train_D_new{n}=train_D{n}(:,index);
    end
%      size(train_D_new)
%      save train_D_new
    %  size(train_D_new{1})
    % [v,ind]=

    % size(clust_f)
    for u=1:num_train
    %     label=zeros(size(((train_D{u}))));
        temp=double(train_D_new{u}');
        ind=[];
        for j=1:size(temp,1)
             [D,I] = pdist2(clust,temp(j,:),'euclidean','Smallest',1);
             ind=horzcat(ind,I);
        end
    %     ind=knnsearch(clust,temp);
    %     ind
    %     ind
        train_data_new_sub_temp(u,:)=histc(ind,1:k);
        train_data_new_sub_temp(u,:)=train_data_new_sub_temp(u,:)/sum(train_data_new_sub_temp(u,:));
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
    train_data_new_sub{sub}=train_data_new_sub_temp;
%     size(train_data_new_sub4);
%     save train_data_new_sub4
end
save train_data_new_sub
end


