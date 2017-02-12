function A = predictTranslation(startX, startY, Ix, Iy, im0, im1)


%     disp('tra');
    win_size=15;
    [Xq,Yq]=meshgrid(startX-floor(win_size/2):startX + floor(win_size/2), startY-floor(win_size/2):startY+floor(win_size/2));
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
    It=((im1_interp-im0_interp));
    Xprime=startX;
    Yprime=startY;
    
   for i=1:50
      if (Xprime-floor(win_size/2))<0 || Xprime+floor(win_size/2)>size(im0,2) ||(Yprime-floor(win_size/2))<0 ||(Yprime+floor(win_size/2))>size(im0,1)
          break
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
           It=((im1_interp_new-im0_interp));
           
        end
   end
    newX=Xprime;
    newY=Yprime;
    A=[newX;newY];
  end
   

        
        
        
        
        
    
