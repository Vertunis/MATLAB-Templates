% people.inf.ethz.ch/arbenz/MatlabKurs/node74.html

% Mir der Funktion mesh können 3D-Maschenflächen geplottet werden. 
% Zu diesem Zweck ist es von Vorteil, zunächst eine weitere Funktion meshgrid einzuführen. 
% Diese Funktion generiert aus zwei Vektoren $ x$ (mit $ n$ Elementen) und $ y$ (mit $ m$ Elementen)
% ein Rechtecksgitter mit $ n\times m$ Gitterpunkten. 

figure(1)
x = -1:0.05:1; 
y = x; 
[xi, yi] = meshgrid(x,y); 
zi = yi.^2 - xi.^2;
mesh(xi, yi, zi) 
axis off
    
figure(2)
meshc(xi, yi, zi) %Kontour-Plot. 
axis off

figure(3)
surf(xi, yi, zi)
axis off