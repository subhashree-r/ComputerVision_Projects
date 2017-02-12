function [VP, lineLabel] = vpDetectionFromLines(lines)

%% Simple vanishing point detection using RANSAC
% === Input === 
% lines: [NumLines x 5]
%   - each row is a detected line segment (x1, y1, x2, y2, length)
% 
% === Output ===
% VP: [2 x 3]
%   - each column corresponds to a vanishing point in the order of X, Y, Z
% lineLabel: [NumLine x 3] logical type
%   - each column is a logical vector indicating which line segments
%     correspond to the vanishing point.

%%

% JLinkage clustering
% http://www.diegm.uniud.it/fusiello/demo/jlk/
PrefMat=[];
PrefMatf=[];
sum_in=0;
for i=1:200
    
%     l1=cross([lines(i,1);lines(i,2);1],[lines(i,3);lines(i,4);1]);
%     l2=cross([lines(i+1,1);lines(i+1,2);1],[lines(i+1,3);lines(i+1,4);1]);
    p1=rand_vp(lines);
    for j=1:100
        
        mp=[(line(j,1)+line(j,3))/2;(line(j,2)+line(j,4))/2;1];
        ep=[line(j,1);line(j,2);1];
        l1=cross(mp,ep);
        
        vp=p1';
        l2=cross(vp,mp);
        v1=[l1(2),-l1(1)];
        v2=[l2(2),-l2(1)];
%         angle=acos(
% %         v1=ep-mp;
% %         v2=vp-mp;
%         v1=[
        angle=rad2deg(acos( dot(v1,v2)/(norm(v1)*norm(v2)) ));
%         angle =rad2deg( atan2(norm(cross(v1,v2)),dot(v1,v2)))
        if(angle>(180-angle))
            angle=(180-angle);
        end  
        
        if (angle<2)
            ang=angle
            PrefMat(j,i)=1;
        else
            PrefMat(j,i)=0;
        end
    end
%     if(sum(sum(PrefMat))>sum_in)
%         PrefMatf=PrefMat;
    end
%     PrefMat=logical(PrefMat)
%     size(PrefMat)

PrefMat=logical(PrefMat);
size(PrefMat)
c=size(p1)
size(lines)
lineLabel = clusterLineSeg(PrefMat);
    
end
% PrefMat=PrefMatf






function lineLabel = clusterLineSeg(PrefMat)

numVP = 3;

T = JLinkageCluster(PrefMat)
numCluster = length(unique(T))
clusterCount = hist(T, 1:numCluster);
[~, I] = sort(clusterCount, 'descend');
check=I

lineLabel = false(size(PrefMat,1), numVP);
for i = 1: numVP
    lineLabel(:,i) = T == I(i);
end

end

function [T, Z, Y] = JLinkageCluster(PrefMat)

Y = pDistJaccard(PrefMat');
Z = linkageIntersect(Y, PrefMat);
T = cluster(Z,'cutoff',1-(1/(size(PrefMat,1)))+eps,'criterion','distance');

end
