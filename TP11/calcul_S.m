function [S,taux_compression] = calcul_S(signal,nb_echantillons_par_mesure,proportion)
    S = T_Gabor(signal,nb_echantillons_par_mesure);
    nb_lignes = size(S,1);
    nb_lignes_a_conserver = proportion*floor(nb_lignes/2);
    S(nb_lignes_a_conserver+1:nb_lignes, :) = 0;
    
    
    
    taux_compression = nb_lignes / nb_lignes_a_conserver; 



end
