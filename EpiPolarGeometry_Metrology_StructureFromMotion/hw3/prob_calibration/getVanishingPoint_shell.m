function vp = getVanishingPoint_shell()
% output vanishing point, input image
im=imread('C:/First_sem/CV/hw3/hw3/prob_calibration/new_classroom_building.jpg');
[r,c]=size(im)
figure(1), hold off, imagesc(im)
hold on 
% load vp1;
% load vp2;
load vp_n_x;
load vp_n_y;
load vp1;
load vp2;
vp1o=vp1;
vp2o=vp2;
vp1=vp_n_x;
vp2=vp_n_y;
% Allow user to input line segments; compute centers, directions, lengths
disp('Set at least two lines for vanishing point')
lines = zeros(3, 0);
line_length = zeros(1,0);
centers = zeros(3, 0);
while 1
    disp(' ')
    disp('Click first point or q to stop')
    [x1,y1,b] = ginput(1)    
    if b=='q'        
        break;
    end
    disp('Click second point');
    [x2,y2] = ginput(1);
    bo=[x2;y2;1];
%     save bo;
    plot([x1 x2], [y1 y2], 'b')
    lines(:, end+1) = real(cross([x1 y1 1]', [x2 y2 1]'))
    line_length(end+1) = sqrt((y2-y1)^2 + (x2-x1).^2);
    centers(:, end+1) = [x1+x2 y1+y2 2]/2;
    size(lines)
    
end

%% solve for vanishing point 
% Insert code here to compute vp (3x1 vector in homogeneous coordinates)
A=[lines(1,1),lines(2,1)];
B=[-lines(3,1)];
for i=2:(size(lines,2))
    A=vertcat(A,[lines(1,i),lines(2,i)]);
    B=vertcat(B,-lines(3,i));
end
% X=[]
% % B=[-1;-1;-1];
size(A)
size(B)
vp=A\B;
act=size(vp)
% 
% a=mean(lines(1,:));
% b=mean(lines(2,:));



c = 1;
x = vp(1);
y = vp(2);

plot([vp1o(1) vp2o(1)],[vp1o(2), vp2o(2)]);
line=cross(vp1,vp2)

% save points.mat vp
% Now the plotting.
% figure(2);
% imshow(im);
% hold on;
% pp = [-a,-c]/b; % Polynomial as MATLAB likes it.
% li = linspace(x-1,x+1);  % Where to plot the line...
% pv = polyval(pp,li);  % Evaluate the polynomial.
% plot(li,pv,'-b',x,y,'*r')
% hold off;
% size(X)
% X(1)=X(1)/X(3);
% 
% X(2)=X(2)/X(3);

% vp=X'
% vp(1:2) = (lines(1:2,:))'\(-1*lines(3,:))';
% 
% vp(3) = 1;
vp(3,:)=1;
Vp2f=vp;
save Vp2f;
% save vp1
% c=size(vr
    
    
   



%% display 
hold on
bx1 = min(1, vp(1)/vp(3))-10; bx2 = max(size(im,2), vp(1)/vp(3))+10;
by1 = min(1, vp(2)/vp(3))-10; by2 = max(size(im,1), vp(2)/vp(3))+10;
for k = 1:size(lines, 2)
    if lines(1,k)<lines(2,k)
        pt1 = real(cross([1 0 -bx1]', lines(:, k)));
        pt2 = real(cross([1 0 -bx2]', lines(:, k)));
    else
        pt1 = real(cross([0 1 -by1]', lines(:, k)));
        pt2 = real(cross([0 1 -by2]', lines(:, k)));
    end
    pt1 = pt1/pt1(3);
    pt2 = pt2/pt2(3);
    plot([pt1(1) pt2(1)], [pt1(2) pt2(2)], 'g', 'Linewidth', 1);
end
plot(vp(1)/vp(3), vp(2)/vp(3), '*r')
axis image
axis([bx1 bx2 by1 by2]); 

