function perf_graph()

    im = im2double(imread('cat.jpg'));
    sz = size(im);
    addpath('./GCmex1.5/');
    data = reshape(im, [sz(1) * sz(2), sz(3)]);
    load('cat_poly.mat');
    mask = poly2mask(poly(:,1), poly(:,2), sz(1), sz(2)); 
    size(poly(:,1))
%     size(mask)
    num_gmm = 5; 
    % Smoothness coefficient
    Sc=[0 1;1 0];
    filter = fspecial('sobel');
    sz = size(im);
    sigma=0.6;
    for k=1:3
      [gx{k}, gy{k}] = gradient(im(:,:,k));
    end
    gx = sum(cat(3, gx{:}).^2, 3);
    gy = sum(cat(3, gy{:}).^2, 3);
    hV = 2 - exp(-gy/(2*sigma));
    hC = 2 - exp(-gx/(2*sigma));

    for iter = 1:5
        % estimate GMM
        fg = data(mask(:), :);
        bg = data(~mask(:),:);
        % estimate gmm model
        fg_gmm = fitgmdist(fg, num_gmm);
        bg_gmm = fitgmdist(bg, num_gmm);
        % calculate the foreground probability
        p_fg = fg_gmm.pdf(data);
        p_fg = reshape(p_fg, sz(1), sz(2));
        p_bg = bg_gmm.pdf(data);
        p_bg = reshape(p_bg, sz(1), sz(2));
        figure(1);
        imagesc(p_fg, [0,1]); title('Foreground');
        figure(2);
        imagesc(p_bg, [0,1]); title('Background');
        Dc = zeros(sz(1),sz(2), 2);
        %calculating data cost
        
        llhBG = -log(p_fg);
        llhFG = -log(p_bg);
        Dc = cat(3, llhBG, llhFG); 
        gch = GraphCut('open', Dc,  Sc, hV,hC);
       
        [gch, Labels] = GraphCut('expand',gch);
        [gch,Labels] = GraphCut('swap', gch);
        cut_img = (Labels==0);

    end
    g_im = zeros(sz);
    % set background as blue
    g_im(:,:,3) = 1.0;
    mask = zeros(sz);
    for i = 1:sz(3)
        mask(:,:,i) = cut_img;
    end
    g_im = g_im.*(1-mask) + im .* mask;
    figure(3);
    imshow(g_im); title('Graph Cut Output');


end
