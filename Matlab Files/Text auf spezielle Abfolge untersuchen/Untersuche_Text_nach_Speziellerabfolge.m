fid = fopen('test.txt'); % öffne Datei
data = {}; % intialisiere zu lesende Daten als leeres Cell Array
while ~feof(fid) % weiter bis zum Ende der Datei
                 % feof == 1 wenn Ende der Datei fid erreicht wurde.
    l = fgetl(fid) % Zeile auslesen
    if ~isempty(l) && (strcmpi(l(1), 'N') || strcmpi(l(1), 'C'))
        data = [data; textscan(l, '%s %f %f %f')];  % wenn das erste Zeichen N oder (!!) C ist, dann Daten auslesen und anhängen.
    end
end   