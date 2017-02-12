
function [G, L] = pyramidsGL(im, N)
% [G, L] = pyramidsGL(im, N)
% Creates Gaussian (G) and Laplacian (L) pyramids of level N from image im.
% G and L are cell where G{i}, L{i} stores the i-th level of Gaussian and Laplacian pyramid, respectively. 
    im = im2single(imread('data/bird.bmp'));
    orig_img=im;
    N=5
    cutoff_frequency=7;
    im_new={};
    G={};
    N={};
    filter = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
   
    size(im)  
    im_new=imfilter(im,filter)
    im_new
    
%     size(im_new)
%     G=imresize(im_new,.5);
%     size(G)
%     size(im_new)
%     L=im_new-(imresize(G,2));
    
%         im= G{i};
        
    

end

