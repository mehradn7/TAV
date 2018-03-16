clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Separation des canaux RVB','Position',[0,0,0.67*L,0.67*H]);
figure('Name','Nuage de pixels dans le repere RVB','Position',[0.67*L,0,0.33*L,0.45*H]);

% Lecture et affichage d'une image RVB :
I = imread('gantrycrane.png');
figure(1);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image RVB','FontSize',20);

% Decoupage de l'image en trois canaux et conversion en doubles :
R = double(I(:,:,1));
V = double(I(:,:,2));
B = double(I(:,:,3));

% Affichage du canal R :
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(R);
axis off;
axis equal;
title('Canal R','FontSize',20);

% Affichage du canal V :
subplot(2,2,3);
imagesc(V);
axis off;
axis equal;
title('Canal V','FontSize',20);

% Affichage du canal B :
subplot(2,2,4);
imagesc(B);
axis off;
axis equal;
title('Canal B','FontSize',20);

% Matrice des donnees :
X = [R(:) V(:) B(:)];			% Les trois canaux sont vectorises et concatenes

% Matrice de variance/covariance :
% calcul du centre de gravité des données :
g = mean(X);
% centrage des données
Xc = X - ones(size(X,1),1)*g;
sigma = (1/(size(X,1))) * (Xc)'*Xc;

[W,D] = eig(sigma);
[D,J] = sort(diag(D), 'descend');
W = W(:,J); %tri des colonnes selon vp décroissantes
C = Xc * W; %changement de base

I2 = reshape(C, size(I));

% dans la nouvelle base :
sigma2 = (1/(size(C,1))) * (C)'*C;
% Coefficients de correlation lineaire :
corrC1C2 = sigma2(1,2)/sqrt(sigma2(1,1)*sigma2(2,2));
corrC1C3 = sigma2(1,3)/sqrt(sigma2(1,1)*sigma2(3,3));
corrC2C3 = sigma2(2,3)/sqrt(sigma2(2,2)*sigma2(3,3));

% Proportions de contraste :
somme = sigma2(1,1) + sigma2(2,2) + sigma2(3,3);
cC1 = sigma2(1,1)/somme;
cC2 = sigma2(2,2)/somme;
cC3 = sigma2(3,3)/somme;

figure(2);				% Deuxieme fenetre d'affichage
subplot(2,2,1);
imagesc(I2);
axis off;
axis equal;
title('Image après ACP','FontSize',20);

% Decoupage de l'image en trois canaux et conversion en doubles :
C1 = double(I2(:,:,1));
C2 = double(I2(:,:,2));
C3 = double(I2(:,:,3));

% Affichage de la composante C1:
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(C1);
axis off;
axis equal;
title('C1','FontSize',20);

% Affichage de la composante C2 :
subplot(2,2,3);
imagesc(C2);
axis off;
axis equal;
title('C2','FontSize',20);

% Affichage de la composante C3 :
subplot(2,2,4);
imagesc(C3);
axis off;
axis equal;
title('C3','FontSize',20);


