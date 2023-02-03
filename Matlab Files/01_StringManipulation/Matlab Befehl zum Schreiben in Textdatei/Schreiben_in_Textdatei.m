% Datei im Schreibmodus öffnen
fileID=fopen('Positionen_Steuerung.txt','w');

% Zeiger Setzen
frewind(fileID); % Setzt Zeiger auf Anfang der Datei
fseek(fileID, 0, 'bof'); % Entspricht dem Befehl darüber. 
%{
zu fseek(fileID,offset,origin):
origin:
'bof' or -1: Beginning of file
'cof' or 0: Current position in file
'eof' or 1: End of file 
%}


A=[511.111, 511.111, 511.111, 511.111; 511.111,511.111,511.111,511.111; 511.111,511.111,511.111,511.111; 511.111,511.111,511.111,511.111];


%-> %d (double %f (floating point) %s (String) %c (Char) sind Platzhalter für die nachfolgenden Einträge z.B A(i,1)
%->

for i=1:1:length(A(1,:))

fprintf(fileID,'movel(appro(%6.3f,%6.3f,%6.3f,%6.3f)\r\n', A(i,1),A(i,1),A(i,1),A(i,1))  

end

% Datei schliessen
fclose(fileID);

