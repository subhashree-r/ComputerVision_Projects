function A = predictTranslation(startX, startY, Ix, Iy, im0, im1)


%     disp('tra');
    Xprime=startX;
    Yprime=startY;
    win_size=15;   
    im0 = (im0);
    im1 = (im1);
    i1 = cell(3,1);
    i1{3} = im0;
    i1{2} = impyramid(im0, 'reduce');
    i1{1} = impyramid(i1{2}, 'reduce');
    i2 = cell(3,1);
    i2{3} = im1;
    i2{2} = impyramid(im1, 'reduce');
    i2{1} = impyramid(i2{2}, 'reduce');
 
    u_t=zeros(size(i1{1})); v_t=zeros(size(i1{1}));
    [u0, v0] = predictLK(i1{1},i2{1},u_t, v_t,startX,startY);

% iterative
    tempu = u0; tempv = v0;
    for j = 2:3
        u_t = imresize(tempu, size(i1{j}));
        v_t = imresize(tempv, size(i1{j}));
        u_t = 2.*u_t;
        v_t = 2.*v_t;
        [tempu, tempv]=predictLK(i1{j},i2{j},u_t, v_t,startX/((j-1)*2),startY/((j-1)*2));
    end
    
  
    resu = tempu;
    resv = tempv;
    Xprime=Xprime+resu;
    Yprime=Yprime+resv;
    newX=Xprime;
    newY=Yprime;
    A=[newX;newY];
%     d=sqrt(sum(u.^2+v.^2));   
%     if d<0.05
%         break;
%     else
%            [Xq,Yq]=meshgrid(Xprime-floor(win_size/2):Xprime+floor(win_size/2),Yprime-floor(win_size/2):Yprime+floor(win_size/2));
%            im1_interp_new=interp2(im1,Xq,Yq);
%            It=((im1_interp_new-im0_interp));
%     end
 end

    
   