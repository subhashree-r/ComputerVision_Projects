function [] = rotmat( )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

    f=1158.21;
    u=-224.292;
    v=-20.1119;
    
    K=[f,0,u;0,f,v;0,0,1];
    p1=[1481.97;465.54;1];
    p2=[554.66;5.34;1];
    p3=[-438.81;412.15;1];
%     p1=[1,0,0]'
%     p2=[0,1,0]'
%     p3=[0,0,1]'
%     
    r1=K\p1;
    r2=K\p2;
    r3=K\p3;
    
    r1=r1/norm(r1);
    r2=r2/norm(r2);
    r3=r3/norm(r3);
    
    R=[r1 r2 r3]
    
end

