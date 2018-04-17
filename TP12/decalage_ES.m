function score = decalage_ES(ES_extrait,delta_t,ES_nuages,f_min)

ES_extrait(:,1) = ES_extrait(:,1) + delta_t;
[~, distances] = dsearchn(ES_nuages, ES_extrait);

score = sum(distances);




end
