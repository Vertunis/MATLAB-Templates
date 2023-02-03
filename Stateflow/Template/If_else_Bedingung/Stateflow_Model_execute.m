%% Test Stateflow Model
dT=1; % Stepsize
t_start=0;
t_end=1;

a_in=2; % Zustand a wird von Stateflow chart aus a_in bezogen (input)
b=2; % Als Parameter in Stateflow deklariert -> Wird aus WS abgerufen 
c=3; % Als Parameter in Stateflow deklariert -> Wird aus WS abgerufen 


sim('Stateflow_Model_for_if_test',t_start:t_end)
