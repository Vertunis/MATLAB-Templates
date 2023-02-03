function plotArmseg_2(s,B_T0,B_T1,j)

s=s/4 % Kleiner Als Spannweite Kosys

for t = 0:1:1 % Geradengleichung mit 2 Punkten erstellen
    i=t+1;
con_ges(i,:)=B_T0(1:3)+t*(B_T1(1:3)-B_T0(1:3))

end

%% Plot KOSYS Urpsrung: O (schwarz), x (grün),y (blau),z (rot)

figure(1)
box on  
grid on
hold on

% Plot Verbindung zwischen einzelnen Koordinatensystemen
if j <= 7

    plot3([con_ges(1,1) con_ges(2,1)],[con_ges(1,2) con_ges(2,2)] ,[con_ges(1,3) con_ges(2,3)],'-','Color',[205 102 0]/255,'LineWidth',8) 
elseif j >= 7
    
    plot3([con_ges(1,1) con_ges(2,1)],[con_ges(1,2) con_ges(2,2)] ,[con_ges(1,3) con_ges(2,3)],'-','Color',[0 0 0]/255,'LineWidth',4)
    
end