% Symbolische Variablen erzeugen
syms x;
syms y;

f1 = x.^2 + y.^2; % Funktion definieren

f_dot=diff(f1,x)
