clear all; close all;
im = (im2double(imread('data/plane.bmp')));
% im=rgb2gray(im);
N=5;
G={};
L={};
[G,L]=pyramidsGL(im,N)

for i=1:5
    fn1=sprintf('C://First_sem//CV//hw1//prob_pyramids//hw-ans//gaussian//%s.jpg',num2str(i))
    imwrite(G{i},fn1);
end
for i=1:5
    fn2=sprintf('C://First_sem//CV//hw1//prob_pyramids//hw-ans//laplacian//%s.jpg',num2str(i))
    imwrite(L{i},fn2);
end
img1=reconstruct(L);
figure(1);
imshow(img1);
d=size(img1)
c=size(im)
 if c(2)~=d(2)&& c(1)==d(1)
%            
       img1=img1(:,1:c(2),:)
%               G{j-1}=[G{j-1} zeros(c(1),1)];
    elseif c(1)~=d(1)&& c(2)==d(2)
        img1=img1(1:c(1),:,:)
%               G{j-1}=[G{j-1}; zeros(1,c(2))];
    elseif c(2)~=d(2)&& c(1)~=d(1)
        img1=img1(1:c(1),1:c(2),:)
 end
% im=imresize(im,round([size(img1, 1), size(img1, 2), size(img1,3)]),'bicubic');
% im=imresize(im,round([size(img1, 1), size(img1, 2), size(img1,3)]),'bicubic');

MSE_recon = immse(img1, im)
img2=scale_reconstruct(L);
d=size(img2)
c=size(im)
if c(2)~=d(2)&& c(1)==d(1)
%            
   img2=img2(:,1:c(2),:)
%               G{j-1}=[G{j-1} zeros(c(1),1)];
elseif c(1)~=d(1)&& c(2)==d(2)
    img2=img2(1:c(1),:,:)
%               G{j-1}=[G{j-1}; zeros(1,c(2))];
elseif c(2)~=d(2)&& c(1)~=d(1)
    img2=img2(1:c(1),1:c(2),:)
end
MSE_recon2 = immse(img2, im)
f2=fspecial('laplacian')
im_new=imfilter(im,f2);
MSE_sharpening=immse(im_new, im)
figure(2);
imshow(img2);
figure(3);
imshow(im_new);

imwrite(img1,'C:/First_sem/CV/hw1/prob_pyramids/hw-ans/recon.jpg');
displayPyramids(G,L);
displayPyramidsfft(G,L);
    
 