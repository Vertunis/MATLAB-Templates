%% Skript soll Werte in Spalten in aufsteigender Reihenfolge sortieren, so dass 
%  die zugehörigen Spalten zugehörig bleiben.

A= [1 2 3 4;...
    2 3 4 5;...
    1 6 3 4;...
    1 2 3 4;... % Hier doppelte Zeile
    2 2 2 2];

B=sortrows(A,[1,4,2,3]) %% Sortiert die Ganze Reihe den Zeilenwerten nach  zuerst 1. Zeile dann 4. Zeile etc.

[C,i,j]=unique(B(:,3),'rows','stable') % C ist Matrix B ohne Doppeleinträge
                                   % Index i is Index to B, returned as a column vector of indices to the first occurrence of repeated elements
                               
                                   
% [D,k,l]=unique(B,'rows','stable'); % Macht das gleiche wie oben nur dass nur Zeile 3 aus B verwendet wird                          
                                   

E = B(i,:) % Sortierte Matrix ohne Doppeleintrag aus Zeile 3 (Matrix B)

%% Unique Example 
% 
% Name = {'Fred';'Betty';'Bob';'George';'Jane'};
% Age = [38;43;38;40;38];
% Height = [71;69;64;67;64];
% Weight = [176;163;131;185;131];
% 
% A = table(Age,Height,Weight,'RowNames',Name) % Generiert Table mit obigen Einträgen