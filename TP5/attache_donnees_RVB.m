function AD_RVB = attache_donnees_RVB(I,moyennes,variances_covariances)
[m,n,~] = size(I);
N = size(moyennes,2);

AD_RVB = zeros(m, n, N);

for i=1:N
    det_sigma = sum(diag(variances_covariances(:,:,i)));    
    
    for j=1:m
        for k=1:n
            moy_reshaped = reshape(moyennes(:,i),1,1,3);
            difference = I(j,k,:) - moy_reshaped;
            difference = reshape(difference, 3,1);
            
            AD_RVB(j,k,i) = 0.5*log(det_sigma) + (0.5*difference' * (variances_covariances(:,:,i)\difference));
        end
    end
end