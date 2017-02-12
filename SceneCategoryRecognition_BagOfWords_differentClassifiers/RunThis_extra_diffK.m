
load sift_desc
% load DAL
num_per_img=10;
load gs
num_test=800;
num_train=1888;
k=25;
train_data_trials=[];
test_data_trials=[];
dict=[];
for i=1:1888
    des=train_D{i};
    t=randi(size(des,2),[1,num_per_img]) ;
    dict=horzcat(dict,des(:,t));
end

data=double(dict');
size(data)
clust_f_1000=k_m_1(data,k);
clust=clust_f_1000;
for u=1:num_train
    act=double(train_D{u}');
    n1 = size(clust,1);
    n2 = size(act,1);
    ci = sum(clust.^2, 2);
    xi = sum((act').^2, 1);
    %J=sum (sum(cluster_centre.^2+data_pt.^2-2*cluster_centre*data_pt))
    J = repmat(ci,1, n2) + repmat(xi, n1, 1) - 2*clust*act';
    %finding closest cluster for every feature
    [m,ind]=min(J,[],1);
    size(ind);
    train_data_trials(u,:)=histc(ind,1:k);
    train_data_trials(u,:)=train_data_trials(u,:)/sum(train_data_trials(u,:));
end
for u=1:num_test
    act=double(test_D{u}');
    n1 = size(clust,1);
    n2 = size(act,1);
    ci = sum(clust.^2, 2);
    xi = sum((act').^2, 1);
    %J=sum (sum(cluster_centre.^2+data_pt.^2-2*cluster_centre*data_pt))
    J = repmat(ci,1, n2) + repmat(xi, n1, 1) - 2*clust*act';
    %finding closest cluster for every feature
    [m,ind]=min(J,[],1);
    test_data_trials(u,:)=histc(ind,1:k);
    test_data_trials(u,:)=test_data_trials(u,:)/sum(test_data_trials(u,:));
    [m,ind]=min(sum(abs(train_data_trials-repmat(test_data_trials(u,:),[num_train,1])),2));
%     size(ind)
%     labels(u) = train_gs(ind); 
%     if train_gs(ind)==test_gs(u)
%         C=C+1;
%     end
end
disp('class');
t = templateSVM('Standardize', 1); 
model=fitcecoc((train_data_trials),(train_gs'),'Learners', t);
% t1=toc;
% % for i=1:800
% tic;
labels=predict(model,test_data_trials);
% t2=toc;
% size(labels)
% out=horzcat(out,labels);
% end
% out=msvm(train_data_new,train_gs,Test_data_new)
% out
% size(out)
confusion_matrix=confusionmat(test_gs',labels)
accuracy=(sum(labels'==test_gs)/800)*100
