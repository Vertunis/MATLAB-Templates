function T = euler_zyx(psi,theta,phi) % psi um z,theta um y,phi um x

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

s_psi=sin(psi*(pi/180));
c_psi=cos(psi*(pi/180));

s_theta=sin(theta*(pi/180));
c_theta=cos(theta*(pi/180));

s_phi=sin(phi*(pi/180));
c_phi=cos(phi*(pi/180));

Rot_z_psi=...
[ c_psi  -s_psi   0  0;
 s_psi    c_psi   0  0;
      0       0   1  0;
      0       0   0  1];

Rot_y_theta=...
[c_theta  0   s_theta  0;
       0  1         0  0;
 -s_theta 0   c_theta  0;
       0  0         0  1];

Rot_x_phi=...
[1     0      0  0;
 0 c_phi -s_phi  0;
 0 s_phi  c_phi  0;
 0     0      0  1];

T= Rot_z_psi*Rot_y_theta*Rot_x_phi