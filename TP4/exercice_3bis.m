clear;
close all;

exercice_3;

% Estimation des parametres par les moindres carres TOTAUX :
x = transpose(xy_donnees_bruitees(1,:));
y = transpose(xy_donnees_bruitees(2,:));
moyenne_x = mean(x);
moyenne_y = mean(y);
var_x = sqrt(sum(abs(x - moyenne_x).^2));
var_y = sqrt(sum(abs(y - moyenne_y).^2));

x = (x-moyenne_x)/var_x;
y = (y-moyenne_y)/var_y;

X_chapeau = MCT(x,y);
X_chapeau = X_chapeau ./ [var_x^2; var_x * var_y; var_y^2; var_x;var_y;1];

[C_chapeau,theta_0_chapeau,a_chapeau,b_chapeau] = conversion(X_chapeau);
C_chapeau = C_chapeau + [moyenne_x;moyenne_y];


% Affichage de l'ellipse estimee par MCT :
affichage_ellipse(C_chapeau,theta_0_chapeau,a_chapeau,b_chapeau,theta_points_ellipse,'k:',3);
lg = legend(' Ellipse',' Donnees bruitees',' Estimation par MV',' Estimation par MCO', 'Estimation par MCT', 'Estimation par MCT après centrage et normalisation des données','Location','Best');
set(lg,'FontSize',20);

% Calcul du score de l'ellipse estimee par MCT :
R_chapeau = [cos(theta_0_chapeau) -sin(theta_0_chapeau) ; sin(theta_0_chapeau) cos(theta_0_chapeau)];
c_chapeau = sqrt(a_chapeau*a_chapeau-b_chapeau*b_chapeau);
F_1_chapeau = R_chapeau*[c_chapeau ; 0]+C_chapeau;
F_2_chapeau = R_chapeau*[-c_chapeau ; 0]+C_chapeau;
fprintf('Score de l''estimation par MCT après centrage et normalisation = %.3f\n',score(F_1,F_2,a,F_1_chapeau,F_2_chapeau,a_chapeau));
