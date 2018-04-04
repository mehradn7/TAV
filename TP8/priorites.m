function [P, C_nouv] = priorites(u, D, C, delta_D, t)
D = double(D);

lab_u = rgb2lab(u);
u_L = lab_u(:,:,1);
[nb_lignes, nb_colonnes, ~] = size(u);
indices_delta_D = find(delta_D > 0);
%% Confiance
C_nouv = C;

for i_p = 1:size(C_nouv,1)
    for j_p = 1:size(C_nouv,2)
        if delta_D(i_p,j_p)
            i_min_p = max(1,i_p-t);
            i_max_p = min(nb_lignes,i_p+t);
            j_min_p = max(1,j_p-t);
            j_max_p = min(nb_colonnes,j_p+t);
            
            V_p = C_nouv(i_min_p:i_max_p, j_min_p:j_max_p,:);
            indices_p_conf_nulle = find(V_p == 0);
            C_nouv(indices_p_conf_nulle) = mean(mean(C_nouv));
        end
    end
end

A = zeros(size(C_nouv));
gradient_u = gradient(u_L);
A = t .* gradient_u;




%% Attache aux données


end

