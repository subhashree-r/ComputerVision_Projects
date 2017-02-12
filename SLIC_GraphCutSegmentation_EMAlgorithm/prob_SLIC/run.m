
img = imread('35049.jpg');
% K = 256;
% compactness = [20, 30, 50];
% figure(1);
% for i = 1:3
%     [cIndMap, time, imgVis] = slic(img, K, compactness(i));
%     subplot(1,3,i);
%     imshow(imgVis,[]);
%     hold on;
%     title(sprintf('Segmenation for weight = %d',compactness(i)));
% end


% % img = imread('35049.jpg');
% [cIndMap, time, imgVis] = slic(img, K, 25);

title('Different K');
% img = imread('35049.jpg');
K = [64, 256, 1024];
time = [0 0 0];
figure(1);
for i = 1:3
    [cIndMap, time(i), imgVis] = slic(img, K(i), 50);
    subplot(1,3,i);
    imshow(imgVis,[]);
    title(sprintf('Segmenation for K = %d',K(i)));
    fprintf('Time when (K=%d) = %s', K(i), time(i));
end
