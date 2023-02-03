function plotKOSYS(s,P,bTt,nr,TCP_ori)

% s: Spannweite KOSYS
% P: Koordinaten Anfangspunkt 
% bTt: Transformationsmatrix die 

%% Endpunkte
Px= P(1,1);
Py= P(2,1);
Pz= P(3,1);

P_orig = [Px;  Py;   Pz]; % Ursprung 

Ori_Kosys = eye(3)*s; 

Pos_KOSYS= [Px    Px    Px;  % Endpunkte der Achsen des KOSYS (x,y,z)
            Py    Py    Py;
            Pz    Pz    Pz];

axis_tr = Ori_Kosys*bTt(1:3,1:3)+Pos_KOSYS; % Transformation der Endpunkte
    
x_axis= axis_tr(:,1);
y_axis= axis_tr(:,2);
z_axis= axis_tr(:,3);


% Verbindungspunkte Ursprung zu xyz
for t = 0:1:1 % Geradengleichung mit 2 Punkten erstellen
    i=t+1;
  
x_con(i,:)=P_orig+t*(x_axis-P_orig);
y_con(i,:)=P_orig+t*(y_axis-P_orig);
z_con(i,:)=P_orig+t*(z_axis-P_orig);
end

%% Plot KOSYS Urpsrung: O (schwarz), x (grün),y (blau),z (rot)

figure(1)
box on  
grid on
hold on
% Plot Verbindung zwischen einzelnen Koordinatensystemen
plot3([x_con(1,1) x_con(2,1)],[x_con(1,2) x_con(2,2)] ,[x_con(1,3) x_con(2,3)],'-','Color',[0 255 0]/255,'LineWidth',3)
plot3([y_con(1,1) y_con(2,1)],[y_con(1,2) y_con(2,2)] ,[y_con(1,3) y_con(2,3)],'-','Color',[0 0 255]/255,'LineWidth',3)
plot3([z_con(1,1) z_con(2,1)],[z_con(1,2) z_con(2,2)] ,[z_con(1,3) z_con(2,3)],'-','Color',[255 0 0]/255,'LineWidth',3)

text( x_con(2,1)-s/5, x_con(2,2)+s/5, x_con(2,3)+s/5,sprintf('x*'),'fontsize',8,'Color',[0 255 0]/255); % 
text( y_con(2,1)-s/5, y_con(2,2)+s/5, y_con(2,3)+s/5,sprintf('y*'),'fontsize',8,'Color',[0 0 255]/255); 
text( z_con(2,1)-s/5, z_con(2,2)+s/5, z_con(2,3)+s/5,sprintf('z*'),'fontsize',8,'Color',[255 0 0]/255); 


% Plot Endpunkte
plot3(P_orig(1),P_orig(2),P_orig(3),'o','Color',[0 0 0]/255,'LineWidth',1)
plot3(x_axis(1),x_axis(2),x_axis(3),'o','Color',[0 255 0]/255,'LineWidth',1)
plot3(y_axis(1),y_axis(2),y_axis(3),'o','Color',[0 0 255]/255,'LineWidth',1)
plot3(z_axis(1),z_axis(2),z_axis(3),'o','Color',[255 0 0]/255,'LineWidth',1)

text(P_orig(1)-s/5,P_orig(2)+s/5,P_orig(3)+s/5,sprintf('A %d', nr),'fontsize',8); % Beschriftung Punkt B

str=sprintf('Eulerwinkel (%d, %d, %d)',TCP_ori(1),TCP_ori(2),TCP_ori(3));
text(-1,0,0,str,'fontsize',8); % Beschriftung Punkt B

%% Plot Kreis um z-Achse
% r=s;
% ang=0:0.01:2*pi; 
% x_circ=r*cos(ang)+P_orig(1);
% y_circ=r*sin(ang)+P_orig(2);
% z_circ=ones(size(y_circ,2),1)*P_orig(3);
% plot3(x_circ,y_circ,z_circ,':','Color',[0 0 0]/255,'LineWidth',1);

end