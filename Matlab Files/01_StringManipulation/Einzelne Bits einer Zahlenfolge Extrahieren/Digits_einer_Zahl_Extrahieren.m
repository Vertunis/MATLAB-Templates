%{
Einzelne Digits aus einer Zahl extrahieren
Anleitung https://www.tutorials.de/threads/ziffern-einer-zahl-auslesen.316333/
123456 % 10 = 6
123456 % 100 = 56 / 10 = 5
123456 % 1000 = 456 / 100 = 4
123456 % 10000 = 3456 / 1000 = 3
%}


%% Beispiel 1 
%x=000000;
% x=123456;
% 
% e=zeros(6,1);
% j=6;
% for i=1:1:6 % 1 bis Anzahl Digits 123456 = 6
%     
% e(j,1) = floor(mod(x,10^i)/(10^(i-1)))
% 
% j=j-1;
% end

%% Beispiel 2

x=1000101000000;

e=zeros(13,1);
j=13;
for i=1:1:13 % 1 bis Anzahl Digits=13
    
e(j,1) = floor(mod(x,10^i)/(10^(i-1)))

j=j-1;
end
