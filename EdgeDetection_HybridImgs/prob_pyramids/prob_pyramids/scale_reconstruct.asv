function img=scale_reconstruct(L)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    L{1}=L{1}*2;
    cutoff_frequency=7;
    filter = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
    s={} 
    c=size(L{4});
    d=size((imresize(L{5},2)));
    t1=imresize(L{5},round([size(L{4}, 1), size(L{4}, 2)]),'bicubic');
%     t1=imresize(t1,size(L{4}),'bicubic');
%     if c(2)~=d(2)&& c(1)==d(1)
%            
%         t1=t1(:,1:c(2),:)
% %               G{j-1}=[G{j-1} zeros(c(1),1)];
%     elseif c(1)~=d(1)&& c(2)==d(2)
%         t1=t1(1:c(1),:,:)
% %               G{j-1}=[G{j-1}; zeros(1,c(2))];
%     elseif c(2)~=d(2)&& c(1)~=d(1)
%         t1=t1(1:c(1),1:c(2),:)
%     end
    s{4}=L{4}+(imfilter(t1,filter));
%     act=size(s{4}) 
%     t1=imfilter(imresize(s{4},2),filter);
%     t1=t1(
% %     g3=L{3}+t1;
%     size(L{3})
%     size(t1)
%     
    for i=0:2
        j=3-i;
        c=size(L{j});
        
%         t=imresize(s{j+1},2);
%         d=size(t);
        t=imresize(s{j+1},round([size(L{j}, 1), size(L{j}, 2)]),'bicubic');
%         rect=[0 0 c(1) c(2)]
%         t=imcrop(t,rect)
%         if c(2)~=d(2)&& c(1)==d(1)
%            
%             t=t(:,1:c(2),:)
% %               G{j-1}=[G{j-1} zeros(c(1),1)];
%         elseif c(1)~=d(1)&& c(2)==d(2)
%             t=t(1:c(1),:,:)
% %               G{j-1}=[G{j-1}; zeros(1,c(2))];
%         elseif c(2)~=d(2)&& c(1)~=d(1)
%             t=t(1:c(1),1:c(2),:)
%         end
        
%         a=L_temp;
        s{j}=L{j}+(imfilter(t,filter));
        size(t)
        size(L{j})
        
    end
%     for i=1:5
%         disp(size(L{i}))
%     end
    
%     img=L_temp;
    
    img=s{j};



end

