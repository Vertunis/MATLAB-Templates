function [TCP_ori] = ori_TCP(bTt)

%% Input: bTt aktuelle Transformationsmatrix von Basis zu Tool
%% Orientierung TCP in zyx-Konvention
n_x=bTt(1,1); % B zu H oder B zu TCP ? 
n_y=bTt(2,1);
n_z=bTt(3,1);
o_x=bTt(1,2);
o_y=bTt(2,2);
o_z=bTt(3,2);
a_x=bTt(1,3);
a_y=bTt(2,3);
a_z=bTt(3,3);

%Problem: arctan ist mehrdeutig, gilt immer 
%nur in einem Quadranten oft wird die erweiterte arctan-Funktion
%verwendet: atan2
phi_z=atan2(n_y,n_x); 
phi_y=atan2((-n_z),(n_x*cos(phi_z)+n_y*sin(phi_z)));
phi_x=atan2((a_x*sin(phi_z)-a_y*cos(phi_z)),(o_y*cos(phi_z)-o_x*sin(phi_z)));

TCP_ori=[phi_x*180/pi, phi_y*180/pi, phi_z*180/pi]; % Umrechnung in Winkel zyx-Konvention

end