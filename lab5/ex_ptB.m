%% q4 impedance as a function of frequency
% Z = R + jwL = V/I


% results
Vampl = ones(length(ptBfrequecies));
Vphase = ones(length(ptBfrequecies));
Iampl = ones(length(ptBfrequecies));
Iphase = ones(length(ptBfrequecies));


for i = 1 : length(ptBfrequecies)

    fileMatrix = readmatrix(sprintf("dat\\lab4partb1mm%dhz.xlsx", ptBfrequecies(i)));
    time   = fileMatrix(:, 1); % s
    coil_v = fileMatrix(:, 4); % V
    coil_i = fileMatrix(:, 5); % A
    
    % trim data to 1 period so computation doesn't take forever
    N = ptBsampleFreq/ptBfrequecies(i);
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
    Vampl(i)  = A(1);
    Vphase(i) = A(3);
    % for current
    ydata = coil_i.';
    x0 = [ydata(1) ptBfrequecies(i)*2*pi 0 0]; % initial guess
    fun = @(A,xdata) A(1).*sin(A(2).*xdata + A(3)) + A(4);
    A = lsqcurvefit(fun,x0,xdata,ydata);
    Iampl(i)  = A(1);
    Iphase(i) = A(3);
    
    fig = figure(8); subplot(3,6,i);
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
exportgraphics(gca, 'img/b_ex_i_curve_fits.png')
hold off;