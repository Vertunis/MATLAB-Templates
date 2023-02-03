% Symbolische Variablen erzeugen
syms x(t) % das (t) macht die Variable zeitabhängig
syms alpha(t)

f=x*cos(alpha)

df=diff(f,t)

pretty(df) % lässt Funktion schöner darstellen