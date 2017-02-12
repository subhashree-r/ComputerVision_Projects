function bmap=edgeGradient(im)

    sigma=5

    [mag, theta] = gradientMagnitude(im, sigma);

    bmap= edge(rgb2gray(im), 'canny').*mag.^0.7;

    %UNTITLED8 Summary of this function goes here
    %   Detailed explanation goes here


end

