function bmap = edgeOrientedFilters(im)
    
    sigma=6

    [mag, theta] = orientedFilterMagnitude(im);
    bmap= edge(rgb2gray(im), 'canny').* mag .^0.7;
%     bmap=nonmax(im,theta).*mag.^7;
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


end

