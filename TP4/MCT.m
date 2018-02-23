function X_chapeau = MCT(x,y)

A = [(x.^2) (x.*y) (y.^2) x y ones(size(x));
    1 0 1 0 0 0];

b = zeros(size(x,1)+1,1);
b(end) = 1;

[U,S,V] = svd(A);
[S,I] = sort(diag(S), 'descend');
V = V(:,I);

X_chapeau = V(:,size(V,2));


