% Symbolische Variablen erzeugen
syms x(t) % das (t) macht die Variable zeitabh�ngig
syms alpha(t)

f=x*cos(alpha)

df=diff(f,t)

pretty(df) % l�sst Funktion sch�ner darstellen