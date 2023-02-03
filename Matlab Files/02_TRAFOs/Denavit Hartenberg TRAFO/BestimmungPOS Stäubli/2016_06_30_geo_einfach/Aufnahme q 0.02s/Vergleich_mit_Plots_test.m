%% Wichtig -> Ändern des zeitlichen Offset in Zeile 26 um die Plots auf gleiche Startzeit zu bekommen

%% Laden Position R aus Achswinkel hat 7500 Einträge bei unbekannter Dauer und Sample Time
%von 0.004s

load 2016_06_30_R_rec

deltaT_rec=0.004; %sample Time des Recorders
lR_rec=length(TCP_pos_m); % Immer 7500 ?
tR_rec=lR_rec*deltaT_rec; % Gesamtdauer in [s]

%% Laden Position R aus Simulink (besitzt 1751 Einträge bei einer Dauer von 35s und einer sample Time von 0.02s)

load Position_R_sim_geo_einfach

deltaT_sim=0.01; % sample Time der Simulation
deltaT_sim_geschickt=0.02; % gewählt da  0.02/0.004=5 
ratio_deltaT=deltaT_sim_geschickt/deltaT_sim; % um auf ganzzahliges Ratio zu kommen

Roboterinfo=Roboterinfo_pos(1:ratio_deltaT:length(Roboterinfo_pos),1:3)/1000;

lR_sim=length(Roboterinfo);
tR_sim=lR_sim*deltaT_sim_geschickt; % Gesamtdauer in [s]

s=deltaT_sim_geschickt/deltaT_rec; % s Zeilenverhältnis zwischen R_sim und TCP_pos_m an um der Simulationsdauer 0.02s zu entsprechen

% Vektoren in gleich große Vektoren schreiben für Plot 
lR_rec_soll=lR_rec/s; % Anzahl Zeilen des Vektors TCP_pos_m  wenn nur jede s-te Zeile entnommen wird

t_offset=5.9 % Zeitliches Offset der Messungen in Sekunden
z_offset_sim=t_offset/deltaT_sim_geschickt;% Umrechnen des zeitlichen Offsets in Zeilennummer

switch 1 % Switch ändern je nach Vektor
    
   case 1 % langer Vektor mit 3750 Einträgen
       t_plot=(0:deltaT_sim_geschickt:tR_sim-deltaT_sim_geschickt); % Plotdauer
%      R_sim=zeros(lR_sim,6); % Nullvektor erzeugen
       R_rec=zeros(lR_sim,6);
       R_sim=Roboterinfo(1:lR_sim,:); % Vektoren auffüllen
       R_rec(1:lR_rec_soll,1:3)=TCP_pos_m(1:s:lR_rec,:);
       
       z_R_rec=length(R_rec(:,1)); % Zeilenzahl von R_rec
       
       R_rec(1:(z_R_rec-z_offset_sim+1),1:3)= R_rec(z_offset_sim:end,1:3);  % Mit berücksichtigung des zeitlichen Offsets
       
    case 2 % kurzer Vektor mit 1500 Einträgen
       t_plot=(0:deltaT_sim_geschickt:tR_rec-deltaT_sim_geschickt); % Plotdauer
       R_sim=zeros(lR_rec_soll,6);  % Nullvektor erzeugen
       R_rec=zeros(lR_rec_soll,6);
       R_sim=Roboterinfo(1:lR_rec_soll,:); % Vektoren auffüllen
       R_rec(1:lR_rec_soll,1:3)=TCP_pos_m(1:s:lR_rec,:); 
       
       z_R_rec=length(R_rec(:,1)); % Zeilenzahl von R_rec
       
       R_rec(1:(z_R_rec-z_offset_sim+1),1:3)= R_rec(z_offset_sim:end,1:3);  % Mit berücksichtigung des zeitlichen Offsets
end

%% Plot x-Wert
figure(1);
grid on
hold on
box on
plot(t_plot,R_rec(:,1),'r','LineWidth',1.5);
plot(t_plot,R_sim(:,1),'k--','LineWidth',1.5);


xlim_min=0;
xlim_max=30;
ylim_min=0;
ylim_max=0.5;

xTicks = 5;
yTicks = 0.1;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);

xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Weg x [m]');  %Beschriftung y-Achse
title('Vergleich der Positionsdaten (x-Wert)');
legend('Simulation','Messung') 

% Plot Abweichung x Wert
figure(2);
grid on
hold on
box on
error_rel=zeros(length(R_sim),1);
for i=1:length(R_sim)
   error_rel(i)=(R_sim(i,1)-R_rec(i,1))/R_rec(i,1)*100;
end        
plot(t_plot,error_rel,'k','LineWidth',1.5);
xlim_min=0;
xlim_max=30;
ylim_min=0;
ylim_max=30;

xTicks = 5;
yTicks = 5;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);

xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Abweichung in Prozent');  %Beschriftung y-Achse
title('Vergleich der Positionsdaten (x-Wert)');
legend('relativer Fehler') 


% Plot y-Wert
figure(3);
grid on
hold on
box on
plot(t_plot,R_sim(:,2),'k--','LineWidth',1.5);
plot(t_plot,R_rec(:,2),'r','LineWidth',1.5);

xlim_min=0;
xlim_max=30;
ylim_min=0;
ylim_max=0.5;

xTicks = 5;
yTicks = 0.1;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);

xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Weg y [m]');  %Beschriftung y-Achse
title('Vergleich der Positionsdaten (y-Wert)');
legend('Simulation','Messung') 

% Plot Abweichung y Wert
figure(4);
grid on
hold on
box on
error_rel=zeros(length(R_sim),1);
for i=1:length(R_sim)
   error_rel(i)=(R_sim(i,2)-R_rec(i,2))/R_rec(i,2)*100;
end        
plot(t_plot,error_rel,'k','LineWidth',1.5);
xlim_min=0;
xlim_max=30;
ylim_min=-20;
ylim_max=20;

xTicks = 5;
yTicks = 5;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);

xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Abweichung in Prozent');  %Beschriftung y-Achse
title('Vergleich der gemessenen Positionsdaten (y-Wert)');
legend('relativer Fehler') 

% Plot z-Wert

figure(5);
grid on
hold on
box on
plot(t_plot,R_sim(:,3),'k--','LineWidth',1.5);
plot(t_plot,R_rec(:,3),'r','LineWidth',1.5);

xlim_min=0;
xlim_max=30;
ylim_min=0;
ylim_max=0.5;

xTicks = 5;
yTicks = 0.1;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);

xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Weg z [m]');  %Beschriftung y-Achse
title('Vergleich der Positionsdaten (z-Wert)');
legend('Simulation','Messung') 

% Plot Abweichung z Wert
figure(6);
grid on
hold on
box on
error_rel=zeros(length(R_sim),1);
for i=1:length(R_sim)
   error_rel(i)=(R_sim(i,3)-R_rec(i,3))/R_rec(i,3)*100;
end        
plot(t_plot,error_rel,'k','LineWidth',1.5);
xlim_min=0;
xlim_max=30;
ylim_min=-15;
ylim_max=15;

xTicks = 5;
yTicks = 5;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);

xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Abweichung in Prozent');  %Beschriftung y-Achse
title('Vergleich der gemessenen Positionsdaten (z-Wert)');
legend('relativer Fehler') 