% Erzeugen eines Vektors bzw Matrix anschließend speichern als Text(csv)-Datei

for i=1:1:24
    
v(i,1)=i;  %dein Vektor, ich gehe einfach mal von einem Spaltenvektor aus
    for j=1:6
    M(i,j)=j; % deine Matrix
    end
end

dlmwrite('matrix.csv',[v,M],'delimiter',';','newline','pc'); %schreiben der txt Datei


%Einlesen geht dann so:
A=dlmread('matrix.csv',';');

% Weitere Infos zu dlmwrite auf http://matlab.izmiran.ru/help/techdoc/ref/dlmwrite.html

% Das Dateiformat CSV steht für englisch Comma-separated values (seltener Character-separated values[1]) und
% beschreibt den Aufbau einer Textdatei zur Speicherung oder zum Austausch einfach strukturierter Daten.
% Die Dateinamenserweiterung lautet .csv.