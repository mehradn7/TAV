function TG = T_Gabor(signal,nb_echantillons_par_mesure)
    TG = [];
    indice_debut = 1;
    indice_fin = nb_echantillons_par_mesure;
    while indice_fin < length(signal)
        TG = [TG fft(signal(indice_debut:indice_fin))];
        indice_debut = indice_debut + nb_echantillons_par_mesure;
        indice_fin = indice_fin + nb_echantillons_par_mesure;
    end
    
%     TG = abs(TG); % Pour ne garder que la partie réelle


end