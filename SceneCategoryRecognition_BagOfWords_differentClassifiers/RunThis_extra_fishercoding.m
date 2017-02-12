
% load sift_desc
% % load DAL
% num_per_img=10;
% load gs
% num_test=800;
% num_train=1888;
% k=25;
% train_data_trials=[];
% test_data_trials=[];
% dict=[];
% for i=1:1888
%     des=train_D{i};
%     t=randi(size(des,2),[1,num_per_img]) ;
%     dict=horzcat(dict,des(:,t));
% end
% 
% data=double(dict');
% size(data)
% clust_f_1000=k_m_1(data,k);
load clust_gmm
clust=clust_gmm;
train_data_soft=[];
test_data_soft=[];

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
    variance=50000;
    w=exp(-0.5*(dis.^2)./variance);
    weight=sum(w,2);
    train_data_soft(u,:)=weight';
    train_data_soft(u,:)=train_data_soft(u,:)/sum(train_data_soft(u,:));
end
for u=1:num_test
%     label=zeros(size(((train_D{u}))));
    temp=double(test_D{u}');
    ind=[];
    dis=[];
    for j=1:size(temp,1)
         [D] = pdist2(clust,temp(j,:));
         dis=horzcat(dis,D);
%          ind=horzcat(ind,I);
    end
    d_new=sort(dis,'descend');
%     size(dis)
%     variance=mean(d_new(1:5))
    variance=50000;
% %     variance1=mean(var(dis,0,1))
%     [ind1,D]=knnsearch(clust,temp,'K',300);
%     ind1
%     D
%     variance=var(D(1,:));
    w=exp(-0.5*(dis.^2)./variance);
    weight=sum(w,2);
    test_data_soft(u,:)=weight';
    test_data_soft(u,:)=test_data_soft(u,:)/sum(test_data_soft(u,:));
%     size(weight)
%     for p=1:size(ind1,1)
%         for q=1:k
%             s=w(p,q) + s;
%         end
    end
disp('class');
t = templateSVM('Standardize', 1); 
model=fitcecoc((train_data_soft),(train_gs'),'Learners', t);
% t1=toc;
% % for i=1:800
% tic;
labels=predict(model,test_data_soft);
% t2=toc;
% size(labels)
% out=horzcat(out,labels);
% end
% out=msvm(train_data_new,train_gs,Test_data_new)
% out
% size(out)
confusion_matrix=confusionmat(test_gs',labels)
accuracy=(sum(labels'==test_gs)/800)*100
