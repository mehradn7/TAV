function nb_recouvrements = nb_disques_recouvrent(abscisses_disques, ordonnees_disques, R)
nb_disques = length(abscisses_disques);
nb_recouvrements = 0;
for i=1:nb_disques
    for j=1:i-1
        if ((abscisses_disques(i) - abscisses_disques(j))^2 + (ordonnees_disques(i) - ordonnees_disques(j))^2 < 2*R^2)
            nb_recouvrements = nb_recouvrements + 1;
        end
    end
end