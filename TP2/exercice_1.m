clear;
close all;
load donnees;
figure('Name','Individu moyen et eigenfaces','Position',[0,0,0.67*L,0.67*H]);

% Calcul de l'individu moyen :
individu_moyen = mean(X);

% Centrage des donnees :
X_c = X - individu_moyen;

% Calcul de la matrice Sigma_2 (de taille n x n) :
n = size(X,1);
Sigma_2 = (X_c*X_c')/n;

% Calcul des vecteurs/valeurs propres de la matrice Sigma_2 :
[Q,D] = eig(Sigma_2);

% Tri par ordre decroissant des valeurs propres de Sigma_2 :
[D,J] = sort(diag(D), 'descend');

% Tri des vecteurs propres de Sigma_2 dans le meme ordre :
Q = Q(:,J);

% Elimination du dernier vecteur propre de Sigma_2 :
Q = Q(:,1:(n-1));

% Vecteurs propres de Sigma (deduits de ceux de Sigma_2) :
W = X_c' * Q;

% Normalisation des vecteurs propres de Sigma :
W = normc(W);

% Affichage de l'individu moyen et des eigenfaces sous forme d'images :
colormap gray;
img = reshape(individu_moyen,nb_lignes,nb_colonnes);
subplot(nb_individus,nb_postures,1);
imagesc(img);
axis image;
axis off;
title('Individu moyen','FontSize',15);
for k = 1:n-1
	img = reshape(W(:,k),nb_lignes,nb_colonnes);
	subplot(nb_individus,nb_postures,k+1);
	imagesc(img);
	axis image;
	axis off;
	title(['Eigenface ',num2str(k)],'FontSize',15);
end

save exercice_1;
