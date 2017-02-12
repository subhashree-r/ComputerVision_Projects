function [cIndMap, time, imgVis] = slic_new(img, K, compactness)



%% Implementation of Simple Linear Iterative Clustering (SLIC)
%
% Input:
%   - img: input color image
%   - K:   number of clusters
%   - compactness: the weighting for compactness
% Output: 
%   - cIndMap: a map of type uint16 storing the cluster memberships
%   - time:    the time required for the computation
%   - imgVis:  the input image overlaid with the segmentation

tic;

% Put your SLIC implementation here


img = im2double(img);
imgVis = img;
img = (rgb2lab(img));
sz = size(img);
[rp,cp]=size(img);
S = round(sqrt(sz(1) * sz(2) / K));

% Initialization of clustering centers
x_reg = floor(linspace(1, sz(2), sqrt(K) + 2));
y_reg = floor(linspace(1, sz(1), sqrt(K) + 2));
[Xnew, Ynew] = meshgrid(x_reg(2: end-1), y_reg(2: end-1));
[r1,c1]=size(Xnew);
cIndMap=zeros([size(img,1),size(img,2),2]); 
Dorig = 10000000000000000000*ones(sz(1),sz(2));
[gx,gy] = imgradient(rgb2gray(img));
g = gx.^2+gy.^2;
for i=1:size(Xnew,2)   
    for j=1:size(Xnew,1)
%         mesh=[];
        grad=g(Ynew(i,j)-1:Ynew(i,j)+1,Xnew(i,j)-1:Xnew(i,j)+1);
        [pix,ind]=min(grad(:));
        [dy,dx]=ind2sub([3 3],ind);
        Xnew(i,j)=Xnew(i,j)+dx;
        Ynew(i,j)=Ynew(i,j)+dy;
    end
end

clust_im=zeros([size(Xnew),3]);
for k=1:3   
    clust_im(:,:,k)=img(sub2ind(size(img),Ynew,Xnew,ones(size(Xnew))));
end
Ds_old=[];
Dc_old=[];
for iter=1:10
    iter
    Ds_max=0;
    Dc_max=0;
    % 1. starting assign pixels and distances
    for j = 1:size(Xnew,2)
        for i = 1:size(Xnew,1)
            if isnan(Xnew(i,j)) || isnan(Ynew(i,j))
                continue;
            end
            win_y = max(1,Ynew(i,j)-S):min(Ynew(i,j)+S, size(img,1));
            win_x = max(1,Xnew(i,j)-S):min(Xnew(i,j)+S, size(img,2));
            grad=img(win_y,win_x,:);
            [Xn,Yn]= meshgrid(win_x,win_y);
            clust_im_new=ones(size(grad));
            for idx = 1:size(grad,3)
                clust_im_new(:,:,idx) = clust_im(i,j,idx) * clust_im_new(:,:,idx);
            end
            Ds=sum((grad-clust_im_new).^2,3);
            Dc=(Xn-Xnew(i,j)).^2+(Yn-Ynew(i,j)).^2;
            
            if (iter>1)
                ms=Ds_max;
                mc=Dc_max;
                D=sqrt((Ds./norm(ms)).^2+(Dc./norm(mc)).^2);
            else
                D=Ds+compactness^2*Dc/S^2;
            end
           
            dist = (D < Dorig(win_y,win_x));
            Dorig(win_y,win_x)=dist.*D+~(dist).*Dorig(win_y,win_x);
            cIndMap(win_y,win_x,1)=dist*j+~(dist).*cIndMap(win_y,win_x,1);
            cIndMap(win_y,win_x,2)=dist*i+~(dist).*cIndMap(win_y,win_x,2);
            if norm(Ds)>Ds_max
                Ds_max=(Ds);
            end
            if norm(Dc)>Dc_max
                Dc_max=(Dc);
            end
            
            
%             Dc_old=horzcat(Dc_old,Dc);
            
        end
    end
    for j=1:size(Xnew,2)
        for i=1:size(Xnew,1)
            t=cat(3,j*ones(size(img,1), size(img,2)),i*ones(size(img,1), size(img,2)));
            mask=(cIndMap==t);
            mask=mask(:,:,1) & mask(:,:,2);
            [r,c]=find(mask);                
            Xnew(i,j)=round(mean(c));   
            Ynew(i,j)=round(mean(r));
            for k=1:3
                mn_img(:,:,k)=img(:,:,k).*mask;
            end
            [~,~,mr]=find(mn_img(:,:,1));
            [~,~,mg]=find(mn_img(:,:,2));
            [~,~,mb]=find(mn_img(:,:,3));
            clust_im(i,j,1)=mean(mr);
            clust_im(i,j,2)=mean(mg);
            clust_im(i,j,3)=mean(mb);
        end
    end
    
    
end
% figure(2);
% title('Error Map when convergence');
% imagesc(log(Dorig))

for j=1:size(Xnew,2)
    for i=1:size(Xnew,1)
        t=cat(3,j*ones(size(img,1), size(img,2)),i*ones(size(img,1), size(img,2)));
        mask=(cIndMap==t);
        mask=mask(:,:,1) & mask(:,:,2);
        index=find(mask);
        if sum(mask(:))<0.3*S^2
            cIndMap(index)=0;
            new_cent_clusy = max(1,i-1):min(i+1,size(Xnew,1));
            new_cent_clusx = max(1,j-1):min(j+1,size(Xnew,2));
            xregion=Xnew(new_cent_clusy,new_cent_clusx);
            yregion=Ynew(new_cent_clusy,new_cent_clusx);
            thresh=(xregion-Xnew(i,j)).^2+(yregion-Ynew(i,j)).^2;
            [~,ind]=sort(thresh(:),'ascend');
            [dy,dx] = ind2sub(size(thresh), ind(2));
            dy_new = new_cent_clusy(dy);
            dx_new = new_cent_clusx(dx);
            size(index)
            % set all the pixels to the nearest cluster center
            cIndMap(index)=dx_new;
            cIndMap(index+size(cIndMap,1)*size(cIndMap,2))=dy_new;
        else
            cIndMap(index)=j;
            cIndMap(index+size(cIndMap,1)*size(cIndMap,2))=i;
        end                  
    end
end

id=sub2ind(size(Xnew),cIndMap(:,:,2),cIndMap(:,:,1))
cIndMap=sub2ind([size(img,1),size(img,2)],Ynew(id),Xnew(id));
time = toc;
[gx,gy]=imgradient(cIndMap);
bMap = (gx.^2 + gy.^2) > 0;
imgVis(bMap)=255;
% figure(4); subplot(1,3,3);
% imshow(imgVis,[]);
% title('Segmented picture');
cIndMap = uint16(cIndMap);
end