function bmap = edgeOrientedFilters(im)
    
    sigma=6
    cutoff_frequency=5
    filter = fspecial('Gaussian', cutoff_frequency*4+1, sigma);
    
    [mag, theta] = orientedFilterMagnitude(im);
%     r=edge(im(:,:,1), 'canny');
%     g=edge(im(:,:,2), 'canny');
%     b=edge(im(:,:,3), 'canny');
%     im=imfilter(im,filter);
    t=rgb2hsv(im);
    can_r=edge(t(:,:,1), 'canny');
    can_g=edge(t(:,:,2), 'canny');
    can_b=edge(t(:,:,3), 'canny');
    can=sqrt(can_r.^2+can_g.^2+can_b.^2);
%     se = strel('disk',2);
    se1=strel([1, 0 ,1; 0, 1 ,0; 1 ,0 ,1])
    se2=strel([1,1,1;1,1,1;1,1,1])
    
%     dilatedI = imdilate(can,se);
%     IM1 = imopen(can,se1);
%     IM1= imclose(IM1, se2);
%     IM2=imclose(can,se1);
%     IM2=imopen(IM2,se2);
%     x=sqrt(IM1.^2+ IM2.^2);
% %     erodedI = imerode(dilatedI,se);
% %     bmap= erodedI.* mag .^0.7;
% %     IM2 = imclose(can,se)
% %     IM2=imerode(IM2,se);
% %     IM2=imdilate(IM2,se);
%     a=(imdilate(can,se))
%     b=(imerode(can,se));
%     IM2=a-b;
%     [tri,hys]=hysteresis3d(can,1,11,8);
%     IM2=can;
    bmap= can.* mag .^0.7;
     
    
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


end

