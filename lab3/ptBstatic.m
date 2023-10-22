%420 Lab 3
%Part B - static
clear all; clc; clear; close all;

g = 9.81; 

% VCA manufacture's parameters
vca_bl = 10.2;    % N/amp

% lab readings for VCA - to compensate for the LabView offsets
lab_current = [0.3 0.5 0.7]; % A
lab_voltage = [2.2 3.7 5.3]; % V

lab_load_cell = 0.19366474; % kg

coil_currents = [0.3 0.5 0.7]; % A

% LVDT paramters from lab2 
% V = V0 + B0*u, so u = (V - V0) / B0
lvdt_b0 = 0.196;  % V/mm
lvdt_v0 = -0.072; % V

plot_markers = ['*', 'o', '+'];

% store results
f_avg = [];
bl_avg = [];
r_avg = [];

%% q1 - F_vca(x_vca) vs position for different I_coil
figure
figure(1)

%trim = 1 - 0.54; % keep data from beginning to length(data)*trim
trim = 0.54; % keep data from length(data)*trim to length(data) % because 1st half has an ugly spike

% for each coil current
for i = 1 : length(coil_currents)
    %sprintf("data\\B2_%.1fA.csv", coil_currents(i))
    fileMatrix = readmatrix(sprintf("data\\B2_%.1fA.csv", coil_currents(i)));
    N = length(fileMatrix(:,1));
    
    % position
    lvdt_voltage = fileMatrix(:, 3);
    position = (lvdt_voltage - lvdt_v0) ./ lvdt_b0;
    position = position - position(1); % zero

    % current
    vca_current = fileMatrix(:, 5);
    vca_current = vca_current - abs(vca_current(1)- lab_current(i)); % compensate for LabView offset
    
    % force
    load_cell = fileMatrix(:, 2); % kg
    load_cell = load_cell - lab_load_cell; % compensate for LabView offset
    force = load_cell * g;

    plot(position(int32(N*trim):N), force(int32(N*trim):N))
    hold on;
    f_avg(i) = mean(force(int32(N*trim):N));
end

ylabel('VCA Force (N)')
xlabel('position (mm)')
%xlim([0 position(end)])
legend('0.3A', '0.5A', '0.7A')
title('VCA Force vs position for different coil currents')
exportgraphics(gca, 'img/b1_F_vs_position.png')
hold off;
%% q2 - Bl vs position for different coil currents, find experimental Bl
figure(2)
% for each coil current
for i = 1 : length(coil_currents)
    fileMatrix = readmatrix(sprintf("data\\B2_%.1fA.csv", coil_currents(i)));
    N = length(fileMatrix(:,1));
    
    % position
    lvdt_voltage = fileMatrix(:, 3);
    position = (lvdt_voltage - lvdt_v0) ./ lvdt_b0;
    position = position - position(1); % zero
    % current
    vca_current = fileMatrix(:, 5);
    vca_current = vca_current - abs(vca_current(1)- lab_current(i)); % compensate for LabView offset
    
    % force
    load_cell = fileMatrix(:, 2); % kg
    load_cell = load_cell - lab_load_cell; % compensate for LabView offset
    force = load_cell * g;

    % experimental Bl
    exp_Bl = force ./ vca_current;

    plot(position(int32(N*trim):N), exp_Bl(int32(N*trim):N)) % plot 2nd half to avoid hysteresis and ugly spike in 1st half
    hold on;
    bl_avg(i) = mean(exp_Bl(int32(N*trim):N));
end

ylabel('VCA Force Constant Bl (N/A)')
xlabel('position (mm)')
legend('0.3A', '0.5A', '0.7A')
title('VCA Force Constant vs Position for different coil currents')
exportgraphics(gca, 'img/b2_Bl_vs_pos.png')
hold off;

%% q3 - R vs position for different coil currents, find experimental R
figure(3)
% for each coil current
for i = 1 : length(coil_currents)
    fileMatrix = readmatrix(sprintf("data\\B2_%.1fA.csv", coil_currents(i)));
    N = length(fileMatrix(:,1));
    
    % position
    lvdt_voltage = fileMatrix(:, 3);
    position = (lvdt_voltage - lvdt_v0) ./ lvdt_b0;
    position = position - position(1); % zero

    % current
    vca_current = fileMatrix(:, 5);
    vca_current = vca_current - abs(vca_current(1) - lab_current(i)); % compensate for LabView offset
    
    % force
    load_cell = fileMatrix(:, 2); % kg
    load_cell = load_cell - lab_load_cell; % compensate for LabView offset
    force = load_cell * g;

    % voltage
    voltage = fileMatrix(:, 4); % V
    voltage = voltage - abs(voltage(1) - lab_voltage(i)); % compensate for LabView offset
    resistance = voltage ./ vca_current;

    plot(position(int32(N*trim):N), resistance(int32(N*trim):N)) % plot 2nd half to avoid hysteresis and ugly spike in 1st half
    hold on;
    r_avg(i) = mean(resistance(int32(N*trim):N));
end

% re-calc experimental R
%bl = polyfit(positions, resistances, 1); % linear best fit
%disp(['linear best fit is y = ' num2str(bl(1)) '*x + ' num2str(bl(2))])
%plot(positions, bl(1)*positions + bl(2))

ylabel('VCA Resistance (Ohms)')
xlabel('Position (mm)')
legend('0.3A', '0.5A', '0.7A')
%legend('0.3A', '0.5A', '0.7A', sprintf("y=%.2fx+%.2f",bl(1),bl(2)))
title('VCA Resistance vs position for different coil currents')
exportgraphics(gca, 'img/b3_R_vs_pos.png')
hold off;


%% print results
disp("Averages:")
for i = 1 : length(coil_currents)
    disp(sprintf("I = %.1f, Force = %.2f, Bl = %.2f, R = %.2f", coil_currents(i), f_avg(i), bl_avg(i), r_avg(i)));
end

disp(sprintf('avg Bl = %.2f, avg R = %.2f', mean(bl_avg), mean(r_avg)))