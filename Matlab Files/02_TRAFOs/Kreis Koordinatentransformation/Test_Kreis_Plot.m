%% Koordinatentransformation eines Kreises

phi=90 % Soll Kippung des Kreises

P_orig=[1; 1; 1] % Ursprung

r=0.1; % Radius des Kreises


    j=1
    for ang=0:0.1:2*pi; % Kreis mit Auflösung 0.01
    % x_circ=r*cos(ang)+P_orig(1)
    % y_circ=r*sin(ang)+P_orig(2)
    % z_circ= P_orig(3)
    
    
    
    circ_s(:,j) = [r*cos(ang);
                   r*sin(ang);
                           0];      

    phi=-0;                       

    s_phi=sin(pi/180*phi);
    c_phi=cos(pi/180*phi);    

    bTt=...             % Transformationsmatrix
            [1     0      0;
             0 c_phi -s_phi;
             0 s_phi  c_phi];

     
    P_circ(:,j)=bTt*circ_s(:,j)+P_orig;  
        
    j=j+1;
     
    end 
     
    plot3(P_circ(1,:),P_circ(2,:),P_circ(3,:),':','Color',[0 0 0]/255,'LineWidth',1);