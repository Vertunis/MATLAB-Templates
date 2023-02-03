%%Erzeugt die 3 Vektorkoordinaten der Rotationsachse
function [n] = func_Quat2Kartesian(q)

a=q(1);
b=q(2);
c=q(3);
d=q(4);

w=2*acos(a);

n_x = b/sin(w/2);
n_y = c/sin(w/2);
n_z = d/sin(w/2);

n=[n_x;n_y;n_z];

end