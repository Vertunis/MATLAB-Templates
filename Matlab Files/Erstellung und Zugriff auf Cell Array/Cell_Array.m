%% Aufbau und Zugriff auf Cell Array

Cell={ 'string1' , [1,3,4];
       'string2' , rand(1,3);
       'string3' , rand(1,3)} 
   

A=Cell{1,1}

%% Zugriff auf einzelne Werte in Cell
B =Cell{1,2}
% oder
B1=Cell{4}

%% Zugriff auf Werte in Matrix in Cell

B2=Cell{1,2}(1,1)
% oder
B3=Cell{4}(1,1)