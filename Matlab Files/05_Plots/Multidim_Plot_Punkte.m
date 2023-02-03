% 3-D Plot Punkte

s=0.2 % Spannweite KOSYS
P_orig = [0 0 0]; % Ursprung 
x_axis = [s 0 0]; % Koordinatenachsen
y_axis = [0 s 0];
z_axis = [0 0 s];
box on  
grid on
hold on
plot3(P_orig(1),P_orig(2),P_orig(3),'.')
plot3(x_axis(1),x_axis(2),x_axis(3),'.')
plot3(y_axis(1),y_axis(2),y_axis(3),'.')
plot3(z_axis(1),z_axis(2),z_axis(3),'.')
% axis([-2 2 -2 2 -2 2]) 
xlim=[-2 2]; % Begrenzungen x
ylim=[-2 2]; % Begrenzungen y
zlim=[-2 2]; % Begrenzungen x
xTicks = 0.5; % Schrittweite x
yTicks = 0.5; % Schrittweite y
zTicks = 0.5; % Schrittweite z
set(gca, 'XTickMode', 'manual', 'XTick', xlim(1):xTicks:xlim(2), 'xlim', [xlim(1),xlim(2)]); % Deklaration Achsen
set(gca, 'YTickMode', 'manual', 'YTick', ylim(1):yTicks:ylim(2), 'ylim', [ylim(1),ylim(2)]);
set(gca, 'ZTickMode', 'manual', 'ZTick', zlim(1):zTicks:xlim(2), 'zlim', [zlim(1),zlim(2)]);
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');

az=144; % Drehung des Koordinatensystems
el=24;
view(az,el);
title('Koordinatensystem');
