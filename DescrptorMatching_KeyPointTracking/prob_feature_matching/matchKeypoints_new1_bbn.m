function matches = matchKeypoints_new1()
   
  %%different bounding boxes produced for different random keypoints used for
%%forming affine transformation at different runs.
    load Frame1;
    load Frame2;
    load Descriptor1;
    load Descriptor2;
    im0 = rgb2gray(imread('C:/First_sem/CV/hw2/prob_feature_matching/stop1.jpg'));
    im1 = rgb2gray(imread('C:/First_sem/CV/hw2/prob_feature_matching/stop2.jpg'));
    thresh=0.7;
    dis1=Descriptor1;
    dis2=Descriptor2;
    
    ind1=[];
    ind2=[];
    dis1_new=Descriptor1';
    dis2_new=Descriptor2';
    dist=dist2(double(dis1_new),double(dis2_new));
    for j=1:size(dist,1)
        sortout=sort(dist(j,:));
        min_2(j,:)=sortout(2);
    end
    [mins,ind]=min(dist,[],2);
    for i=1:size(mins,1)
        if(mins(i)<0.6*min_2(i))
            ind1=horzcat(ind1 ,i);
            ind2=horzcat(ind2,ind(i));
        end
    end
    ind1_n=[];
    ind2_n=[];
    v=min(min_2)
    for i=1:size(mins,1)
        if(mins(i)<20000)
            ind1_n=horzcat(ind1_n ,i);
            ind2_n=horzcat(ind2_n,ind(i));
        end
    end
    r1=ind1;
    r2=ind2;
    matches=[r1;r2];
%     matches_n=[ind1_n;ind2_n];
    plotmatches(im0,im1,Frame1,Frame2,matches)
%     plotmatches(im0,im1,Frame1,Frame2,matches_n);
%     for i=1:size(matches,2)
%         x1(i)=Frame1(1,matches(1,i));
%         x2(i)=Frame2(1,matches(2,i));
%         y1(i)=Frame1(2,matches(1,i));
%         y2(i)=Frame2(2,matches(2,i));
%     end
%     
%     for j=1:size(matches,2)
%         if 
    r = randi([1 size(matches,2)],1,3);
    x1=Frame1(1,matches(1,r(1)));
    x2=Frame1(1,matches(1,r(2)));
    x3=Frame1(1,matches(1,r(3)));
    y1=Frame1(2,matches(1,r(1)));
    y2=Frame1(2,matches(1,r(2)));
    y3=Frame1(2,matches(1,r(3)));
    nx1=Frame2(1,matches(2,r(1)));
    nx2=Frame2(1,matches(2,r(2)));
    nx3=Frame2(1,matches(2,r(3)));
    ny1=Frame2(2,matches(2,r(1)));
    ny2=Frame2(2,matches(2,r(2)));
    ny3=Frame2(2,matches(2,r(3)));
% %     76 26 287 236
%     X = zeros(size(matches,2, 1) * 2,6);
%     for k=1:size(matches,2)
%          X(1:2:end, 1) = x1(k);
%          X(2:2:end, 4) = x1(k);
%          X(1:2:end, 2) = y1(k);
%          X(2:2:end, 5) = y1(k);
%          X(1:2:end, 3) = 1;
%          X(2:2:end, 6) = 1;
%          
%              size(X1,1);
%     r=1;
%     k=1;
%     while(r<(2.*size(matches,2)))
%         M(r,:)=[x1(k) y1(k) 0 0 1 0];
% %         M(i+1,:)=[0 0 X1(i) Y1(i) 0 1];
%         r=r+2;
%         k=k+1;
%     end
%     k=1;
%     m=2;
%     while m<=(2.*size(matches,2))
% %         M(i,:)=[X1(i) Y1(i) 0 0 1 0];
% %        if ~(k>size(X1,1))
%         M(m,:)=[0 0 x1(k) y1(k) 0 1];
%         m=m+2;
%         k=k+1;
%     end
    X =[x1 y1 0 0 1 0;0 0 x1 y1 0 1;x2 y2 0 0 1 0;0 0 x2 y2 0 1;x3 y3 0 0 1 0;0 0 x3 y3 0 1]
%     L=[x2(1);y2(1)];
%     for j=2:size(matches,2)
%         L=vertcat(L,x2(j));
%         L=vertcat(L,y2(j));
%     end  
    B=[nx1;ny1;nx2;ny2;nx3;ny3]
    A=B\X;
    size(A)
    Req=[76 26 0 0 1 0;0 0 76 26 0 1;287 236 0 0 1 0;0 0 287 236 0 1]*A';
    
    xr1=Req(1);
    yr1=Req(2);
    xr2=Req(3);
    yr2=Req(4);
%     I=imread('000027.jpg');
    figure(2);imshow(im1);
    hold on
    rectangle('Position',[xr1, yr1, xr2-xr1, yr2-yr1],'FaceColor','r')
    hold off
           
%     m=size(mins)
%     i=size(ind)
%     size(dist)
    
end