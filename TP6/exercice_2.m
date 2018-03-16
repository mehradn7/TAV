clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Parametres divers :
N = 100;					% Nombre de disques d'une configuration
R = 10;					% Rayon des disques
R_carre = R*R;
nb_points_disque = 30;
increment_angulaire = 2*pi/nb_points_disque;
theta = 0:increment_angulaire:2*pi;
rose = [253 108 158]/255;
q_max = 120;
nb_valeurs_a_afficher = 10000;
pas_entre_deux_affichages = floor(q_max/nb_valeurs_a_afficher);
temps_affichage = 0.001;

% Lecture et affichage de l'image :
I = imread('colonie.png');
I = rgb2gray(I);
I = double(I);
I = I(100:500,100:500);
[nb_lignes,nb_colonnes] = size(I);
figure('Name',['Detection de ' num2str(N) ' flamants roses'],'Position',[0,0,L,0.65*H]);

% % Tirage aleatoire d'une configuration initiale et calcul des niveaux de gris moyens :
% abscisses_disques = zeros(N,1);
% ordonnees_disques = zeros(N,1);
% nvg_moyens_disques = zeros(N,1);
% for k = 1:N
% 	abscisse_nouveau = nb_colonnes*rand;
% 	ordonnee_nouveau = nb_lignes*rand;
%     while(any((abscisses_disques - abscisse_nouveau).^2 + (ordonnees_disques - ordonnee_nouveau).^2  < 2*R^2))
%         abscisse_nouveau = nb_colonnes*rand;
%         ordonnee_nouveau = nb_lignes*rand;
%     end
% 	nvg_moyens_disques(k) = nvg_moyen(abscisse_nouveau,ordonnee_nouveau,R,I);
% 	abscisses_disques(k) = abscisse_nouveau;
% 	ordonnees_disques(k) = ordonnee_nouveau;
% end
% valeurs_q = 0;
% nvg_moyen_config = mean(nvg_moyens_disques);
% valeurs_nvg_moyen_config = nvg_moyen_config;

% Affichage de la configuration initiale :
subplot(1,2,1);
imagesc(I);
axis image;
axis off;
colormap gray;
hold on;
% for k = 1:N
% 	abscisses_affichage = abscisses_disques(k)+R*cos(theta);
% 	ordonnees_affichage = ordonnees_disques(k)+R*sin(theta);
% 	indices = find(abscisses_affichage>0 & abscisses_affichage<nb_colonnes & ...
% 			ordonnees_affichage>0 & ordonnees_affichage<nb_lignes);
% 	plot(abscisses_affichage(indices),ordonnees_affichage(indices),'Color',rose,'LineWidth',3);
% end
% pause(temps_affichage);

% Courbe d'evolution du niveau de gris moyen :
% subplot(1,2,2);
% plot(valeurs_q,valeurs_nvg_moyen_config,'.','Color',rose);
% axis([0 q_max/1000 100 240]);
% set(gca,'FontSize',20);
% hx = xlabel('Nombre d''iterations','FontSize',30);
% hy = ylabel('Niveau de gris moyen','FontSize',30);

% Paramètres
beta = 1.0;
S = 130;
gamma = 5.0;
T0 = 0.1;
lambda0 = 100.0;
alpha = 0.99;

T = T0;
lambda = lambda0;


abscisses_disques = zeros();
ordonnees_disques = zeros();
nvg_moyens_disques = zeros();


% Recherche de la configuration optimale :
for q = 1:q_max
% 	k = rem(q,N)+1;					% On parcourt les N disques en boucle
% 	nvg_moyen_courant = nvg_moyens_disques(k);
    
    
    
    %% Tirage aleatoire du nombre de nouveaux disques
    N_tilde = poissrnd(lambda);

	%% Tirage aleatoire de N_tilde nouveaux disques et calcul des niveaux de gris moyens :
    for k = 1:N_tilde
        abscisse_nouveau = nb_colonnes*rand;
        ordonnee_nouveau = nb_lignes*rand;
        nvg_moyens_disques = [nvg_moyens_disques, nvg_moyen(abscisse_nouveau,ordonnee_nouveau,R,I)];
        abscisses_disques = [abscisses_disques; abscisse_nouveau];
        ordonnees_disques = [ordonnees_disques; ordonnee_nouveau];
    end

    %% Tri des disques par ordre d'énergie décroissante
    energies = zeros(1,length(abscisses_disques));
    for k = 1:length(abscisses_disques)
        energies(k) = (1 - 2/(1 + exp(-gamma*((nvg_moyens_disques(k)/S) - 1)))) + nb_disques_recouvrent(abscisses_disques, ordonnees_disques, R);
    end
    [energies_triees, I] = sort(energies, 'desc');
    
    %% Morts
    nouvelles_abscisses = zeros();
    nouvelles_ordonnees = zeros();
    for k = 1:length(energies_triees)
        p = lambda/(lambda + exp((-energies_triees(k) - beta*nb_disques_recouvrent_D(abscisses_disques, ordonnees_disques, abscisses_disques(I(k)), ordonnees_disques(I(k)), R))/T));
        if p > rand
            % Conserver le disque
            nouvelles_abscisses = [nouvelles_abscisses; abscisses_disques(I(k))];
            nouvelles_ordonnees = [nouvelles_ordonnees; ordonnees_disques(I(k))];
        else
            % Supprimer le disque, i.e. ne rien faire
        end
    end
    
    abscisses_disques = zeros();
    abscisses_disques = nouvelles_abscisses;
    ordonnees_disques = zeros();
    ordonnees_disques = nouvelles_ordonnees;
    
    %% Mettre à jour les paramètres
    lambda = alpha*lambda;
    T = alpha*T;
    
	% Affichage des disques
		hold off;
		subplot(1,2,1);
		imagesc(I);
		axis image;
		axis off;
		colormap gray;
		hold on;
		for k = 1:length(abscisses_disques)
			abscisses_affichage = abscisses_disques(k)+R*cos(theta);
			ordonnees_affichage = ordonnees_disques(k)+R*sin(theta);
			indices = find(abscisses_affichage>0 & abscisses_affichage<nb_colonnes & ...
					ordonnees_affichage>0 & ordonnees_affichage<nb_lignes);
			plot(abscisses_affichage(indices),ordonnees_affichage(indices),'Color',rose,'LineWidth',3);
		end
		pause(temps_affichage);

	% Courbe d'evolution du niveau de gris moyen :
	if rem(q,pas_entre_deux_affichages)==0
		valeurs_q = [valeurs_q q];
		nvg_moyen_config = mean(nvg_moyens_disques);
		valeurs_nvg_moyen_config = [valeurs_nvg_moyen_config nvg_moyen_config];
		subplot(1,2,2);
		plot(valeurs_q,valeurs_nvg_moyen_config,'.-','Color',rose,'LineWidth',3);
		axis([0 max(q_max/1000,1.05*q) 100 240]);
		set(gca,'FontSize',20);
		hx = xlabel('Nombre d''iterations','FontSize',30);
		hy = ylabel('Niveau de gris moyen','FontSize',30);
	end
end
