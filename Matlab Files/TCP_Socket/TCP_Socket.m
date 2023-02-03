% Positionsdaten des Roboter per TCP/IP-Socket exportieren
 
% Daten deklarieren die verschickt werden sollen
% sollen als String vorliegen ???
data1 = num2str(Roboterinfo_pos)
data2 = num2str(Roboterinfo_v)

%Anzeigen der Details
s_data1 = whos('data1')
s_data2 = whos('data1')

s_data1.size
s_data2.size

s_data1.bytes
s_data2.bytes

if s_data1.bytes > s_data2.bytes
   s.data = s_data1.bytes;
else
    s.data= s_data2.bytes;
end

%Matlab als Server einrichten
%(http://blogs.mathworks.com/loren/2011/05/27/transferring-data-between-two-computers-using-matlab/)

ip='169.254.58.190'  % Ip der CS8C auf LANPort J205 169.254.58.190 (eingegeben bei I/O TCP-Sockets)
port=50001

tcpipServer = tcpip(ip,port,'NetworkRole','Server');

%Set the OutputBufferSize property to a value large enough
% to hold the data. This is the first place where we use the output of the whos function, specifically the value of s.bytes. 
set(tcpipServer,'OutputBufferSize',s.data);


% Open the server socket and wait indefinitely for a connection. 
% This line will cause MATLAB to wait until an incoming connection is established. 
fopen(tcpipServer);

Once the connection is made by the client, 
read and write the data out and close the server.

Kippstart=0;
for Kippstart=0
    
Kippstart=fread(tcpipServer)

        
end


if Kippstart==Theta_start
    
 n=deltaT*lengthsim; %Anzahl der Pakete
 for i=0:n
     
 fwrite(tcpipServer,data1,'double');
 fwrite(tcpipServer,data2,'double');
 
 pause(deltaT);
 end

 fclose(tcpipServer);
