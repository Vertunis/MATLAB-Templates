for i=1:1:10/0.01;
theta(i,:)=[90,90,-90,0,0,0];
end

for i=1:length(theta(:,1));

% DH_Par=[theta, d, a, alpha]
DH_Par=...   % eigene ermittelte DH Parameter (24.10.2016)
[   theta(1),     0.320,                 0, -90; %Transformation Joint 0-1
-90+theta(2),     0.035,             0.225,   0; %Transformation Joint 1-2      
 90+theta(3),         0,                 0,  90; %Transformation Joint 2-3 
    theta(4),     0.225,                 0, -90; %Transformation Joint 3-4   
    theta(5),         0,                 0,  90; %Transformation Joint 4-5
    theta(6),0.065+0.01,                 0,   0; %Transformation Joint 5-6 Handflansch (mit Adapter 0,01m)        
           0,   0.0935+(0.0017),   -0.0075,   0; %Transformation Joint 6-7 Rotationspunkt R
          90,         0,           0.017/2, -90; %Transformation Joint 7-8
           0,      0.15,                 0,   0; %Transformation Joint 8-9 TCP Gie?schnauze Flasche P
           0,         0,                 0,   0];%Transformation Joint 9-10   
%% Bestimmung der Transformationsmatrizen

T01=DenavitTrafo2(DH_Par(1,1),DH_Par(1,2),DH_Par(1,3),DH_Par(1,4)); % Transformation von joint 0 zu 1
T12=DenavitTrafo2(DH_Par(2,1),DH_Par(2,2),DH_Par(2,3),DH_Par(2,4));
T23=DenavitTrafo2(DH_Par(3,1),DH_Par(3,2),DH_Par(3,3),DH_Par(3,4));
T34=DenavitTrafo2(DH_Par(4,1),DH_Par(4,2),DH_Par(4,3),DH_Par(4,4));
T45=DenavitTrafo2(DH_Par(5,1),DH_Par(5,2),DH_Par(5,3),DH_Par(5,4));
T56=DenavitTrafo2(DH_Par(6,1),DH_Par(6,2),DH_Par(6,3),DH_Par(6,4));
T67=DenavitTrafo2(DH_Par(7,1),DH_Par(7,2),DH_Par(7,3),DH_Par(7,4)); % Handflansch H
T78=DenavitTrafo2(DH_Par(8,1),DH_Par(8,2),DH_Par(8,3),DH_Par(8,4));
T89=DenavitTrafo2(DH_Par(9,1),DH_Par(9,2),DH_Par(9,3),DH_Par(9,4)); % TCP des Greifers unter ber?cksichtigung der Greifer Geometrie
T910=DenavitTrafo2(DH_Par(10,1),DH_Par(10,2),DH_Par(10,3),DH_Par(10,4)); % TCP des Greifers unter ber?cksichtigung der Ladle-Geometrie


bTh=  T01*T12*T23*T34*T45*T56%*T67; % Beschreibung von Transformationsmatrix T welche B zum Handlfansch H beschreibt
bTtcp=T01*T12*T23*T34*T45*T56*T67*T78*T89*T910; % Beschreibung von Transformationsmatrix T welche B zum TCP beschreibt

H_P=[0;0;0;1];% Handflansch bez?glich HandflanschKosys in homogener Beschreibung
B_H=bTh*H_P;   % Handflansch bez?glich BasisKosys B ben?tigt bTh
R_pos(i,:)=B_H(1:3,1)';
% Umgerechnete Positionsdaten in Vektor schreiben
R_pos_m(i,:)=R_pos(i,:);

TCP_P=[0;0;0;1];  % TCP bez?glich TCP-Kosys in homogener Beschreibung
B_TCP=bTtcp*TCP_P;   % TCP bez?glich BasisKosys B ben?tigt bTh
TCP(i,:)=B_TCP(1:3,1)';
% Umgerechnete Positionsdaten in Vektor schreiben
TCP_pos_m(i,:)=TCP(i,:);


%% Orientierung 
n_x=bTh(1,1); % =bTtcp(1,1); % B zu H oder B zu TCP ? 
n_y=bTh(2,1); % =bTtcp(2,1);
n_z=bTh(3,1); % =bTtcp(3,1);
o_x=bTh(1,2); % =bTtcp(1,2);
o_y=bTh(2,2); % =bTtcp(2,2);
o_z=bTh(3,2); % =bTtcp(3,2);
a_x=bTh(1,3); % =bTtcp(1,3);
a_y=bTh(2,3); % =bTtcp(2,3);
a_z=bTh(3,3); % =bTtcp(3,3);

%Problem: arctan ist mehrdeutig, gilt immer 
%nur in einem Quadranten oft wird die erweiterte arctan-Funktion
%verwendet: atan2
phi_z=atan2(n_y,n_x); 
phi_y=atan2((-n_z),(n_x*cos(phi_z)+n_y*sin(phi_z)));
phi_x=atan2((a_x*sin(phi_z)-a_y*cos(phi_z)),(o_y*cos(phi_z)-o_x*sin(phi_z)));

TCP_ori_m(i,:)=[phi_x*180/pi, phi_y*180/pi, phi_z*180/pi]; %Zusammenfassung + Umrechnung in Winkel
end

save('Rec2pos/2016_06_19_Pos_R_aus_Achswinkel','TCP_pos_m');
save('Rec2pos/2016_06_19_Ori_R_aus_Achswinkel','TCP_ori_m');

%Ziel R bez?glich B zu beschreiben
% H_P=[-7.5;0;91.79;1]; % TCP bez?glich Handflansch in Homogener Transformation