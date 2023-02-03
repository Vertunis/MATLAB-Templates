%%Vergleich der Koordinaten aus recorder Daten und Simulationsdaten
% Wichtig -> Ändern des zeitlichen Offset in Zeile 50 um die Plots auf gleiche Startzeit zu bekommen

n=2 % 1 = Vergleich der Orientierung von P 
    % 2 = Vergleich der Orientierung von R
switch n   

    case 1
% Laden Position P transformierten Recorderdaten und Simulation 
load Rec2Pos/2016_06_19_Ori_TCP_aus_Achswinkel % -> TCP_ori_m (hat unterschiedliche viele Einträge mit dT = 0.004s)
ori_measure=TCP_ori_m;
load Simulationsdaten/Roboteinfo_pos_Roboterinfo_pos_ori_sim_Bierflasche_Greifer_y_euler
ori_sim=Roboterinfo_pos(:,4:6);
    
    case 2 
% Laden Position R transformierten Recorderdaten und Simulation
load Rec2Pos/2016_06_19_Ori_R_aus_Achswinkel % -> R_ori_m (hat unterschiedliche viele Einträge mit dT = 0.004s)
ori_measure=H_ori_m;

load Simulationsdaten/Roboteinfo_pos_Roboterinfo_pos_ori_sim_Bierflasche_Greifer_y_euler % -> ori_sim (besitzt 7500 Einträge bei einer Dauer von 70s und einer dT=0.01s)                  
ori_sim=Roboterinfo_pos(:,4:6);

end

deltaT_rec=0.004; %sample Time des Recorders
deltaT_sim=0.01; % sample Time der Simulation
deltaT_soll=0.02;
% kleinstes gemeinsames Vielfaches beider sample Times
deltaT_rec_gem=deltaT_soll/deltaT_rec; % jede 5. Zeile bei Recorder-Vektor um auf 0.02s zu kommen
deltaT_sim_gem=deltaT_soll/deltaT_sim; % jede 2. Zeile bei Simulations-Vektor um auf 0.02s zu kommen

t_sim=length(ori_sim)*deltaT_sim; % Gesamtdauer Simulation
t_rec=length(ori_measure)*deltaT_rec; % Gesamtdauer Messung

ori_sim=ori_sim(1:deltaT_sim_gem:length(ori_sim),1:3);
ori_measure=ori_measure(1:deltaT_rec_gem:length(ori_measure),1:3);

if length(ori_sim)<length(ori_measure)  % Nullvektor entsprechend dem kürzeren Vektor erstellen  
   ori_s=zeros(length(ori_sim),3);
   ori_m=zeros(length(ori_sim),3);
else    
   ori_s=zeros(length(ori_measure),3);
   ori_m=zeros(length(ori_measure),3);
end

for i=1:size(ori_m,1) % Vektoren entsprechend kürzerem Nullvektor auffüllen
   ori_s(i,:)=ori_sim(i,:);
   ori_m(i,:)=ori_measure(i,:);
end

t_offset=0.1 % Zeitliches Offset der Messungen in Sekunden
z_offset_sim=t_offset/deltaT_soll;% Umrechnen des zeitlichen Offsets in Zeilennummer

       t_plot=(deltaT_soll:deltaT_soll:deltaT_soll*size(ori_m,1)); % Plotdauer
       ori_s=ori_s; % Vektoren auffüllen
       ori_m=ori_m;  
       z_ori_m=length(ori_m(:,1)); % Zeilenzahl von ori_m
       ori_m(1:(z_ori_m-z_offset_sim+1),1:3)= ori_m(z_offset_sim:end,1:3);  % Mit berücksichtigung des zeitlichen Offsets
    
      
%% Plot x-Rotation
figure(1);
grid on
hold on
box on
plot(t_plot,ori_s(:,1),'k--','LineWidth',1.5);
plot(t_plot,ori_m(:,1),'r','LineWidth',1.5);
xlim_min=0;
xlim_max=30;
ylim_min=-100;
ylim_max=100;
xTicks = 5;
yTicks = 20;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Eulerwinkel rx [Deg]');  %Beschriftung y-Achse
title('Vergleich der Orientierung (rx-Wert)');
legend('Simulation','Messung') 

% % Plot Abweichung x Wert
% figure(2);
% grid on
% hold on
% box on
% error_rel=zeros(length(ori_s),1);
% for i=1:length(ori_s)
%    error_rel(i)=(ori_s(i,1)-ori_m(i,1))/ori_m(i,1)*100;
% end        
% plot(t_plot,error_rel,'k','LineWidth',1.5);
% xlim_min=0;
% xlim_max=30;
% ylim_min=0;
% ylim_max=30;
% xTicks = 5;
% yTicks = 5;
% set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
% set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
% 
% xlabel('Zeit T [s]'); %Beschriftung x-Achse 
% ylabel('Abweichung in Prozent');  %Beschriftung y-Achse
% title('Vergleich der Positionsdaten (x-Wert)');
% legend('relativer Fehler') 


% Plot y-Rotation
figure(3);
grid on
hold on
box on
plot(t_plot,ori_s(:,2),'k--','LineWidth',1.5);
plot(t_plot,ori_m(:,2),'r','LineWidth',1.5);
xlim_min=0;
xlim_max=30;
ylim_min=-100;
ylim_max= 100;
xTicks = 5;
yTicks = 20;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Eulerwinkel ry [Deg] [m]');  %Beschriftung y-Achse
title('Vergleich der Orientierung (ry-Wert)');
legend('Simulation','Messung') 

% % Plot Abweichung z-Rotation
% figure(4);
% grid on
% hold on
% box on
% error_rel=zeros(length(ori_s),1);
% for i=1:length(ori_s)
%    error_rel(i)=(ori_s(i,2)-ori_m(i,2))/ori_m(i,2)*100;
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
plot(t_plot,ori_s(:,3),'k--','LineWidth',1.5);
plot(t_plot,ori_m(:,3),'r','LineWidth',1.5);
xlim_min=0;
xlim_max=30;
ylim_min=-100;
ylim_max=100;
xTicks = 5;
yTicks = 20;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
xlabel('Eulerwinkel rz [Deg] [s]'); %Beschriftung x-Achse 
ylabel('Weg z [m]');  %Beschriftung y-Achse
title('Vergleich der Orientierung (rz-Wert)');
legend('Simulation','Messung') 

% % Plot Abweichung z Wert
% figure(6);
% grid on
% hold on
% box on
% error_rel=zeros(length(ori_s),1);
% for i=1:length(ori_s)
%    error_rel(i)=(ori_s(i,3)-ori_m(i,3))/ori_m(i,3)*100;
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

% Plot y-Rotation
figure(3);
grid on
hold on
box on
plot(t_plot,ori_s(:,2),'k--','LineWidth',1.5);
plot(t_plot,ori_m(:,2),'r','LineWidth',1.5);
xlim_min=0;
xlim_max=30;
ylim_min=-100;
ylim_max= 100;
xTicks = 5;
yTicks = 20;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Eulerwinkel ry [Deg] [m]');  %Beschriftung y-Achse
title('Vergleich der Orientierung (ry-Wert)');
legend('Simulation','Messung')


% Plot y-Rotation
figure(10);
grid on
hold on
box on
plot(t_plot,ori_s(:,3),'k--','LineWidth',1.5);
plot(t_plot-2,ori_m(:,2)-90,'r','LineWidth',1.5);
xlim_min=0;
xlim_max=25;
ylim_min=-110;
ylim_max=-60;
xTicks = 5;
yTicks = 10;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Eulerwinkel ry [Deg] [m]');  %Beschriftung y-Achse
title('Vergleich der Orientierung (ry-Wert)');
legend('Simulation','Messung')

