function [F,inliers,outliers] = find_fund(matches,c1,r1,c2,r2)


no_inliers=0; 
% outliers=0;
F={};
F_new=[];

for i = 1:30

    ind=randsample(size(matches,1),8)
    idx = matches(ind,:);
    F{i} = fund_comp(idx,c1,r1,c2,r2);
    x1 = c1(matches(:,1));
    y1 = r1(matches(:,1));
    x2 = c2(matches(:,2));
    y2 = r2(matches(:,2));

    p2 = F{i}*[x1';y1';ones(1,size(x1,1))];
    norm2 = sqrt(p2(1,:).^2 + p2(2,:).^2);
    p1 = F{i}'*[x2';y2';ones(1,size(x2,1))];
    norm1 = sqrt(p1(1,:).^2 + p1(2,:).^2);
    %finding inliers by checking the distance of points in first image to
    %epipolar line in second image. Similarly the distance of keypoints in
    %second image and epi-pola
    dist1 = abs(sum([x1';y1';ones(1,size(x1,1))].*p1))./norm1;
    dist2 = abs(sum([x2';y2';ones(1,size(x2,1))].*p2))./norm2;
    inliers = (dist1<2 & dist2<2);

    if (sum(inliers)>no_inliers)
        inliers_most=inliers;
        outliers_less=~inliers;
        no_inliers = sum(inliers);
        F_new=F{i};
    end

end

F=F_new;
inliers=inliers_most;
outliers=outliers_less;

end