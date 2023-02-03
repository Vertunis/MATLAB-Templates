function plotKOSYS_0(s,P,l_seg)

% s: Spannweite KOSYS
% P: Koordinaten Anfangspunkt 
% l_seg: Segmentlänge in z
%% Endpunkte
ox= P(1,1);
oy= P(2,1);
oz= P(3,1);

O_orig = [ox   oy   oz]; % Ursprung 
% x_axis = [ox+s oy   oz]; % Koordinatenachsen
% y_axis = [ox   oy+s oz];
% z_axis = [ox   oy oz+s];
% 
% % Verbindungspunkte Ursprung zu xyz
% for t = 0:1:1 % Geradengleichung mit 2 Punkten erstellen
%     i=t+1
% x_con(i,:)=O_orig+t*(x_axis-O_orig);
% y_con(i,:)=O_orig+t*(y_axis-O_orig);
% z_con(i,:)=O_orig+t*(z_axis-O_orig);
% end
% 
% con_ges{1}=x_con';
% con_ges{2}=y_con';
% con_ges{3}=z_con';

figure(1)
box on  
grid on
hold on

%% Plot Armsegment auf Basis des Kreises
r_seg=s/4;
for ang=0:pi/4:2*pi;
    for i = 0:0.02:l_seg

    x_circ_seg=r_seg*cos(ang)+O_orig(1);
    y_circ_seg=r_seg*sin(ang)+O_orig(2);
    z_circ_seg=i+O_orig(3);
    plot3(x_circ_seg,y_circ_seg,z_circ_seg,'.','Color',[205 102 0]/255,'LineWidth',3);
    end
end


end