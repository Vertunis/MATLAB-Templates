function [q_eh] = func_EinheitsQuat(q)

%% q = [a, b, c, d];

a=q(1);
b=q(2);
c=q(3);
d=q(4);

q_betrag = sqrt(a^2+b^2+c^2+d^2); % Erzeugt den Betrag der Einheitsquaternion |q|

q_eh=q/q_betrag;

end