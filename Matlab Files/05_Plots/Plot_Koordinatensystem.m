% 3-D Plot Koordinatensystem

% Endpunkte
s=0.5% Spannweite KOSYS
O_orig = [0 0 0]; % Ursprung 
x_axis = [s 0 0]; % Koordinatenachsen
y_axis = [0 s 0];
z_axis = [0 0 s];

% Verbindungspunkte
for t = 0:1:1 % Geradengleichung mit 2 Punkten erstellen
    i=t+1
x_con(i,:)=O_orig+t*(x_axis-O_orig);
y_con(i,:)=O_orig+t*(y_axis-O_orig);
z_con(i,:)=O_orig+t*(z_axis-O_orig);
end

%% Plot KOSYS Urpsrung: O (schwarz), x (grün),y (blau),z (rot)
figure(1)
box on  
grid on
hold on
% Plot Verbindung zwischen einzelnen Koordinatensystemen
plot3([x_con(1,1) x_con(2,1)],[x_con(1,2) x_con(2,2)] ,[x_con(1,3) x_con(2,3)],'-','Color',[0 255 0]/255,'LineWidth',1) 
plot3([y_con(1,1) y_con(2,1)],[y_con(1,2) y_con(2,2)] ,[y_con(1,3) y_con(2,3)],'-','Color',[0 0 255]/255,'LineWidth',1)
plot3([z_con(1,1) z_con(2,1)],[z_con(1,2) z_con(2,2)] ,[z_con(1,3) z_con(2,3)],'-','Color',[255 0 0]/255,'LineWidth',1)

% Plot Endpunkte
plot3(O_orig(1),O_orig(2),O_orig(3),'.','Color',[0 0 0]/255,'LineWidth',3)
plot3(x_axis(1),x_axis(2),x_axis(3),'.','Color',[0 255 0]/255,'LineWidth',3)
plot3(y_axis(1),y_axis(2),y_axis(3),'.','Color',[0 0 255]/255,'LineWidth',3)
plot3(z_axis(1),z_axis(2),z_axis(3),'.','Color',[255 0 0]/255,'LineWidth',3)

xlim=[-2 2]; % Begrenzungen x
ylim=[-2 2]; % Begrenzungen y
zlim=[-2 2]; % Begrenzungen x
xTicks = 0.5; % Schrittweite x
yTicks = 0.5; % Schrittweite y
zTicks = 0.5; % Schrittweite z
set(gca, 'XTickMode', 'manual', 'XTick', xlim(1):xTicks:xlim(2), 'xlim', [xlim(1),xlim(2)]); % Deklaration Achsen
set(gca, 'YTickMode', 'manual', 'YTick', ylim(1):yTicks:ylim(2), 'ylim', [ylim(1),ylim(2)]);
set(gca, 'ZTickMode', 'manual', 'ZTick', zlim(1):zTicks:zlim(2), 'zlim', [zlim(1),zlim(2)]);
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');

az=144; % Drehung des 3-D Plots
el=24;
view(az,el);
text(O_orig(1)+s/5,O_orig(2)+s/5,O_orig(3)+s/5,'B','fontsize',8); % Beschriftung Punkt B
title('Koordinatensystem');
