% Periodische Sinusfunktion
% http://de.bettermarks.com/mathe-portal/mathebuch/periodische-vorgaenge-die-allgemeine-sinusfunktion.html

%% Modellierung Sinusfunktion
x = 0:0.01:12*pi; % Betrachung für den entsprechenden x-Bereich

a = 1;  % Amplitude
b = 2;  % Stauchung der Kurve in x-Richtung (Änderung der Periode) b>1 erhöht die Frequenz b<1 Verringert die Frequenz
c = 0;  %[RAD] Phasenverschiebung (c<0: Verschiebung nach rechts c>0: Verschiebung nach links) INFO: Umrechnung RAD zu GRAD -> 2*Pi [Rad] =360 [Grad]
d = 0;  % Verschiebung y-Achse

T_periode = (2*pi)/abs(b) % Periodendauer T
f = 1/ T_periode % Frequenz

sinFKT = a*sin(b*x+c)+d;

%% Plot
figure(1)
grid on
hold on
box on
plot(x,sinFKT,'LineWidth',1);
xlim_min=0; % Begrenzungen x
xlim_max=10;
ylim_min=-2*a; % Begrenzungen y
ylim_max=2*a;
xTicks = xlim_max/10; % Schrittweite x
yTicks = (ylim_max-ylim_min)/10; % Schrittweite y
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Amplitude [Degr]');  %Beschriftung y-Achse
title('Periodische Sinusfunktion');
legend('Sin')