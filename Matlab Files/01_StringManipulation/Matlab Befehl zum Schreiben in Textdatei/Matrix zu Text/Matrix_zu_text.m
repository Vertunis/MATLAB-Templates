% Erzeugen eines Vektors bzw Matrix anschließend speichern als Text(csv)-Datei

v=rand(46000,1);  %dein Vektor, ich gehe einfach mal von einem Spaltenvektor aus
M=rand(46000,6); % deine Matrix
dlmwrite('matrix.csv',[v,M],'delimiter',';','newline','pc'); %schreiben der txt Datei
%Einlesen geht dann so:
A=dlmread('matrix.csv',';');

% Weitere Infos zu dlmwrite auf http://matlab.izmiran.ru/help/techdoc/ref/dlmwrite.html

% Das Dateiformat CSV steht für englisch Comma-separated values (seltener Character-separated values[1]) und
% beschreibt den Aufbau einer Textdatei zur Speicherung oder zum Austausch einfach strukturierter Daten.
% Die Dateinamenserweiterung lautet .csv.