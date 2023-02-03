% load 2016_03_07_Achswinkel % Achspositionen aus rec2mat

Joints_degr = [0,90,0,0,0,0]; % Winkel in Grad umrechnen

%% kinematische Vorwärtstransformation
% mit Function [T]=DenavitTrafo(alpha,d,a,theta)
% Manipulator Abmessungen aus Manual in Bild: Abmessungen Roboter
% Alle Winkel in Grad und alle Translationen in [m]
% Ziel Beschreibung des TCP des Greifers bezüglich Basis aus Achswinkeln

%% STÄUBLI ROBOTER TX 40 DH-Parameter

theta=zeros(6,1);
TCP_pos_m=zeros(length(Joints_degr(:,1)),3);
TCP=zeros(length(Joints_degr(:,1)),3);

for i=1:length(Joints_degr(:,1)); % Ermittlung aller Daten aus valueTable

% Winkel
for k=1:6    
theta(k)=Joints_degr(i,k);
end

% DH_Par=[theta, d, a, alpha]
DH_Par=...   % eigene ermittelte DH Parameter Bierflasche (24.10.2016)
[   theta(1),     0.320,                 0, -90; %Transformation Joint 0-1
-90+theta(2),     0.035,             0.225,   0; %Transformation Joint 1-2      
 90+theta(3),         0,                 0,  90; %Transformation Joint 2-3 
    theta(4),     0.225,                 0, -90; %Transformation Joint 3-4   
    theta(5),         0,                 0,  90; %Transformation Joint 4-5
    theta(6),0.065+0.01,                 0,   0; %Transformation Joint 5-6 Handflansch (mit Adapter 0,01m)        
           0,   0.09179,           -0.0075,   0; %Transformation Joint 6-7 Rotationspunkt
          90,         0,           0.017/2, -90; %Transformation Joint 7-8
           0,      0.15,                 0,   0; %Transformation Joint 8-9 TCP Gießschnauze Flasche
           0,         0,                 0,   0];%Transformation Joint 9-10    
       
%% Bestimmung der Transformationsmatrizen

T01=DenavitTrafo2(DH_Par(1,1),DH_Par(1,2),DH_Par(1,3),DH_Par(1,4)); % Transformation von joint 0 zu 1
T12=DenavitTrafo2(DH_Par(2,1),DH_Par(2,2),DH_Par(2,3),DH_Par(2,4));
T23=DenavitTrafo2(DH_Par(3,1),DH_Par(3,2),DH_Par(3,3),DH_Par(3,4));
T34=DenavitTrafo2(DH_Par(4,1),DH_Par(4,2),DH_Par(4,3),DH_Par(4,4));
T45=DenavitTrafo2(DH_Par(5,1),DH_Par(5,2),DH_Par(5,3),DH_Par(5,4));
T56=DenavitTrafo2(DH_Par(6,1),DH_Par(6,2),DH_Par(6,3),DH_Par(6,4));  % Handflansch H
T67=DenavitTrafo2(DH_Par(7,1),DH_Par(7,2),DH_Par(7,3),DH_Par(7,4));
T78=DenavitTrafo2(DH_Par(8,1),DH_Par(8,2),DH_Par(8,3),DH_Par(8,4));
T89=DenavitTrafo2(DH_Par(9,1),DH_Par(9,2),DH_Par(9,3),DH_Par(9,4));
T910=DenavitTrafo2(DH_Par(10,1),DH_Par(10,2),DH_Par(10,3),DH_Par(10,4)); % TCP des Greifers unter berücksichtigung der Ladle-Geometrie

bTh=  T01*T12*T23*T34*T45*T56*T67; % Beschreibung von Transformationsmatrix T welche B zum Handlfansch H beschreibt
bTtcp=T01*T12*T23*T34*T45*T56*T67*T78*T89*T910; % Beschreibung von Transformationsmatrix T welche B zum TCP beschreibt

H_P=[0;0;0;1];% Handflansch bezüglich HandflanschKosys in homogener Beschreibung
B_H=bTh*H_P;   % Handflansch bezüglich BasisKosys B benötigt bTh
R_pos(i,:)=B_H(1:3,1)';
% Umgerechnete Positionsdaten in Vektor schreiben
R_pos_m(i,:)=R_pos(i,:)

TCP_P=[0;0;0;1];  % TCP bezüglich TCP-Kosys in homogener Beschreibung
B_TCP=bTtcp*TCP_P;   % TCP bezüglich BasisKosys B benötigt bTh
TCP(i,:)=B_TCP(1:3,1)';
% Umgerechnete Positionsdaten in Vektor schreiben
TCP_pos_m(i,:)=TCP(i,:)

end
%Ziel R bezüglich B zu beschreiben
% H_P=[-7.5;0;91.79;1]; % TCP bezüglich Handflansch in Homogener Transformation