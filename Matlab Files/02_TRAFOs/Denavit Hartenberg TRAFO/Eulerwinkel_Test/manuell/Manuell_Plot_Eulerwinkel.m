%% Koordinatensystem nach DH-Plotten
close all

load 'TCP_Ori.mat'
%% Plot Einstellungen
% s: Spannweite KOSYS
% P: Koordinaten Anfangspunkt 
% xlim ylim zxlim:Beschränkungen des KOSYS
% xTicks,yTicks,zTicks: Auflösung Achsen
s=0.5;
xlim= [-1 1];
ylim= [-1 1];
zlim= [-1 1];
xTicks = 0.5; % Schrittweite x 
yTicks = 0.5; % Schrittweite y
zTicks = 0.5; % Schrittweite z

% Deklaration BasisKOSYS
P_0 =[0;0;0]; % Postion Ursprung

plotKOSYS_0(s,P_0,xlim,ylim,zlim,xTicks,yTicks,zTicks) % Plottet in figure(1)

%% Transformation

% n=length(TCP_ori);
c=2

switch c
    
    case 1 
      
        ang_eul=[90,0,0] %manuelle Eingabe
        
    case 2 
       
        n=12;
        ang_eul = TCP_ori{n} % Einlesen aus Vektor
        
end
        
    psi=ang_eul(3); % Drehung um z
    theta=ang_eul(2); % Drehung um y
    phi=ang_eul(1); % Drehung um x

    T= euler_zyx(psi,theta,phi); %Transformationsmatrix mit Eulertransformation zyx-Konvention
    
    bTt= eye(4)* T;
    

nr=1;

B_T=[0.1;0.1;0.1;1]; % Offset des zu betrachtenden KOSYS

plotKOSYS(s,B_T,bTt,nr,ang_eul) % Plot der KOSYS der einzelnen Achsen

