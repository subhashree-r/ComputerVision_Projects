
load annotation_data  
%   load my


no_ann = 25;
no_img = 150;
len_ann = length(annotation_scores)
I = unique(image_ids)';
beta = .5;
sigma = std(annotation_scores);
mu = zeros(no_img, 1);
for i=1:no_img
mu(I(i)) = mean( annotation_scores(image_ids==I(i)) );
end

for k=1:20
L=[];

for v = 1:len_ann
L(v,1)=normpdf(annotation_scores(v),mu(image_ids(v)),sigma);
end
L(:, 2) = 1/10;

w = zeros(25, 1);
for k = 1:no_ann
idx = annotator_ids == k; % Find the votes that cast by the k-th annotator
t1 = log(beta)   + sum(log(L(idx,1)));
t2 = log(1-beta) + sum(log(L(idx,2)));
w(k) = exp(t1) / (exp(t1)+exp(t2));
end


wf = w(annotator_ids);
beta = sum(wf)/ len_ann;

for i=1:no_img
    mu(i) = sum(annotation_scores(image_ids==I(i)).*wf(image_ids==I(i))) / sum(wf(image_ids==I(i)));
end
sigma = sqrt(sum((annotation_scores - mu(image_ids)).^2 .* wf) / sum(wf));

end
good = find(w>.5)
bad=find(w<0.5)
sigma=mean(sigma)

% for i=1:no_img
% mean_scores(i) = mean( annotation_scores( good(annotator_ids) & image_ids==i ) );
% end
plot(1:150, mu(1:150));
end
