% Zeit von sekunden in Stunden Minuten Sekunden und Millisekunden umrechnen
clear all

t= 3756.567; % in Sekunden

hour=floor(t/3600) % sekunden durch Stunden -> Ergibt Stunden -> floor rundet ab
rest_in_min=mod(t,3600)/60
rest_in_sec1=mod(t,3600)

minute=floor(rest_in_min) % restlichen sekunden nachdem stunden abgezogen wurden sind geteilt durch 60 ergeben minuten
rest_in_sec2=mod(t,60)

sekunde=floor(rest_in_sec2)

rest_in_sec3=mod(t,1)

millisec=floor(rest_in_sec3*100)