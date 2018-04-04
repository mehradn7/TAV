clear;
close all;

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Modèle TV-Hilbert','Position',[0,0,L,H]);

% Lecture et affichage de l'image originale u :
u0 = double(imread('Barbara.png'));
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

% Frequences en x et en y (axes = repere matriciel) :
[n_x,n_y] = meshgrid(1:nb_lignes,1:nb_colonnes);
n_x = n_x/nb_lignes-0.5;	% Frequences dans l'intervalle [-0.5,0.5]
n_y = n_y/nb_colonnes-0.5;
% Filtrage passe-bas :
eta = 0.05;
passe_bas = 1./(1+(n_x.^2 + n_y.^2)/eta);


% Paramètres
lambda = 1000; % Poids de la regularisation
eps = 0.5;
gamma = 0.0001;

u = u0;
k = 0;

while k < 1000
    g_x = Dx*u(:);
    g_y = Dy*u(:);
    g_xx = -Dx'*Dx*u(:);
    g_yy = -Dy'*Dy*u(:);
    g_xy = -Dx'*Dy*u(:);

    u_prec = u;
    u = u_prec - gamma.*( ifft2(ifftshift(passe_bas .* (abs(fftshift(fft2(u_prec)) - fftshift(fft2(u0)))))));
    u = u(:);
    u = u + gamma * lambda * ( (g_xx.*(g_y.^2 + eps) + (g_yy.*(g_x.^2 + eps)) - 2.*g_x.*g_y.*g_xy) ...
        ./ (g_x.^2 + g_y.^2 + eps).^(3/2));
    u = reshape(u,nb_lignes,nb_colonnes);
    
    k = k+1;
    if (mod(k, 20) == 0)
        c = u;
        drawnow nocallbacks
        subplot(2,3,2)
        imagesc(real(c))
        colormap gray
        axis image off;
        title(['Cartoon, itération ' num2str(k)],'FontSize',20)

        t = u0 - c;
        drawnow nocallbacks
        subplot(2,3,3);
        imagesc(real(t));
        colormap gray;
        axis image off;
        title(['Texture, itération ' num2str(k)],'FontSize',20)

%         drawnow nocallbacks
%         subplot(2,3,4);
%         imagesc(t>2);
%         colormap gray;
%         axis image off;
%         title(['Texture seuillée, itération ' num2str(k)],'FontSize',20)
    end
end

