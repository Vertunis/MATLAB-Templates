function rad_eul = func_Quat2Eul(q)

a=q(1);
b=q(2);
c=q(3);
d=q(4);

% Yaw   Gieren um z-Achse mit Drehwinkel psi
% Pitch Nicken um y-Achse mit Drehwinkel theta
% Roll  Rollen um x-Achse mit Drehwinkel phi

psi   =  atan(  2*(b*c + a*d) / (a^2+b^2-c^2-d^2) );
theta =  asin(2*(a*c-b*d));
phi   = -atan(2*(c*d+a*b)/ -(a^2-b^2-c^2+d^2));

rad_eul = [phi, theta, psi]; % (rX,rY,rZ)
end