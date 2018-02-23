function [F_1_chapeau,F_2_chapeau,a_chapeau] = MV(xy_donnees_bruitees,x_F_aleatoire,y_F_aleatoire,a_aleatoire)

min_somme = Inf;
indice_min = 1;
for k=1:size(x_F_aleatoire,2)
    E = sqrt((xy_donnees_bruitees(1,:)-x_F_aleatoire(1,k)).^2 + (xy_donnees_bruitees(2,:)-y_F_aleatoire(1,k)).^2) ...
    + sqrt((xy_donnees_bruitees(1,:)-x_F_aleatoire(2,k)).^2 + (xy_donnees_bruitees(2,:)-y_F_aleatoire(2,k)).^2) ...
    - 2 *a_aleatoire(k);

    E = E.^2;
    somme = sum(E);
    if somme < min_somme
        min_somme = somme;
        indice_min = k;
    end
end

F_1_chapeau = [x_F_aleatoire(1,indice_min);y_F_aleatoire(1,indice_min)];
    
F_2_chapeau = [x_F_aleatoire(2,indice_min);y_F_aleatoire(2,indice_min)];
a_chapeau = [a_aleatoire(indice_min)];



