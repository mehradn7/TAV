%--------------------------------------------------------------------------
% ENSEEIHT - 2IMA - Traitement des donnees Audio-Visuelles
% TP8 - Realite diminuee
% fonction frontieres.m :
%--------------------------------------------------------------------------

function [delta_D_int,delta_D_ext] = frontieres(D)
	
	masque_convolution = [ 0 1 0 ; 1 0 1 ; 0 1 0 ];
	D_conv_masque = conv2(D,masque_convolution,'same');

	% Seuls les points de D peuvent etre dans delta_D_int :
	delta_D_int = D.*D_conv_masque;

	% Un voisin au moins d'un point de delta_D_int doit etre exterieur a D :
	delta_D_int(delta_D_int==4) = 0;
	delta_D_int = double(delta_D_int>0);

	% Seuls les points hors de D peuvent etre dans delta_D et dans delta_D_ext :
	delta_D = (~D).*D_conv_masque;

	% Un voisin au moins d'un point de delta_D doit etre dans D :
	delta_D(delta_D==0) = 0;
	delta_D = double(delta_D>0);

	% D_barre = union de D et de delta_D :
	D_barre = D+delta_D;

	% Calcul de delta_D_ext (similaire au calcul de delta_D_int) :
	D_barre_conv_masque = conv2(D_barre,masque_convolution,'same');
	delta_D_ext = (~D_barre).*D_barre_conv_masque;
	delta_D_ext(delta_D_ext==0) = 0;
	delta_D_ext = double(delta_D_ext>0);

end
