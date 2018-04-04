function u = collage(r,s,interieur)

% Dimensions de r :
[nb_lignes_r,nb_colonnes_r,nb_canaux] = size(r);

r = double(r);
s = double(s);

matrice_bords = ones(size(r, 1), size(r, 2));
matrice_bords(2:end-1, 2:end-1) = 0;

% Operateur gradient :
nb_pixels = nb_lignes_r*nb_colonnes_r;
e = ones(nb_pixels,1);
Dx = spdiags([-e e],[0 nb_lignes_r],nb_pixels,nb_pixels);
Dx(nb_pixels-nb_lignes_r+1:nb_pixels,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(nb_lignes_r:nb_lignes_r:nb_pixels,:) = 0;

% Laplacien
A = -Dx'*Dx - Dy'*Dy;
bord_r = find(matrice_bords == 1);
nb_bord_r = length(bord_r);
A(bord_r,:) = sparse(1:nb_bord_r,bord_r,ones(nb_bord_r,1),nb_bord_r,nb_pixels);



% Calcul de l'imagette resultat im, canal par canal :
u = r;
for k = 1:nb_canaux
	u_k = u(:,:,k);
	s_k = s(:,:,k);
    r_k = r(:,:,k);
    
    g_k_1 = Dx*r_k(:);
    g_k_2 = Dy*r_k(:);
    
    g_s_x = Dx*s_k(:);
    g_s_y = Dy*s_k(:);
    
    g_k_1(interieur) = g_s_x(interieur);
    g_k_2(interieur) = g_s_y(interieur);    
    
    b_k = -Dx'*g_k_1  - Dy'*g_k_2 ;
    b_k(bord_r) = u_k(bord_r);
	u_k  = A\b_k;
	u(:,:,k) = reshape(u_k, nb_lignes_r, nb_colonnes_r);
end
