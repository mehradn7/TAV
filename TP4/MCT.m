function X_chapeau = MCT(x,y)

A = [(x.^2) (x.*y) (y.^2) x y ones(size(x))];

[U,S,V] = svd(A);
[S,I] = sort(diag(S), 'descend');
V = V(:,I);

X_chapeau = V(:,size(V,2));


