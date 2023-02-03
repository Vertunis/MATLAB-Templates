%Runge Kutta (Stufe4)
function xo = TestRungeKutta(x, varin, dT) 
% mit x als Zustandsvektor z.B. [omega;theta;h;w_0;w_L], 
% varin is the input argument (z.B. u_t) 
% dT is the sample time deltaT (tk+1 - tk) 

h = dT; %Schrittweite in Runge Kutta

%k-Werte
k1 = fx(x, varin);  
k2 = fx(x + k1*(h/2), varin);    
k3 = fx(x + k2*(h/2), varin);
k4 = fx(x + k3*h, varin);

xo = x + ((h)*(1/6)*(k1 +k2*2 + k3*2 + k4));

%the nonlinear differential equations are defined as follows.

function dx = fx(x, varin) 
%Funktion dx gibt alle k-Werte für alle Funktionen als Vektor aus 
%durch dx kann außerdem das Input Argument um z.B. k1*h/2 verschoben werden


%% Berechnung unserer aktuellen Geometrieparameter 
%A(Theta),dA(Theta)/dTheta, dV_s(Theta)/dTheta
%mit den Polynomen aus Parameter_RegelstreckeV5 

% Fläche A (Zeile 59 in Parameter_RegelstreckeV5)
pA=[-0.000282794812959369 0.150637966122916 -33.1464249309021 3856.41512152397 -250243.583395489 8589878.35829289 -121907918.240099];
G1=polyval(pA,x(2)); % A-Wert für entsprechenden WinkelTheta x(2)

%dA/dTheta (Zeile 63 in Parameter_RegelstreckeV5)
G2=(-(978120663756381*x(2)^5)/576460752303423488 + (848016360123765*x(2)^4)/1125899906842624 - (2332472296366795*x(2)^3)/17592186044416 + (12720519802940391*x(2)^2)/1099511627776 - (4299152026869887*x(2))/8589934592 + 4611655828185765/536870912);

%dV_s/dTheta (Zeile 138 139 in Parameter_RegelstreckeV5)
if x(2)<86 %erster Teil des Polynoms von Theta 70° bis 86°
G3=(-(46479802549403307*x(2)^6)/604462909807314587353088 + (21361084319617965*x(2)^5)/590295810358705651712 - (4084641645685135*x(2)^4)/576460752303423488 + (6655684570483847*x(2)^3)/9007199254740992 - (24367526405604867*x(2)^2)/562949953421312 + (5939435228182105*x(2))/4398046511104 - 4819178745928227/274877906944);
else if x(2)<103 %zweiter Teil des Polynoms von Theta 87° bis 104°
G3=(-(830872107047289*x(2)^3)/36893488147419103232 + (7383107598691485*x(2)^2)/1152921504606846976 - (5437096742658501*x(2))/9007199254740992 + 5304387443738957/281474976710656); 
    else G3=0;
    end
end

G=[(G1/1000000);(G2/1000000);(G3/1000)]; % Umrechnung auf [[m²];[m²/°];[m³/°]] 

%% Übergeordnete Parameter

%deltaT=0.01; %Zeit pro Abtastvorgang/Sample Time [s] 
rho=1000;    %Dichte Flüssigkeit [kg/m³]       

% Motorparameter P_t 

T_t=0.06; %[s]
K_t=24.58;    %[Deg/[Vs]  K_t/T_t [Deg/V] 
          %Ausgangsspannung Servo 5V (?)
          %-> Kippung um mindestens 103,5° !
% Parameter P_f (Gießprozess)

g=9.81; %Erdbeschleunigung [m/s²]
c=0.85; % 0<c<1 Flussratenkoeffizient
L_f=0.065; %Geometrie-Parameter der Gießschnauze [m]

%Parameter Weight Load 
T_L=0.1; %[s]
%% Nonlinear equations (müssen als DGL´s vorliegen!!!)

q=x(3)^(3/2)*c*L_f*(2*g)^(1/2);

dx1 = x(1)*(-1/T_t)+(K_t/T_t)*varin;        %f1(x,varin);
dx2 = x(1);                                 %f2(x,varin);
dx3 = 1/G(1)*(-q-x(3)*G(2)*x(1)-G(3)*x(1)); %f3(x,varin);
dx4 = rho*q;                                %f4(x,varin);
dx5 = (-1/T_L)*x(5)+1/T_L*x(4);          %f5(x,varin);

%Alle Variablen nochmel überprüfen bzw schaun ob in Workspace vorhanden so dass drauf zugegriffen werden kann[to-do]
dx = [dx1; dx2; dx3; dx4; dx5];


 
