clear;
close all;

exercice_2;

% Estimation des parametres par les moindres carres TOTAUX :
x = transpose(xy_donnees_bruitees(1,:));
y = transpose(xy_donnees_bruitees(2,:));
X_chapeau = MCT(x,y);
[C_chapeau,theta_0_chapeau,a_chapeau,b_chapeau] = conversion(X_chapeau);

% Affichage de l'ellipse estimee par MCT :
affichage_ellipse(C_chapeau,theta_0_chapeau,a_chapeau,b_chapeau,theta_points_ellipse,'y-',3);
lg = legend(' Ellipse',' Donnees bruitees',' Estimation par MV',' Estimation par MCO', 'Estimation par MCT','Location','Best');
set(lg,'FontSize',20);

% Calcul du score de l'ellipse estimee par MCT :
R_chapeau = [cos(theta_0_chapeau) -sin(theta_0_chapeau) ; sin(theta_0_chapeau) cos(theta_0_chapeau)];
c_chapeau = sqrt(a_chapeau*a_chapeau-b_chapeau*b_chapeau);
F_1_chapeau = R_chapeau*[c_chapeau ; 0]+C_chapeau;
F_2_chapeau = R_chapeau*[-c_chapeau ; 0]+C_chapeau;
fprintf('Score de l''estimation par MCT = %.3f\n',score(F_1,F_2,a,F_1_chapeau,F_2_chapeau,a_chapeau));
