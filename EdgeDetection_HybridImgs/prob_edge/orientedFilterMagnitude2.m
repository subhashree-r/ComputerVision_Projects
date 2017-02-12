function [mag,theta] = orientedFilterMagnitude2(im) 
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%     sigma=5
    cutoff_frequency=3;
%     im = im2single(imread('data/images/3096.jpg'));
    s=size(im)
    temp=zeros(s(1),s(2),4);
    
    filter = fspecial('Gaussian', 25, 4); 
    filter_sobel= fspecial('sobel');
    D=imfilter(filter,filter_sobel);
    Gx=imfilter(filter,filter_sobel');
    %at 0 degree
%     values=[0 45 90 135 180];
%     fil_1 = imrotate(D,0);
% %     fil_y1=fil_x1';
%     filtered1=imfilter(im,fil_1);
%     fil_2 = imrotate(D,45);
%     filtered2=imfilter(im,fil_2);
%     fil_3 = imrotate(D,90);
%     filtered3=imfilter(im,fil_3);
%     fil_4 = imrotate(D,135);
%     filtered4=imfilter(im,fil_4);
%     fil_5 = imrotate(D,180);
%     filtered5=imfilter(im,fil_5);
    values=[0:180/8:180];
%     size(filtered4)
    filtered={}
    fil={}
%     filtered1=imfilter(filtered1,filter_sobel);
%     filtered2=imfilter(filtered2,filter_sobel);
%     filtered3=imfilter(filtered3,filter_sobel);
%     filtered4=imfilter(filtered4,filter_sobel);
%     filtered5=imfilter(filtered5,filter_sobel);

    for i=1:8
        fil{i}=imrotate(D,values(i));
        filtered{i}=imfilter(im,fil{i});
    end
    
    R={}
    G={}
    B={}
    for o=1:8
        R{o}=filtered{o}(:,:,1);
        G{o}=filtered{o}(:,:,2);
        B{o}=filtered{o}(:,:,3);
    end
    sq1=R{1}.^2;
    sq2=G{1}.^2;
    sq3=B{1}.^2;
    for p=2:8
        sq1=sq1+R{p};
        sq2=sq2+G{p};
        sq3=sq3+B{p};
    end
    R=sqrt(sq1);
    G=sqrt(sq2);
    B=sqrt(sq3);
    
    mag=sqrt(R.^2+G.^2+B.^2);
        
    
    t=filtered{1}
    for i=2:8
        m=max(t,filtered{i});
        t=m;
        t=t+filtered{i};
    end
%     av=t/8;
% %     m1=max(filtered1,filtered2);
% %     m2=max(m1,filtered3);
% %     m3=max(m2,filtered4);
% %     m4=max(m3,filtered5);
% %     m3=sqrt(fil_1.^2+fil_2.^2+fil_3.^2+fil_4.^2);
%     
    s1=sum(sum(m(:,:,1)));
    s2=sum(sum(m(:,:,2)));
    s3=sum(sum(m(:,:,3)));
    
    fsobel= fspecial('sobel');
    Ry=imfilter(m(:,:,1),fsobel);
    Gy=imfilter(m(:,:,2),fsobel);
    By=imfilter(m(:,:,3),fsobel);
    Rx=imfilter(m(:,:,1),fsobel');
    Gx=imfilter(m(:,:,2),fsobel');
    Bx=imfilter(m(:,:,3),fsobel');
    x=sqrt( Rx.^2 + Gx.^2 + Bx.^2);
    y=sqrt( Ry.^2 + Gy.^2 + By.^2);
    s=[s1 s2 s3];
    if find(s==max(s))==1
        theta=atan2( Ry, Rx) * (180.0/pi);
    elseif find(s==max(s))==2
        theta=atan2( Gy, Gx) * (180.0/pi);
    elseif find(s==max(s))==3
        theta=atan2( By, Bx) * (180.0/pi);
    end
%     
%     A=sqrt(sum(filtered1.^2,3));
%     B=sqrt(sum(filtered2.^2,3));
%     C=sqrt(sum(filtered3.^2,3));
%     D=sqrt(sum(filtered4.^2,3));
%     E=sqrt(sum(filtered5.^2,3));
    
%     q={}
% %     for i=1:8
% %         q{i}=sqrt(sum(filtered{i}.^2,3));
% %     end
%     e=sqrt(sum(av.^2,3));
    
%     x=q{1};
%     for i=2:8
%         mag=max(x,q{1});
%         x=mag;
%     end
%     mag=e
%     max1=max(A,B);
%     max2=max(max1,C);
%     max3=max(max2,D);
%     max4=max(max3,E);
%     size(max3);
%     mag=max4;
%     theta=[];
    
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
    
%     
%     fil_y1 = fil_x1';
%     fil_x2 = cos(30)*Gx + sin(30)*Gy;
% %     fil_y2 = fil_x2';
%     fil_x3 = cos(60)*Gx + sin(60)*Gy;
% %     fil_y3 = fil_x3';
%     fil_4 = cos(90)*Gx + sin(90)*Gy;
%     fil_y4 = fil_x4';

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
%     mag=sqrt( x.^2 + y.^2);
end

