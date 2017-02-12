im1=imread((('C:/First_sem/CV/hw2/prob_tracking/images/hotel.seq0.PNG')));
im1=im2double(im1);
[x,y] = keypoint(im1);
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
im_orig=imread('C:/First_sem/CV/hw2/prob_tracking/images/hotel.seq0.png');
px={};
py={};


for i=0:10
    fn1 = sprintf('C:/First_sem/CV/hw2/prob_tracking/images/hotel.seq%d.png',i);
    im0=imread(fn1);
    im0=im2double(im0);
    fn2 = sprintf('C:/First_sem/CV/hw2/prob_tracking/images/hotel.seq%d.png',i+1);
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
flow(:,:,1)=px{10}-px{1};
flow(:,:,2)=py{10}-py{1};
flowToColor(flow);
    
figure(3)
% 
imshow(im_orig);
hold on;

% % rands = randi([1,(count)], 1, 20);
% 
% rands = randi([1,size(startXs, 1) - 1], 1, 20);
% for i = 1:30
%     H=[px{i}';px{i+1}']
%     M=[py{i}';py{i+1}']
%     plot(H,M);
%     
% 
% end
% hold off;
plot(px{1}, py{1},'.g','LineWidth',5)
for i=1:10
    plot(px{i}, py{i},'.r','LineWidth',5)
end
hold off;
% figure(4);
% imshow(im_orig);
% hold on;

% % hold on;
% for i=2:11
%     for j=1:size(startXs,1)
%         line([round(px{i}(j)) round(px{i+1}(j))],[round(py{i}(j)) round(py{i+1}(j))],'Marker','.','LineStyle','-')
%     end

    


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

