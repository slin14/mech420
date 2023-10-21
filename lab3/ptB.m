%420 Lab 3
%Part B
clear all; clc; clear; close all;


g = 9.81; 

% VCA manufacture's parameters
vca_bl = 10.2;    % N/amp

% lab readings for VCA - to compensate for the LabView offsets
lab_current = [0.3 0.5 0.7];
lab_voltage = [2.2 3.7 5.3];

coil_currents = [0.3 0.5 0.7]; % A

% LVDT paramters from lab2 
% V = V0 + B0*u, so u = (V - V0) / B0
lvdt_b0 = 0.196;  % V/mm
lvdt_v0 = -0.072; % V

plot_markers = ['*', 'o', '+'];

%% q1 - F_vca(x_vca) vs position for different I_coil
figure
figure(1)

%trim = 1 - 0.53; % keep data from beginning to length(data)*trim
trim = 0.53; % keep data from length(data)*trim to length(data) % because 1st half has an ugly spike

% for each coil current
for i = 1 : length(coil_currents)
    %sprintf("data\\B2_%.1fA.csv", coil_currents(i))
    fileMatrix = readmatrix(sprintf("data\\B2_%.1fA.csv", coil_currents(i)));
    N = length(fileMatrix(:,1));
    
    % position
    lvdt_voltage = fileMatrix(:, 3);
    position = (lvdt_voltage - lvdt_v0) ./ lvdt_b0;
    %position = position - position(int32(N*trim)); zero the 1st half
    position = position(int32(N*trim)) - position;

    % current
    vca_current = fileMatrix(:, 5);
    vca_current = vca_current - lab_current(i); % compensate for LabView offset
    
    % force
    load_cell = fileMatrix(:, 2); % kg
    force = load_cell * g;
    %force = vca_bl * vca_current;
    %plot(position(1:int32(N*trim)), force(1:int32(N*trim))); % plot 1st
    %half to avoid hysteresis
    plot(position(int32(N*trim):N), force(int32(N*trim):N))

    %plot(position(1:length(position)/2), force(1:length(force)/2)); % remove hysteresis, keep 1st half
    %plot(position(length(position)*0.53:length(position)), force(length(force)*0.53:length(force))); % remove hysteresis, keep 2nd half
    hold on;
end

ylabel('VCA Force (N)')
xlabel('position (mm)')
xlim([0 position(end)])
legend('0.3A', '0.5A', '0.7A')
title('VCA Force vs position for different coil currents')
exportgraphics(gca, 'img/b1_F_vs_position.png')
hold off;
