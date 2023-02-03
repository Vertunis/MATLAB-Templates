%%Vergleich der Koordinaten aus recorder Daten und Simulationsdaten
% Wichtig -> Ändern des zeitlichen Offset in Zeile 50 um die Plots auf gleiche Startzeit zu bekommen

n=1 % 1 = Vergleich der Position P 
    % 2 = Vergleich der Position R
switch n   

    case 1
% Laden Position P transformierten Recorderdaten und Simulation 
load Rec2pos/2016_06_30_P_rec % -> TCP_pos_m (hat unterschiedliche viele Einträge mit dT = 0.004s)
pos_measure=TCP_pos_m;
load Simulationsdaten/Position_P_sim_geo_einfach % -> pos_sim (besitzt 7500 Einträge bei einer Dauer von 70s und einer dT=0.01s)
pos_sim=Roboterinfo_pos;
    
    case 2 
% Laden Position R transformierten Recorderdaten und Simulation
load Rec2pos/2016_06_30_R_rec % -> R_pos_m (hat unterschiedliche viele Einträge mit dT = 0.004s)
pos_measure=R_pos_m;
load Simulationsdaten/Position_R_sim_geo_einfach % -> pos_sim (besitzt 7500 Einträge bei einer Dauer von 70s und einer dT=0.01s)                  
pos_sim=Roboterinfo_pos;

end

deltaT_rec=0.004; %sample Time des Recorders
deltaT_sim=0.01; % sample Time der Simulation
deltaT_soll=0.02; % kleinstes gemeinsames Vielfaches beider sample Times
deltaT_rec_gem=deltaT_soll/deltaT_rec; % jede 5. Zeile bei Recorder-Vektor um auf 0.02s zu kommen
deltaT_sim_gem=deltaT_soll/deltaT_sim; % jede 2. Zeile bei Simulations-Vektor um auf 0.02s zu kommen

t_sim=length(pos_sim)*deltaT_sim; % Gesamtdauer Simulation
t_rec=length(pos_measure)*deltaT_rec; % Gesamtdauer Messung

pos_sim=pos_sim(1:deltaT_sim_gem:length(pos_sim),1:3)/1000;
pos_measure=pos_measure(1:deltaT_rec_gem:length(pos_measure),1:3);

if length(pos_sim)<length(pos_measure)  % Nullvektor entsprechend dem kürzeren Vektor erstellen  
   pos_s=zeros(length(pos_sim),3);
   pos_m=zeros(length(pos_sim),3);
else    
   pos_s=zeros(length(pos_measure),3);
   pos_m=zeros(length(pos_measure),3);
end

for i=1:size(pos_m,1) % Vektoren entsprechend kürzerem Nullvektor auffüllen
   pos_s(i,:)=pos_sim(i,:);
   pos_m(i,:)=pos_measure(i,:);
end

t_offset=4.5 % Zeitliches Offset der Messungen in Sekunden
z_offset_sim=t_offset/deltaT_soll;% Umrechnen des zeitlichen Offsets in Zeilennummer

       t_plot=(deltaT_soll:deltaT_soll:deltaT_soll*size(pos_m,1)); % Plotdauer
       pos_s=pos_s; % Vektoren auffüllen
       pos_m=pos_m;  
       z_R_rec=length(pos_m(:,1)); % Zeilenzahl von pos_m
       pos_m(1:(z_R_rec-z_offset_sim+1),1:3)= pos_m(z_offset_sim:end,1:3);  % Mit berücksichtigung des zeitlichen Offsets
       
% Plot x-Wert
figure(1);
grid on
hold on
box on
plot(t_plot,pos_m(:,1),'r','LineWidth',1.5);
plot(t_plot,pos_s(:,1),'k--','LineWidth',1.5);


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

% % Plot Abweichung x Wert
% figure(2);
% grid on
% hold on
% box on
% error_rel=zeros(length(pos_s),1);
% for i=1:length(pos_s)
%    error_rel(i)=(pos_s(i,1)-pos_m(i,1))/pos_m(i,1)*100;
% end        
% plot(t_plot,error_rel,'k','LineWidth',1.5);
% xlim_min=0;
% xlim_max=30;
% ylim_min=0;
% ylim_max=30;
% 
% xTicks = 5;
% yTicks = 5;
% set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
% set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
% 
% xlabel('Zeit T [s]'); %Beschriftung x-Achse 
% ylabel('Abweichung in Prozent');  %Beschriftung y-Achse
% title('Vergleich der Positionsdaten (x-Wert)');
% legend('relativer Fehler') 


% Plot y-Wert
figure(3);
grid on
hold on
box on
plot(t_plot,pos_s(:,2),'k--','LineWidth',1.5);
plot(t_plot,pos_m(:,2),'r','LineWidth',1.5);

xlim_min=0;
xlim_max=30;
ylim_min=-0.3;
ylim_max=0;

xTicks = 5;
yTicks = 0.1;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);

xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Weg y [m]');  %Beschriftung y-Achse
title('Vergleich der Positionsdaten (y-Wert)');
legend('Simulation','Messung') 

% % Plot Abweichung y Wert
% figure(4);
% grid on
% hold on
% box on
% error_rel=zeros(length(pos_s),1);
% for i=1:length(pos_s)
%    error_rel(i)=(pos_s(i,2)-pos_m(i,2))/pos_m(i,2)*100;
% end        
% plot(t_plot,error_rel,'k','LineWidth',1.5);
% xlim_min=0;
% xlim_max=30;
% ylim_min=-20;
% ylim_max=20;
% 
% xTicks = 5;
% yTicks = 5;
% set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
% set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
% 
% xlabel('Zeit T [s]'); %Beschriftung x-Achse 
% ylabel('Abweichung in Prozent');  %Beschriftung y-Achse
% title('Vergleich der gemessenen Positionsdaten (y-Wert)');
% legend('relativer Fehler') 

% Plot z-Wert

figure(5);
grid on
hold on
box on
plot(t_plot,pos_s(:,3),'k--','LineWidth',1.5);
plot(t_plot,pos_m(:,3),'r','LineWidth',1.5);

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

% % Plot Abweichung z Wert
% figure(6);
% grid on
% hold on
% box on
% error_rel=zeros(length(pos_s),1);
% for i=1:length(pos_s)
%    error_rel(i)=(pos_s(i,3)-pos_m(i,3))/pos_m(i,3)*100;
% end        
% plot(t_plot,error_rel,'k','LineWidth',1.5);
% xlim_min=0;
% xlim_max=30;
% ylim_min=-15;
% ylim_max=15;
% 
% xTicks = 5;
% yTicks = 5;
% set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
% set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
% 
% xlabel('Zeit T [s]'); %Beschriftung x-Achse 
% ylabel('Abweichung in Prozent');  %Beschriftung y-Achse
% title('Vergleich der gemessenen Positionsdaten (z-Wert)');
% legend('relativer Fehler') 