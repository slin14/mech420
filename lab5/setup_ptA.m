% 423 Lab 5
% Setup & Define Parameters
clear all; clc; clear; close all;

ptAcurrents = [0 0.3]; % A
g = 9.81; 

% VCA manufacture's parameters
vca_bl = 10.2;    % N/amp

% LVDT paramters from lab2 
% V = V0 + B0*u, so u = (V - V0) / B0
lvdt_b0 = 0.196;  % V/mm
lvdt_v0 = -0.072; % V

% lab 5 readings to compensate for the LabView offsets
lab_current = [0.0 0.3]; % A
lab_voltage = [0.0 12.9]; % V
lab_load_cell = 0.176242033; % kg
%lab_zero_position = 2.096543; % mm

trimHead0 = 80000; % trim initial data points
trimHead1 = 72000; % trim initial data points
trimTail1 = 80000; % trim final data points

%% read 0.0A data
fileMatrix0 = readmatrix("data\\partA\\aa_0.0A.xlsx");
N0 = length(fileMatrix0(:,1));

% position
lvdt_voltage0 = fileMatrix0(:, 3);
position0 = (lvdt_voltage0 - lvdt_v0) ./ lvdt_b0;
position0 = position0(trimHead0:N0); % trim
lab_zero_position = position0(1); % mm
position0 = position0 - position0(1); % zero

% force
load_cell0 = fileMatrix0(:, 2); % kg
load_cell0 = load_cell0 - lab_load_cell; % compensate for LabView offset
force0 = load_cell0 * g;
force0 = force0(trimHead0:N0); % trim

%% read 0.3A data
fileMatrix1 = readmatrix("data\\partA\\aa_0.3A.xlsx");
N1 = length(fileMatrix1(:,1));

% position
lvdt_voltage1 = fileMatrix1(:, 3);
position1 = (lvdt_voltage1 - lvdt_v0) ./ lvdt_b0;
position1 = position1(trimHead1:N1-trimTail1); % trim
%position1 = position1 - position1(1); % zero
position1 = position1 - lab_zero_position; % zero

% force
load_cell1 = fileMatrix1(:, 2); % kg
load_cell1 = load_cell1 - lab_load_cell; % compensate for LabView offset
force1 = load_cell1 * g;
force1 = force1(trimHead1:N1-trimTail1); % trim