function [newXs, newYs] = predictTranslationAll(startXs, startYs, im0, im1)

[Ix, Iy] = gradient(im0);
disp('trall');

newXs = zeros(size(startXs));
win=floor(15/2);

for i=1:size(startXs,1)
    
   startX=startXs(i);
   startY=startYs(i);
   [Xq,Yq]=meshgrid(startX-win:startX+win, startY-win:startY+win);
   Ix_interp=interp2(Ix,Xq,Yq,'*linear');
   Iy_interp=interp2(Iy,Xq,Yq,'*linear'); 
   A=  predictTranslation(startX, startY, Ix_interp, Iy_interp, im0, im1);
   newXs(i)=A(1);
   newYs(i)=A(2);
   im_orig=imread('C:/First_sem/CV/hw2/prob_tracking/images/hotel.seq0.png');
   figure(4);
  
end
%  imshow(im_orig);
%  hold on;
%  plot( newXs, newYs, '.r', 'LineWidth', 5);
%  hold off;
end
