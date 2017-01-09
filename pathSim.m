clear all;
clc;
addpath(genpath(pwd));

ini_pos = zeros(1, 3);
ini_vel = zeros(1, 3);
ini_att = zeros(1, 3); % 航向角 俯仰角 翻滚角
ini_att(1) = 50;


% 首先通过 ODE模型法 求得初始轨迹。然后进行B样条拟合，将拟合后的轨迹求微分，可以得到速度和加速度以及加加速度。
%%  匀加速运动仿真
A0 = 0.2;

options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4 1e-4 1e-4 1e-4 1e-4]);
[T0 , Y0] = ode45(@(t,y) constAccFlat(t, y, A0, ini_att(1)),0:500, horzcat(ini_vel, ini_pos),options);
T0_att = T0;
ATT0 = horzcat(zeros(1,3), ini_att);
ATT0 = ATT0(ones(size(T0_att, 1) , 1) ,:);

figure(1);
plot(T0, Y0(:,1),'-',T0, Y0(:,2),'-.',T0, Y0(:,3),'.');
title('velocity in ENU coordinate system for segment 0');

figure(2);
plot(T0,Y0(:,4),'-',T0,Y0(:,5),'-.',T0,Y0(:,6),'.');
title('position in ENU coordinate system for segment 0');

%%  上升运动
% 俯仰角运动是等角速度运动 ， 匀加速上升运动。
V_1 = norm(  Y0(end, 1:3), 2);
Wrate_1 = [ 0 0.3 0 ];
att_1 = ini_att;

% 计算位置和速度
[T1 , Y1] = ode45(@(t,y) constAccUp(t, y, V_1, Wrate_1(2)), 500:530, Y0(end, :), options);

% 计算姿态角和姿态角变化率
[T1_att , ATT1] = ode45(@(t,y) constAttVel(t, y, Wrate_1), 500:530, horzcat(zeros(1,3), att_1), options);

figure(3);
plot(T1, Y1(:,1), '-+', T1, Y1(:,2), '-.', T1, Y1(:,3), '.');
title('velocity in ENU coordinate system for segment 1');

figure(4);
plot(T1, Y1(:,4), '-+', T1, Y1(:,5), '-.', T1, Y1(:,6),'.');
title('position in ENU coordinate system for segment 1');

figure(5);
plot(T1_att, ATT1(:, 1), '-+', T1_att, ATT1(:, 2), '-*', T1_att, ATT1(:, 3), '.');
title('attitude rate in ENU coordinate system for segment 1');

figure(6);
plot(T1_att, ATT1(:, 4), '-+', T1_att, ATT1(:, 5), '-*', T1_att, ATT1(:, 6), '.');
title('attitude in ENU coordinate system for segment 1');

% 转弯运动
V_2 = norm(  Y1(end, 1:3), 2);
Wrate_2 = [ 0  0  0.3  ];
W_2 = ATT1(end, :);

% 计算位置和速度
[T2 , Y2] = ode45(@(t,y) constAccUp(t, y, V_2, Wrate_2(3)), 530:560, Y1(end, :), options);

% 计算姿态角和姿态角变化率
[T2_att , ATT2] = ode45(@(t,y) constAttVel(t, y, Wrate_2), 530:560, W_2, options);

figure(7);
plot(T2, Y2(:,1), '-+', T2, Y2(:, 2), '-.', T2, Y2(:, 3), '.');
title('velocity in ENU coordinate system for segment 2');

figure(8);
plot(T2, Y2(:, 4), '-+', T2, Y2(:, 5), '-.', T2, Y2(:, 6),'.');
title('position in ENU coordinate system for segment 2');

figure(9);
plot(T2_att, ATT2(:, 1), '-+', T2_att, ATT2(:, 2), '-*', T2_att, ATT2(:, 3), '.');
title('attitude rate in ENU coordinate system for segment 2');

figure(10);
plot(T2_att, ATT2(:, 4), '-+', T2_att, ATT2(:, 5), '-*', T2_att, ATT2(:, 6), '.');
title('attitude in ENU coordinate systemfor segment 2');


T_whole = vertcat(T0, T1(2:end), T2(2:end));
Y_whole = vertcat(Y0, Y1(2:end,:), Y2(2:end,:));
T_att_whole = vertcat(T0_att, T1_att(2:end), T2_att(2:end));
ATT_whole = vertcat(ATT0, ATT1(2:end,:), ATT2(2:end,:));

figure(11);
plot(T_whole, Y_whole(:, 4), '-+', T_whole, Y_whole(:, 5), '-.', T_whole, Y_whole(:, 6),'.');
title('position in ENU coordinate system for segment whole');




















