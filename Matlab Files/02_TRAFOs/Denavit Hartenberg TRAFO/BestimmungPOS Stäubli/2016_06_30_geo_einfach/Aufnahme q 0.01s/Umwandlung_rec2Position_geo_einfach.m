%% rec2mat
clc
clear all

file_rec = 'Recorddaten/record.rec';
fid_rec = fopen(file_rec,'r');
binFile = fread(fid_rec);

% Read nuber of logged variables
nLoggedVars = hex2dec(reshape(dec2hex(binFile(73:-1:70))', [,], 1)') %invers order due to little endian - big endian difference
nLogEntries = hex2dec(reshape(dec2hex(binFile(77:-1:74))', [,], 1)') %invers order due to little endian - big endian difference

%read variable names
%var name format: [ASCII Varname Length 4 Bytes] [ASCII Variable Name] [Index 4 Bytes]
varNames = cell(1,nLoggedVars);
idxLength = 78;
lenLength = 4; 
lenIndex  = 4;

for iVars = 1:nLoggedVars
lenName         = hex2dec(reshape(dec2hex(binFile(idxLength+lenLength-1:-1:idxLength))', [,],1)');
idxName         = idxLength + 4;
idxIndex        = idxLength +lenLength + lenName;
Index           = hex2dec(reshape(dec2hex(binFile(idxIndex+lenIndex-1:-1:idxIndex))', [,],1)');
varNames{iVars} = [char(binFile(idxName : idxName+lenName - 1)'),num2str(Index)];
idxLength       = idxLength + lenLength + lenIndex + lenName;
end

szValueTable = nLogEntries * nLoggedVars * 8;
fseek(fid_rec, 0, 1);
szRecFile = ftell(fid_rec);
szHeader = szRecFile - szValueTable;
fseek(fid_rec, szHeader, -1);

values = fread(fid_rec, Inf, 'double',0, 'ieee-le');
fclose(fid_rec);

valueTable = reshape(values, [nLoggedVars, nLogEntries])';

save('Rec2Pos/2016_06_30_Achswinkel_mat','valueTable');

Joints_degr = valueTable*(180/pi); % Winkel in Grad umrechnen

%% kinematische Vorwärtstransformation
% mit Function [T]=DenavitTrafo(alpha,d,a,theta)
% Manipulator Abmessungen aus Manual in Bild: Abmessungen Roboter
% Alle Winkel in Grad und alle Translationen in [m]
% Ziel Beschreibung des TCP des Greifers bezüglich Basis aus Achswinkeln

%% STÄUBLI ROBOTER TX 40 DH-Parameter

theta=zeros(6,1);
TCP_pos_m=zeros(length(Joints_degr(:,1)),3);
TCP=zeros(length(Joints_degr(:,1)),3);
R_pos_m =zeros(length(Joints_degr(:,1)),3);
R_pos=zeros(length(Joints_degr(:,1)),3);

for i=1:length(Joints_degr(:,1)); % Ermittlung aller Daten aus valueTable

% Winkel
for k=1:6    
theta(k)=Joints_degr(i,k);
end

% DH_Par=[theta, d, a, alpha] 24.10.2016

DH_Par=...   % eigene ermittelte DH Parameter (3.11.2016)
[   theta(1),       0.320,         0, -90; %Transformation Joint 0-1
-90+theta(2),       0.035,     0.225,   0; %Transformation Joint 1-2     
 90+theta(3),           0,         0,  90; %Transformation Joint 2-3 
    theta(4),       0.225,         0, -90; %Transformation Joint 3-4   
    theta(5),           0,         0,  90; %Transformation Joint 4-5
    theta(6),       0.065,         0,   0; %Transformation Joint 5-6 Handflansch (ohne Adapter)        
           0,     0.10435,  (-0.007),   0; %Transformation Joint 6-7 
           90,          0,         0, -90; %Transformation Joint 7-8 
          -90,          0,         0,   0 %Transformation Joint 8-9 Rotationspunkt R
          -90,      0.015,     0.165,   0 %Transformation Joint 9-10
           90,          0,         0,   0]; %Transformation Joint 10-11 TCP Gießschnauze P Ladle_einfache_Geometrie 
%% Bestimmung der Transformationsmatrizen

T01=DenavitTrafo2(DH_Par(1,1),DH_Par(1,2),DH_Par(1,3),DH_Par(1,4)); % Transformation von joint 0 zu 1
T12=DenavitTrafo2(DH_Par(2,1),DH_Par(2,2),DH_Par(2,3),DH_Par(2,4));
T23=DenavitTrafo2(DH_Par(3,1),DH_Par(3,2),DH_Par(3,3),DH_Par(3,4));
T34=DenavitTrafo2(DH_Par(4,1),DH_Par(4,2),DH_Par(4,3),DH_Par(4,4));
T45=DenavitTrafo2(DH_Par(5,1),DH_Par(5,2),DH_Par(5,3),DH_Par(5,4));
T56=DenavitTrafo2(DH_Par(6,1),DH_Par(6,2),DH_Par(6,3),DH_Par(6,4));
T67=DenavitTrafo2(DH_Par(7,1),DH_Par(7,2),DH_Par(7,3),DH_Par(7,4)); % Handflansch H
T78=DenavitTrafo2(DH_Par(8,1),DH_Par(8,2),DH_Par(8,3),DH_Par(8,4));
T89=DenavitTrafo2(DH_Par(9,1),DH_Par(9,2),DH_Par(9,3),DH_Par(9,4)); % Rotationspunkt R
T910=DenavitTrafo2(DH_Par(10,1),DH_Par(10,2),DH_Par(10,3),DH_Par(10,4)); 
T1011=DenavitTrafo2(DH_Par(11,1),DH_Par(11,2),DH_Par(11,3),DH_Par(11,4)); % Gießschnauze P (TCP der Ladle)


bTh=  T01*T12*T23*T34*T45*T56*T67 % Beschreibung von Transformationsmatrix T welche B zum Handlfansch H beschreibt (nicht verwendet)
bTR=  T01*T12*T23*T34*T45*T56*T67*T78*T89; % Beschreibung von Transformationsmatrix T welche B zum Rotationspunkt R beschreibt 
bTtcp=T01*T12*T23*T34*T45*T56*T67*T78*T89*T910*T1011; % Beschreibung von Transformationsmatrix T welche B zum TCP beschreibt

H_P=[0;0;0;1];% Rotationspunkt bezüglich RotationspunktKosys in homogener Beschreibung
B_R=bTR*H_P;   % Handflansch bezüglich BasisKosys B benötigt bTR
R_pos(i,:)=B_R(1:3,1)';
% Umgerechnete Positionsdaten in Vektor schreiben
R_pos_m(i,:)=R_pos(i,:);

TCP_P=[0;0;0;1];  % TCP bezüglich TCP-Kosys in homogener Beschreibung
B_TCP=bTtcp*TCP_P;   % TCP bezüglich BasisKosys B benötigt bTh
TCP(i,:)=B_TCP(1:3,1)';
% Umgerechnete Positionsdaten in Vektor schreiben
TCP_pos_m(i,:)=TCP(i,:);

end

save('Rec2Pos/2016_06_30_P_rec','TCP_pos_m');
save('Rec2Pos/2016_06_30_R_rec','R_pos_m');
%Ziel R bezüglich B zu beschreiben
% H_P=[-7.5;0;91.79;1]; % TCP bezüglich Handflansch in Homogener Transformation
