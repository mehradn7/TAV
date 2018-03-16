function [U_i_j] = a_priori(i, j, k, k_i_j, beta)
% Calcule la probabilite a priori de la k-eme configuration

nb_lignes  = size(k, 1);
nb_colonnes = size(k, 2);

if (i==1 && j==1)
    % Coin haut-gauche
    U_i_j = beta * (3 + (k_i_j ~= k(1, 2)) + (k_i_j ~= k(2, 1)) + (k_i_j ~= k(2, 2)));
    
elseif (i==1 && j==nb_colonnes)
    % Coin haut-droite
    U_i_j = beta * (3 + (k_i_j ~= k(1, nb_colonnes-1)) + (k_i_j ~= k(2, nb_colonnes)) + (k_i_j ~= k(2, nb_colonnes-1)));
    
elseif (i==nb_lignes && j==1)
    % Coin bas-gauche
    U_i_j = beta * (3 + (k_i_j ~= k(nb_lignes-1, 1)) + (k_i_j ~= k(nb_lignes, 2)) + (k_i_j ~= k(nb_lignes-1, 2)));
    
elseif (i==nb_lignes && j==nb_colonnes)
    % Coin bas-droite
    U_i_j = beta * (3 + (k_i_j ~= k(nb_lignes, nb_colonnes-1)) + (k_i_j ~= k(nb_lignes-1, nb_colonnes)) + (k_i_j ~= k(nb_lignes-1, nb_colonnes-1)));
    
elseif (i==1)
    % Bordure haute (pas un coin)
    U_i_j = beta * (5 + (k_i_j ~= k(1, j-1)) + (k_i_j ~= k(1, j+1)) + (k_i_j ~= k(2, j-1)) + (k_i_j ~= k(2, j)) + (k_i_j ~= k(2, j+1)));
    
elseif (i==nb_lignes)
    % Bordure basse (pas un coin)
    U_i_j = beta * (5 + (k_i_j ~= k(nb_lignes, j-1)) + (k_i_j ~= k(nb_lignes, j+1)) + (k_i_j ~= k(nb_lignes-1, j-1)) + (k_i_j ~= k(nb_lignes-1, j)) + (k_i_j ~= k(nb_lignes-1, j+1)));
    
elseif (j==1)
    % Bordure gauche (pas un coin)
    U_i_j = beta * (5 + (k_i_j ~= k(i-1, 1)) + (k_i_j ~= k(i+1, 1)) + (k_i_j ~= k(i-1, 2)) + (k_i_j ~= k(i, 2)) + (k_i_j ~= k(i+1, 2)));
    
elseif (j==nb_colonnes)
    % Bordure droite (pas un coin)
    U_i_j = beta * (5 + (k_i_j ~= k(i-1, nb_colonnes)) + (k_i_j ~= k(i+1, nb_colonnes)) + (k_i_j ~= k(i-1, nb_colonnes-1)) + (k_i_j ~= k(i, nb_colonnes-1)) + (k_i_j ~= k(i+1, nb_colonnes-1)));
    
else
    % A l'interieur de l'image
    U_i_j = beta * (8 + (k_i_j ~= k(i-1, j-1)) + (k_i_j ~= k(i-1, j)) + (k_i_j ~= k(i-1, j+1)) + (k_i_j ~= k(i, j-1)) + (k_i_j ~= k(i, j+1)) + (k_i_j ~= k(i+1, j-1)) + (k_i_j ~= k(i+1, j)) + (k_i_j ~= k(i+1, j+1)));
end

end