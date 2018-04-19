% On peut penser a un critere comme l'entropie ou alors la "brillance" (on
% voit que les pensees sont plus brillantes par endroit

clear;
close all;

load exercice_3;

% Calcul du maximum de vraisemblance :
V_max = max(V_pensees,V_oeillets);
V_max = max(V_max,V_chrysanthemes);
classe_pensees = find(V_pensees==V_max);
classe_oeillets = find(V_oeillets==V_max);
classe_chrysanthemes = find(V_chrysanthemes==V_max);
code_classe = zeros(nb_r,nb_v);
code_classe(classe_pensees) = 3;
code_classe(classe_oeillets) = 2;
code_classe(classe_chrysanthemes) = 1;

% Affichage des classes :
figure('Name','Classification par maximum de vraisemblance','Position',[0.5*L,0,0.5*L,0.67*H]);
axis equal;
axis ij;
axis([r(1) r(end) v(1) v(end)]);
hold on;
surface(r,v,code_classe);
carte_couleurs = [.45 .45 .65 ; .45 .65 .45 ; .65 .45 .45];
colormap(carte_couleurs);
set(gca,'FontSize',20);
xlabel('$\bar{r}$','Interpreter','Latex','FontSize',30);
ylabel('$\bar{v}$','Interpreter','Latex','FontSize',30);
view(-90,90);

% Initialisation des compteurs :
cpt_images = 0;
cpt_images_correctement_classees = 0;

% Comptage des images de pensees correctement classees :
for i = 1:nb_images_pensees
    cpt_images = cpt_images + 1;
    x = X_pensees(i,:);
    
    vraisemblance_pensees = (1/ sqrt(det(Sigma_pensees))) * exp(-0.5*(x - mu_pensees)*inv_Sigma_pensees*(x - mu_pensees)');
    vraisemblance_oeillets = (1/ sqrt(det(Sigma_oeillets))) * exp(-0.5*(x - mu_oeillets)*inv_Sigma_oeillets*(x - mu_oeillets)');
    vraisemblance_chrysanthemes = (1/ sqrt(det(Sigma_chrysanthemes))) * exp(-0.5*(x - mu_chrysanthemes)*inv_Sigma_chrysanthemes*(x - mu_chrysanthemes)');

    
    if (vraisemblance_pensees == max(vraisemblance_pensees, max(vraisemblance_oeillets, vraisemblance_chrysanthemes)))
        cpt_images_correctement_classees = cpt_images_correctement_classees + 1;
        plot3(X_pensees(i,1), X_pensees(i,2), 4, '* r', 'MarkerSize', 10, 'LineWidth', 2);
    else
        plot3(X_pensees(i,1), X_pensees(i,2), 4, '* k', 'MarkerSize', 10, 'LineWidth', 2);
    end

        
end

% Comptage des images d'oeillets correctement classees :
for i = 1:nb_images_oeillets
	 cpt_images = cpt_images + 1;
    x = X_oeillets(i,:);
    
    vraisemblance_pensees = (1/ sqrt(det(Sigma_pensees))) * exp(-0.5*(x - mu_pensees)*inv_Sigma_pensees*(x - mu_pensees)');
    vraisemblance_oeillets = (1/ sqrt(det(Sigma_oeillets))) * exp(-0.5*(x - mu_oeillets)*inv_Sigma_oeillets*(x - mu_oeillets)');
    vraisemblance_chrysanthemes = (1/ sqrt(det(Sigma_chrysanthemes))) * exp(-0.5*(x - mu_chrysanthemes)*inv_Sigma_chrysanthemes*(x - mu_chrysanthemes)');

    
    if (vraisemblance_oeillets == max(vraisemblance_pensees, max(vraisemblance_oeillets, vraisemblance_chrysanthemes)))
        cpt_images_correctement_classees = cpt_images_correctement_classees + 1;
        plot3(X_oeillets(i,1), X_oeillets(i,2), 4, '* g', 'MarkerSize', 10, 'LineWidth', 2);
    else
        plot3(X_oeillets(i,1), X_oeillets(i,2), 4, '* k', 'MarkerSize', 10, 'LineWidth', 2);
    end

end

% Comptage des images de chrysanthemes correctement classees :
for i = 1:nb_images_chrysanthemes
	 cpt_images = cpt_images + 1;
    x = X_chrysanthemes(i,:);
    
    vraisemblance_pensees = (1/ sqrt(det(Sigma_pensees))) * exp(-0.5*(x - mu_pensees)*inv_Sigma_pensees*(x - mu_pensees)');
    vraisemblance_oeillets = (1/ sqrt(det(Sigma_oeillets))) * exp(-0.5*(x - mu_oeillets)*inv_Sigma_oeillets*(x - mu_oeillets)');
    vraisemblance_chrysanthemes = (1/ sqrt(det(Sigma_chrysanthemes))) * exp(-0.5*(x - mu_chrysanthemes)*inv_Sigma_chrysanthemes*(x - mu_chrysanthemes)');

    
    if (vraisemblance_chrysanthemes == max(vraisemblance_pensees, max(vraisemblance_oeillets, vraisemblance_chrysanthemes)))
        cpt_images_correctement_classees = cpt_images_correctement_classees + 1;
        plot3(X_chrysanthemes(i,1), X_chrysanthemes(i,2), 4, '* b', 'MarkerSize', 10, 'LineWidth', 2);
    else
        plot3(X_chrysanthemes(i,1), X_chrysanthemes(i,2), 4, '* k', 'MarkerSize', 10, 'LineWidth', 2);
    end

end

% Affichage du pourcentage d'images correctement classees :
pourcentage_bonnes_classifs = cpt_images_correctement_classees/cpt_images;