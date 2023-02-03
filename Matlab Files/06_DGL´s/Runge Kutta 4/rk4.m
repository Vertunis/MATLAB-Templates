function [ output_args ] = rk4( f,x1,y1,x,ilt)
%rk4 It is a 2nd order Runge-Kutta method for solving ordinary differential
%equations 
%
%www.Extremevoltages.blogspot.com
%
%otomanb@gmail.com
%
% rk4(function,x0,y(x0)=y1,initially x=#, # of ilternation



h=x/ilt
x(1)=x1;
y(1)=y1;

fun=inline(f);
for i=1:ilt
    

fprintf('\nilteration number= %d\n',i)

k1=fun(x(i),y(i))

k2=fun(x(i)+0.5*h , y(i)+0.5*h*k1)

k3=fun(x(i)+0.5*h , y(i)+0.5*k2*h)

k4=fun(x(i)+h , y(i)+k3*h)

y(i+1)=y(i)+ (1/6)*h*(k1+(2*k2)+(2*k3)+k4)

x(i+1)=x(i)+h;


end

