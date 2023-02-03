%%Differentialgleichungen des Gießroboters

%%Motormodell mit Omega = w, T_t =Zeitkonstante des Motors,
%%K_t=Verstärkungsfaktor

%%inhomogene Differenatialgleichung(Ordnung 1) Motor: dw(t)+w(t)*(1/(T_t)-(K_t/T_t)*u(t)

syms w u %T_t K_t

%T_t=0.006; 
%K_t=24.58;
%Randbedingung w(0)==0
%Wichtig Bei DGL w und u müssen vorne Stehen vor Konstanten
w=dsolve('Dw+w*(1/(T_t))=u*(K_t/T_t)','w(0)==0') 

