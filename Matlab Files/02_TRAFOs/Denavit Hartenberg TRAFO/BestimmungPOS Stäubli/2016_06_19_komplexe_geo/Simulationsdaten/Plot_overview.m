%% P

load('Position_P_sim.mat')


t=0.01:0.01:((size(Roboterinfo_pos,1))*0.01);
% Gesamtstrecke kartesische Orientierung

figure(1)
grid on
hold on
box on
plot(t,Roboterinfo_pos(:,4),'k','LineWidth',2)
xlim_min=0; % Begrenzungen x
xlim_max=25;
ylim_min=-110; % Begrenzungen y
ylim_max=-60;
xTicks = 5; % Schrittweite x
yTicks = 10; % Schrittweite y
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Winkel [Degr]');  %Beschriftung y-Achse
title('Orientierung des TCP');
legend('x-Achse')

figure(2)
grid on
hold on
box on
plot(t,Roboterinfo_pos(:,2)/1000,'k','LineWidth',2)
xlim_min=0; % Begrenzungen x
xlim_max=25;
ylim_min=0.2; % Begrenzungen y
ylim_max=0.5;
xTicks = 5; % Schrittweite x
yTicks = 0.1; % Schrittweite y
set(gca, 'XTickMode', 'manual', 'XTick', xlim_min:xTicks:xlim_max, 'xlim', [xlim_min,xlim_max]); 
set(gca, 'YTickMode', 'manual', 'YTick', ylim_min:yTicks:ylim_max, 'ylim', [ylim_min,ylim_max]);
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Weg [m]');  %Beschriftung y-Achse
title('Position des TCP');
legend('y-Wert')





% %% R
% load('Position_R_sim.mat')
% 
% figure(3)
% t=0.01:0.01:((size(Roboterinfo_pos,1))*0.01);
% plot(t,Roboterinfo_pos(:,2))