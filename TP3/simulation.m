function [x_gauche,x_droite] = simulation(y,beta_0,gamma_0,delta_moyen,sigma_delta,d)
    beta = delta_moyen + sigma_delta.*randn(1,2*d-1);
    beta = [beta(1:d-1), beta(2*d-1)];
    x_gauche = bezier(y,beta_0,beta);

    gamma = delta_moyen + sigma_delta.*randn(1,2*d-1);
    gamma = gamma(d:2*d-1);
    x_droite = bezier(y,gamma_0,gamma);

end

