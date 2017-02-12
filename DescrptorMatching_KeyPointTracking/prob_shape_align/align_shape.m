function [T] = align_shape(im1,im2)

  tic;
  padsize = 100;
  im1 = padarray(im1, [padsize padsize]);
  im2 = padarray(im2, [padsize padsize]);
  [Y1, X1] = find(im1>0); 
  [Y2, X2] = find(im2>0);
  [H W] = size(im2); 

  [dis, ind] = bwdist(im2);
 
  T_X = floor((ind-1)/H)+1;
  T_Y = mod((ind-1), H)+1;
  Y_temp = Y1; 
  X_temp = X1;
  M1=[X_temp,Y_temp];
%   var=M1';
  M2=[X2,Y2];
  size(M2)
  [U,S, V]=svd((cov(M1)));
  R1=V*U';
  theta1=atan2(V(1,1),V(2,1))
  [U1,S1, V1]=svd(cov(M2));
  R2=U1*V1';
  theta2=atan2(V1(1,1),V1(2,1))
  theta=(theta2-theta1)*(180/3.14)
  if abs(theta)>150 ||theta<-150
      imrotate(im1,180)
  end
  if round(theta)==90 ||round(theta)==-90
      rot=[cos(theta),-sin(theta);sin(theta),cos(theta)];
      A=rot*M1';
% %   b=size(A)
      X_temp(:,1)=abs(A(1,:));
      Y_temp(:,1)=abs(A(2,:));
  end
%   if round(theta)<90 ||round(theta)>40
%       rot=[cos(theta),-sin(theta);sin(theta),cos(theta)];
%       A=rot*M1';
% % %   b=size(A)
%       X_temp(:,1)=abs(A(1,:));
%       Y_temp(:,1)=abs(A(2,:));
%   end
%   p=size(theta)
%   N1=theta*M1';
%   X_temp=N1(1,:);
%   Y_temp=N1(2,:);
%   X_temp=X_temp';
%   Y_temp=Y_temp';
%   c=size(theta)
%   rot=[cos(theta),-sin(theta);sin(theta),cos(theta)];
%   A=rot*M1;
% %   b=size(A)
%   X_temp(:,1)=A(1,:);
%   Y_temp(:,1)=A(2,:);
%   size(X_temp)
%   size(Y_temp)
  
  
  dx = mean(X2) - mean(X1); dy = mean(Y2) - mean(Y1); 
  Transform = [1 0 0; 0 1 0; dx dy 1]; 
  oldT =[X_temp Y_temp ones(size(X1))];
  for i=1:60
    newT = [X_temp Y_temp ones(size(X1))]*Transform; 
    if i>1
      if sum(sum(abs(newT-oldT)))< 7 
        break;
      end
    end
    oldT = newT;
    X1 = round(newT(:,1)); 
    Y1 = round(newT(:,2)); 
    
    B=zeros( size(X1, 1), 1); A = zeros( size(X1, 1), 6);
    for j=1:size(X1,1)
      A([j*2-1,j*2],:) = [X1(j) Y1(j) 1 0 0 0; 0 0 0 X1(j) Y1(j) 1];
      B([j*2-1,j*2] ) = [T_X(Y1(j),X1(j)) T_Y(Y1(j),X1(j))];
    end
    Transformation = pinv(A)*B;
    Transform = Transform*[Transformation(1) Transformation(4) 0; Transformation(2) Transformation(5) 0; Transformation(3) Transformation(6) 1]; 
  end
       T = Transform';
  toc;
end
