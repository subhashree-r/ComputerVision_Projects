clear all; close all;
im = im2single(imread('data/plane.bmp'));
N=5;
G={};
L={};
[G,L]=pyramidsGL(im,N)

img1=reconstruct(L);
figure(1);
imshow(img1);
size(img1)
size(im)
% im=imresize(im,round([size(img1, 1), size(img1, 2), size(img1,3)]),'bicubic');
MSE = immse(im, img1)
img2=scale_reconstruct(L);
figure(2);
imshow(img2);

imwrite(img1,'C:/First_sem/CV/hw1/prob_pyramids/hw-ans/recon.jpg');
displayPyramids(G,L);
displayPyramidsfft(G,L);
    
 