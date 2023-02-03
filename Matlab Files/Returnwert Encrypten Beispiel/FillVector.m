clear all
z=7012010070
j=13

for i=1:1:j
y(j,1)=floor(mod(z,10^i)/(10^(i-1))); %

j=j-1;
if(j<=1)
    break; % Bricht die Schleife ab wenn j < 1;
end
end

x=floor(mod(z,10^1)/(10^(1-1)))