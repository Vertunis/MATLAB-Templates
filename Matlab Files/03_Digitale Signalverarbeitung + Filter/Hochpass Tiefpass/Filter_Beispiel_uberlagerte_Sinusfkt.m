%% Rauschen Filtern

%% Erzeugung einer überlagerten Sinusfkt

% Haupfunktion
dT= 0.001 % Auflösung (Schrittweite)

x=0:dT:2*pi;

f = 10 % [Hz] gewünschte Frequenz
T_periode = 1/f % [s] Periodendauer

a = 10;  % Amplitude
b = (2*pi)/T_periode % Stauchung der Kurve in x-Richtung (Änderung der Periode) b>1 erhöht die Frequenz b<1 Verringert die Frequenz
c = 0;  %[RAD] Phasenverschiebung (c<0: Verschiebung nach rechts c>0: Verschiebung nach links) INFO: Umrechnung RAD zu GRAD -> 2*Pi [Rad] =360 [Grad]
d = 0;  % Verschiebung y-Achse

sinFKT_1 = a*sin(b*x+c)+d;

% Überlagerte Rauschfunktion

f = 100 % [Hz] gewünschte Frequenz
T_periode = 1/f % [s] Periodendauer

a = 1;  % Amplitude
b = (2*pi)/T_periode % Stauchung der Kurve in x-Richtung (Änderung der Periode) b>1 erhöht die Frequenz b<1 Verringert die Frequenz
c = 0; %[RAD] Phasenverschiebung (c<0: Verschiebung nach rechts c>0: Verschiebung nach links) INFO: Umrechnung RAD zu GRAD -> 2*Pi [Rad] =360 [Grad]
d = 0;  % Verschiebung y-Achse

sinFKT_2 = a*sin(b*x+c)+d;
    
% Überlagerung beider Fkt

sig=sinFKT_1+sinFKT_2;

%% Filter
% BUTTER-Filter http://www.mikrocontroller.net/topic/142356
s=sig;    % s: Signal      
n=6;      % n: Filterordnung
fs=1/dT;  % fs: Abtastfrequenz (Sollte mindestens 10 x mehr sein als die höchste betrachtete Frequenz)
fg1=40;   % fg1: untere Grenzfrequenz (Hochpassfilter)
fg2=10;   % fg2: obere Grenzfrequenz  (Tiefpassfilter)


[b,a]=butter(n,fg1/(fs/2),'high'); %Hochpassfilter
s_HP = filter(b,a,s);

[b,a]=butter(n,fg2/(fs/2),'low'); %Tiefpassfilter
s_TP = filter(b,a,s);

figure(1)
hold on 
subplot(311)
plot(x,sig)
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Amplitude');  %Beschriftung y-Achse
legend('Überlagerte Funktion')
subplot(312)
plot(x,s_HP)
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Amplitude');  %Beschriftung y-Achse
legend('Hochpassfilter')
subplot(313)
plot(x,s_TP)
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Amplitude');  %Beschriftung y-Achse
legend('Tiefpassfilter')
