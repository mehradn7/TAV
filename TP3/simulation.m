function [x_gauche,x_droite] = simulation(y,beta_0,gamma_0,delta_moyen,sigma_delta,d)
    delta = delta_moyen + sigma_delta.*randn(1,2*d-1);
    beta = [delta(1:d-1), delta(2*d-1)];
    x_gauche = bezier(y,beta_0,beta);

    gamma = delta(d:2*d-1);
    x_droite = bezier(y,gamma_0,gamma);

end

