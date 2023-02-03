%% Information Roboter TCP
%% Berechnung Orientierung im Raum

% Koordinantensysteme (
% B:Basis d. Roboters
% O: Zielpunkt des Gießens
% R: Rotationspunk 
% P: Gießsschauze
% W: Weltkoordinatensystem 
% G: Auftreffpunkt Flüssigkeit

% Koordinatensysteme Von O G W schauen in die
% Gleichen Richtungen

% Beschreibung der Transformation als Homogene Transformation
%{ 
Bsp (nx ox ax  px)  
    (ny oy ay  py)
    (nz oz az  pz)
    (0  0  0    1)   
%}

%% Transformationsmatrix von Kosys A zu Kosys B mit Euler XYZ-Konvention
%input HarmTrafoXYZ(alpha,beta,gamma,x,y,z)
% Winkel in Grad im x,y,z in Meter

bTa=HarmTrafoXYZ(90,90,0,0,0,0)

