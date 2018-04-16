function [indices_S_max,S_max,taux_compression] = calcul_S_max(signal,nb_echantillons_par_mesure,n)
    TG = T_Gabor(signal,nb_echantillons_par_mesure);
    TG = TG(1:floor(size(TG,1)/2), :);
    [TG,I] = sort(abs(TG), 'desc');
    
    S_max = TG(1:n, :);
    indices_S_max = I(1:n, :);
    
    taux_compression = size(TG,1) / n;
    
    S_max
    




end
