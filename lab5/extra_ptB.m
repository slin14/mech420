%% impedence magnitude
figure(7);
plot(ptBfrequecies, Zampl_1.','o')
hold on;
plot(ptBfrequecies, Zampl_2.','o')
ylabel('impedence magnitude (Ohms)')
xlabel('frequency (Hz)')
legend('1mm', '30mm', 'Location','southeast')
title('Magnetude of Coil Impedence vs Frequency')
exportgraphics(gca, 'img/b_Z_mag.png')

%% q2 - find L using complex part curve fit
% curve fit imag(Z) = wL
ptA_R = 45; % Ohm

figure(8);
plot(ptBfrequecies, imag(Z_1).','o')
hold on;
plot(ptBfrequecies, imag(Z_2).','o')

% curve fit 1
xdata = ptBfrequecies.';
ydata = imag(Z_1).';
funZ = @(B,xdata) xdata.*2*pi.*B(1);
x0 = [100]; % initial guess
B = lsqcurvefit(funZ,x0,xdata,ydata);
L_1 = B(1);
plot(ptBfrequecies, ptBfrequecies.*2*pi.*L_1)

% curve fit 2
xdata = ptBfrequecies.';
ydata = imag(Z_2).';
funZ = @(B,xdata) xdata.*2*pi.*B(1);
x0 = [100]; % initial guess
B = lsqcurvefit(funZ,x0,xdata,ydata);
L_2 = B(1);
plot(ptBfrequecies, ptBfrequecies.*2*pi.*L_2)

ylabel('complex part of impedence (Ohms)')
xlabel('frequncy (Hz)')
legend('1mm', '30mm', '1mm curve fit', '30mm curve fit', 'Location','southeast')
%legend('Magnitude of Z', 'y = sqrt(R^2 + w^2*L^2)')
title('Complex Part of Coil Impedence vs Frequency Curve Fit')
exportgraphics(gca, 'img/b2_L_curve_fit.png')
hold off

%% q2 - find L using magnitude curve fit
% curve fit abs(Z) = sqrt(R^2 + w^2*L^2)
ptA_R = 45; % Ohm

figure(10);
plot(ptBfrequecies, Zampl_1.','o')
hold on;
plot(ptBfrequecies, Zampl_2.','o')

% curve fit 1
xdata = ptBfrequecies.';
ydata = Zampl_1.';
funZ = @(B,xdata) sqrt(ptA_R^2 + (xdata.*2*pi).^2.*B(1).^2);
x0 = [100]; % initial guess
B = lsqcurvefit(funZ,x0,xdata,ydata);
L_1 = B(1);
plot(ptBfrequecies, sqrt(ptA_R^2 + (ptBfrequecies.*2*pi).^2.*L_1.^2))

% curve fit 2
xdata = ptBfrequecies.';
ydata = Zampl_2.';
funZ = @(B,xdata) sqrt(ptA_R^2 + (xdata.*2*pi).^2.*B(1).^2);
x0 = [100]; % initial guess
B = lsqcurvefit(funZ,x0,xdata,ydata);
L_2 = B(1);
plot(ptBfrequecies, sqrt(ptA_R^2 + (ptBfrequecies.*2*pi).^2.*L_2.^2))

ylabel('magnitude of impedence (Ohms)')
xlabel('frequncy (Hz)')
legend('1mm', '30mm', '1mm curve fit', '30mm curve fit', 'Location','southeast')
%legend('Magnitude of Z', 'y = sqrt(R^2 + w^2*L^2)')
title('Magnitude of Coil Impedence vs Frequency')
exportgraphics(gca, 'img/b2_L.png')
hold off
