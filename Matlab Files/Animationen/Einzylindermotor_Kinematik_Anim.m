%% Kinematik des Einzylindermotors A8: Animationsbeispiel
syms r l gamma delta          % symbolische Variablen definieren
% Ortsvektoren
r1 = [ r*sin(gamma) r*cos(gamma)];
r2 = [0 r*cos(gamma)+l*cos(delta)];

% Schleifen-Zwangsbedingung / Berechnung der Hilfsvariablen
sol = solve(r*sin(gamma)-l*sin(delta) == 0, delta);
delta_sol = sol(1);

% Beispielwerte
r = 0.5;
l = 2;
gamma_ = [1:200]*2*2*pi/200;  % 2 Umdrehungen in 200 Schritten

% Animation
h_fig = figure(1);

for idx = 1:length(gamma_)    % Zeitschritte durchiterieren
    % Werte einsetzen
    gamma = gamma_(idx);
    delta = eval(delta_sol);
    r1_ =eval(r1);
    r2_ =eval(r2);
    
    % Bild neu zeichnen
    figure(h_fig); cla;
    plot([0 r1_(1) r2_(1)],[0 r1_(2) r2_(2)],'-o','linewidth',2,'markersize',10)
    title('Kinematik des Einzylindermotors')
    axis equal
    ylim([-r r+l])
    xlim([-r r])
    pause(0.03)               % kurz halten und zeigen
end 