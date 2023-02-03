function [T]=EulerXYZ(alpha,beta,gamma,a,b,c)


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

%% Transformatuionsmatrizen

% Rotation um x-Achse um Winkel alpha
Rot_x_alpha=[1 0 0 0;0 cos((pi/180)*alpha) -sin((pi/180)*alpha) 0;0 sin((pi/180)*alpha)  cos((pi/180)*alpha) 0;0 0 0 1];

% Translation entlang x-Achse um a
Trans_x_a=[1 0 0 a;0 1 0 0;0 0 1 0;0 0 0 1];


% Rotation um y-Achse um Winkel beta
Rot_y_beta=[cos((pi/180)*beta) 0 sin((pi/180)*beta) 0;0 1 0 0;-sin((pi/180)*beta) 0 cos((pi/180)*beta) 0;0 0 0 1];

% Translation entlang y-Achse um b
Trans_y_b=[1 0 0 0;0 1 0 b;0 0 1 0;0 0 0 1];

% Rotation um z-Achse um Winkel gamma
Rot_z_gamma=[cos((pi/180)*gamma) -sin((pi/180)*gamma) 0 0;sin((pi/180)*gamma) cos((pi/180)*gamma) 0 0;0 0 1 0;0 0 0 1];

% Translation entlang z-Achse um c
Trans_z_c=[1 0 0 0;0 1 0 0;0 0 1 c;0 0 0 1];

%% neue Transformationmatrix T
T=Rot_x_alpha*Rot_y_beta*Rot_z_gamma*Trans_x_a*Trans_y_b*Trans_z_c;