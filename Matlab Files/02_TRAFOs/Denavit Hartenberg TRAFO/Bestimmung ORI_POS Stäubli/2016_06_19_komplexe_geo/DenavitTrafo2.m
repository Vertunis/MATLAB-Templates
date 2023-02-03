function T = DenavitTrafo2(theta,d,a,alpha)

%Siehe Grundlagen Robotik S.122

% Einganswinkel in Grad
% Beschreibung der Transformation als Homogene Transformation
%{ 
Bsp Matrix 
    (nx ox ax  px)  
    (ny oy ay  py)
    (nz oz az  pz)
    (0  0  0    1)
   Bsp Vektor
    [0;0;0;1]
%}

sa=sin(alpha*(pi/180));
ca=cos(alpha*(pi/180));

st=sin(theta*(pi/180));
ct=cos(theta*(pi/180));

Rot_x_a=...
[1  0   0  0;
 0 ca -sa  0;
 0 sa  ca  0;
 0  0   0  1];

trans_x_a=...
[1 0 0 a;
 0 1 0 0;   
 0 0 1 0;
 0 0 0 1];

trans_z_d=...
[1 0 0 0;
 0 1 0 0;   
 0 0 1 d;
 0 0 0 1];

Rot_z_t=...
[ct -st   0  0;
 st  ct   0  0;
  0   0   1  0;
  0   0   0  1];

T=Rot_z_t*trans_x_a*trans_z_d*Rot_x_a;