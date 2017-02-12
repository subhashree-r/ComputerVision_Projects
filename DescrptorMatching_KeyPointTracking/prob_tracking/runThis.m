
[x,y] = keypoint();
figure(4);
hold on;
plot( x, y, '.g', 'LineWidth', 5);

startXs = x;
startYs = y;
c=size(startXs);
%A1checkinitial = [newXs,newYs];
disapp_pts_x=[];
disapp_pts_y=[];
x_temp=startXs;
y_temp=startYs;
count=size(startXs,1);
newXs=[];
newXy=[];
im_orig=imread('C:/First_sem/CV/hw2 - Copy/prob_tracking/images/hotel.seq0.png');
px={};
py={};
lx={};
ly={};


for i=0:40
    fn1 = sprintf('C:/First_sem/CV/hw2 - Copy/prob_tracking/images/hotel.seq%d.png',i);
    im0=imread(fn1);
    im0=im2double(im0);
    fn2 = sprintf('C:/First_sem/CV/hw2 - Copy/prob_tracking/images/hotel.seq%d.png',i+1);
    im1=imread(fn2);
    im1=im2double(im1);
%     figure(5);
%     imshow(im_orig);
%     hold on;
%     plot(x_temp,y_temp,'r.', 'linewidth',5);
%     hold off;
%     
    
    
    [x_1,y_1]= predictTranslationAll(x_temp, y_temp, im0, im1);
    px{i+1}=x_1;
    py{i+1}=y_1;
    
%     size(x_1)
%     newXs(:,i+1)=x_1;
%     newYs(:,i+1)=y_1;
%     chexk=size(newXs(:,i+1))
    x_temp=x_1;
    y_temp=y_1;
    
    
%     if newXs(:,i+1)==0
%         count=count-1;
%         disapp_pts_x=horzcat(disapp_pts_x,newXs(:,i+1));
%         disapp_pts_y=horzcat(disapp_pts_y,newYs(:,i+1));
%     end
end
    
figure(3)
% 
imshow(im_orig);
hold on;
axis([0 1 0 1])
plot(startXs,startYs,'.g', 'LineWidth', 5)
% % rands = randi([1,(count)], 1, 20);
% 
% rands = randi([1,size(startXs, 1) - 1], 1, 20);
for i = 1:40
   for j=1:size(startXs,1) 
        line([round(px{i}(j)) round(px{i+1}(j))],[round(py{i}(j)) round(py{i+1}(j))],'Marker','.','LineStyle','-')
%         plot(px{i},py{i},'.r', 'LineWidth', 5)
 end  
end
%     H=[px{i}';px{i+1}']
%     M=[py{i}';py{i+1}']
%     plot(H,M);
    


hold off;
figure(5);
imshow(im_orig);
hold on;
plot(startXs,startYs,'.g', 'LineWidth', 5)

for i = 6:30
    plot(px{i},py{i},'.r', 'LineWidth', 5)
end
hold off;
figure(6);
imshow(im_orig);
hold on;
%%%plotting lost points%%%
for k=1:9
    for j=1:size(startXs,1) 
        if(px{k}(j)<10)||px{k}(j)>size(im_orig,1)||(py{k}(j)>size(im_orig,2)||(py{k}(j)<10))
            plot(px{k},py{k},'.r', 'LineWidth', 5)
        end
    end
end
hold off;
            
    
% end
% hold off;

% figure(2);
% imshow(im_orig);
% hold on;
% %%%%plotting lost points%%%%(
% for i=1:size(disapp_pts_x,1)
%     plot(disapp_pts_x(i),disapp_pts_y(i), '.g', 'linewidth', 3);
% end

    

    

% end
% 

