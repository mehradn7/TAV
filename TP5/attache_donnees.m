function [AD] = attache_donnees(I,moyennes,variances)
AD = zeros(size(I,1), size(I,2), length(moyennes));

for k=1:length(moyennes)
    AD(:,:,k) = 0.5*log(variances(k)) + 0.5*((I(:,:) - moyennes(k))/sqrt(variances(k))).^2;
end