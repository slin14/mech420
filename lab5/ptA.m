% 423 Lab 5
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

% for each coil current
for i = 1 : length(ptAcurrents)
    fileMatrix = readmatrix(sprintf("data\\partA\\aa_%.1fA.xlsx", ptAcurrents(i)));
    N = length(fileMatrix(:,1));
    
    % position
    lvdt_voltage = fileMatrix(:, 3);
    position = (lvdt_voltage - lvdt_v0) ./ lvdt_b0;
    position = position - position(1); % zero
    position = position(trimIndex:N); % trim

    % force
    load_cell = fileMatrix(:, 2); % kg
    load_cell = load_cell - lab_load_cell; % compensate for LabView offset
    force = load_cell * g;
    force = force(trimIndex:N); % trim

    plot(position, force, 'LineWidth', 2)
    hold on;
    %f_avg(i) = mean(force(int32(N*trim):N));

    % Curve Fit
    xdata = position.';
    ydata = force.';
    funZ = @(C,xdata) C(1).*ptAcurrents(i).^2./(C(2) + xdata).^2
    x0 = [1 1]; % initial guess
    C = lsqcurvefit(funZ,x0,xdata,ydata);
    plot(position, C(1).*ptAcurrents(i).^2./(C(2) + position).^2, "--")
end

ylabel('Force (N)')
xlabel('Position (mm)')
legend('0A', '0.3A', '0A curve fit', sprintf('0.3A curve fit, C1 = %.2f, C2 = %.2f', C(1), C(2)))
title('Force vs position using F(x_s_a, I_c_o_i_l) = C_1*I_c_o_i_l^2/(C_2 + x_s_a)^2')
%title(sprintf('Magnitude of Coil Impedence vs Frequency, L from best fit = %.4fH',L))
exportgraphics(gca, 'img/a2_curve_fit_0.3A.png')
hold off

%% q4 - coil resistance for different currents
figure(3)

% for each coil current
for i = 1 : length(ptAcurrents)
    fileMatrix = readmatrix(sprintf("data\\partA\\aa_%.1fA.xlsx", ptAcurrents(i)));
    N = length(fileMatrix(:,1));
    
    % position
    lvdt_voltage = fileMatrix(:, 3);
    position = (lvdt_voltage - lvdt_v0) ./ lvdt_b0;
    position = position - position(1); % zero
    position = position(trimIndex:N); % trim

    % force
    load_cell = fileMatrix(:, 2); % kg
    load_cell = load_cell - lab_load_cell; % compensate for LabView offset
    force = load_cell * g;
    force = force(trimIndex:N); % trim

    plot(position, force, 'LineWidth', 2)
    hold on;
    %f_avg(i) = mean(force(int32(N*trim):N));

    % Curve Fit
    xdata = position.';
    ydata = force.';
    funZ = @(C,xdata) C(1).*ptAcurrents(i).^2./(C(2) + xdata).^2
    x0 = [1 1]; % initial guess
    C = lsqcurvefit(funZ,x0,xdata,ydata);
    plot(position, C(1).*ptAcurrents(i).^2./(C(2) + position).^2, "--")
end

ylabel('Force (N)')
xlabel('Position (mm)')
legend('0A', '0.3A', '0A curve fit', sprintf('0.3A curve fit, C1 = %.2f, C2 = %.2f', C(1), C(2)))
title('Force vs position using F(x_s_a, I_c_o_i_l) = C_1*I_c_o_i_l^2/(C_2 + x_s_a)^2')
%title(sprintf('Magnitude of Coil Impedence vs Frequency, L from best fit = %.4fH',L))
exportgraphics(gca, 'img/a2_curve_fit_0.3A.png')
hold off

