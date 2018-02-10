clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Separation des canaux RVB','Position',[0,0,0.67*L,0.67*H]);

%% Lecture et affichage d'une image RVB :
I = imread('baby.jpg');
figure(1);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image RVB','FontSize',20);

%% Decoupage de l'image en trois canaux et conversion en doubles :
R = double(I(:,:,1));
V = double(I(:,:,2));
B = double(I(:,:,3));

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

%% Image associée à la moyenne arithmétique des canaux RVB
Invg = (R+V+B)/3;
colormap gray;
subplot(2,2,3);
hold on
imagesc(flip(Invg,1));
axis off;
axis equal
title('R+V+B / 3');

%% Image obtenue avec rgb2gray
Y = rgb2gray(I);
colormap gray;
subplot(2,2,4);
hold on
imagesc(flip(Invg,1));
axis off;
axis equal
title('0.2989R + 0.5870V + 0.1140B');

% baby.png elimine la premiere image (C1)
% difficile de voir a l'oeil nu une difference entre les 2 derniers types
% d'image (moyenne arithmetique et rgb2gray)
M = [0.2989 0.5870 0.1140; (-0.1687) (-0.3313) 0.5; 0.5 (-0.4187) (-0.0813)];
M'*M % M n'est pas orthogonale 
