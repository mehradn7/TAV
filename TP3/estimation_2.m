function [delta_moyen,sigma_delta] = estimation_2( delta )
    delta_moyen = mean(delta);
    
    sigma_delta = sqrt(sum((delta - mean(delta)).^2))/size(delta,2);
end

