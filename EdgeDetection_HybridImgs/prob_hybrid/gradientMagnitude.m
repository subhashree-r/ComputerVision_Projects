function [mag, theta] = gradientMagnitude(im, sigma) 
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

    %im = im2single(imread('data/dog.bmp'));
%     sigma=5
    size(im)
    cutoff_frequency=6;
    filter = fspecial('Gaussian', cutoff_frequency*4+1, sigma);
    im=imfilter(im,filter);
    filter1= fspecial('sobel');
    filter2=(filter1)';
    Rx=imfilter(im(:,:,1),filter1);
    Gx=imfilter(im(:,:,2),filter1);
    Bx=imfilter(im(:,:,3),filter1);
    Ry=imfilter(im(:,:,1),filter2);
    Gy=imfilter(im(:,:,2),filter2);
    By=imfilter(im(:,:,3),filter2);
    x=sqrt( Rx.^2 + Gx.^2 + Bx.^2);
    y=sqrt( Ry.^2 + Gy.^2 + By.^2);
%     size(Rx)
    
%     X=rssq(x)
%     Y=rssq(y)
%     C=[X Y]
    img_grad=sqrt( x.^2 + y.^2);
    figure;
    imshow(img_grad)
    size(img_grad)
end

