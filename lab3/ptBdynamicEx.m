%420 Lab 3
%Part B - dynamic
clear all; clc; clear; close all;

g = 9.81;
f_sampl = 10000; % Hz

% VCA manufacture's parameters
vca_bl = 10.2;    % N/amp

% lab readings for VCA - to compensate for the LabView offsets
lab_current = [0.3 0.5 0.7]; % A
lab_voltage = [2.2 3.7 5.3]; % V

lab_load_cell = 0.19366474; % kg


% LVDT paramters from lab2 
% V = V0 + B0*u, so u = (V - V0) / B0
lvdt_b0 = 0.196;  % V/mm
lvdt_v0 = -0.072; % V

plot_markers = ['*', 'o', '+'];

% store results
f_avg = [];
bl_avg = [];
r_avg = [];

%figure

% dynamic
%% q4 example curve fit of current to sine

figure(4);
freqs = [1 3 5 7 9 10 30 50 70 90 100 300 500 700 90 1000]; % Hz

i = 1;
fileMatrix = readmatrix(sprintf("data\\B3_%d.csv", freqs(i)));
time   = fileMatrix(:, 1); % s
coil_v = fileMatrix(:, 4); % V
coil_i = fileMatrix(:, 5); % A

% trim data to 1 period so computation doesn't take forever
time   = time(1:int32(f_sampl/freqs(i)));
coil_v = coil_v(1:int32(f_sampl/freqs(i)));
coil_i = coil_i(1:int32(f_sampl/freqs(i)));
N = length(time);

i_avg = mean(coil_i);
%v_avg = mean(coil_v);

% curve fitting to sine function
x0 = [1 1 1 1]; % initial guess
xdata = time.';
ydata = coil_i.';
fun = @(A,xdata) A(1).*sin(A(2).*xdata + A(3)) + A(4);
A = lsqcurvefit(fun,x0,xdata,ydata);

plot(time, coil_i)
hold on;
%plot(time, ones(N).*i_avg) % average
plot(time,  A(1).*sin(A(2).*time + A(3)) + A(4), 'r') % curve fit

ylabel('Current (A)')
xlabel('time (s)')
legend('VCA Coil Current', sprintf('y = %.2fsin(%.2fx%.2f)+%.2f',A(2),A(2),A(3),A(4)))
%legend('VCA Coil Current', sprintf('average = %.2fA',i_avg), 'curve fit')
title('Example Curve Fit of VCA Current vs Time to Sine Function')
exportgraphics(gca, 'img/b4_ex_i_curve_fit_sine.png')
hold off;

%% q4 example curve fit of voltage to sine
figure(5);
i = 1;
fileMatrix = readmatrix(sprintf("data\\B3_%d.csv", freqs(i)));
time   = fileMatrix(:, 1); % s
coil_v = fileMatrix(:, 4); % V
coil_i = fileMatrix(:, 5); % A

% trim data to 1 period so computation doesn't take forever
time   = time(1:int32(f_sampl/freqs(i)));
coil_v = coil_v(1:int32(f_sampl/freqs(i)));
coil_i = coil_i(1:int32(f_sampl/freqs(i)));
N = length(time);

%i_avg = mean(coil_i);
v_avg = mean(coil_v);

% curve fitting to sine function
x0 = [1 1 1 1]; % initial guess
xdata = time.';
ydata = coil_v.';
fun = @(A,xdata) A(1).*sin(A(2).*xdata + A(3)) + A(4);
A = lsqcurvefit(fun,x0,xdata,ydata);

plot(time, coil_v, 'LineWidth', 2.0)
hold on;
%plot(time, ones(N).*v_avg)
plot(time,  A(1).*sin(A(2).*time + A(3)) + A(4), 'r') % curve fit

ylabel('Voltage (V)')
xlabel('time (s)')
legend('VCA Coil Voltage', sprintf('y = %.2fsin(%.2fx%.2f)+%.2f',A(2),A(2),A(3),A(4)))
%legend('VCA Coil Voltage', sprintf('average = %.2fV',v_avg))
title('Example Curve Fit of VCA Voltage vs Time to Sine Function')
exportgraphics(gca, 'img/b4_ex_v_curve_fit_sine.png')
hold off;
