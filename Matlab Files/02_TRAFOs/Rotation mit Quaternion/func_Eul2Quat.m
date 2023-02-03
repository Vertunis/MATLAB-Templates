function q = func_Eul2Quat(rad_eul)
%Realteil a:

psi = rad_eul(3); % Rotation um z
theta = rad_eul(2); % Rotation um y
phi = rad_eul(1); % Rotation um x

a= cos(psi/2)*cos(theta/2)*cos(phi/2)+sin(psi/2)*sin(theta/2)*sin(phi/2);
b= cos(psi/2)*cos(theta/2)*sin(phi/2)-sin(psi/2)*sin(theta/2)*cos(phi/2);
c= cos(psi/2)*sin(theta/2)*cos(phi/2)+sin(psi/2)*cos(theta/2)*sin(phi/2);
d= sin(psi/2)*cos(theta/2)*cos(phi/2)-cos(psi/2)*sin(theta/2)*sin(phi/2);

q=[a b c d];

end 
