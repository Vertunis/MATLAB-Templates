clear all;
clc;

% Variablen deklarieren
aspeed1=1;
bspeed2='A';
speed3={'Hallo';[magic(4)]};
spied1=2;
 
% Variablen auflisten
vars=whos; % whos listet alle Variablen in Workspace nach alphabetischer Reihenfolge, es werden auch alle Eigenschaften angezeigt 

% Zu suchende Begriffe deklarieren
str='speed'; % enthält 'speed'
str2='^speed'; % beginnt mit 'speed'

for k=1:length(vars) % Durchläuft die Liste Zeile für Zeile
    
    i=k % für Debug
    
    if regexp(vars(k).name,str2) % regexp() vergleicht Namensabschnitt im
                                 % whos mit zu suchendem String (str oder str2) und gibt 1
                                 % heraus falls identisch
        
       v = evalin('base',vars(k).name) % This example extracts the value of the variable vars in the MATLAB base workspace  and captures the value in the local variable v:
    end
end