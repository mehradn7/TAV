clear;
close all;

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Filtrage frequentiel','Position',[0,0,L,H]);

% Lecture et affichage de l'image originale u :
u0 = double(imread('empreinte.png'));
[nb_lignes,nb_colonnes] = size(u0);
u_max = max(u0(:));
subplot(2,3,1);
imagesc(u0);
axis image off;
colormap gray;
title('Image originale','FontSize',20);

% Operateur gradient :
nb_pixels = nb_lignes*nb_colonnes;
e = ones(nb_pixels,1);
Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
Dx(nb_pixels-nb_lignes+1:nb_pixels,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(nb_lignes:nb_lignes:nb_pixels,:) = 0;

% Second membre b du systeme :
b = u0(:);

% Paramètres
lambda = 5; % Poids de la regularisation
eps = 0.01;

Lap = -Dx'*Dx - Dy'*Dy;
A = speye(nb_pixels) - lambda*Lap;

u = u0;
norme_x = 1;
diff_norme = 1;
k = 0;

% Resolution itérative du systeme A*x = b (opérateur backslash) :
while k < 20
    gradients_x = Dx*u(:);
    gradients_y = Dy*u(:);
    W = 1./sqrt(gradients_x.^2 + gradients_y.^2 + eps);
    W = spdiags(W, 0, nb_pixels, nb_pixels);
    A = speye(nb_pixels) - lambda * ( (-Dx'*W*Dx - Dy'*W*Dy) );
    u_prec = u;
%     [x,flag] = pcg(A,b,1e-5,50,R',R,u(:));
    x = A\b;
    u = reshape(x,nb_lignes,nb_colonnes);
    diff_norme = norm(u_prec(:)-u(:));
    norme_x = norm(u_prec(:));
    
    k = k+1;
    c = u;
    drawnow nocallbacks
    subplot(2,3,2)
	imagesc(max(0,min(1,u/u_max)),[0 1])
	colormap gray
    axis image off;
	title(['Cartoon, itération ' num2str(k)],'FontSize',20)
    
    t = u0 - c;
    drawnow nocallbacks
    subplot(2,3,3);
    imagesc(t);
    colormap gray;
    axis image off;
	title(['Texture, itération ' num2str(k)],'FontSize',20)
    
    drawnow nocallbacks
    subplot(2,3,4);
    imagesc(t>2);
    colormap gray;
    axis image off;
	title(['Texture seuillée, itération ' num2str(k)],'FontSize',20)
end

%% Vérifier qu'on n'a pas le meme résultat en seuillant simplement l'image originale
% Lecture et affichage de l'image originale u seuillée à 2 :
u0_seuil = double(imread('empreinte.png'));
[nb_lignes,nb_colonnes] = size(u0_seuil);
subplot(2,3,5);
imagesc(u0>5);
axis image off;
colormap gray;
title('Image originale','FontSize',20);


