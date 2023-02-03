%% https://www.gomatlab.de/tutorial-keine-angst-vor-dem-function-handle-t545.html
% http://matlab.izmiran.ru/help/techdoc/ref/function_handle.html
clear all;

%init polynom werte von curve fitting
p00 =       17.82;
p10 =       2.362; 
p01 =     0.02962; 
p20 =      -0.112; 
p11 =    0.006737;  
p02 =  -6.494e-05; 
p30 =  -0.0002888;  
p21 =   6.412e-05; 
p12 =  -3.558e-06; 
p03 =   2.922e-08; 
p40 =    1.58e-05;  
p31 =   -8.03e-07;  
p22 =  -3.418e-09;  
p13 =   7.046e-10;  
p04 =   -5.44e-12;
p50 =  -8.332e-08; 
p41 =   4.056e-09;  
p32 =   -1.75e-11;  
p23 =   6.692e-13;  
p14 =  -5.339e-14;  
p05 =   3.699e-16; 

rpm = [ 750.0  1222.2  1694.4  2166.7  2638.9  3111.1  3583.3  4055.6  4527.8  5000.0];
prct = [0  7.1  14.3  21.4  28.6  35.7  42.9  50.0  57.1  64.3  71.4  78.6  85.7  92.9  100.0];

%mypoly(50,3000);

trq = @(x,y)p00 + p10*x + p01*y + p20*x^2 + p11*x*y + p02*y^2 + p30*x^3 + p21*x^2*y + p12*x*y^2 + p03*y^3 + p40*x^4 + p31*x^3*y + p22*x^2*y^2 + p13*x*y^3 + p04*y^4 + p50*x^5 + p41*x^4*y + p32*x^3*y^2 + p23*x^2*y^3 + p14*x*y^4 + p05*y^5;

%matrix erstellen
z(15,10)=0;

%matrix befuellen
for i=1:length(rpm)
    for j=1:length(prct)
        z(j,i) = trq(prct(j),rpm(i));
    end;
end;

%auf 2 nachkomastellen runden
z=round(z,2);

%plot
surf(rpm,prct,z);
title('engine characteristic');
xlabel('speed in rpm');
ylabel('throttle in %');
zlabel('torque in Nm');

function trq = mypoly(x,y)
% x - prct
% y - rpm
%f(x,y) = p00 + p10*x + p01*y + p20*x^2 + p11*x*y + p02*y^2 + p30*x^3 + p21*x^2*y 
%                    + p12*x*y^2 + p03*y^3 + p40*x^4 + p31*x^3*y + p22*x^2*y^2 
%                    + p13*x*y^3 + p04*y^4 + p50*x^5 + p41*x^4*y + p32*x^3*y^2 
%                    + p23*x^2*y^3 + p14*x*y^4 + p05*y^5;

trq = p00 + p10*x + p01*y + p20*x^2 + p11*x*y + p02*y^2 + p30*x^3 + p21*x^2*y + p12*x*y^2 + p03*y^3 + p40*x^4 + p31*x^3*y + p22*x^2*y^2 + p13*x*y^3 + p04*y^4 + p50*x^5 + p41*x^4*y + p32*x^3*y^2 + p23*x^2*y^3 + p14*x*y^4 + p05*y^5;


end
                    
         