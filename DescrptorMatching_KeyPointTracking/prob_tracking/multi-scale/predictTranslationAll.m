function [newXs, newYs] = predictTranslationAll(startXs, startYs, im0, im1)

[Ix, Iy] = gradient(im0);
disp('trall');

newXs = zeros(size(startXs));
win=7;

for i=1:size(startXs,1)
    
   startX=startXs(i);
   startY=startYs(i);
   [Xq,Yq]=meshgrid(startX-win:startX+win, startY-win:startY+win);
   Ix_interp=interp2(Ix,Xq,Yq,'*linear');
   Iy_interp=interp2(Iy,Xq,Yq,'*linear'); 
   A=  predictTranslation(startX, startY, Ix_interp, Iy_interp, im0, im1);
   newXs(i)=A(1);
   newYs(i)=A(2);
end
end
