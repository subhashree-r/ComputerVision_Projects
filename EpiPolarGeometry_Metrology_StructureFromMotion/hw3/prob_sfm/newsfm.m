function [  ] = newsfm( D )

    
% load tracks.mat;
% save track_x;
% save track_y;

im=imread('C:/First_sem/CV/hw3/hw3/prob_sfm/images/hotel.seq0.PNG');
figure;imshow(im);hold on;
Xs=D(1:51,:);
Ys=D(52:102,:);
plot( Xs,Ys, '.r', 'LineWidth', 5);
size(Xs)
% hold off;   
    
[F P] = size(Xs); 



%%% 0. to eliminate translation, center all points. i.e. subtract

%% mean of each row
% 
% Xs = bsxfun(@minus, Xs, mean(Xs, 2));
% 
% Ys = bsxfun(@minus, Ys, mean(Ys, 2));
    Xorig=Xs;
    Yorig=Ys;
    Xs=Xs(:,~any(isnan(Xs),1));
    Ys=Ys(:,~any(isnan(Ys),1));
%     [~,mis_pts]=find(isnan(Xorig));
%     a=unique(mis_pts);
%     h=size(a)
%     [frames,~]=find(isnan(Xorig(:,a(1))));
%     t=size(frames)
    
    
    
%     newind=[];
% %     for 
%     for i=1:size(frames,1)
%         newind=horzcat(newind,(frames(i)+F));
%     end
%     xind=horzcat(frames',newind);
%     yind=a';
    
        
        
        
    
    
    
%     [~,index2]=find(isnan(Yorig));
%     bh1=(unique(index1))
%     bh2=(unique(index2))
    % size(Xs)
    % size(Ys)
    Xs_n = Xs - sum(Xs,2)/size(Xs,2)*ones(1,size(Xs,2)); % FxP

    Ys_n = Ys - sum(Ys,2)/size(Ys,2)*ones(1,size(Ys,2)); % FxP


    %%% 1. compute W

    W = [Xs_n; Ys_n];

    [U D V] = svd((W));
    
    U3=U(:,1:3);
    V3=V(:,1:3);
    V3_n=V3';
    D3=D(1:3,1:3);
    A=U3*sqrt(D3);
    S=sqrt(D3)*V3_n;
    
%%% computing Q matrix
    If = A(1:F, :);
    Jf = A(F+1:end, :);
    c=size(If)
    d=size(Jf)
    m = [metric_const(If,Jf); metric_const(If, Jf); metric_const(If, Jf)]; 
    c = [ones(2*F, 1); zeros(F, 1)]; % 3Fx1
    size(c)
    size(m)
    I = m\c; % 6x1
    size(I)

    L = [I(1) I(2) I(3);  I(2) I(4) I(5);I(3) I(5) I(6)];
    L=Spd_Mat(L);
    C=chol(L);
    A=A*C;
    S=C\S;
    
    ch1=size(A)
    ch2=size(S)
    
    figure;

    plot3(S(1, :), S(2,:), S(3,:),'k.'); hold on;

    plot3(S(1, :), S(2,:), S(3,:),'b.');

    plot3(0,0,0,'gs');

    grid on;

    title(['3D points from tracked points: before and after eliminating ' , 'affine ambiguity upto orthography']);

    legend('before','after', 'origin');

    %% plot of the predicted 3D path of the cameras

    %The camera position for each frame is given by the cross product

    %kf = if × jf. For consistent results, normalize all kf to be unit

    %vectors. Give three plots, one for each dimension of kf.

    
    si=size(Xs,1);
    r1=A(1,:)';
    r1=r1/norm(r1);
    r2=A((si+1),:)';
    r2=r2/norm(r2);
    r3=cross(r1,r2);
    chr2=size(r2)
    chr1=size(r1)
    r3=r3/norm(r3);
    b=size(r3)
    
    R=[r1 r2 r3];
    A=A*R;
    S=R\S;
    shape=size(S)
    Aff=size(A)
    

%     
    plotSfM(A,S);
    
    
    
    rotate3d on
    


end







