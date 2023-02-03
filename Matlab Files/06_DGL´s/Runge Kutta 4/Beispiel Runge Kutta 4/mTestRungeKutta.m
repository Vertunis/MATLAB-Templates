%Anfangsbedingungen
x=[0;70.5;0;0;0];
u_in=0.04;
deltaT=0.01;

for k=0:0.01:34 % k=0:deltaT:Dauer der Simulation 
x1=TestRungeKutta(x, u_in, deltaT); 
x=x1
end

