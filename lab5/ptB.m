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

%%
figure(7);
plot(ptBfrequecies, Zampl_1.','o')
hold on;
plot(ptBfrequecies, Zampl_2.','o')
ylabel('impedence magnitude (Ohms)')
xlabel('frequency (Hz)')
legend('1mm', '30mm', 'Location','southeast')
title('Magnetude of Coil Impedence vs Frequency')
exportgraphics(gca, 'img/b2_Z_mag.png')

