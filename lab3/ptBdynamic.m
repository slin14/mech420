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
%% q4 impedance as a function of frequency
% Z = R + jwL = V/I

freqs = [1 3 5 7 9 10 30 50 70 90 100 300 500 700 90 1000]; % Hz

% results
Vampl = ones(length(freqs));
Vphase = ones(length(freqs));
Iampl = ones(length(freqs));
Iphase = ones(length(freqs));


for i = 1 : length(freqs)

    fileMatrix = readmatrix(sprintf("data\\B3_%d.csv", freqs(i)));
    time   = fileMatrix(:, 1); % s
    coil_v = fileMatrix(:, 4); % V
    coil_i = fileMatrix(:, 5); % A
    
    % trim data to 1 period so computation doesn't take forever
    N = f_sampl/freqs(i);
    time   = time(1:N);
    coil_v = coil_v(1:N);
    coil_i = coil_i(1:N);

    % curve fitting to sine function
    xdata = time.';
    % for voltage
    ydata = coil_v.';
    x0 = [ydata(1) freqs(i)*2*pi 0 0]; % initial guess
    fun = @(A,xdata) A(1).*sin(A(2).*xdata + A(3)) + A(4);
    A = lsqcurvefit(fun,x0,xdata,ydata);
    Vampl(i)  = A(1);
    Vphase(i) = A(3);
    % for current
    ydata = coil_i.';
    x0 = [ydata(1) freqs(i)*2*pi 0 0]; % initial guess
    fun = @(A,xdata) A(1).*sin(A(2).*xdata + A(3)) + A(4);
    A = lsqcurvefit(fun,x0,xdata,ydata);
    Iampl(i)  = A(1);
    Iphase(i) = A(3);
    
    fig = figure(8); subplot(4,4,i);
    plot(time, coil_i)
    hold on;
    plot(time,  A(1).*sin(A(2).*time + A(3)) + A(4), 'r') % curve fit

end
han=axes(fig,'visible','off'); 
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Current (A)');
xlabel(han, 'time (s)');
sgtitle('Curve Fits of VCA Current vs Time for all frequencies')
exportgraphics(gca, 'img/b4_i_curve_fits.png')
hold off;
%% q4 impedance bode plots

%Vampl(:,1)
%Vphase(:,1)
%Iampl(:,1)
%Iphase(:,1)

V = Vampl(:,1).*complex(cos(Vphase(:,1)),sin(Vphase(:,1)));
I = Iampl(:,1).*complex(cos(Iphase(:,1)),sin(Iphase(:,1)));

V = V.';
I = I.';

Zampl = abs(V./I);
Zphase = angle(V./I);

figure(6);
plot(freqs, Zampl.','o')
%plot(freqs, Zampl.')
ylabel('impedence (Ohms)')
xlabel('frequncy (Hz)')
%legend('VCA Coil Current', sprintf('y = %.2fsin(%.2fx%.2f)+%.2f',A(2),A(2),A(3),A(4)))
title('Magnitude of Coil Impedence vs Frequency')
exportgraphics(gca, 'img/b4_Z_mag.png')

figure(7);
plot(freqs, 2*pi/180*Zphase.','+')
%plot(freqs, 2*pi/180*Zphase.')
ylabel('impedence phase (deg)')
xlabel('frequncy (Hz)')
%legend('VCA Coil Current', sprintf('y = %.2fsin(%.2fx%.2f)+%.2f',A(2),A(2),A(3),A(4)))
title('Phase of Coil Impedence vs Frequency')
exportgraphics(gca, 'img/b4_Z_ph.png')


%% plot all voltage curve fits - figure(9
for i = 1 : length(freqs)

    fileMatrix = readmatrix(sprintf("data\\B3_%d.csv", freqs(i)));
    time   = fileMatrix(:, 1); % s
    coil_v = fileMatrix(:, 4); % V
    coil_i = fileMatrix(:, 5); % A
    
    % trim data to 1 period so computation doesn't take forever
    N = f_sampl/freqs(i);
    time   = time(1:N);
    coil_v = coil_v(1:N);
    coil_i = coil_i(1:N);

    % curve fitting to sine function
    xdata = time.';
    % for voltage
    ydata = coil_v.';
    x0 = [ydata(1) freqs(i)*2*pi 0 0]; % initial guess
    fun = @(A,xdata) A(1).*sin(A(2).*xdata + A(3)) + A(4);
    A = lsqcurvefit(fun,x0,xdata,ydata);
    Vampl(i)  = A(1);
    Vphase(i) = A(3);
    fig = figure(9); subplot(4,4,i);
    plot(time, coil_v)
    hold on;
    plot(time,  A(1).*sin(A(2).*time + A(3)) + A(4), 'r') % curve fit

    % for current
    ydata = coil_i.';
    x0 = [ydata(1) freqs(i)*2*pi 0 0]; % initial guess
    fun = @(A,xdata) A(1).*sin(A(2).*xdata + A(3)) + A(4);
    A = lsqcurvefit(fun,x0,xdata,ydata);
    Iampl(i)  = A(1);
    Iphase(i) = A(3);
end
han=axes(fig,'visible','off'); 
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Voltage (A)');
xlabel(han, 'time (s)');
sgtitle('Curve Fits of VCA Voltages vs Time for all frequencies')
exportgraphics(gca, 'img/b4_v_curve_fits.png')
hold off;