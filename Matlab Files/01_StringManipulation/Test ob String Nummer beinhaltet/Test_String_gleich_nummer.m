str = '1';     % Beispiel-Eingabe
 
i = str2num(str);
if isempty(i)
  % Fehlerfall 1: Ungültige Zahl
  warndlg('Ungültige Zahl',' Fehlerfall 1'); 
  return 
elseif numel(i) ~= 1
  % Fehlerfall 2: Vektor oder Array eingegeben
  warndlg('Vektor oder Array eingegeben',' Fehlerfall 2'); 
  return 
elseif isnan(i) || isinf(i)
  % Fehlerfall 3: Inf/-Inf bzw. NaN eingegeben
  warndlg('Inf/-Inf bzw. NaN eingegeben',' Fehlerfall 3'); 
  return 

else  
  warndlg('String ist Zahl',' Zustimmung'); 
  return 
end
