function [mu,Sigma] = estimation_mu_Sigma(X)
    mu = mean(X);
    
    X_c = X - mu;
    Sigma = (X_c' * X_c)/(size(X,1));


end
