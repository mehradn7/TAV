clear;
close all;

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Filtrage frequentiel','Position',[0,0,L,H]);

% Lecture et affichage de l'image originale u :
u0 = double(imread('Barbara.png'));
[nb_lignes,nb_colonnes] = size(u0);
u_max = max(u0(:));
subplot(1,3,1);
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
lambda = 50; % Poids de la regularisation
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
    subplot(1,3,2)
	imagesc(max(0,min(1,u/u_max)),[0 1])
	colormap gray
    axis image off;
	title('Cartoon ','FontSize',20)
    
    t = u0 - c;
    drawnow nocallbacks
    subplot(1,3,3);
    imagesc(t);
    colormap gray;
    axis image off;
    title('Texture','FontSize',20);
end


% Spectre de u :
% s = fft2(u);
% s = fftshift(s);		% Permet de positionner l'origine (n_x,n_y) = (0,0) au centre

% Affichage du logarithme du module du spectre de u :
% subplot(2,3,1);
% imagesc(log(abs(s)));
% axis image off;
% colormap gray;
% title('Spectre','FontSize',20);

% Frequences en x et en y (axes = repere matriciel) :
% [n_x,n_y] = meshgrid(1:nb_lignes,1:nb_colonnes);
% n_x = n_x/nb_lignes-0.5;	% Frequences dans l'intervalle [-0.5,0.5]
% n_y = n_y/nb_colonnes-0.5;

% Filtrage passe-bas :
% n_c = 0.08;			% Frequence de coupure (faire varier ce parametre)
% % passe_bas = n_x.^2+n_y.^2<n_c^2;
% eta = 0.05;
% passe_bas = 1./(1+(n_x.^2 + n_y.^2)/eta);
% s_c = passe_bas.*s;

% Affichage du logarithme du module du spectre de c :
% subplot(2,3,2);
% imagesc(log(abs(s_c)));
% axis image off;
% colormap gray;
% title('Basses frequences','FontSize',20);

% Affichage de c :
% c = real(ifft2(ifftshift(s_c)));
% subplot(1,3,3);
% imagesc(c);
% axis image off;
% colormap gray;
% title('Cartoon','FontSize',20);

% Filtrage passe-haut :
% s_t = (1-passe_bas).*s;

% Affichage du logarithme du module du spectre de t :
% subplot(2,3,3);
% imagesc(log(abs(s_t)));
% axis image off;
% colormap gray;
% title('Hautes frequences','FontSize',20);

% Affichage de t :
% t = real(ifft2(ifftshift(s_t)));

