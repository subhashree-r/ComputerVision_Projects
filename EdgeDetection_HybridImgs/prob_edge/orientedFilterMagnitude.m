function [mag,theta] = orientedFilterMagnitude(im) 
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%     sigma=5
    cutoff_frequency=3;
%     im = im2single(imread('data/images/3096.jpg'));
%     s=s
    
    filter = fspecial('Gaussian', 25, 4); 
    filter_sobel= fspecial('sobel');
    D=imfilter(filter,filter_sobel);
%     Gx=imfilter(filter,filter_sobel');
    ri=im(:,:,1);
    gi=im(:,:,2)
    bi=im(:,:,3);
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
    filteredr={};
    filteredg={};
    filteredb={};
    fil={}
%     filtered1=imfilter(filtered1,filter_sobel);
%     filtered2=imfilter(filtered2,filter_sobel);
%     filtered3=imfilter(filtered3,filter_sobel);
%     filtered4=imfilter(filtered4,filter_sobel);
%     filtered5=imfilter(filtered5,filter_sobel);

    for i=1:8
        fil{i}=imrotate(D,values(i));
        filteredr{i}=imfilter(ri,fil{i});
        filteredg{i}=imfilter(gi,fil{i});
        filteredb{i}=imfilter(bi,fil{i});
    end
    
    R={}
    G={}
    B={}
    sq1=filteredr{1}.^2;
    sq2=filteredg{1}.^2;
    sq3=filteredb{1}.^2;
    for p=2:8
        sq1=sq1+filteredr{p}.^2;
        sq2=sq2+filteredg{p}.^2;
        sq3=sq3+filteredb{p}.^2;
    end
%     for o=1:8
%         R{o}=filteredr{o};
%         G{o}=filteredg{o};
%         B{o}=filteredb{o}(:,:,3);
%     end
   
    R=sqrt(sq1);
    G=sqrt(sq2);
    B=sqrt(sq3);
    
    mag=sqrt(R.^2+G.^2+B.^2);
    size(mag)
        
    
%     t=filtered{1}
%     for i=2:8
%         m=max(t,filtered{i});
%         t=m;
%         t=t+filtered{i};
%     end

%     
%     s1=sum(sum(m(:,:,1)));
%     s2=sum(sum(m(:,:,2)));
%     s3=sum(sum(m(:,:,3)));
    
    fsobel= fspecial('sobel');
    Ry=imfilter(R,fsobel);
    Gy=imfilter(G,fsobel);
    By=imfilter(B,fsobel);
    Rx=imfilter(R,fsobel');
    Gx=imfilter(G,fsobel');
    Bx=imfilter(B,fsobel');
    x=sqrt( Rx.^2 + Gx.^2 + Bx.^2);
    y=sqrt( Ry.^2 + Gy.^2 + By.^2);
    Rt=sum(sum(R));
    Gt=sum(sum(G));
    Bt=sum(sum(B));
    
    s=[Rt Gt Bt];
    if find(s==max(s))==1
        theta=atan2( abs(Ry), abs(Rx)) * (180.0/pi);
    elseif find(s==max(s))==2
        theta=atan2( abs(Ry), abs(Rx)) * (180.0/pi);
    elseif find(s==max(s))==3
        theta=atan2( abs(Ry), abs(Rx)) * (180.0/pi);
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
    theta=[];
    
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



