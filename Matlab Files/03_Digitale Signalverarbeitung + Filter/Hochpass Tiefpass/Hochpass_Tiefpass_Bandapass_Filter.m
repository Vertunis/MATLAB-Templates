% BUTTER-Filter http://www.mikrocontroller.net/topic/142356
% s: Signal
% fs: Abtastfrequenz
% n: Filterordnung
% lowFreq: untere Grenzfrequenz
% hiFreq: obere Grenzfrequenz
% y : gefiltertes Signal
[b,a]=butter(n,lowFreq/(fs/2),'high'); %Hochpassfilter
y = filter(b,a,s);

[b,a]=butter(n,hiFreq/(fs/2),'low'); %Tiefpassfilter
y = filter(b,a,s);

% http://stackoverflow.com/questions/17340198/what-is-the-command-for-butterworth-bandpass-filter

[b,a] = butter(n, [lowFreq hiFreq]/(fs/2), 'bandpass'); % Bandpass
y = filter(b,a,x);