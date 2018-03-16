function [k,U] = recuit_simule(k_cour,k_nouv,U_cour,U_nouv,T)
if U_nouv < U_cour
    k = k_nouv;
    U = U_nouv;
else
    p = rand();
    if exp(-(U_nouv-U_cour)/T) >= p
        k = k_nouv;
        U = U_nouv;
    else
        k = k_cour;
        U = U_cour;
    end
end

