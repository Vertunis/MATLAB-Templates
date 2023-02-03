%% Schreiben der Roboterinfos in eine csv bzw. eine txt Datei
dlmwrite('Roboterinfo_SteuerungV10_pos.csv',Roboterinfo_pos,'delimiter',';','newline','pc'); %schreiben der csv Datei
dlmwrite('Roboterinfo_SteuerungV10_pos.txt',Roboterinfo_v,'delimiter',';','newline','pc'); %schreiben der .txt Datei
