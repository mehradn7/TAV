function [P,C_nouv] = priorites(u,D,C,delta_D_int,delta_D_ext,t)
    
[nb_lignes,nb_colonnes,~] = size(u);
P = zeros(size(D));

indices_delta_D_int = find(delta_D_int > 0);
nb_points_delta_D_int = length(indices_delta_D_int);

indices_delta_D_ext = find(delta_D_ext > 0);
nb_points_delta_D_ext = length(indices_delta_D_ext);

%% Transformation de l'image RGB en image LAB
u_lab = rgb2lab(u);
l = u_lab(:,:,1);

[l_y,l_x] = gradient(l);
[D_y, D_x] = gradient(double(D));

for i=1:nb_points_delta_D_int
    indp = indices_delta_D_int(i);

	[i_p,j_p] = ind2sub(size(D),indp);

    % Bornes du voisinage de p :
    i_min_p = max(1,i_p-t);
    i_max_p = min(nb_lignes,i_p+t);
    j_min_p = max(1,j_p-t);
    j_max_p = min(nb_colonnes,j_p+t);
    
    % Moyennes des C(p)
    C_vp = C(i_min_p:i_max_p,j_min_p:j_max_p);
    C_vp = C_vp(:);
    C_p = sum(C_vp)/numel(C_vp);
    
    C_nouv = C;
    C_nouv(i_p,j_p) = C_p;
    
    dist = inf;
    pixel_courant = [i_p;j_p];
    for j=1:nb_points_delta_D_ext
        indpext = indices_delta_D_ext(j);
        [i_ext,j_ext] = ind2sub(size(D),indpext);
        pixel_proche = [i_ext;j_ext];
        d = norm(pixel_courant-pixel_proche);
        if d<dist
            dist = d;
            pixel_fin = pixel_proche;
        end
    end
    
    i_ext = pixel_fin(1);
    j_ext = pixel_fin(2);
    
    tangente = [-D_y(i_p,j_p);D_x(i_p,j_p)];
    tangente = max([0;0],tangente/norm(tangente));
    tangente = tangente/norm(tangente);
    
    gradient_l = [l_x(i_ext,j_ext);l_y(i_ext,j_ext)];
    
    A_p = abs(dot(tangente,gradient_l));
    
    P(i_p,j_p) = C_nouv(i_p,j_p) * A_p;
end
end

