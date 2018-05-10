function [indices_S_max,S_max,taux_compression] = calcul_S_max(signal,nb_echantillons_par_mesure,n)
    TG = T_Gabor(signal,nb_echantillons_par_mesure);
    TG = TG(1:floor(size(TG,1)/2), :);
    % On trie la matrice de la Transformée de Gabor selon les modules
    % décroissants
    [TG_trie_par_valeur_absolue,I] = sort(abs(TG), 'desc');
    
    
    S_max = [];
    % On sélectionne les lignes de TG correspondant aux coefficients du
    % sonogramme de module le plus élevé
    
    for i=1:size(TG,2)
       S_max(:,i) = TG(I(1:n,i), i); 
    end
    indices_S_max = I(1:n, :);
    
    taux_compression = size(TG,1) / n;
    
    




end
