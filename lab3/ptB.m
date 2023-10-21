%420 Lab 3
%Part B
%F_vca(x_vca) vs position for different I_coil
clear all
clc;
clear;

% VCA parameters
vca_bl = 10.2;    % N/amp

% LVDT paramters from lab2 
% V = V0 + B0*u, so u = (V - V0) / B0
lvdt_b0 = 0.196;  % V/mm
lvdt_v0 = -0.072; % V

fileMatrix = readmatrix("data\B2_0.3A.csv");
% position
lvdt_voltage = fileMatrix(:, 3);
position = (lvdt_voltage - lvdt_v0) ./ lvdt_b0;
% force
vca_current = fileMatrix(:, 3);
force = vca_bl * vca_current;

plot(position, force)
%plot(time(focus_times), rhs, time(focus_times), lhs)
ylabel('VCA Force (N)')
xlabel('position (mm)')
legend('3A')
%legend('RHS - Inertia', 'LHS - Torque Balance')
title('VCA Force vs position for different coil currents')
%title(sprintf('Part B, Je = %d kg m^2', Je))
exportgraphics(gca, 'img/b1_F_vs_position.png')
