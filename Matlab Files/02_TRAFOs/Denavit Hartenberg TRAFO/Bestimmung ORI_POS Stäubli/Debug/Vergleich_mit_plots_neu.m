%%Vergleich der Koordinaten aus recorder Daten und Simulationsdaten
% Wichtig -> Ändern des zeitlichen Offset in Zeile 50 um die Plots auf gleiche Startzeit zu bekommen

% Laden Position R transformierten Recorderdaten und Simulation
load Rec2Pos/2016_06_19_Ori_R_aus_Achswinkel % -> R_ori_m (hat unterschiedliche viele Einträge mit dT = 0.004s)
ori_m=TCP_ori_m;

t_plot=(0.02:0.02:size(ori_m,1)*0.02);

     
%% Plot x-Wert
figure(1);
grid on
hold on
box on
plot(t_plot,ori_m(:,1),'r','LineWidth',1.5);

xlim_min=0;
xlim_max=25;
ylim_min=-360;
ylim_max=360;

xTicks = 5;
yTicks = 45;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);

xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Weg x [m]');  %Beschriftung y-Achse
title('Vergleich der Orientierung (rx-Wert)');
legend('Simulation','Messung') 

%% Plot y-Wert
figure(3);
grid on
hold on
box on

plot(t_plot,ori_m(:,2),'r','LineWidth',1.5);

xlim_min=0;
xlim_max=25;
ylim_min=-360;
ylim_max=360;

xTicks = 5;
yTicks = 45;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);

xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Weg y [m]');  %Beschriftung y-Achse
title('Vergleich der Orientierung (ry-Wert)');
legend('Simulation','Messung') 

%% Plot z-Wert

figure(5);
grid on
hold on
box on

plot(t_plot,ori_m(:,3),'r','LineWidth',1.5);

xlim_min=0;
xlim_max=25;
ylim_min=-360;
ylim_max=360;

xTicks = 5;
yTicks = 45;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);

xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Weg z [m]');  %Beschriftung y-Achse
title('Vergleich der Orientierung (rz-Wert)');
legend('Simulation','Messung') 
