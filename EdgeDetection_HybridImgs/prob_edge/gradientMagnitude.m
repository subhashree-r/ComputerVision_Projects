function [mag, theta] = gradientMagnitude(im, sigma) 
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
      size(im)
%     im = im2single(imread('data/images/3096.jpg'));
%     sigma=5;
%     size(im)
%     theta=[]
    cutoff_frequency=5;
    filter = fspecial('Gaussian', cutoff_frequency*4+1, sigma);
    im=imfilter(im,filter);
    filter1= fspecial('sobel');
    filter2=(filter1)';
    Rx=imfilter(im(:,:,1),filter2);
%     size(Rx)
    Gx=imfilter(im(:,:,2),filter2);
    Bx=imfilter(im(:,:,3),filter2);
    Ry=imfilter(im(:,:,1),filter1);
    Gy=imfilter(im(:,:,2),filter1);
    By=imfilter(im(:,:,3),filter1);
    x=sqrt( Rx.^2 + Gx.^2 + Bx.^2);
    y=sqrt( Ry.^2 + Gy.^2 + By.^2);
    
    R=sum(sum(sqrt( Rx.^2 + Ry.^2 )));
    G=sum(sum(sqrt( Gx.^2 + Gy.^2 )));
    B=sum(sum(sqrt( Bx.^2 + By.^2 )));
    
    C=[R G B]
    find(C==max(C))
%     size(R)
%     %size(R)
    if find(C==max(C))==1
        theta=atan2( Ry, Rx) * (180.0/pi);
    elseif find(C==max(C))==2
        theta=atan2( Gy, Gx) * (180.0/pi);
    elseif find(C==max(C))==3
        theta=atan2( By, Bx) * (180.0/pi);
    end
    size(theta)
% %     size(Rx)
%     
% %     X=rssq(x)
% %     Y=rssq(y)
% %     C=[X Y]
    img_grad=sqrt( x.^2 + y.^2);
    size(img_grad);
    mag=img_grad;
%     mag=img_grad;
% %     
%     figure;
%     imshow(img_grad);
%     size(img_grad)
end

