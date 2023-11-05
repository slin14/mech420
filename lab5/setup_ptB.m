% 423 Lab 5 - Part B
% Setup & Define Parameters
clear all; clc; clear; close all;

ptBfrequecies = [1 3 5 7 10 30 50 70 100 300 500 700 1000]; % Hz
ptBpositions = [11 30]; % mm
ptBsampleFreqs = [1000 1000 1000 1000 1000 1000 1000 1000 1000 5000 5000 5000 5000]; % Hz


g = 9.81; 

% VCA manufacture's parameters
vca_bl = 10.2;    % N/amp

% LVDT paramters from lab2 
% V = V0 + B0*u, so u = (V - V0) / B0
lvdt_b0 = 0.196;  % V/mm
lvdt_v0 = -0.072; % V

% lab 5 readings to compensate for the LabView offsets
lab_load_cell = 0.176242033; % kg

%% position = 11mm -> read voltages and currents for all frequencies
Vampl_1 = ones(length(ptBfrequecies));
Vphase_1 = ones(length(ptBfrequecies));
Iampl_1 = ones(length(ptBfrequecies));
Iphase_1 = ones(length(ptBfrequecies));


for i = 1 : length(ptBfrequecies)

    fileMatrix = readmatrix(sprintf("data\\partB\\partB11mm%d.xlsx", ptBfrequecies(i)));
    time   = fileMatrix(:, 1); % s
    coil_v = fileMatrix(:, 4); % V
    coil_i = fileMatrix(:, 5); % A
    
    % trim data to 1 period so computation doesn't take forever
    N = ptBsampleFreqs(i)/ptBfrequecies(i);
    time   = time(1:N);
    coil_v = coil_v(1:N);
    coil_i = coil_i(1:N);

    % curve fitting to sine function
    xdata = time.';
    % for voltage
    ydata = coil_v.';
    x0 = [ydata(1) ptBfrequecies(i)*2*pi 0 0]; % initial guess
    fun = @(A,xdata) A(1).*sin(A(2).*xdata + A(3)) + A(4);
    A = lsqcurvefit(fun,x0,xdata,ydata);
    Vampl_1(i)  = A(1);
    Vphase_1(i) = A(3);
    % for current
    ydata = coil_i.';
    x0 = [ydata(1) ptBfrequecies(i)*2*pi 0 0]; % initial guess
    fun = @(A,xdata) A(1).*sin(A(2).*xdata + A(3)) + A(4);
    A = lsqcurvefit(fun,x0,xdata,ydata);
    Iampl_1(i)  = A(1);
    Iphase_1(i) = A(3);
end

%% position = 30mm -> read voltages and currents for all frequencies
Vampl_2 = ones(length(ptBfrequecies));
Vphase_2 = ones(length(ptBfrequecies));
Iampl_2 = ones(length(ptBfrequecies));
Iphase_2 = ones(length(ptBfrequecies));


for i = 1 : length(ptBfrequecies)

    fileMatrix = readmatrix(sprintf("data\\partB\\partB30mm%d.xlsx", ptBfrequecies(i)));
    time   = fileMatrix(:, 1); % s
    coil_v = fileMatrix(:, 4); % V
    coil_i = fileMatrix(:, 5); % A
    
    % trim data to 1 period so computation doesn't take forever
    N = ptBsampleFreqs(i)/ptBfrequecies(i);
    time   = time(1:N);
    coil_v = coil_v(1:N);
    coil_i = coil_i(1:N);

    % curve fitting to sine function
    xdata = time.';
    % for voltage
    ydata = coil_v.';
    x0 = [ydata(1) ptBfrequecies(i)*2*pi 0 0]; % initial guess
    fun = @(A,xdata) A(1).*sin(A(2).*xdata + A(3)) + A(4);
    A = lsqcurvefit(fun,x0,xdata,ydata);
    Vampl_2(i)  = A(1);
    Vphase_2(i) = A(3);
    % for current
    ydata = coil_i.';
    x0 = [ydata(1) ptBfrequecies(i)*2*pi 0 0]; % initial guess
    fun = @(A,xdata) A(1).*sin(A(2).*xdata + A(3)) + A(4);
    A = lsqcurvefit(fun,x0,xdata,ydata);
    Iampl_2(i)  = A(1);
    Iphase_2(i) = A(3);
end