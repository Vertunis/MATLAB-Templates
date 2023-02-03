%% In Textdatei auf bestimmten Pointer springen
%{
frewind(fileID); % Setzt Zeiger auf Anfang der Datei
fseek(fileID, 0, 'bof'); % Entspricht dem Befehl darüber. 

zu fseek(fileID,offset,origin):
origin:
'bof' or -1: Beginning of file
'cof' or 0: Current position in file
'eof' or 1: End of file 
%}


% Create files test1.dat and test2.dat
% Each character uses 8 bits (1 byte)

fid1 = fopen('test1.dat', 'w+');
fwrite(fid1, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');

fid2 = fopen('test2.dat', 'w+');
fwrite(fid2, 'Second File');

% Seek to the 10th byte ('J'), read 5
fseek(fid1, 9, 'bof');
A = fread(fid1, 5, 'uint8=>char');
fclose(fid1);

% Append to test2.dat
fseek(fid2, 0, 'eof');
fwrite(fid2, A);
fclose(fid2);