clc
clear all


z=7012010070 % Stellt den Beipspiel Returnwert dar. Ganz Rechts ist der erste Wert. alle Werte sind vorher und nacher mit dem Delimiter 0 unterbrochen um Zahlen > 10 aber < 100 verwenden zu können

j=13
for i=1:1:j
y(j,1)=floor(mod(z,10^i)/(10^(i-1))); %
y(j,2)=i;
y(j,3)=z-mod(z,10^(i))
j=j-1;
if(j<=1)
    break; % Bricht die Schleife ab wenn j < 1;
end
end

j=13;
k=1;
for i=1:1:j
    
    if (y(j,1)==0 && y(j-1,1)~= 0 && y(j-2,1)== 0) % Prüfe ob Zustand < 10  
       
        e(i,1)= y(j-1,1)
        j=j-2; % Springe um Faktor 10 weiter im Array
     
    elseif (y(j,1)==0 && y(j-2,1)== 1) % Prüfe Ob Zustand 10 oder größer
    
        e(i,1)= y(j-2,1)*10+ y(j-1,1)*1
        j=j-3; % Springe um Faktor 100 weiter im Array
      
    end
    

    if (y(j,2)==0)
           break;  % Bricht Schleife ab Sobald Restwert = 0
    elseif(j<=1)
        break; % Bricht die Schleife ab wenn j < 1;
    end
end

