function [cx, cy, w, h, orient, count]= getObjectRegion(keypt1, keypt2, matches, objbox, minpts)
objx = mean(objbox([1 3])); % x-center 
objy = mean(objbox([2 4])); % y-center 
objw = objbox(3)-objbox(1); 
objh = objbox(4)-objbox(2);
% Find parameters for keypoints in image 1 
s1 = keypt1(3, matches(1, :));
o1 = keypt1(4, matches(1, :)); 
x1 = keypt1(1, matches(1, :)); 
y1 = keypt1(2, matches(1, :));
% Find parameters for keypoints in image 2 
s2 = keypt2(3, matches(2, :)); 
o2 = keypt2(4, matches(2, :)); 
x2 = keypt2(1, matches(2, :)); 
y2 = keypt2(2, matches(2, :));

orient=o2-o1;
h=(s2/s1).*objh
w=(s2/s1).*objw
cx=x2+sum([(objx-x1) ; (objy-y1)] .* [cos(o2-o1) ; -sin(o2-o1)],1).*(s2./s1)
cy=y2+sum([(objx-x1) ; (objy-y1)] .* [sin(o2-o1) ; cos(o2-o1)],1).*(s2./s1)


end

