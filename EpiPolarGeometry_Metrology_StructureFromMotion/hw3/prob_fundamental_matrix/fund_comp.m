function [F] = fund_comp(idx,c1,r1,c2,r2)


    x1 = c1(idx(:,1));
    y1 = r1(idx(:,1));
    x2 = c2(idx(:,2));
    y2 = r2(idx(:,2));

    x_cent = [(x1-mean(x1)) (y1-mean(y1))];  %the x and y coord were centered by subtracting mean. These coordinates were 
                                               %then divided by their norm
                                               %to 
    y_cent = [(x2-mean(x2)) (y2-mean(y2))];
    nd1 = 1/(std(sqrt(sum(x_cent.^2,2))))*sqrt(2);
    nd2 = 1/(std(sqrt(sum(y_cent.^2,2))))*sqrt(2);
    x_cent = x_cent*nd1;
    x1_norm = x_cent(:,1);
    y1_norm = x_cent(:,2);
    y_cent = y_cent*nd2;
    x2_norm = y_cent(:,1);
    y2_norm = y_cent(:,2);
    T1 = [nd1 0 0;0 nd1 0;0 0 1]*[1 0 -mean(x1);0 1 -mean(y1);0 0 1];
    T2 = [nd2 0 0;0 nd2 0;0 0 1]*[1 0 -mean(x2);0 1 -mean(y2);0 0 1];
    A = zeros(size(idx,1),9);

    for i = 1:size(idx,1)

        A(i,:) = [x2_norm(i)*x1_norm(i) x2_norm(i)*y1_norm(i) x2_norm(i) y2_norm(i)*x1_norm(i) y2_norm(i)*y1_norm(i) y2_norm(i) x1_norm(i) y1_norm(i) 1];

    end
%DENORMALISATION
    [U,S,V] = svd(A);
    f = V(:,end);
    F = reshape(f,[3 3])';
    [U1,S1,V1] = svd(F);
    S1(3,3) = 0;
    F = U1*S1*V1';
    F = T2'*F*T1;
    F = F*(sqrt(1/sum(sum(F.^2))));



end