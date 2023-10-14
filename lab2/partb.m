%420 Lab 2
%Part B
%Question 1
clear all
clc;
clear;

% forward direction
time= xlsread('partb.xlsx','partb','A3:A300');
channel_A_forwards= xlsread('partb.xlsx','partb','B3:B300');
channel_B_forwards= xlsread('partb.xlsx','partb','C3:C300');

plot(time,channel_A_forwards,'LineWidth',1.5)
hold on
plot(time,channel_B_forwards,'LineWidth',1.5)
title("Channel A and B Forwards");
xlabel("time (s)");
ylabel("Voltage (V)");
legend("Channel A","Channel B");

% backward direction
clear all;
time= xlsread('partb.xlsx','partb','A3:A300');
channel_A_backwards= xlsread('partb.xlsx','partb','G3:G300');
channel_B_backwards= xlsread('partb.xlsx','partb','H3:H300');

plot(time,channel_A_backwards,'LineWidth',1.5)
hold on
plot(time,channel_B_backwards,'LineWidth',1.5)
title("Channel A and B Backwards")
xlabel("time (s)");
ylabel("Voltage (V)");
legend("Channel A","Channel B");

clear all;
clc;
clear;

% Encoder Pulses vs LVIT Position
channel_A_20= xlsread('partb.xlsx','20','B2:B910');
position= xlsread('partb.xlsx','20','D2:D910');

plot(position,channel_A_20,LineWidth=1.25);
title("Channel A Encoder Pulses vs LVIT Position");
xlabel("Position (mm)");
ylabel("Voltage (V)");
pulsewidth(channel_A_20);









