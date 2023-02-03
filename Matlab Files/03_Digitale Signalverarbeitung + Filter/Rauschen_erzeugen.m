minrauschen = -.1;
maxrauschen = .1;
x = 0:0.01:6*pi;
rauschen = (maxrauschen-minrauschen) .* rand(size(x)) - minrauschen; % Rauschanteil
signal = sin(x) %Signal
A=signal+rauschen; % Verrauschtes Signal

% save A.mat

figure(1)
hold on 
plot(x,A)
