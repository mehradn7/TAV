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

% Affichage du nuage de pixels dans le repere RVB :
figure(2);				% Deuxieme fenetre d'affichage
plot3(R,V,B,'b.');
axis equal;
xlabel('R');
ylabel('V');
zlabel('B');
rotate3d;

% Matrice des donnees :
X = [R(:) V(:) B(:)];			% Les trois canaux sont vectorises et concatenes

% Matrice de variance/covariance :
% calcul du centre de gravité des données :
g = mean(X);
%centrage des données
Xc = X - ones(size(X,1),1)*g;
sigma = (1/(size(X,1))) * (Xc)'*Xc;
% Coefficients de correlation lineaire :
corrRV = sigma(1,2)/sqrt(sigma(1,1)*sigma(2,2));
corrRB = sigma(1,3)/sqrt(sigma(1,1)*sigma(3,3));
corrVB = sigma(2,3)/sqrt(sigma(2,2)*sigma(3,3));

% Proportions de contraste :
somme = sigma(1,1) + sigma(2,2) + sigma(3,3);
cR = sigma(1,1)/somme;
cV = sigma(2,2)/somme;
cB = sigma(3,3)/somme;

% mauvaise idée car les canaux R et V ont une faible proportion de
% contraste : on ne distingue pas bien les objets de couleur différente







