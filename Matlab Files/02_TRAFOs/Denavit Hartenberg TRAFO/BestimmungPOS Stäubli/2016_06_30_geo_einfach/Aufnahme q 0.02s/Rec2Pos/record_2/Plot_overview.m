%% P

load('2016_06_30_P_rec.mat')

figure(1)
t=0.01:0.01:((size(TCP_pos_m,1))*0.01);
plot(t,TCP_pos_m(:,2))


%% R
load('2016_06_30_R_rec.mat')

figure(2)
t=0.01:0.01:((size(R_pos_m,1))*0.01);
plot(t,R_pos_m(:,2))