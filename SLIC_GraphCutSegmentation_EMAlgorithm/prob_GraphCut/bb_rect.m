function [ ] = bb_rect( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure(4);

% size(x)
% load('y.mat');
% ceil(x);
% ceil(y);

img=imread((('n_ball.jpg')));

im2=imread('ol3n.jpg');
sz2=size(im2);
im2=im2double(im2);
img=imresize(img,[sz2(1) sz2(2)]);
sz=size(img);
img=im2double(img);
addpath('./GCmex1.5/');

imshow(img);
hold on;
[x,y]=ginput(20);
[x,y,BW, xi, yi] = roipoly(img);
% size(xi)
x=ceil(x);
y=ceil(y);
% x=x';
% y=y';
% BW
% rect=getrect;
% I=imcrop(img,rect);
% figure(2);
% imshow(I);
% figure(3);
% imshow(img);
% hold on;
% rectangle('Position',rect);
% 
% x=[rect(1) rect(1)+rect(3)];
% y=[rect(2) rect(2)+rect(4)];
% 
% save I;

data = reshape(img, [sz(1) * sz(2), sz(3)]);
% load('cat_poly.mat');
mask = poly2mask(x,y, sz(1), sz(2)); 
% figure(5);
% imshow(mask);
%     size(mask)
num_gmm = 5; 
% Smoothness coefficient
%  num_gmm = 5; 
    % Smoothness coefficient
Sc=[0 1;1 0];
% filter = fspecial('sobel');
sz = size(img);
sigma=0.6;
for k=1:3
  [gx{k}, gy{k}] = gradient(img(:,:,k));
end
gx = sum(cat(3, gx{:}).^2, 3);
gy = sum(cat(3, gy{:}).^2, 3);
hV = 2 - exp(-gy/(2*sigma));
hC = 2 - exp(-gx/(2*sigma));

%     hV = zeros(sz(1:2));
%     hC = hV;
%     for k=1:size(im,3)
%         hV = max(hV, abs(imfilter(im(:,:,k), filter)));
%         hC = max(hC, abs(imfilter(im(:,:,k), filter')));
%     end

for iter = 1:2
    % estimate GMM
    fg = data(mask(:), :);
    bg = data(~mask(:),:);
    % estimate gmm model
    fg_gmm = fitgmdist(fg, num_gmm);
    bg_gmm = fitgmdist(bg, num_gmm);
    % calculate the foreground probability
    p_fg = fg_gmm.pdf(data);
    p_fg = reshape(p_fg, sz(1), sz(2));
    p_bg = bg_gmm.pdf(data);
    p_bg = reshape(p_bg, sz(1), sz(2));
    figure(1);
    imagesc(p_fg, [0,1]); title('Background');
    figure(2);
    imagesc(p_bg, [0,1]); title('Foreground');
    Dc = zeros(sz(1),sz(2), 2);
    %calculating data cost

    llhBG = -log(p_fg);
    llhFG = -log(p_bg);
    Dc = cat(3, llhBG, llhFG); 
    gch = GraphCut('open', Dc,  Sc, hV,hC);

    [gch, Labels] = GraphCut('expand',gch);
    [gch,Labels] = GraphCut('swap', gch);
    cut_img = (Labels==0);
    size(cut_img)
end
g_im =im2;
% set background as blue
% g_im(:,:,3) = 1.0;
mask = zeros(sz);
for i = 1:sz(3)
    mask(:,:,i) = cut_img;
end
im2 = im2.*(1-mask) + img .* mask;
figure(3);
imshow(im2); title('Graph Cut Output');

%im2 is background image and mask is to be overlapped image


end

