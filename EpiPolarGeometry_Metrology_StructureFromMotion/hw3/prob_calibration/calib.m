function  calib()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    load Vx;
    load Vy;
    load Vz;
    

    X1=[1,0,0]';
    X2=[0,1,0]';
    X3=[0,0,1]';
    syms x y
    eqn1=((Vx(1)-x).*(Vx(1)-Vz(1)))+((Vx(2)-y).*(Vy(2)-Vz(2)));
    eqn2=((Vz(1)-x).*(Vx(1)-Vy(1))+((Vz(2)-y).*(Vx(2)-Vy(2))));
    [A,B] = equationsToMatrix([eqn1, eqn2], [x, y])
    X = linsolve(A,B)
    f=sqrt(((-(Vx(1)-X(1)).*(Vy(1)-X(1))))-((Vx(2)-X(2)).*(Vy(2)-X(2))))

end

