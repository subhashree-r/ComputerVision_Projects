function bmap = edgeOrientedFilters(im)
    
    sigma=6

    [mag, theta] = orientedFilterMagnitude(im);
%     r=edge(im(:,:,1), 'canny');
%     g=edge(im(:,:,2), 'canny');
%     b=edge(im(:,:,3), 'canny');
    can=edge(rgb2gray(im), 'canny');
    se = strel('disk',2);
%     dilatedI = imdilate(can,se);
%     erodedI = imerode(dilatedI,se);
%     bmap= erodedI.* mag .^0.7;
    IM2 = imclose(can,se)
%     [tri,hys]=hysteresis3d(can,1,11,8);
    
    bmap= IM2.* mag .^0.7;
    
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


end

