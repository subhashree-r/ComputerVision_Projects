function [ vp ] = rand_vp( lines )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


a=randsample(size(lines,1),2);
px=0;
py=0;
p=[];
for i=1:(size(a,1)-1)
    l1=cross([lines(a(i),1);lines(a(i),2);1],[lines(a(i),3);lines(a(i),4);1]);
    l2=cross([lines(a(i+1),1);lines(a(i+1),2);1],[lines(a(i+1),3);lines(a(i+1),4);1]);
    p=cross(l1,l2);
    px=px+p(1);
    py=py+p(2);
end
vp=[px;py;1];

end

