function find_fund_norm( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    load matches;
    load r1;
    load c1;
    im1=imread('C:/First_sem/CV/hw3/hw3/prob_fundamental_matrix/chapel00.PNG')    
    im2=imread('C:/First_sem/CV/hw3/hw3/prob_fundamental_matrix/chapel01.PNG')  
    [m n]=size(im2);
    new1=matches(:,1);
    new2=matches(:,2);
    for i=1:size(new1,1)
        x1(1:3,i)=[r1(new1(i)); c1(new1(i));1];
        x2(1:3,i)=[r2(new1(i)); c2(new1(i));1];
    end
    size(x1,2)
    F={};
    F_new=[];
    prev_inliers=100;
    for i=1:20
        ind=randsample(size(x1,2),8)
        for j=1:8
            
            x1_new(:,j)=x1(:,ind(j));
            x2_new(:,j)=x2(:,ind(j));
        end
         x1_new=
         A = [x2_new(1,:)'.*x1_new(1,:)'   x2_new(1,:)'.*x1_new(2,:)'  x2_new(1,:)'  x2_new(2,:)'.*x1_new(1,:)' x2_new(2,:)'.*x1_new(2,:)'  x2_new(2,:)'  x1_new(1,:)' x1_new(2,:)' ones(8,1) ]; 
         [U, S, V] = svd(A);
         f = V(:, end);
         F{i} = reshape(f, [3 3])';
         [U, S, V] = svd(F{i});
         S(3,3) = 0;
         F{i} = U*S*V';
         thr=x1_new'*F{i}*x2_new;
         size(thr)
         c=mean(var(abs(thr)));
         inliers=find(thr<c);
         outliers=find(thr>c);
         no_inliers=((size(inliers,1)));
         cur_inliers=no_inliers;
         v=find(thr(outliers(1:end)))
         size(thr)
         if(prev_inliers>cur_inliers)
             F_new=F{i};
%              outliers_ind=find(thr>c)
%              
%             if (size(outliers_ind))
%              for m=1:size(outliers_ind,2)
%                 o_i(m,:)=thr(outliers_ind(m))
%              end
%             end
% %              in_i(:,:)=thr(inliers)
             
%              for k=1:size(outliers_ind,2)
%                  outliers(1,k)=x1_new(outliers_ind(1,k));
%                  outliers(2,k)=x1_new(outliers_ind(2,k));
%                  inliers_p(1,k)=x1_new(inliers(1,k));
%                  inliers_p(2,k)=x1_new(inliers(2,k));
%              end
%              
         end
         
%          if 
%          check=min(abs(thr))
%          size(F{1})
    end
%     for l=1:10
%         
     size(F_new)
%      
%          
%      
     figure(1);
     imshow(im2);
         
     hold on;
     plot(x2_new(1,:), x2_new(2,:), 'r*'); 

    % Getting the epipolar line on the RIGHT image:
    for k=1:8
     left_P = [x2_new(1,k); x2_new(2,k); 1];
     right_P = F_new*left_P;
     right_epipolar_x = 1:2*m;

    % Using the eqn of line: ax+by+c=0; y = (-c-ax)/b
     right_epipolar_y = (-right_P(3)-right_P(1)*right_epipolar_x)/right_P(2);
     plot(right_epipolar_x, right_epipolar_y, 'g');
     
    end
    hold off;
    figure(2);
    imshow(im1);

    hold on;
    plot(x1_new(1,:), x1_new(2,:), 'r*'); 

    % Getting the epipolar line on the RIGHT image:
    for k=1:8
%      left_P = [x2_new(1,k); x2_new(2,k); 1];
%      right_P = F*left_P;
%      right_epipolar_x = 1:2*m;
% 
%     % Using the eqn of line: ax+by+c=0; y = (-c-ax)/b
%      right_epipolar_y = (-right_P(3)-right_P(1)*right_epipolar_x)/right_P(2);
%      plot(right_epipolar_x, right_epipolar_y, 'g');
    [FU, FD, FV] = svd(F_new);
    left_epipole = FV(:,3);
    left_epipole = left_epipole/left_epipole(3);

    % Hence using the left epipole and the given input point on left
    % image we plot the epipolar line on the left image
    left_epipolar_x = 1:2*m;
    left_epipolar_y = x1_new(2,k)+ (left_epipolar_x-x1_new(1,k))*(left_epipole(2)-x1_new(2,k))/(left_epipole(1)-x1_new(1,k));
    plot(left_epipolar_x, left_epipolar_y, 'g');
    end
    hold off;
    figure(3);
    imshow(im1);         
    hold on;
    plot(outliers(1,:), outliers(2,:), 'r*'); 
    plot(inliers_p(1,:), inliers_p(2,:), 'g*'); 
    hold off;
     

        

end

