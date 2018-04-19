function [moy] = moyenne(im)
    im = double(im);
    [nb_lignes, nb_colonnes, nb_canaux] = size(im);
    
    im_rvb = (1./(max(1,im(:,:,1) + im(:,:,2) +im(:,:,3)))).* im;
    
    r_barre = mean(mean(im_rvb(:,:,1)))
    b_barre = mean(mean(im_rvb(:,:,2)))
    
    mean(mean(im_rvb(:,:,3)))
    
    moy = [r_barre b_barre];



end