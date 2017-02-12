function [ u,v ] = predictLK( im0,im1,u,v,startX,startY )



    win_size=15;
%     [x,y] = keypoint((im0));
    startX = startX/4;
    startY = startY/4; 
%     for i=1:size(startXs,1)
%     startX=startXs(1);
%     startY=startYs(1);
    [Xq,Yq]=meshgrid(startX-floor(win_size/2):startX + floor(win_size/2), startY-floor(win_size/2):startY+floor(win_size/2));
%     [Xq1,Yq1]=meshgrid(startX-win:startX+win, startY-win:startY+win);
    [Ix, Iy] = gradient(im0);
    Ix_interp=interp2(Ix,Xq,Yq,'*linear');
    Iy_interp=interp2(Iy,Xq,Yq,'*linear'); 
    Ix_interp = Ix;
    Iy_interp = Iy;
    im0_interp = interp2(im0,Xq,Yq);
    im1_interp = interp2(im1,Xq,Yq);
    Ix2= sum(sum(Ix_interp).^2);
    Iy2=sum(sum(Iy_interp).^2);
    IxIy=sum(sum(Ix_interp.*Iy_interp));
    A=[Ix2,IxIy;IxIy,Iy2];
    if abs(det(A)) < eps
    % singular matrix
        return
    end
    It=(sum(sum(im1_interp-im0_interp).^2));
    Xprime=startX;
    Yprime=startY;

   for i=1:50
      if (Xprime-floor(win_size/2))<0 || Xprime+floor(win_size/2)>size(im0,2) ||(Yprime-floor(win_size/2))<0 ||(Yprime+floor(win_size/2))>size(im0,1)
          break;
      end
        displ=[];
        B=-[sum(sum(Ix_interp.*It));sum(sum(Iy_interp.*It))];
        displ=A\B;
        u=displ(1);
        v=displ(2);
        Xprime=Xprime+u;
        Yprime=Yprime+v;
        %%evaluating It again
        d=sqrt(sum(u.^2+v.^2));   
        if d<0.05
            break;
        else
           [Xq,Yq]=meshgrid(Xprime-floor(win_size/2):Xprime+floor(win_size/2),Yprime-floor(win_size/2):Yprime+floor(win_size/2));
           im1_interp_new=interp2(im1,Xq,Yq);
           It=(sum(sum(im1_interp_new-im0_interp).^2));

        end
   end
   
    
end
%     for i = 1+win : size(It,1)-win  
%         for j = 1+win : size(It,2)-win
% 
%     % st
%         [Xq,Yq]=meshgrid( i-win:i+win, j-win:j+win);
%         Ix_interp = Ix( i-SizeBig:i+SizeBig, j-SizeBig:j+SizeBig );
%         Iy_interp =Iy( i-SizeBig:i+SizeBig, j-SizeBig:j+SizeBig );  
%         [xq,yq]=meshgrid(1:size(im0,2),1:size(im0,1))
%         im0_interp = interp2(im0,xq,yq);
%         [xq1,yq1]=meshgrid(1:size(im1,2),1:size(im1,1))
%         im1_interp = interp2(im1,xq1,yq1);
%         Ix2= sum(sum(Ix_interp).^2);
%         Iy2=sum(sum(Iy_interp).^2);
%         IxIy=sum(sum(Ix_interp.*Iy_interp));
%         A=[Ix2,IxIy;IxIy,Iy2];
% 
% 
%         if abs(det(A)) < eps
%         % singular matrix
%             return
%         end
%         It=It( i-win:i+win, j-win:j+win );
% 
% 
% 
%         B=-[sum(sum(Ix_interp.*It));sum(sum(Iy_interp.*It))];
%         displ=A\B;
%         u=displ(1);
%         v=displ(2);
% 
%                 
%         end
%           
%     end
% end
%  
%         
        
        
        
        
    










