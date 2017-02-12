function [ ] = get_ht(  )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
%     
%     bo=[937.27;2227.77;1]
%     f=[922.68; 1956.06; 1]
%     r=[942.14; 926.82; 1];
    load vp_n_x;
    load vp_n_y;
    load vp_n_z;
    load bo;
    load temp;% temp changes for the value of tractor and building(base coordinates)
    load r;
    load to;
%     size(b)
%     temp=b;
%     c=size(f)
%     size(bo)
    c1=(cross(temp,bo));
    c2=cross(vp_n_x,vp_n_y);
%     to=[942.14; 2073.69;1];
    v=cross(c1,c2);
    c3=cross(v,to);
    c4=cross(r,temp);
    t=cross(c3,c4);
% %     A=[norm(t-temp)*norm( r)
%     num=(norm(t-temp)*norm( r))
%     den=(norm(r-temp)*norm( - t))
%     H=(num/den)*6236.220472441
    A=[bo';to'];
    B=[temp';r'];
    C=[t';temp'];
    D=[r';temp'];
    E=[vp_n_z';r'];
    F=[vp_n_z';t'];
    d1 = pdist(C,'euclidean');
    d2 = pdist(D,'euclidean');
    d3 = pdist(E,'euclidean');
    d4 = pdist(F,'euclidean');
    
    fac=((d1*d3)/(d2*d4))
    H=1.65*fac
    
    a = v_n_x - v_n_z;
    b = bo - v_n_z;
    ht_camera = norm(cross(a,b)) / norm(a);

    
%     d1 = pdist(A,'euclidean');
%     d2 = pdist(B,'euclidean');
%     H=1.65*(d2/d1)
%     
%     
    
    

end

