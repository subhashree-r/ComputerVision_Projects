function [m] = metric_const(a,b)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    m = [ a(:,1).*b(:,1), a(:,1).*b(:,2) + a(:,2).*b(:,1), a(:,1).*b(:,3) + a(:,3).*b(:,1), a(:,2).*b(:,2) ,a(:,2).*b(:,3) + a(:,3).*b(:,2) , a(:,3).*b(:,3) ];

end

