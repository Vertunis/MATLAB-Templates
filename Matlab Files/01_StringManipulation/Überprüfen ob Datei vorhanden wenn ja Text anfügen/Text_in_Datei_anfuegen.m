%% Header aus Template lesen

filename = 'Analyse_Iterationen_Template.csv';
filepath = '.\Analyse_Iteration\';
fileID_1=[filepath,filename];

delimiterIn = ',';
headerlinesIn = 1; % gibt Anzahl der Headerlines an

getfile_template = importdata(fileID_1, delimiterIn, headerlinesIn); % Importiert Header aus Template
% getfile_template.textdata{1}, % Darin befinden sich die Headerinfos


%% Neue Datei erzeugen falls noch nicht vorhanden sonst in diese Datei schreiben


filename = ['Analyse_Iterationen_',num2str(test_nr),'.csv'];
filepath = '.\Analyse_Iteration\';
fildeID=[filepath,filename];

if ~isempty(dir(fullfile(pwd, filepath, filename))) == 0  % Überprüft ob Datei vorhanden ist und erzeugt neue Datei wenn noch nicht vorhanden (Returns 0 wenn nicht vorhanden, pwd -> Aktueller Ordner)  
    
    % Zieldatei im Schreibmodus öffnen
    fileID = fopen(fildeID,'w+');

    % Schreibt Header in neue Datei (Achtung ';' statt ',' verwendet)
    fprintf(fileID,'%s;%s;%s;%s;%s;%s;%s;%s;%s \r\n', getfile_template.textdata{1},getfile_template.textdata{2},getfile_template.textdata{3},getfile_template.textdata{4},getfile_template.textdata{5},getfile_template.textdata{6},getfile_template.textdata{7},getfile_template.textdata{8},getfile_template.textdata{9});
    % fprintf(fileID,'%s,%s,%s,%s,%s,%s,%s,%s,%s \r\n', 'SegmentNr','IterationNr','Duration','Tardiness','velScale','newVel','velScale (corr.)','newVel (corr.)','prevVel');

    fprintf(fileID,'%4.0f;%4.0f;%4.3f;%4.3f;%4.3f;%4.3f;%4.3f;%4.3f;%4.3f \r\n', testsegment, iterationNo,... (Achtung ';' statt ',' verwendet)
                duration_segment, tardiness_segment,...
                velScaleFactors_nonlimited,...
                newVelocityPercentage_nonlimited,... 
                velScaleFactors_limited,... 
                newVelocityPercentage_limited_test,... 
                oldVelocityPercentage);  
    
    fclose(fileID);

else % Falls datei bereits vorhanden ist, schreibe ans Ende dieser Datei
  
    fileID = fopen(fildeID,'a+'); % Schreibt ans Ende der vorhandenen Datei
    
    fprintf(fileID,'%4.0f;%4.0f;%4.3f;%4.3f;%4.3f;%4.3f;%4.3f;%4.3f;%4.3f \r\n', testsegment, iterationNo,... (Achtung ';' statt ',' verwendet)
                duration_segment, tardiness_segment,...
                velScaleFactors_nonlimited,...
                newVelocityPercentage_nonlimited,... 
                velScaleFactors_limited,... 
                newVelocityPercentage_limited_test,... 
                oldVelocityPercentage);  
            
    % Datei schliessen
    fclose(fileID);
    
end

% % fid = fopen('test2.dat', 'r+');
% % fseek(fid, 0, 'eof'); % Ende der Datei suchen
% % fwrite(fid, A, 'uint32');
% % fclose(fid);

end