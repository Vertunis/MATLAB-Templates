function plotKOSYS_0(s,P,xlim,ylim,zlim,xTicks,yTicks,zTicks)

% s: Spannweite KOSYS
% P: Koordinaten Anfangspunkt 
% xlim ylim zxlim:Beschränkungen des KOSYS
% xTicks,yTicks,zTicks: Auflösung Achsen
%% Endpunkte
ox= P(1,1);
oy= P(2,1);
oz= P(3,1);

O_orig = [ox   oy   oz]; % Ursprung 
x_axis = [ox+s oy   oz]; % Koordinatenachsen
y_axis = [ox   oy+s oz];
z_axis = [ox   oy oz+s];

% Verbindungspunkte Ursprung zu xyz
for t = 0:1:1 % Geradengleichung mit 2 Punkten erstellen
    i=t+1
x_con(i,:)=O_orig+t*(x_axis-O_orig);
y_con(i,:)=O_orig+t*(y_axis-O_orig);
z_con(i,:)=O_orig+t*(z_axis-O_orig);
end

con_ges{1}=x_con';
con_ges{2}=y_con';
con_ges{3}=z_con';

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
plot3(O_orig(1),O_orig(2),O_orig(3),'.','Color',[0 0 0]/255,'LineWidth',6)
plot3(x_axis(1),x_axis(2),x_axis(3),'.','Color',[0 255 0]/255,'LineWidth',6)
plot3(y_axis(1),y_axis(2),y_axis(3),'.','Color',[0 0 255]/255,'LineWidth',6)
plot3(z_axis(1),z_axis(2),z_axis(3),'.','Color',[255 0 0]/255,'LineWidth',6)
set(gca, 'XTickMode', 'manual', 'XTick', xlim(1):xTicks:xlim(2), 'xlim', [xlim(1),xlim(2)]); % Deklaration Achsen
set(gca, 'YTickMode', 'manual', 'YTick', ylim(1):yTicks:ylim(2), 'ylim', [ylim(1),ylim(2)]);
set(gca, 'ZTickMode', 'manual', 'ZTick', zlim(1):zTicks:zlim(2), 'zlim', [zlim(1),zlim(2)]);
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
az=120; % Drehung des 3-D Plots
el=24;
view(az,el);
title('Koordinatensystem');
text(O_orig(1)-s/5,O_orig(2)+s/5,O_orig(3)+s/5,'B','fontsize',8); % Beschriftung Punkt B
legend('x','y','z')

%% Plot Kreis um z-Achse
r=s
ang=0:0.01:2*pi; 
x_circ=r*cos(ang)+O_orig(1);
y_circ=r*sin(ang)+O_orig(2);
z_circ=ones(size(y_circ,2),1)*O_orig(3)
plot3(x_circ,y_circ,z_circ,':','Color',[0 0 0]/255,'LineWidth',1);

end