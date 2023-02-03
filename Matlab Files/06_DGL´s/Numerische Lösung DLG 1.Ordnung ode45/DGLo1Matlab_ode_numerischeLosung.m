%% Numerische Lösung der Differenzialgleichung 
% (Add to path) aus der Funktion: DGLo1Matlab_ode
% im Bereich -1 bis 1 mit Randbedingung w0

w0 =  1
ta = -1; %Startwert
te =  1; %Endwert

[w,u] = ode45(@DGLo1Matlab_ode,[ta te],w0)