% 423 Lab 5 - Part B
% load parameters and data
% -> run setup_ptB.m

%% q1 - complex impedance bode plots
% 1 mm
V_1 = Vampl_1(:,1).*complex(cos(Vphase_1(:,1)),sin(Vphase_1(:,1)));
I_1 = Iampl_1(:,1).*complex(cos(Iphase_1(:,1)),sin(Iphase_1(:,1)));

V_1 = V_1.';
I_1 = I_1.';

Z_1 = V_1./I_1;
Zampl_1 = abs(V_1./I_1);
Zphase_1 = angle(V_1./I_1);

% 30 mm
V_2 = Vampl_2(:,1).*complex(cos(Vphase_2(:,1)),sin(Vphase_2(:,1)));
I_2 = Iampl_2(:,1).*complex(cos(Iphase_2(:,1)),sin(Iphase_2(:,1)));

V_2 = V_2.';
I_2 = I_2.';

Z_2 = V_2./I_2;
Zampl_2 = abs(V_2./I_2);
Zphase_2 = angle(V_2./I_2);

figure(6);
plot(ptBfrequecies, imag(Z_1).','o')
hold on;
plot(ptBfrequecies, imag(Z_2).','o')
ylabel('complex part of impedence (Ohms)')
xlabel('frequncy (Hz)')
legend('1mm', '30mm', 'Location','southeast')
title('Complex Part of Coil Impedence vs Frequency for both positions')
exportgraphics(gca, 'img/b1_Z_mag.png')



%% q2 - find L using complex part curve fit up to 100 Ohm
% curve fit imag(Z) = wL
ptA_R = 45; % Ohm
trimFreqIndex = 6;

ptBfrequecies_trim = ptBfrequecies(1:trimFreqIndex);
Z_1_trim = Z_1(1:trimFreqIndex);
Z_2_trim = Z_2(1:trimFreqIndex);

figure(9);
plot(ptBfrequecies_trim, imag(Z_1_trim).','o')
hold on;
plot(ptBfrequecies_trim, imag(Z_2_trim).','o')

% curve fit 1
xdata = ptBfrequecies_trim.';
ydata = imag(Z_1_trim).';
funZ = @(B,xdata) xdata.*2*pi.*B(1);
x0 = [100]; % initial guess
B = lsqcurvefit(funZ,x0,xdata,ydata);
L_1_trim = B(1);
plot(ptBfrequecies_trim, ptBfrequecies_trim.*2*pi.*L_1_trim)

% curve fit 2
xdata = ptBfrequecies_trim.';
ydata = imag(Z_2_trim).';
funZ = @(B,xdata) xdata.*2*pi.*B(1);
x0 = [100]; % initial guess
B = lsqcurvefit(funZ,x0,xdata,ydata);
L_2_trim = B(1);
plot(ptBfrequecies_trim, ptBfrequecies_trim.*2*pi.*L_2_trim)

ylabel('complex part of impedence (Ohms)')
xlabel('frequncy (Hz)')
legend('1mm', '30mm', sprintf('1mm curve fit, L=%.2fH',L_1_trim), sprintf('30mm curve fit, L=%.2fH',L_2_trim), 'Location','southeastoutside')
title('Complex Part of Coil Impedence vs Frequency Curve Fit up to 100 Ohm')
exportgraphics(gca, 'img/b2_L_curve_fit_trim.png')
hold off

