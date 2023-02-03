clear all

a = 12101097; %Gewünschte Zahl
c=zeros(13,3);

j=13 %% Bis zu 13 Zahlen werden gescannt
for i=1:1:j
%d(j,1)=mod(a,10^i)-a  % Zahl, welche an i-ter Stelle von a
c(j,1)=floor(mod(a,10^i)/(10^(i-1))) % Vektor von hinten nach vorne mit aktueller Stelle 
c(j,2)=i; % Kontrollspalte mit aktuellem Iterationsschritt
c(j,3)=(a-(mod(a,10^i))) % momentaner Restwert 
j=j-1; 
end

%e(i,1)=floor(mod(a,10^i)/(10^(i-1))) 
j=13;
k=1; % 2. Index zum Überspringen einer Zeile 
for i=1:1:j
    
    if (c(j,1)==0 && c(j,3)~=0) % Wenn aktueller Wert von C gleich 0 und der Rest der Zahl noch ungleich 0 

        
        e(k,1)=c(j-1,1)*10
        j=j-1;

    else
 
       e(k,1)=c(j,1)

    end
    
    j=j-1;
    k=k+1;
        
        if (c(j,3)==0)
            break;  % Bricht Schleife ab Sobald Restwert = 0
        end
end
