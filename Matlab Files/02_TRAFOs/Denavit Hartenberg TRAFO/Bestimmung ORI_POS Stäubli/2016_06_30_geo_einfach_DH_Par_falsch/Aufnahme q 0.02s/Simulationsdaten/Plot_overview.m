%% P

load('Position_P_sim_geo_einfach.mat')

figure(1)
t=0.01:0.01:((size(Roboterinfo_pos,1))*0.01);
plot(t,Roboterinfo_pos(:,2))


%% R
load('Position_R_sim_geo_einfach.mat')

figure(2)
t=0.01:0.01:((size(Roboterinfo_pos,1))*0.01);
plot(t,Roboterinfo_pos(:,2))