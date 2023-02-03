% Abrunden

load MayaAxis.mat
round_low = floor( mayaAxis.data .* 10) ./ 10; % Komplette Matrix abrunden

% Runden auf beliebige Nachkommastelle N
x=555.555;
N=1; % Um auf Stelle vor dem Komma zu Runden N=-1
r=round(x,N)

round_normal = round( mayaAxis.data,N); % Komplette Matrix abrunden