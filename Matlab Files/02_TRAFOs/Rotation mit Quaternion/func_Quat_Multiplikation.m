%%Eine Doppelte Drehung erst um q dann um p
% Quelle: https://mathepedia.de/Quaternionen.html
function [qp] = func_Quat_Multiplikation(q,p)

x0=q(1);
x1=q(2);
x2=q(3);
x3=q(4);

y0=p(1);
y1=p(2);
y2=p(3);
y3=p(4);


qp=[x0*y0 - x1*y1 - x2*y2 - x3*y3;...
    x0*y1 + x1*y0 + x2+y3 - x3*y2;...
    x0*y2 - x1*y3 + x2*y0 + x3*y1;...
    x0*y3 + x1*y2 - x2*y1 + x3*y0];

end