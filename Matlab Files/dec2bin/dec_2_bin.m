%% Code zur Erzeugung eines Binärcodes aus Dezimalzahl
function bin = dec_2_bin(dec)

    n=0;

    j=1; % Erster Eintrag Vektor
    n2=zeros(1,30);
    n2(j)=2^n; %Zweierpotenz 1. Eintrag 2^0; 2. Eintrag 2^1 usw.

    %% Suche wieviel Potenzen man braucht

    for j=1:30 % Anzahl Stellen, bis unendlich möglich 

        n2(j)=2^n;
        n=n+1; % Iterative erhöhung der Potenz bis n2(j) >= dec

        if n2(j) >= dec && mod(n2(j),dec)==0 % Wenn Zahl genau der Potenz entspricht 

            break;  % Bricht for schleife ab 

        elseif n2(j) >= dec && mod(n2(j),dec)~=0  % Wenn Zahl kleiner als höchste Potenz entspricht 

            n=n-1;
            break;  % Bricht for schleife ab   

        end
    end

    % n_notw=n        % Ergebnis: Anzahl der Potenzen, die max gebraucht werden
    % dec_notw=n2(n)  % Ergebnis in Dezimal

    %% Dec in Binär umwandeln 
    bin_vec=zeros(1,n);      % Erzeugt Nullvektor
    rest_prev=dec;        % Jeweils verbleibender Restwert an Zahlen vor Umrechnung in Binär


    for k=1:n

        k_n2_back=n+1-k; % Vektor n2 Zugriff rückwärts

        [bin_curr_bit,rest_curr] = current_bin_bit(n2,k,k_n2_back,rest_prev);

         bin_vec(k) = bin_curr_bit(k); % Setzt das aktuelle Bits auf entsprechende Stelle 
         rest_prev = rest_curr;

    end

    % bin_vec = bin_vec % Test

    %% Transformation Vektor zu einzelner DezimalZahl

    bin=0;

    for i=1:1:(size(bin_vec,2)) 
        k_n2_back=n+1-i;

       bin = bin+bin_vec(k_n2_back)*10^(i-1);

    end

end

function [bin_curr_bit,rest_curr] = current_bin_bit(n2,k,k_n2_back,rest_prev)
% Ausgang:
% bin_curr_bit -> Aktuelles Bit 0 oder 1
% rest_curr aktueller Rest für nächstes Bit 

% Eingänge:
% n2 Vektor mit allen Potenzzahl
% k ist aktuelle Postion des Binärvektors von links
% k_n2_back ist aktuelle Postion des Potenzvektors von rechts
% rest_prev -> Restzahl die aufgespalten werden muss
bin_curr_bit=0;

    if (rest_prev/n2(k_n2_back)) < 1 % Wenn sich der Rest nicht durch aktuelle Potenzzahlteilen lässt

        bin_curr_bit(k) = 0; %wird bit auf 0 gesetzt

        rest_curr=rest_prev; % und rest bleibt gleich

    elseif (rest_prev/n2(k_n2_back)) >= 1 % Wenn sich der Rest durch aktuelle Potenzzahlteilen lässt

        bin_curr_bit(k) = 1; % wird aktuelles bit auf 1 gesetzt

        rest_curr = mod(rest_prev,n2(k_n2_back)); 
    end 
end 