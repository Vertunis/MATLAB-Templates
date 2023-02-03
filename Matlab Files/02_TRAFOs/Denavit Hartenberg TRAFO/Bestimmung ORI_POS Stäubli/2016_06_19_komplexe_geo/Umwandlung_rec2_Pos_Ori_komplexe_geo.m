%% rec2mat
clc
clear all

file_rec = 'Recorddaten/record_2.rec';
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

save('Rec2pos/2016_06_19_Achswinkel_mat','valueTable');

Joints_degr = valueTable*(180/pi); % Winkel in Grad umrechnen

% Joints_degr=[0 90 0 0 0 0]; % Test

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

% DH_Par=[theta, d, a, alpha]
DH_Par=...   % eigene ermittelte DH Parameter (3.11.2016)
[   theta(1),     0.320,                 0, -90; %Transformation Joint 0-1
-90+theta(2),     0.035,             0.225,   0; %Transformation Joint 1-2      
 90+theta(3),         0,                 0,  90; %Transformation Joint 2-3 
    theta(4),     0.225,                 0, -90; %Transformation Joint 3-4   
    theta(5),         0,                 0,  90; %Transformation Joint 4-5
    theta(6),0.065+0.01,                 0,   0; %Transformation Joint 5-6 Handflansch (mit Adapter 0,01m)        
           0,   0.0935+(0.0017),   -0.0075,   0; %Transformation Joint 6-7 
          90,         0,                 0, -90; %Transformation Joint 7-8
         -90,         0,                 0,   0; %Transformation Joint 8-9 Rotationspunkt R (mit Ori entsprechend der Roboterbasis während des Gießvorganges)
          90,     0.150,           0.017/2,   0; %Transformation Joint 9-10   
         -90,         0,                 0,   0];%Transformation Joint 10-11 Gießschnauze P der Flasche (mit Ori entsprechend der Roboterbasis während des Gießvorganges)

%% Bestimmung der Transformationsmatrizen
% Durchläuft alle Zeilen der DH Parameter und bestimmt jeweils die
% Transformationsmatrix bTt und den Vektor B_T
    
    for n = 1:1:size(DH_Par,1) % 1 bis Zeilenlänge DH_PAR (11)  

    TCP_P=[0;0;0;1];  % TCP bezüglich TCP-Kosys in homogener Beschreibung
    bTt{1}=eye(4); % Start-Transformation in homogener Beschreibung (für ersten Wert)

    T{n}=DenavitTrafo2(DH_Par(n,1),DH_Par(n,2),DH_Par(n,3),DH_Par(n,4)); % Denvavit-Hartenberg Transformationen jedes Schrittes in Cell Array 
    bTt{n+1}=bTt{n}*T{n}; % Transformationsmatrix TCP bezüglich Basis 
    B_T{n+1}=bTt{n+1}*TCP_P; % Position des TCP bezüglich BasisKosys B: (Transformationsmatrix*Vektor) -> Beide homogen

    % nr=i; % Nummer der aktuellen Achse für Plot
    % plotKOSYS(s,B_T{i+1},bTt{i+1},nr,plot_DH(i)) % Plot der KOSYS der einzelnen Achsen

    end

%% Positionen

% Rotationspunkt bezüglich BasisKosys B benötigt bTh (befindet sich auf n=9
% jedoch muss aufgrund b_T{n+1} eins dazuaddiert werden)
B_H=B_T{6+1};  
H_pos_m(i,:)=B_H(1:3,1);

% Rotationspunkt bezüglich BasisKosys B benötigt bTh (befindet sich auf n=9
% jedoch muss aufgrund b_T{n+1} eins dazuaddiert werden)
B_R=B_T{9+1};  
R_pos_m(i,:)=B_R(1:3,1);

% TCP bezüglich BasisKosys B benötigt bTh (befindet sich auf n=11 jedoch
% muss aufgrund bTt{n+1} eins dazuaddiert werden)
B_TCP=B_T{11+1};   
TCP_pos_m(i,:)=B_TCP(1:3,1);

%% Orientierung 
% Bestimmung der Orientierung für alle Achsen 1:n_DH  (zyx-Konvention)

[H_ori] = ori_TCP(bTt{6+1});  %befindet sich auf n=6 (siehe DH_PAR) jedoch muss aufgrund bTt{n+1} eins dazuaddiert
H_ori_m(i,:)=H_ori;

% Rotationspunkt
[R_ori] = ori_TCP(bTt{9+1});  %befindet sich auf n=9 (siehe DH_PAR) jedoch muss aufgrund bTt{n+1} eins dazuaddiert
R_ori_m(i,:)=R_ori;

% TCP
[TCP_ori] = ori_TCP(bTt{11+1}); %befindet sich auf n=11 (siehe DH_PAR) jedoch muss aufgrund bTt{n+1} eins dazuaddiert
TCP_ori_m(i,:)=TCP_ori;

end

% Speichern der Werte

save('Rec2pos/Pos_H','H_pos_m');
save('Rec2pos/Ori_H','H_ori_m');
save('Rec2pos/Pos_R','R_pos_m');
save('Rec2pos/Ori_R','R_ori_m');
save('Rec2pos/Pos_TCP','TCP_pos_m');
save('Rec2pos/Ori_TCP','TCP_ori_m');

