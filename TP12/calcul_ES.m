function ES = calcul_ES(S,indices_partition,valeurs_t,valeurs_f_S)

ES = [];

for i=1:length(indices_partition) -1 
    sous_bande = S(indices_partition(i):indices_partition(i+1)-1, :);
    [valeurs_max, indices_max] = max(abs(sous_bande));
    
    moyenne = mean(valeurs_max);
    ecart_type = std(valeurs_max);
    seuil = moyenne + ecart_type ;
    
    indices_col = find(valeurs_max > seuil);
    frequences_conservees = valeurs_f_S(indices_partition(i) + indices_max(indices_col) - 1);
    
    ES = [ES ; valeurs_t(indices_col)' frequences_conservees'];
    
    
    
    
end





end