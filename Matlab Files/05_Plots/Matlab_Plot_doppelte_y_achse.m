figure(1);
grid on
hold on
box on
set(gcf, 'color', [1 1 1]) % Hintergrundfarbe Rahmen
FontSize = 10; % Schriftgrößen

x  = -10:0.01:10; %x-Werte
y1 = 10*sin(x); %y1-Werte
y2 = 100*x.*y1; %y2-Werte

[AX,H1,H2] = plotyy(x,y1,x,y2,'plot'); % Befehl Plot yy für 2 y-Achsen

set(get(AX(1),'Ylabel'),'String','y1-Beschriftung') % y1-Achse
set(get(AX(1),'Ylabel'),'FontSize',FontSize)
set(get(AX(2),'Ylabel'),'String','y2-Beschriftung') % y2-Achse
set(get(AX(2),'Ylabel'),'FontSize',FontSize)

set(H1,'LineWidth',3,'Color',[1 0 0]) % Linienart und Farben y1-Plot
set(H2,'LineWidth',3,'Color',[0 0 1]) % Linienart und Farben y2-Plot
set(AX(1),'FontSize',FontSize,'YColor',[1 0 0]); % Farben y1-Achse
set(AX(2),'FontSize',FontSize,'YColor',[0 0 1]); % Farben y2-Achse


set(AX(1),'XLim',[-10 10]);
set(AX(2),'XLim',[-10 10]);
set(AX(1),'YTick',[-10:0.01:10]);
set(AX(1),'YLim',[-11 11]);
set(AX(1),'YTick',[-11:1:11]);
set(AX(2),'YLim',[1e-4 -1e-4]);
set(AX(2),'YTick',[1e-4:0.001-1e-4]);

% xmin =-10;
% xmax = 10;
% axis(AX(1),[xmin xmax -11 11]); % Achsskalierung y1
% axis(AX(2),[xmin xmax 1e-4 -1e-4]); % Achsskalierung y2

xlabel('x-Beschriftung','FontSize',FontSize)
title('Überschrift','FontSize',FontSize)
legend('y1-Legende', 'y2-Legende')