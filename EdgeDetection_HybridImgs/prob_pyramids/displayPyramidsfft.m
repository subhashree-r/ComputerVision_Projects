function displayPyramidsfft(G, L)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    figure;
    for i=1:5
        subplot(2,5,i);
        imagesc((log((abs(fftshift(fft2(double(rgb2gray(G{i})))))))));
        colormap jet;
        subplot(2,5,i+5);
        imagesc((log((abs(fftshift(fft2(double(rgb2gray(L{i}+0.5)))))))));
        colormap jet;
    end


end

