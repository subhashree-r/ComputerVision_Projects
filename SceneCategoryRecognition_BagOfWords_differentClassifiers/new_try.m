function [ h ] = new_try( im,numbins )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

img=im;
bin_size = 256./numbins;
ind = cumprod([1 numbins]);
[h w z] = size(img);
temp = ones(h*w,1);
a = numbins(1);
b = a*numbins(2);
c = b*numbins(3);
%put in 0 255 scale
if ~strcmp(class(img), 'uint8') 
    img = im2uint8(img); 
end
for i = 1:3
    im1 = double(img(:,:,i));
    im1 = reshape(im1,[h*w 1]);
   
    binnumber = floor(im1/bin_size(i));

    temp = temp + binnumber*ind(i);
end

hist_bin = hist(temp,1:c) + 1;
h = hist_bin/sum(hist_bin);


end

