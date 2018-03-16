function nb_recouvrements_D = nb_disques_recouvrent_D(abscisses_disques, ordonnees_disques, x_D, y_D, R)
nb_disques = length(abscisses_disques);
nb_recouvrements_D = 0;
for i=1:nb_disques
    if ((abscisses_disques(i) - x_D)^2 + (ordonnees_disques(i) - y_D)^2 < 2*R^2)
        nb_recouvrements_D = nb_recouvrements_D + 1;
    end
end