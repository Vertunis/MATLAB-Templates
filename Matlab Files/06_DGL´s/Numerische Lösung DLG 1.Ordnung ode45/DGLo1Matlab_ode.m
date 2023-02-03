function [dw] = DGLo1Matlab_ode(w,u)

%Motormodell mit w=Winkelgeschwindigkeit, T_t =Zeitkonstante des Motors,
%K_t=Verstärkungsfaktor

%Differenatialgleichung Motor: dw+w*(1/(T_t)-(K_t/T_t)*u
K_t=1;
T_t=0.06;


dw=w*(-1/(T_t))+u*(K_t/T_t);

end

