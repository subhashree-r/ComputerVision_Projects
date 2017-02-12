function [d] = dett(A, method)
%Dett  Determinate of any sized matrix
%      Version 2 includes code suggested by John D'Errico
%
%usage:  d = dett(A)
%
%From the QR decomposition of A we have A=Q*R
%
%if A is square then det(A) = det(Q)*prod(diag(R)) = prod(eig(A))
%but
%if A is not square  det(A) = det(Q)*prod(diag(R))
%
%From the SVD of A, A=U*S*V' we have
%     det(Q) = det(U)*det(V') and prod(diag(S)) = prod(diag(R))
%
%see also: Det, Cond, Eig, SVD, ADJ
%

%Paul Godfrey
%Version 2, November 2006
%  Algorithmic speed improvements made based on
%  discussion suggestions from John D'Errico


if exist('method','var')
  % old SVD based version
  [r,c]=size(A);
  [u,s,v]=svd(A);

  if r==1 | c==1
     s=s(1);
  else
     s=diag(s);
  end
  d=det(u)*prod(s)*det(v');
else
  % use John D'Errico's version as the default
  % using John's publicly available code
  % with a fix for a complex matrix bug

  [r,c]=size(A);
  if r>=c
     [Q,R] = qr(A);
  else % faster QR decomp based on size
     [Q,R] = qr(A.');% need .' here, not John's original A'
  end

  if r==1 | c==1
     R=R(1);
  else
     R=prod(diag(R));
  end
  d=det(Q)*R;
end

return
