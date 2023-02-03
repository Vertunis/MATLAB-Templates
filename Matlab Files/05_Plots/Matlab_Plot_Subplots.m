figure(1);
hold(subplot(2,1,1),'on');
grid on
box on
set(gcf, 'color', [1 1 1]); % Hintergrund weiﬂ
subplot(2,1,1); %subplot(Anzahl insegesamt, Zeile 1, Spalte 1)
plot(t_plot,ws_wL);
plot(t_plot,ws_wLtoc(:,1),'k','LineWidth',1.5);
axis([startsim lengthsim -0.1 0.7]); %Achsen x y 
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Gewicht [kg]');  %Beschriftung y-Achse
legend('gemessenes Gewicht wL', 'Kompensationgewicht w_t_o_c')
title('Gemessenes Gewicht w_L und Kompensationsgewicht w_t_o_c');

hold(subplot(2,1,2),'on');
grid on
box on
subplot(2,1,2); %subplot(Anzahl insegesamt, Zeile 1, Spalte 2)
plot(t_plot,ws_wLc(:,1),'LineWidth',0.5);
axis([startsim lengthsim -0.1 0.7]); %Achsen x y 
xlabel('Zeit T [s]'); %Beschriftung x-Achse 
ylabel('Gewicht [kg]');  %Beschriftung y-Achse
legend('Gewicht w_L_c nach Gewichtskompensation'); %Legende 
title('Gewicht w_L_c nach Gewichtskompensation');