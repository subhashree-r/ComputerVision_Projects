function keypoint1()

    im1=imread((('C:/First_sem/CV/hw2/prob_tracking/images/hotel.seq0.PNG')))
    im1=im2double(im1)
    sigma=3
    cutoff_frequency=5
    filter = fspecial('Gaussian', cutoff_frequency*4+1, sigma);
%     im1=imfilter(im1,filter)
    filter1=fspecial('sobel');
%     Ix=imfilter(im1,filter1');
%     Iy=imfilter(im1,filter1);
    [Gx,Gy]=imgradientxy(filter);
    Ix=imfilter(im1,Gx)
    Iy=imfilter(im1,Gy)
%     Ix=conv2(Gx,im1);
%     Iy=conv2(Gy,im1);
    IxIx=imfilter((Ix.^2),filter)
    IyIy=imfilter((Iy.^2),filter)
    IxIy=imfilter((Ix.*Iy),filter)
    har=[IxIx IxIy;IxIy IyIy]
  
%     har=(IxIx.*IyIy)-((IxIy).*(IxIy))-0.05.*((IxIx+IyIy).^2)
    har=dett(har)-(0.05)*(trace(har))^2
    
    N = 5;
%     har=har/max(har(:));
    har = har.*double(har ==ordfilt2(har, N^2, true(N))) > .05;
    [y,x]=find(har);
    keypoints=[y,x];
    figure(1); imshow(im1); 
    hold on;
    plot( keypoints(:,1), keypoints(:,2), '.g', 'LineWidth', 3);
    hold off;
    
    
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


end