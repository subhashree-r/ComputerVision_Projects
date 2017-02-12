function [  ] = sfm_try( )
    
load tracks.mat;
save track_x;
save track_y;

Xs=track_x';
Ys=track_y';
size(Xs)
    
    
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
    [~,mis_pts]=find(isnan(Xorig));
    a=unique(mis_pts);
    h=size(a)
    [frames,~]=find(isnan(Xorig(:,a(1))));
    t=size(frames)
    
    
    
    newind=[];
%     for 
    for i=1:size(frames,1)
        newind=horzcat(newind,(frames(i)+F));
    end
    xind=horzcat(frames',newind);
    yind=a';
    
        
        
        
    
    
    
%     [~,index2]=find(isnan(Yorig));
%     bh1=(unique(index1))
%     bh2=(unique(index2))
    % size(Xs)
    % size(Ys)
    Xs_n = Xs - sum(Xs,2)/size(Xs,2)*ones(1,size(Xs,2)); % FxP

    Ys_n = Ys - sum(Ys,2)/size(Ys,2)*ones(1,size(Ys,2)); % FxP


    %%% 1. compute W

    W = [Xs_n; Ys_n];
    P=size(W)

% W = zeros(2*F, P);

% for f = 1:F

%     W(2*f-1:2*f, :) = [Xs(f, :); Ys(f, :)];

% end



%%% 2. SVD of W

    [U D V] = svd((W));
    
    U3=U(:,1:3);
    V3=V(:,1:3);
    V3_n=V3';
    D3=D(1:3,1:3);
    A=U3*sqrt(D3);
    IN1=size(A)
    
    S=sqrt(D3)*V3_n;
    IN2=size(S)
    
%%% computing Q matrix
    If = A(1:F, :);
    Jf = A(F+1:end, :);
    c=size(If)
    d=size(Jf)
    m = [metric_const(If,Jf); metric_const(If, Jf); metric_const(If, Jf)]; 
    c = [ones(2*F, 1); zeros(F, 1)]; % 3Fx1
    size(c)
    size(m)
    I = m\c;
    size(I)

    L = [I(1) I(2) I(3);  I(2) I(4) I(5);I(3) I(5) I(6)];
    L=Spd_Mat(L);
    C=chol(L);
    A=A*C;
    S=C\S;
    size(S)
    size(A)
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
    
%     Anew=A(xind,yind);
%     thecheck=size(Anew)
    
    
%     a1=
%     a(~isnan(a))
%     
    plotSfM(A,S);
    
    
    
    rotate3d on
    
%     figure; plot3(S(1, :), S(3, :), S(2, :), 'o'); xlabel('x coordinate'); ylabel('z coordinate'); zlabel('y coordinate');
% 
%     figure; plot3(S(2, :), S(3, :), S(1, :), 'o'); xlabel('y coordinate'); ylabel('z coordinate'); zlabel('x coordinate');
% 
%     figure; plot3(S(3, :), S(2, :), S(1, :), 'o'); xlabel('z coordinate'); ylabel('y coordinate'); zlabel('x coordinate');
%     k_f = zeros(3, size(U,1));
% 
%     for index = 1 : (si-1)
% 
%         i_f = A(index,:)';
% 
%         i_f = i_f / norm(i_f);
% 
%         j_f = A(si+index,:)';
% 
%         j_f = j_f / norm(j_f);
% 
%         k = cross(i_f, j_f);
% 
%         k_f(:,index) = k / norm(k);
% 
%     end
%     figure; plot3(k_f(:, 1), k_f(:, 2), k_f(:, 3),'.-');
% 
%     figure; 
% 
%     subplot(131);plot(k_f(:, 1), k_f(:, 2), '.-');
% 
%     grid on;    title('XY axis');
% 
%     subplot(132);plot(k_f(:, 1), k_f(:, 3),'.-');
% 
%     grid on;    title('XZ axis');
% 
%     subplot(133); plot(k_f(:, 2), k_f(:, 3),'.-');
% 
%     grid on;  title('YZ axis');
% 
%     suptitle('camera position over all frames on');
%     
%     figure; plot3(k_f(1,:), k_f(2,:), k_f(3,:), 'k.'); xlabel('x coordinate'); ylabel('y coordinate'); zlabel('z coordinate');
% 
%     figure; hold on; xlabel('the ith frame'); 
% 
%     plot(1:size(U,1), k_f(1,:), 'r.');
% 
%     plot(1:size(U,1), k_f(2,:), 'g.');
% 
%     plot(1:size(U,1), k_f(3,:), 'b.');
%     
%     hleg = legend('x coordinate','y coordinate','z coordinate','Location','NorthEastOutside'); set(hleg,'FontAngle','italic','TextColor',[.3,.2,.1]);
%         camera_pos = zeros(si, 3);

%     for f = 1:si
% 
%         kf = cross(A(f,:), A(f+si, :));
% 
%         camera_pos(f,:) = kf/norm(kf); % in unit norm
% 
%     end
% 
% 
% 
%     % save this plot in 3 axis.......
% 
%     %sfigure; plot3(camera_pos(:, 1), camera_pos(:, 2), camera_pos(:, 3),'.-');
% 
%     figure; 
% 
%     subplot(131);plot(camera_pos(:, 1), camera_pos(:, 2), '.-');
% 
%     grid on;    title('XY axis');
% 
%     subplot(132);plot(camera_pos(:, 1), camera_pos(:, 3),'.-');
% 
%     grid on;    title('XZ axis');
% 
%     subplot(133); plot(camera_pos(:, 2), camera_pos(:, 3),'.-');
% 
%     grid on;  title('YZ axis');
% 
%     suptitle('camera position over all frames on');
% 
% %%% 3. make M', S' 
% 
% % Mhat = U(:, 1:3)*sqrt(D(1:3, 1:3)); 
% % 
% % Shat = sqrt(D(1:3, 1:3))*V(:, 1:3)';



%%% 4. Compute Q, impose the metric constraints

% Is = Mhat(1:F, :);
% 
% Js = Mhat(F+1:end, :);






% l2 = G\c;
% 
% fprintf('resid with mldivide = Gl - c, %g\n', norm(G*l2 - c));
% 
% % they give the same result because matlab is optimized
% 
% 
% 
% % could be a programatic way, but hey we "see" 3D or 2D
% 
% L = [l(1) l(2) l(3);...
% 
%      l(2) l(4) l(5);...
% 
%      l(3) l(5) l(6)] ;
% 
% Q = chol(L); % finally!
% 
% 
% 
% %fprintf('check %g\n', all(all(L = Q'*Q)));
% 
% 
% 
% %%% 5. get M and S
% 
% M = Mhat*Q;
% 
% S = inv(Q)*Shat;
% 
% 
% 
% if VERBOSE
% 
%     %% plot of 3D points
% 
%     sfigure;
% 
%     plot3(Shat(1, :), Shat(2,:), Shat(3,:),'k.'); hold on;
% 
%     plot3(S(1, :), S(2,:), S(3,:),'b.');
% 
%     plot3(0,0,0,'gs');
% 
%     grid on;
% 
%     title(['3D points from tracked points: before and after eliminating ' ...
% 
%            'affine ambiguity upto orthography']);
% 
%     legend('before','after', 'origin');
% 
%     %% plot of the predicted 3D path of the cameras
% 
%     %The camera position for each frame is given by the cross product
% 
%     %kf = if × jf. For consistent results, normalize all kf to be unit
% 
%     %vectors. Give three plots, one for each dimension of kf.
% 
%     
% 
%     camera_pos = zeros(F, 3);
% 
%     for f = 1:F
% 
%         kf = cross(M(f,:), M(f+F, :));
% 
%         camera_pos(f,:) = kf/norm(kf); % in unit norm
% 
%     end
% 
% 
% 
%     % save this plot in 3 axis.......
% 
%     %sfigure; plot3(camera_pos(:, 1), camera_pos(:, 2), camera_pos(:, 3),'.-');
% 
%     sfigure; 
% 
%     subplot(131);plot(camera_pos(:, 1), camera_pos(:, 2), '.-');
% 
%     grid on;    title('XY axis');
% 
%     subplot(132);plot(camera_pos(:, 1), camera_pos(:, 3),'.-');
% 
%     grid on;    title('XZ axis');
% 
%     subplot(133); plot(camera_pos(:, 2), camera_pos(:, 3),'.-');
% 
%     grid on;  title('YZ axis');
% 
%     suptitle('camera position over all frames on');

end


