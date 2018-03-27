%--------------------------------------------------------------------------
% ENSEEIHT - 2IMA - Traitement des donnees Audio-Visuelles
% TP7 - Restauration d'images
% exercice_1_bis.m : Debruitage avec modele de Tikhonov (couleurs)
%--------------------------------------------------------------------------

clear
close all
clc

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Debruitage avec le modele de Tikhonov','Position',[0.06*L,0.1*H,0.9*L,0.7*H])

% Lecture de l'image :
u0 = double(imread('lena.bmp'));
[nb_lignes,nb_colonnes,nb_canaux] = size(u0);
u_max = max(u0(:));

% Ajout d'un bruit gaussien :
sigma_bruit = 0.05;
u0 = u0 + sigma_bruit*u_max*randn(nb_lignes,nb_colonnes);

% Affichage de l'image bruitee :
subplot(1,2,1)
	imagesc(max(0,min(1,u0/u_max)),[0 1])
	colormap gray
	axis image off
	title('Image bruitee','FontSize',20)

% Operateur gradient :
nb_pixels = nb_lignes*nb_colonnes;
e = ones(nb_pixels,1);
Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
Dx(nb_pixels-nb_lignes+1:nb_pixels,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(nb_lignes:nb_lignes:nb_pixels,:) = 0;

% Second membre b du systeme :
b_R = u0(:,:,1);
b_R = b_R(:);
b_V = u0(:,:,2);
b_V = b_V(:);
b_B = u0(:,:,3);
b_B = b_B(:);

lambda = 15; % Poids de la regularisation
eps = 0.01;

Lap = -Dx'*Dx - Dy'*Dy;
A = speye(nb_pixels) - lambda*Lap;
R = ichol(A,struct('droptol',1e-3));

u = u0;
norme_x = 1;
diff_norme = 1;
k = 0;

% Resolution itérative du systeme A*x = b (gradient conjugue preconditionne) :
while diff_norme > norme_x/1000
    u_R = u(:,:,1);
    u_V = u(:,:,2);
    u_B = u(:,:,3);
    gradients_x_R = Dx*u_R(:);
    gradients_y_R = Dy*u_R(:);
    gradients_x_V = Dx*u_V(:);
    gradients_y_V = Dy*u_V(:);
    gradients_x_B = Dx*u_B(:);
    gradients_y_B = Dy*u_B(:);
    
    % Canal rouge
    W_R = 1./sqrt(gradients_x_R.^2 + gradients_y_R.^2 + eps);
    W_R = spdiags(W_R, 0, nb_pixels, nb_pixels);
    A_R = speye(nb_pixels) - lambda * ( (-Dx'*W_R*Dx - Dy'*W_R*Dy) );
    u_prec_R = u_R;
    [x_R,flag] = pcg(A_R,b_R,1e-5,50,R',R,u_R(:));
    u_R = reshape(x_R,nb_lignes,nb_colonnes);
    diff_norme = norm(u_prec_R(:)-u_R(:));
    norme_x = norm(u_prec_R(:));
    
    % Canal vert
    W_V = 1./sqrt(gradients_x_V.^2 + gradients_y_V.^2 + eps);
    W_V = spdiags(W_V, 0, nb_pixels, nb_pixels);
    A_V = speye(nb_pixels) - lambda * ( (-Dx'*W_V*Dx - Dy'*W_V*Dy) );
    u_prec_V = u_V;
    [x_V,flag] = pcg(A_V,b_V,1e-5,50,R',R,u_V(:));
    u_V = reshape(x_V,nb_lignes,nb_colonnes);
    
    % Canal bleu
    W_B = 1./sqrt(gradients_x_B.^2 + gradients_y_B.^2 + eps);
    W_B = spdiags(W_B, 0, nb_pixels, nb_pixels);
    A_B = speye(nb_pixels) - lambda * ( (-Dx'*W_B*Dx - Dy'*W_B*Dy) );
    u_prec_B = u_B;
    [x_B,flag] = pcg(A_B,b_B,1e-5,50,R',R,u_B(:));
    u_B = reshape(x_B,nb_lignes,nb_colonnes);
    
    k = k+1;
    u(:,:,1) = u_R;
    u(:,:,2) = u_V;
    u(:,:,3) = u_B;
    drawnow nocallbacks
    subplot(1,2,2)
	imagesc(max(0,min(1,u/u_max)),[0 1])
	colormap gray
	axis image off
	title('Image restauree','FontSize',20)
end


% Affichage de l'image restauree :
subplot(1,2,2)
	imagesc(max(0,min(1,u/u_max)),[0 1])
	colormap gray
	axis image off
	title('Image restauree','FontSize',20)
