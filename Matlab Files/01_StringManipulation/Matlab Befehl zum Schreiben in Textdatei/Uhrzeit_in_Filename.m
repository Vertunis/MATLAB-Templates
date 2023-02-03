c = clock;

iterationNo='1';

ProgramName = ['subMoves_',num2str(c(1),'%02d'),num2str(c(2),'%02d'), num2str(c(3),'%02d'),'_',num2str(c(4),'%02d'), num2str(c(5),'%02d'),'_i',num2str(iterationNo)];
File = fopen(['Positionen_Steuerung_',ProgramName,'.csv'],'w+');

fopen('Positionen_Steuerung.txt','w');

fclose(File); 