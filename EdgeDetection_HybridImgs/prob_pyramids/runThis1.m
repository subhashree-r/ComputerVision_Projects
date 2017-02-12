





% function runThis
% 
% 
% 
% 
% 
%     
% 
% end
% 
% 
% function displayPyramids(G, L)
% % Displays intensity and fft images of pyramids
% % for i=1:5
% figure(1);
% imshow(G{1});    
% % end
% 
% end
% 
% function displayFFT(im, minv, maxv)
% % Displays FFT images
% % figure(1)
% 
% 
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % YOUR CODE BELOW. Use imfilter() to create 'low_frequencies' and
% % 'high_frequencies' and then combine them to create 'hybrid_image'
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Remove the high frequencies from image1 by blurring it. The amount of
% % blur that works best will vary with different image pairs
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %low_frequencies = 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Remove the low frequencies from image2. The easiest way to do this is to
% % subtract a blurred version of image2 from the original version of image2.
% % This will give you an image centered at zero with negative values.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %high_frequencies = 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Combine the high frequencies and low frequencies
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %hybrid_image = 
% 
% %% Visualize and save outputs
% % figure(1); imshow(low_frequencies)
% % figure(2); imshow(high_frequencies + 0.5);
% % vis = vis_hybrid_image(hybrid_image);
% % figure(3); imshow(vis);
% % imwrite(low_frequencies, 'low_frequencies.jpg', 'quality', 95);
% % imwrite(high_frequencies + 0.5, 'high_frequencies.jpg', 'quality', 95);
% % imwrite(hybrid_image, 'hybrid_image.jpg', 'quality', 95);
% % imwrite(vis, 'hybrid_image_scales.jpg', 'quality', 95);