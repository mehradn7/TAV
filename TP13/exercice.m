%% TP 13 - Reconnaissance de phonemes
liste_phonemes = {'a', 'e', 'e_aigu', 'e_grave',  'i', 'o', 'o_ouvert', 'ou', 'u'};
repertoire = '/mnt/n7fs/ens/tp_queau/Apprentissage/';
nb_phonemes = length(liste_phonemes);
nb_coefficients = 882;

donnees_spectres = [];
donnees_cepstres = [];

spectres_means = [];
cepstres_means = [];

bonne_classif = [];

for i=1:nb_phonemes
    for j=1:5
        nom_fichier = strcat(repertoire, liste_phonemes{i}, '_', num2str(j), '.wav');
        [signal,f_echantillonnage] = audioread(nom_fichier);
        
        [coefficients_spectre,coefficients_cepstre] = spec_ceps(signal,f_echantillonnage, nb_coefficients);
        
        donnees_spectres = [donnees_spectres ; mean(coefficients_spectre,1)];
        donnees_cepstres = [donnees_cepstres ; mean(coefficients_cepstre,1)];
        bonne_classif = [bonne_classif ; i];
    end
    spectres_means = [spectres_means ; mean(donnees_spectres(1 + (i-1)*5:i*5, :), 1)];
    cepstres_means = [cepstres_means ; mean(donnees_cepstres(1 + (i-1)*5:i*5, :), 1)];
    

end

[IDX_spec, C_spec] = kmeans(donnees_spectres, nb_phonemes,'emptyaction', 'error', 'start', spectres_means);
[IDX_ceps, C_ceps] = kmeans(donnees_cepstres, nb_phonemes,'emptyaction', 'error', 'start', cepstres_means);

% Pourcentages de bonnes classifications
taux_bonnes_classif_spec = (sum(IDX_spec == bonne_classif)/45)*100;
taux_bonnes_classif_ceps = (sum(IDX_ceps == bonne_classif)/45)*100;

% ACP sur les donnees cepstrales

X = donnees_cepstres;
g = mean(X);
Xc = X - ones(size(X,1),1)*g;
sigma = (1/(size(X,1))) * (Xc)'*Xc;
[W,D] = eig(sigma);
[D,J] = sort(diag(D), 'descend');
W = W(:,J); %tri des colonnes selon vp décroissantes
C = Xc * W; %changement de base


liste_couleurs = {'. b','. g', '. r', '. c', '. m', '. y', '* b', '* g', '* r'}; 
figure(1)
hold on;
for i=1:size(C(:,1),1)
    if (IDX_ceps(i) == bonne_classif(i))
        couleur = liste_couleurs{IDX_ceps(i)};
    else
        couleur = '. k';
    end
    
    plot(C(i,1), C(i,2), couleur);

end


