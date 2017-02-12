function [  ] = runThis(  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
load gs
% load train_gs


% hist{1}
c=0;
load hist
labels=[];
for m=1:800
%     m
    nm=sprintf('C:/First_sem/CV/hw5/test/%d.jpg',m);
    test_im=im2double(imread(nm));
    hist_test=new_try(test_im,[50 50 50]);
    for k=1:1888
    %     size(final_color{1})
    %     size(color_hist_train)
    %     dist=;
        temp=pdist2(hist{k},  hist_test);
        dist(k)=norm(temp);
    %     size(dist{1})
    

    end
    [min_d,ind]=min(dist);
    labels(m)=train_gs(ind);
    if(train_gs(ind)==test_gs(m))
        
        c=c+1;
    end
end
confusion_matrix=confusionmat(test_gs,labels')
acc=c/700
end
%     train_gs(ind)