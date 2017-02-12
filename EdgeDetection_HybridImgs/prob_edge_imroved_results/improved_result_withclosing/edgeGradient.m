function bmap=edgeGradient(im)

    sigma=5

    [mag, theta] = gradientMagnitude(im, sigma);
    can=edge(rgb2gray(im), 'canny')
    se = strel('disk',2);
%     dilatedI = imdilate(can,se);
%     erodedI = imerode(dilatedI,se);
    IM2 = imclose(can,SE)
    bmap= IM2.* mag .^0.7;

%     bmap= edge(rgb2gray(im), 'canny').*mag.^0.7;

    %UNTITLED8 Summary of this function goes here
    %   Detailed explanation goes here


end

