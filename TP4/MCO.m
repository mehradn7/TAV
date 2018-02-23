function X_chapeau = MCO(x,y)

A = [(x.^2) (x.*y) (y.^2) x y ones(size(x));
    1 0 1 0 0 0];

b = zeros(size(x,1)+1,1);
b(end) = 1;

X_chapeau = (A'*A)\(A'*b);


