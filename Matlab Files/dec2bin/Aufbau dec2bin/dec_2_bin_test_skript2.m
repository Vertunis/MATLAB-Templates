clear all

dec=1024 % Zu suchende Zahl

%% Code zur Erzeugung eines Bin�rcodes aus Dezimalzahl
 
n=0;

j=1; % Erster Eintrag Vektor
n2(j)=2^n; %Zweierpotenz 1. Eintrag 2^0; 2. Eintrag 2^1 usw.

%% Suche wieviel Potenzen man braucht
    
for j=1:inf % zu suchende Zahl bis unendlich m�glich 
    
    n2(j)=2^n;
    n=n+1 % Iterative erh�hung der Potenz bis n2(j) >= dec

    if n2(j) >= dec && mod(n2(j),dec)==0 % Wenn Zahl genau der Potenz entspricht 
    
        break;  % Bricht for schleife ab 
        
    elseif n2(j) >= dec && mod(n2(j),dec)~=0  % Wenn Zahl kleiner als h�chste Potenz entspricht 
        
        n=n-1;
        break;  % Bricht for schleife ab   
        
    end
end

n_notw=n        % Ergebnis: Anzahl der Potenzen, die max gebraucht werden
dec_notw=n2(n)  % Ergebnis in Dezimal

%% Dec in Bin�r umwandeln 
bin_vec=zeros(1,n);      % Erzeugt Nullvektor
rest_prev=dec;        % Jeweils verbleibender Restwert an Zahlen vor Umrechnung in Bin�r


for k=1:n

    k_n2_back=n+1-k; % Vektor n2 Zugriff r�ckw�rts
    
    [bin_curr_bit,rest_curr] = current_bin_bit(n2,k,k_n2_back,rest_prev);

     bin_vec(k) = bin_curr_bit(k) % Setzt das aktuelle Bits auf entsprechende Stelle 
     rest_prev = rest_curr
     
end

% bin_vec = bin_vec % Test

%% Transformation Vektor zu einzelner DezimalZahl
   
bin=0;

for i=1:1:(size(bin_vec,2)) 
    k_n2_back=n+1-i
    
   bin = bin+bin_vec(k_n2_back)*10^(i-1);
    
end

bin=bin