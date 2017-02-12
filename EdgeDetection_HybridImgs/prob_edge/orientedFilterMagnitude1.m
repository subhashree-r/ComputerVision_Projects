function [mag,theta] = orientedFilterMagnitude1(im) 
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%     sigma=5
    cutoff_frequency=3;
%     im = im2single(imread('data/images/3096.jpg'));
    s=size(im)
    temp=zeros(s(1),s(2),4);
    
    filter = fspecial('Gaussian', cutoff_frequency*4+1, 2); 
    filter_sobel= fspecial('sobel');
    D=imfilter(filter,filter_sobel);
    Gx=imfilter(filter,filter_sobel');
    %at 0 degree
    values=[0 45 90 135 180];
    fil_1 = cos(0)*Gx + sin(0)*Gy;
%     fil_y1=fil_x1';
    filtered1=imfilter(im,fil_1);
    fil_2 = cos(45)*Gx + sin(45)*Gy;
    filtered2=imfilter(im,fil_2);
    fil_3 = cos(90)*Gx + sin(90)*Gy;
    filtered3=imfilter(im,fil_3);
    fil_4 = cos(135)*Gx + sin(135)*Gy;
    filtered4=imfilter(im,fil_4);
    fil_5 = cos(180)*Gx + sin(180)*Gy;
    filtered5=imfilter(im,fil_5);
%     size(filtered4)
    
    m1=max(filtered1,filtered2);
    m2=max(m1,filtered3);
    m3=max(m2,filtered4);
    m4=max(m3,filtered5);
%     m3=sqrt(fil_1.^2+fil_2.^2+fil_3.^2+fil_4.^2);
    
    s1=sum(sum(m4(:,:,1)));
    s2=sum(sum(m4(:,:,2)));
    s3=sum(sum(m4(:,:,3)));
    
    fsobel= fspecial('sobel');
    Ry=imfilter(m4(:,:,1),fsobel);
    Gy=imfilter(m4(:,:,2),fsobel);
    By=imfilter(m4(:,:,3),fsobel);
    Rx=imfilter(m4(:,:,1),fsobel');
    Gx=imfilter(m4(:,:,2),fsobel');
    Bx=imfilter(m4(:,:,3),fsobel');
    s=[s1 s2 s3];
    if find(s==max(s))==1
        theta=atan2( Ry, Rx) * (180.0/pi);
    elseif find(s==max(s))==2
        theta=atan2( Gy, Gx) * (180.0/pi);
    elseif find(s==max(s))==3
        theta=atan2( By, Bx) * (180.0/pi);
    end
%     
    A=sqrt(sum(filtered1.^2,3));
    B=sqrt(sum(filtered2.^2,3));
    C=sqrt(sum(filtered3.^2,3));
    D=sqrt(sum(filtered4.^2,3));
    E=sqrt(sum(filtered5.^2,3));
    
    max1=max(A,B);
    max2=max(max1,C);
    max3=max(max2,D);
    max4=max(max3,E);
    size(max3);
    mag=max4;
%     theta=[];
%     
%     filt={filtered1 ;filtered2 ;filtered3 ;filtered4};
% %     
%     for i=1:4
%         temp(:,:,i)=sqrt(sum(filt{i}.^2,3));
%     end
%     size(sqrt(sum(filtered2.^2,3)))
%     
%     size(temp)
%     [mag,angle]=max(temp,[],3)
%     theta=values(angle);
%     size(theta);
    
    
%     fil_y1 = fil_x1';
%     fil_x2 = cos(30)*Gx + sin(30)*Gy;
% %     fil_y2 = fil_x2';
%     fil_x3 = cos(60)*Gx + sin(60)*Gy;
% %     fil_y3 = fil_x3';
%     fil_4 = cos(90)*Gx + sin(90)*Gy;
% %     fil_y4 = fil_x4';
% 
%     Rx=imfilter(im(:,:,1),filter1);
%     Gx=imfilter(im(:,:,2),filter1);
%     Bx=imfilter(im(:,:,3),filter1);
%     Ry=imfilter(im(:,:,1),filter2);
%     Gy=imfilter(im(:,:,2),filter2);
%     By=imfilter(im(:,:,3),filter2);
%     x=sqrt( Rx.^2 + Gx.^2 + Bx.^2);
%     y=sqrt( Ry.^2 + Gy.^2 + By.^2);
%     img_grad=sqrt( x.^2 + y.^2);
%    
end

