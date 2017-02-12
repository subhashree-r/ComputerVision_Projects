function displayPyramids(G, L)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    figure;
%     for i=1:5
%         subplot(2,5,i);
%         imshow(G{i});
%         subplot(2,5,i+5);
%         imshow(L{i}+0.5);
%     end
    ha = tight_subplot(2,5,[.01 .03],[.1 .01],[.01 .01]);
% %           for ii = 1:6; axes(ha(ii)); plot(randn(10,ii)); end
% 
% %     axes(ha(1));
% %     imshow(G{1});
% 
    for i=1:5
% %         figure;
%         axes(ha(i));
        subplot(ha(i)),imshow(G{i});
%         
% %         axes(ha(i+5));
% % %         subplot(2,5,i+5);
%         imshow(G{1,i});
    end
% %     
    for j=1:5
% %         figure;
% %         imshow((G{i}));
        subplot(ha(j+5)),imshow((L{j})+0.5);
%         imshow((L{1,j})+0.5);
%     end
%     figure;
end

