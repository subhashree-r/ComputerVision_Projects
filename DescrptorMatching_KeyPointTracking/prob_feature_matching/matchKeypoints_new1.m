function matches = matchKeypoints_new1()
   
    
    load SIFT_features.mat;
    save Frame1;
    save Frame2;
    save Descriptor1;
    save Descriptor2;
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
           
%     m=size(mins)
%     i=size(ind)
%     size(dist)
    
end