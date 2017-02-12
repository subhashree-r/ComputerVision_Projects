function [G, L] = pyramidsGL(im, N)
    G={};
    L={};
    cutoff_frequency=7;
%     im_new={};
%     G={};
%     N={};
    filter = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
   
    size(im) 
    G{1}=im;
    im_new=imfilter(G{1},filter);
    orig_filt_img= G{1};
    size(im_new)
    
    for i=2:5
        G{i}= imresize(im_new,.5);
        im_new=imfilter(G{i},filter);
    end
    disp('finishedG');
    size(G{1})
    a=size(imresize(G{1},2))
    b=size(orig_filt_img)
%     if a(1)~=b(1)&& a(2)==b(2)
%         orig_filt_img=[orig_filt_img ;zeros(1,a(2))];
%         disp('YES')
%     
%     elseif a(2)~=b(2)&& a(1)==b(1)
%         orig_filt_img=[orig_filt_img  zeros(a(1),1)];
%     
%     elseif a(2)~=b(2)&& a(1)~=b(1)
% %         X=[[zeros(1,a(2));orig_filt_img] zeros(a(1)+1,1)];
% %         orig_filt_img=[orig_filt_img ;zeros(a(1),1)];
% %         orig_filt_img=[orig_filt_img zeros(1,a(2))];
%         orig_filt_img=padarray(orig_filt_img,[1 1],0,'post');
%     end
    c=size(orig_filt_img);
    d=size(imresize(G{1},2));
    t1=(imresize(G{2},2));
    if c(2)~=d(2)&& c(1)==d(1)
           
        t1=t1(:,1:c(2),:)
%               G{j-1}=[G{j-1} zeros(c(1),1)];
    elseif c(1)~=d(1)&& c(2)==d(2)
        t1=t1(1:c(1),:,:)
%               G{j-1}=[G{j-1}; zeros(1,c(2))];
    elseif c(2)~=d(2)&& c(1)~=d(1)
        t1=t1(1:c(1),1:c(2),:)
    end
%     a1=size(imresize(G{1},2))
%     b1=size(X)
%         
%     size(orig_filt_img)
%     if size(orig_filt_img)== size(imresize(G{1},2))
    L{1}= (orig_filt_img - (imfilter(t1,filter)));
%         disp('yes');
%     else
%         disp('no');
%     end
%     Y=[]
    for j= 2:4
        disp(j)
        c=size(G{j});
        d=size(imresize(G{j+1},2));
        t2=(imresize(G{j+1},2));
        if c(2)~=d(2)&& c(1)==d(1)

            t2=t2(:,1:c(2),:)
    %               G{j-1}=[G{j-1} zeros(c(1),1)];
        elseif c(1)~=d(1)&& c(2)==d(2)
            t2=t2(1:c(1),:,:)
    %               G{j-1}=[G{j-1}; zeros(1,c(2))];
        elseif c(2)~=d(2)&& c(1)~=d(1)
            t2=t2(1:c(1),1:c(2),:)
        end
        
        L{j}=G{j}-(imfilter(t2,filter))
        
    end
    L{5}=G{5};
%    
% %         if a1~=a2
%     if size(G{j-1})==size(imresize(G{j},2))
%         L{j}=G{j-1}- imresize(G{j},2);
%     else
%         disp('no')
%         size(G{j-1})
%         size(imresize(G{j},2))
% %     end
%     
%     size(im_new)
%     G=imresize(im_new,.5);
%     size(G)
%     size(im_new)
%     L=im_new-(imresize(G,2));
    
%         im= G{i};
        


end

