function [x,y]=keypoint(im1)

%     im1=imread((('C:/First_sem/CV/hw2/prob_tracking/images/hotel.seq0.PNG')));
%     im1=im2double(im1);
    sigma=1;
    cutoff_frequency=5;
    filter = fspecial('Gaussian', cutoff_frequency*4+1, sigma);
%     im1=imfilter(im1,filter)
%     filter1=fspecial('sobel');
%     Ix=imfilter(im1,filter1');
%     Iy=imfilter(im1,filter1);
    [Ix,Iy]=imgradientxy(im1);
%     Ix=conv2(
%     Ix=conv2(Gx,im1);
%     Iy=conv2(Gy,im1);
    IxIx=imfilter((Ix.*Ix),filter);
    IyIy=imfilter((Iy.*Iy),filter);
    IxIy=imfilter((Ix.*Iy),filter);
    har=(IxIx.*IyIy)-((IxIy).^2)-(0.04*((IxIx+IyIy).^2))
    N = 5;
%     har=har/max(har(:));
    har = har.*double(har ==ordfilt2(har, N^2, true(N))) > .0001;
    [y,x]=find(har);
    keypoints=[y,x];
%     n=size(x)
    figure(1); imshow(im1); 
    hold on;
    plot( x, y, '.g', 'LineWidth', 5);
    hold off;
    
    
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


end

