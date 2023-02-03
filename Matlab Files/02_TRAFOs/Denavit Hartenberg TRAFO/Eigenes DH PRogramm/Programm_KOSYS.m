%% Koordinatensystem nach DH-Plotten
close all
%% Plot Einstellungen
% s: Spannweite KOSYS
% P: Koordinaten Anfangspunkt 
% xlim ylim zxlim:Beschränkungen des KOSYS
% xTicks,yTicks,zTicks: Auflösung Achsen
s=0.05;
xlim= [-0.75 0.75];
ylim= [-0.75 0.75];
zlim= [ 0 1.5];
xTicks = 0.25; % Schrittweite x 
yTicks = 0.25; % Schrittweite y
zTicks = 0.25; % Schrittweite z

% Deklaration BasisKOSYS

B_T{1}=[0 ;0 ;0 ;1] % Postion Ursprung in Basis

plotKOSYS_0(s,B_T{1},xlim,ylim,zlim,xTicks,yTicks,zTicks) % Plottet in figure(1)

%% DH-Transformation

% load('Joints_degr.mat')

Joints_degr=[0 0 0 0 0 0];

for i=1:length(Joints_degr(:,1)); % Ermittlung aller Daten aus valueTable

n=6; %Anzahl der zu betrachtenden Achsen

    for k=1:n    
    theta(k)=Joints_degr(i,k); % Winkel
    end
end

n_DH=12 % Durchläuft n DH-Parameter

for i=1:n_DH
% DH_Par=[theta, d, a, alpha] 
DH_Par=...   % neue DH Parameter (12.12.2016)
[   theta(1),       0.320,                 0, -90; %Transformation Joint 0-1
    theta(2),       0.170,                 0,  90; %Transformation Joint 1-2
           0,       0.255,                 0,  90; %Transformation Joint 2-3 
    theta(3), 0.170-0.035,                 0, -90; %Transformation Joint 3-4
    theta(4),       0.225,                 0, -90; %Transformation Joint 4-5   
    theta(5),           0,                 0,  90; %Transformation Joint 5-6
    theta(6),  0.065+0.01,                 0,   0; %Transformation Joint 6-7 Handflansch (mit Adapter 0,01m) 
           0,  0.0935+(0.0017),      -0.0075,   0; %Transformation Joint 7-8 
          90,         0,                   0, -90; %Transformation Joint 8-9
         -90,         0,                   0,   0; %Transformation Joint 9-10 Rotationspunkt R (mit Ori entsprechend der Roboterbasis während des Gießvorganges)
          90,     0.150,             0.017/2,   0; %Transformation Joint 10-11   
         -90,         0,                 0,   0];%Transformation Joint 11-12 Gießschnauze P der Flasche (mit Ori entsprechend der Roboterbasis während des Gießvorganges)
     
plot_DH=[1;0;1;0;1;1;1;0;1;0;0;1]; % Entspricht der Zeilenanzahl von DH_Par, nur wenn = 1 dann wird dieses KOSYS gelottet 

%% Bestimmung der Transformationsmatrizen
TCP_P=[0;0;0;1];  % TCP bezüglich TCP-Kosys in homogener Beschreibung
bTt{1}=eye(4); % Start-Transformation in homogener Beschreibung

T{i}=DenavitTrafo2(DH_Par(i,1),DH_Par(i,2),DH_Par(i,3),DH_Par(i,4)); % Denvavit-Hartenberg Transformationen iedes Schrittes in Cell Array 
bTt{i+1}=bTt{i}*T{i}; % Transformationsmatrix TCP bezüglich Basis 
B_T{i+1}=bTt{i+1}*TCP_P; % Position des TCP bezüglich BasisKosys B: (Transformationsmatrix*Vektor) -> Beide homogen

nr=i; % Nummer der aktuellen Achse für Plot

plotKOSYS(s,B_T{i+1},bTt{i+1},nr,plot_DH(i)) % Plot der KOSYS der einzelnen Achsen

[TCP_ori{i}] = ori_TCP(bTt{i+1}); % Bestimmung der Orientierung für alle Achsen 1:n_DH  (zyx-Konvention)

end
j=0
for i = 1:n_DH % Plot des Roboters bis Handflansch
    j=j+1
% plotArmseg(s,B_T{1},DH_Par(1,2)) % Plottet Armsegmente
plotArmseg_2(s,B_T{i},B_T{i+1},j) % Plottet Armsegmente

end

save TCP_ori.mat