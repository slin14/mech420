%420 Lab 3
%Part B
%F_vca(x_vca) vs position for different I_coil
clear all; clc; clear; close all;
figure
figure(1)

% VCA manufacture's parameters
vca_bl = 10.2;    % N/amp

% lab readings for VCA - to compensate for the LabView offsets
lab_current = [0.3 0.5 0.7];
lab_voltage = [2.2 3.7 5.3];

% LVDT paramters from lab2 
% V = V0 + B0*u, so u = (V - V0) / B0
lvdt_b0 = 0.196;  % V/mm
lvdt_v0 = -0.072; % V

plot_markers = ['*', 'o', '+'];

% for each coil current
coil_currents = [0.3 0.5 0.7]; % A
for i = 1 : length(coil_currents)
    sprintf("data\\B2_%.1fA.csv", coil_currents(i))
    fileMatrix = readmatrix(sprintf("data\\B2_%.1fA.csv", coil_currents(i)));
    
    % position
    lvdt_voltage = fileMatrix(:, 3);
    position = (lvdt_voltage - lvdt_v0) ./ lvdt_b0;
    
    % force
    vca_current = fileMatrix(:, 3);
    vca_current = vca_current - lab_current(i); % compensate for LabView offset
    force = vca_bl * vca_current; % wrong, must be a function of position
    plot(position, force);
    hold on;
end

%plot(position(:,1), force(:,1), position(:,2), force(:,2), position(:,3), force(:,3));
%plot(time(focus_times), rhs, time(focus_times), lhs)
ylabel('VCA Force (N)')
xlabel('position (mm)')
legend('0.3A', '0.5A', '0.7A')
%legend('RHS - Inertia', 'LHS - Torque Balance')
title('VCA Force vs position for different coil currents')
%title(sprintf('Part B, Je = %d kg m^2', Je))
exportgraphics(gca, 'img/b1_F_vs_position.png')

