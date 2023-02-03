% Vergleich Ori aus Simulation und Messung


%% Laden der Dateien
load Rec2Pos/Ori_TCP % -> TCP_ori_m (hat unterschiedliche viele Einträge mit dT = 0.004s)
ori_measure=TCP_ori_m;


load Simulationsdaten\Roboterinfo_pos_ori_sim_Bierflasche_Greifer
ori_sim=Roboterinfo_pos(:,4:6);

%% Anpassung beider Vektoren

deltaT_rec=0.004; %sample Time des Recorders
deltaT_sim=0.01; % sample Time der Simulation
deltaT_soll=0.02;

% kleinstes gemeinsames Vielfaches beider sample Times
deltaT_rec_gem=deltaT_soll/deltaT_rec; % jede 5. Zeile bei Recorder-Vektor um auf 0.02s zu kommen
deltaT_sim_gem=deltaT_soll/deltaT_sim; % jede 2. Zeile bei Simulations-Vektor um auf 0.02s zu kommen

t_sim=length(ori_sim)*deltaT_sim; % Gesamtdauer Simulation
t_rec=length(ori_measure)*deltaT_rec; % Gesamtdauer Messung

% ori_s=ori_sim(1:deltaT_sim_gem:length(ori_sim),1:3);
% ori_m=ori_measure(1:deltaT_rec_gem:length(ori_measure),1:3);

%% Anpassung Plot-Dauer

t_m=0:deltaT_rec:t_rec-deltaT_rec; % Zeit Messung
t_s=0:deltaT_sim:t_sim-deltaT_sim; % Zeit Simulation

t_offset=-2.1;

%% Plot x-Rotation
figure(1);
grid on
hold on
box on
plot(t_m+t_offset,ori_measure(:,1),'k--','LineWidth',1.5);
plot(t_s, ori_sim(:,1),'r','LineWidth',1.5);
xlim_min=0;
xlim_max=25;
ylim_min=-110;
ylim_max=-60;
xTicks = 5;
yTicks = 20;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Winkel [Deg]');  %Beschriftung y-Achse
title('Vergleich der TCP-Orientierung (x-Achse)');
legend('Simulation','Messung') 

% Plot y-Rotation
figure(3);
grid on
hold on
box on
plot(t_m+t_offset,ori_measure(:,2),'k--','LineWidth',1.5);
plot(t_s, ori_sim(:,2),'r','LineWidth',1.5);
xlim_min=0;
xlim_max=25;
ylim_min=-40;
ylim_max=60;
xTicks = 5;
yTicks = 20;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Winkel [Deg]');  %Beschriftung y-Achse
title('Vergleich der TCP-Orientierung (y-Achse)');
legend('Simulation','Messung') 

% Plot z-Wert
figure(5);
grid on
hold on
box on
plot(t_m+t_offset,ori_measure(:,3),'k--','LineWidth',1.5);
plot(t_s, ori_sim(:,3),'r','LineWidth',1.5);
xlim_min=0;
xlim_max=25;
ylim_min=-40;
ylim_max=60;
xTicks = 5;
yTicks = 20;
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Winkel [Deg]');  %Beschriftung y-Achse
title('Vergleich der TCP-Orientierung (z-Achse)');
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


% % Plot Abweichung y-Rotation
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

