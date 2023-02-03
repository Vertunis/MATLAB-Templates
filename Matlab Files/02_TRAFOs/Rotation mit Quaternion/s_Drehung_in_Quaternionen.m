%% Drehung in Quaternionen-Beschreibung
% Anleitung auf https://www.youtube.com/watch?v=C5g62Cy6WLA
% 
% Linearkombination aus 3 Imaginär und einem Realteil
% q= a*1 + b*i + c*j + d*k
% 
% a*1 (1=eins) -> Realteil
% b*i + c*j + d*k -> Imaginärteil
% 
% b,c,d spannen in einem Kosys K den Dreh-Vektor zum Urpsurng auf um den die
% Rotation statt finden soll

%% Beispiel Quaternion in Eulerwinkel und Kartesisch KOSYS darstellen
clear all

a=360; %% Drehung umRotationsvektor in Grad
b=1; % X-Achse
c=0; % Y-Achse
d=0; % Z-Achse
q = [a, b, c, d];

q_eh = func_EinheitsQuat(q); %%q_eh=q/q_betrag; % Bildet Einheitsquaternion

rad_eul = func_Quat2Eul(q_eh); % Erzeugt Eulerwinkel aus Quaternion [in Rad] 
deg_eul = rad_eul*180/pi % Umrechnung der Eulerwinkel in Grad
n = func_Quat2Kartesian(q_eh) % Erzeugt x,y,z als Kartesische Koordinaten
[RotMatr] = func_Quat2RotMatrix(q_eh);

% Plottet eines 3D-Kosys mit Doppelter Weite 2*(x,y,z)
func_Plot3D_KOSYS(1,n,2,2,2);  % func_Plot3D_KOSYS(fig,n,x,y,z)


%% Beispiel 1 
%  Eulerwinkel in Quaternion umrechnen
%  https://www.youtube.com/watch?v=8sdNyJ7I-Tk

q = func_Eul2Quat(rad_eul) % Sollte dem Normierten Quaternion q_eh entsprechen
% Als Kontrolle mit q_eh Vergleichen


%% Beispiel 2 
%  Verkettung von 2 Quaternionen aka Drehung um Quaternion q dann um Quaternion p 

a1=90; %% Drehung umRotationsvektor in Grad
b1=1; % X-Achse
c1=0; % Y-Achse
d1=0; % Z-Achse
q = [a1, b1, c1, d1];

a2=90; %% Drehung umRotationsvektor in Grad
b2=0; % X-Achse
c2=0; % Y-Achse
d2=1; % Z-Achse
p = [a2, b2, c2, d2];

% Bildung der Einheitsquaternion
q_eh = func_EinheitsQuat(q);
p_eh = func_EinheitsQuat(p);

qp = func_Quat_Multiplikation(q_eh,p_eh);

rad_eul_qp = func_Quat2Eul(qp); % Erzeugt Eulerwinkel aus Quaternion [in rad] 
deg_eul_qp = rad_eul*180/pi; % Umrechnung der Eulerwinkel in Grad
n_qp = func_Quat2Kartesian(qp) % Erzeugt x,y,z als Kartesische Koordinaten

% Plottet eines 3D-Kosys mit Doppelter Weite 2*(x,y,z)
func_Plot3D_KOSYS(2,n_qp,2,2,2);  % func_Plot3D_KOSYS(fig,n,x,y,z)
