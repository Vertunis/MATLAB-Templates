function [bin_curr_bit,rest_curr] = current_bin_bit(n2,k,k_n2_back,rest_prev)

% Ausgang:
% bin_curr_bit -> Aktuelles Bit 0 oder 1
% rest_curr aktueller Rest f�r n�chstes Bit 

% Eing�nge:
% n2 Vektor mit allen Potenzzahl
% k ist aktuelle Postion des Bin�rvektors von links
% k_n2_back ist aktuelle Postion des Potenzvektors von rechts
% rest_prev -> Restzahl die aufgespalten werden muss

    if (rest_prev/n2(k_n2_back)) < 1 % Wenn sich der Rest nicht durch aktuelle Potenzzahlteilen l�sst

        bin_curr_bit(k) = 0; %wird bit auf 0 gesetzt

        rest_curr=rest_prev; % und rest bleibt gleich

    elseif (rest_prev/n2(k_n2_back)) >= 1 % Wenn sich der Rest durch aktuelle Potenzzahlteilen l�sst

        bin_curr_bit(k) = 1; % wird aktuelles bit auf 1 gesetzt

        rest_curr = mod(rest_prev,n2(k_n2_back)); 


    end 

end 