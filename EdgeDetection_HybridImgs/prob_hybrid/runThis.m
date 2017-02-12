% Debugging tip: You can split your MATLAB code into cells using "%%"
% comments. The cell containing the cursor has a light yellow background,
% and you can press Ctrl+Enter to run just the code in that cell. This is
% useful when projects get more complex and slow to rerun from scratch

close all; % closes all figures

% mkdir('data/dog');
path='C:/First_sem/CV/hw1/prob_hybrid/happy';

%% Setup
% read images and convert to floating point format
image1 = ((imread('data/1.jpg')));
% image1=image1(:,1:349,:);
image2 = ((imread('data/2.jpg')));
% image2=(imresize(image2,size(image1)));
figure('Name','log magnitude fft of orig 1');
show1=imagesc((log((abs(fftshift(fft2(double((image1)))))))));

colormap jet;
figure('Name','log magnitude fft of orig 2');
show2=imagesc((log((abs(fftshift(fft2(double((image2)))))))));

colormap jet;
% Several additional test cases are provided for you, but feel free to make
% your own (you'll need to align the images in a photo editor such as
% Photoshop). The hybrid images will differ depending on which image you
% assign as image1 (which will provide the low frequencies) and which image
% you asign as image2 (which will provide the high frequencies)

%% Filtering and Hybrid Image construction
% cutoff_frequency = 7; %This is the standard deviation, in pixels, of the 
% % Gaussian blur that will remove the high frequencies from one image and 
% % remove the low frequencies from another image (by subtracting a blurred
% % version from the original version). You will want to tune this for every
% % image pair to get the best results.
% filter = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE BELOW. Use imfilter() to create 'low_frequencies' and
% 'high_frequencies' and then combine them to create 'hybrid_image'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%H = fspecial('motion',20,45);

%GussianBlur1 = imfilter(image1,filter);
%GussianBlur2 = imfilter(image2,filter);
%figure(1);
%imshow(GaussianBlur1);

%Iblur1 = imgaussfilt(I,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the high frequencies from image1 by blurring it. The amount of
% blur that works best will vary with different image pairs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cutoff_frequency1=7
filter = fspecial('Gaussian', 30, 5);
% filter = fspecial('Gaussian', cutoff_frequency1*4+1, cutoff_frequency1);
% filter = fspecial('Gaussian', cutoff_frequency1*4+1, cutoff_frequency1);
low_frequencies=(imfilter(image1,filter));
% R   = 1;  % Value in range [0, 1]
% G   = 1;
% B   = 1;
% low_frequencies = cat(3, low_frequencies * R, low_frequencies * G, low_frequencies * B);

I1=(low_frequencies);
% imshow(imagesc(log(abs(fftshift(fft2(I1))))),[] );
figure('Name','fft mag of low freq');
% figure(5);
I1_new=imagesc((log((abs(fftshift(fft2(double(I1))))))));
% colormap jet;

% imagesc((abs(fftshift(fft2(I1)))));
colormap jet;
% plot(I1_new)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the low frequencies from image2. The easiest way to do this is to
% subtract a blurred version of image2 from the original version of image2.
% This will give you an image centered at zero with negative values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cutoff_frequency2=5
% filter_high = fspecial('Gaussian', cutoff_frequency2*4+1, cutoff_frequency2);
filter_high = fspecial('Gaussian', 30, 8);
% lf=imfilter(image2,filter_low);
high_frequencies = image2- imfilter(image2,filter_high);
% high_frequencies=high_frequencies;
I2=(high_frequencies);
figure('Name','fft mag of high freq');
I2_new=imagesc((log((abs(fftshift(fft2(double(I2))))))));

% imagesc((abs(fftshift(fft2(I1)))));
colormap jet;
% imshow(imagesc(log(abs(fftshift(fft2(I1))))),[] );

% figure(5);

% figure(6)
% imshow(imagesc(log(abs(fftshift(fft2(high_frequencies))))),[] );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combine the high frequencies and low frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% size(low_frequencies)
% size(high_frequencies)
% % a=zeros(1,2,3);
% a=size(high_frequencies);
% low_frequencies=imresize(low_frequencies,a,'bicubic');
% % ny=3;nx=3;nz=5; %% desired output dimensions
% % [y x z]=...
% %    ndgrid(linspace(1,size(low_frequencies,1),a(1)),...
% %           linspace(1,size(low_frequencies,2),a(2)),...
% %           linspace(1,size(low_frequencies,3),a(3)));
% % low_frequencies=interp3(im,x,y,z);
% low_frequencies=imresize(low_frequencies,size(high_frequencies));
size(low_frequencies)
size(high_frequencies)
hybrid_image =(low_frequencies+high_frequencies);
[G,L]=pyramidsGL(hybrid_image,5);
displayPyramids(G,L);


% figure(7)
% imshow(imagesc(log(abs(fftshift(fft2(hybrid_image))))),[]);

%% Visualize and save outputs
figure('Name','low_freq'), imshow(low_frequencies);
figure('Name','high_freq'), imshow(high_frequencies + 0.5);
vis = vis_hybrid_image(hybrid_image);
figure('Name','vis'),imshow(vis);
figure('Name','hybrid'),imshow(hybrid_image);
figure('Name','log magnitude fft of hybrid');
show3=imagesc((log((abs(fftshift(fft2(double((hybrid_image)))))))));
colormap jet;
figure('Name','image1'), imshow(image1);
figure('Name','image2'), imshow(image2);

imwrite(vis,strcat(path,'/vis.jpg'));
imwrite(image1,strcat(path,'/imag1.jpg'));
imwrite(image2,strcat(path,'/imag2.jpg'));
imwrite(hybrid_image,strcat(path,'/hybrid_img.jpg'));
imwrite(low_frequencies,strcat(path,'/lo_freq.jpg'));
imwrite(high_frequencies,strcat(path,'/highfeq.jpg'));


% imwrite(low_frequencies, 'low_frequencies.jpg', 'quality', 95);
% imwrite(high_frequencies + 0.5, 'high_frequencies.jpg', 'quality', 95);
% imwrite(hybrid_image, 'hybrid_image.jpg', 'quality', 95);
% imwrite(vis, 'hybrid_image_scales.jpg', 'quality', 95);