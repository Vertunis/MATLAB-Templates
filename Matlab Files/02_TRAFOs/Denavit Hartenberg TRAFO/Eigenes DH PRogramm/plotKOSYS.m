function plotKOSYS(s,P,T,nr,plot_DH)

% s: Spannweite KOSYS
% P: Koordinaten Anfangspunkt 
% T: Transformationsmatrix bTt

%% Endpunkte
Px= P(1,1);
Py= P(2,1);
Pz= P(3,1);

P_orig = [Px;  Py;   Pz]; % Ursprung 

Ori_Kosys = eye(3)*s; 

Pos_KOSYS= [Px    Px    Px;  % Endpunkte der Achsen des KOSYS (x,y,z)
            Py    Py    Py;
            Pz    Pz    Pz];

axis_tr = Ori_Kosys*T(1:3,1:3)+Pos_KOSYS; % Transformation der Endpunkte
    
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
    
    if plot_DH==1

    figure(1)
    box on  
    grid on
    hold on
    % Plot Verbindung zwischen einzelnen Koordinatensystemen
    plot3([x_con(1,1) x_con(2,1)],[x_con(1,2) x_con(2,2)] ,[x_con(1,3) x_con(2,3)],'-','Color',[0 255 0]/255,'LineWidth',1) 
    plot3([y_con(1,1) y_con(2,1)],[y_con(1,2) y_con(2,2)] ,[y_con(1,3) y_con(2,3)],'-','Color',[0 0 255]/255,'LineWidth',1)
    plot3([z_con(1,1) z_con(2,1)],[z_con(1,2) z_con(2,2)] ,[z_con(1,3) z_con(2,3)],'-','Color',[255 0 0]/255,'LineWidth',1)
    % Plot Endpunkte
    plot3(P_orig(1),P_orig(2),P_orig(3),'.','Color',[0 0 0]/255,'LineWidth',6)
    plot3(x_axis(1),x_axis(2),x_axis(3),'.','Color',[0 255 0]/255,'LineWidth',6)
    plot3(y_axis(1),y_axis(2),y_axis(3),'.','Color',[0 0 255]/255,'LineWidth',6)
    plot3(z_axis(1),z_axis(2),z_axis(3),'.','Color',[255 0 0]/255,'LineWidth',6)

    text(P_orig(1)-s/5,P_orig(2)+s/5,P_orig(3)+s/5,sprintf('A %d', nr),'fontsize',8); % Beschriftung Punkt B
     %% Plot Kreis um z-Achse (unter Berücksichtigung der TRAFO)
    r=s; % Radius Kreis

        j=1
        for ang=0:0.1:2*pi; % Kreis mit Auflösung 0.1   

        circ_s(:,j) = [r*cos(ang); % Kreispunkte 
                       r*sin(ang);
                               0];      

        P_circ(:,j)=T(1:3,1:3)*circ_s(:,j)+P_orig; % Position

        j=j+1;

        end 
     
    plot3(P_circ(1,:),P_circ(2,:),P_circ(3,:),':','Color',[0 0 0]/255,'LineWidth',1);
end

end