    
load matches;
% load r1;
% load c1;
% load r2;
% load c2;
% save c1;
% save c2;
% save r1;     
im1=imread('C:/First_sem/CV/hw3/hw3/prob_fundamental_matrix/chapel00.PNG')    
im2=imread('C:/First_sem/CV/hw3/hw3/prob_fundamental_matrix/chapel01.PNG')

[F,inliers,outliers] = find_fund(matches,c1,r1,c2,r2);
h=plotmatches(im1,im2,[c1 r1]',[c2 r2]',matches(outliers,:)');
n_outlier = sum(outliers);
fprintf(1, 'The number of outliers is %d\n', n_outlier);

X_outlier = c1(matches(outliers,1));
Y_outlier = r1(matches(outliers,1));
figure,imshow(im1),hold on;
plot(X_outlier,Y_outlier,'g.','linewidth',4),hold off;
title('Outliers ');
figure(5);
imshow(im1);hold on;
X_inlier = c1(matches(inliers,1));
Y_inlier = r1(matches(inliers,1));
plot(X_inlier,Y_inlier,'r.','linewidth',4),hold off;
title('Inliers ');

no_inliers = randperm(sum(inliers));
tempIdx = find(inliers>0);
idx = matches(tempIdx(no_inliers(1:8)),:);
x1 = c1(idx(:,1));
y1 = r1(idx(:,1));
x2 = c2(idx(:,2));
y2 = r2(idx(:,2));
figure;title('Epipolar lines ');
subplot(1,2,1),imshow(im1),hold on;
for i = 1:8
    p1 = F'*[x2(i);y2(i);1];
    x = 1:size(im1,2);
    plot(x1(i),y1(i),'r+','linewidth',1),hold on;
    plot(x,(-p1(1)/p1(2)).*x - p1(3)/p1(2),'g'),hold on;
end
subplot(1,2,2),imshow(im2), hold on;
for i = 1:8
    %finding the corresponding epi-polar lines of points in img1 on img2
    p2 = F*[x1(i);y1(i);1];
    x = 1:size(im1,2);
    plot(x2(i),y2(i),'r+','linewidth',1),hold on;
    plot(x,(-p2(1)/p2(2)).*x - p2(3)/p2(2),'g'),hold on;
end
hold off;