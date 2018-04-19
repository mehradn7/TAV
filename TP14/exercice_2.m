clear;
close all;

load exercice_1;

[IDX, C] = kmeans([X_pensees; X_oeillets; X_chrysanthemes], 3,'emptyaction', 'error', 'start', [mean(X_pensees);mean(X_oeillets);mean(X_chrysanthemes)]);

bonne_classif = [ones(10,1); 2*ones(10,1); 3*ones(10,1)];
taux_bonnes_classif = (sum(IDX == bonne_classif)/30)*100;


