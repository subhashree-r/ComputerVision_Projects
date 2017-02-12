function matches = matchKeypoints_bb()
   

    load Frame1;
    load Frame2;
    load Descriptor1;
    load Descriptor2;
    im0 = rgb2gray(imread('C:/First_sem/CV/hw2/prob_feature_matching/stop1.jpg'));
    im1 = rgb2gray(imread('C:/First_sem/CV/hw2/prob_feature_matching/stop2.jpg'));
    thresh=0.7
    dis1=Descriptor1;
    dis2=Descriptor2;
    
%     size(Descriptor1)
%     size(Frame1)
%     n=size(a)
%     dis=(norm((Descriptor1(:,1)-Descriptor2(:,1)),2))
%     [min_dis,ind]=sort(dis)
%     dis_fin=[min_dis(1)]
%     
%     for i=1:size(Descriptor1,2)
%         dis(i,:)=sqrt((Descriptor1(:,1)-Descriptor2(:,1)).^2)
        
%     dis=sqrt(dis*dis')
    
%     size(min_dis)
%     size(ind)
%     size(dis)
    threshold=1140
    check1=[3000]
    dis2_new=dis2';
%     dis_fin=[3000];
    ind1=[]
    ind2=[]
    matches= zeros(2,size(dis1,1));
    for i=1:size(dis1,2)
        
        size(dis1(:,i))
        size(dis2_new)
        dist =double(dis1(:,i)) *double( dis2_new);
        [min_dis,ind]=sort((dist));
        checkp=size(dist)
        if min_dis(1)<threshold
            matches(i)=1;
        else
            matches(i)=0;
        end
    end
            
     
    ind1=find(matches>0);
    ind2=matches(ind1);
    s_in1=size(ind1);
    s_ind2=size(ind2);
    r1=ind1';
    r2=ind2';
    matches=[r1;r2];
    plotmatches(im0,im1,Frame1,Frame2,matches)
    
%          min_dis
%        
%         check=(min_dis(2))
%         check1=horzcat(check1,check);
       
%        check=max(min_dis(2).*.8)
%        if min_dis<10
%            match(
           
%        dis_fin=horzcat(dis_fin,min_dis(1))

    x1=Frame1(1,matches(1,3));
    x2=Frame1(1,matches(1,6));
    x3=Frame1(1,matches(1,9));
    y1=Frame1(2,matches(1,3));
    y2=Frame1(2,matches(1,6));
    y3=Frame1(2,matches(1,6));
    nx1=Frame2(1,matches(1,3));
    nx2=Frame2(1,matches(1,6));
    nx3=Frame2(1,matches(1,9));
    ny1=Frame2(2,matches(1,3));
    ny2=Frame2(2,matches(1,6));
    ny3=Frame2(2,matches(1,6));
%     76 26 287 236
    X=[x1 y1 0 0 1 0;0 0 x1 y1 0 1;x2 y2 0 0 1 0;0 0 x2 y2 0 1;x3 y3 0 0 1 0;0 0 x3 y3 0 1]
    B=[nx1;ny1;nx2;ny2;nx3;ny3]
    A=B\X;
    Req=[76 26 0 0 1 0;0 0 76 26 0 1;287 236 0 0 1 0;0 0 287 236 0 1]*B
       
    end
       
%     now=min(check1)   
%         
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here




