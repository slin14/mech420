% 423 Lab 5 - Part A
% load parameters and data
% -> run setup_ptA.m

%% q1 - F(x_sa) vs position for different I_coil
figure
figure(1)
plot(position0, force0, 'LineWidth', 2)
hold on;
plot(position1, force1, 'LineWidth', 2)
ylabel('Actuator Force (N)')
xlabel('Position (mm)')
%xlim([0 position(end)])
legend('0A', '0.3A')
title('Actuator Force vs Position for different coil currents')
exportgraphics(gca, 'img/a1_F_vs_position.png')
hold off

%% q2 - curve fit for force as a func of position and current

figure(2)

plot(position0, force0, 'LineWidth', 2)
hold on;
plot(position1, force1, 'LineWidth', 2)

% Curve Fit 0
xdata = position0.';
ydata = force0.';
funZ = @(C,xdata) C(1).*ptAcurrents(1).^2./(C(2) + xdata).^2
x0 = [1 1]; % initial guess
C = lsqcurvefit(funZ,x0,xdata,ydata);
plot(position0, C(1).*ptAcurrents(1).^2./(C(2) + position0).^2, "--")

% Curve Fit 1
xdata = position1.';
ydata = force1.';
funZ = @(C,xdata) C(1).*ptAcurrents(2).^2./(C(2) + xdata).^2
x0 = [1 1]; % initial guess
C = lsqcurvefit(funZ,x0,xdata,ydata);
plot(position1, C(1).*ptAcurrents(2).^2./(C(2) + position1).^2, "--")

ylabel('Force (N)')
xlabel('Position (mm)')
%legend('measured', sprintf('curve fit, C1 = %.2f, C2 = %.2f', C(1), C(2)))
legend('0A', '0.3A', '0A curve fit', sprintf('0.3A curve fit, C1 = %.2f, C2 = %.2f', C(1), C(2)))
title('Force vs position using F(x_s_a, I_c_o_i_l) = C_1*I_c_o_i_l^2/(C_2 + x_s_a)^2')
%title(sprintf('Magnitude of Coil Impedence vs Frequency, L from best fit = %.4fH',L))
exportgraphics(gca, 'img/a2_curve_fit_0.3A.png')
hold off

%% q4 - coil resistance for different currents
figure(3)

resistance0 = (lab_voltage(1) - coil_voltage0) ./ coil_current0;
resistance1 = (lab_voltage(2) - coil_voltage1) ./ (coil_current1 - lab_current(2));

%plot(position0, resistance0, 'LineWidth', 2)
%hold on;
plot(position1, resistance1, 'r', 'LineWidth', 2)

ylabel('Coil Resistance (Ohm)')
xlabel('Position (mm)')
%legend('0A', '0.3A')
title('Coil Resistance vs Position for different coil currents')
exportgraphics(gca, 'img/a3_R_vs_I.png')
hold off

