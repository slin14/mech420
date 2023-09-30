%MATLAB script for analyzing excel data
%Lab 1/ MECH 420
%Run 1 section at a time, I was lazy and x/y variables have the same name

%import data for IR sensor
clear;

x_steel = xlsread('lab1.xlsx','IR','C3:C1251');
y_steel = xlsread('lab1.xlsx','IR','D3:D1251');

x_shiny = xlsread('lab1.xlsx','IR','E3:E1392');
y_shiny = xlsread('lab1.xlsx','IR','F3:F1392');

x_sand = xlsread('lab1.xlsx','IR','G3:G1298');
y_sand = xlsread('lab1.xlsx','IR','H3:H1298');

x_shiny_sand = xlsread('lab1.xlsx','IR','I3:I1358');
y_shiny_sand = xlsread('lab1.xlsx','IR','J3:J1358');

x_acrylic = xlsread('lab1.xlsx','IR','K3:K1472');
y_acrylic = xlsread('lab1.xlsx','IR','L3:L1472');

%plot
plot(x_steel,y_steel,'LineWidth', 1.35);
hold on;
plot(x_shiny,y_shiny,'LineWidth', 1.35);
hold on;
plot(x_sand,y_sand,'LineWidth', 1.35);
hold on;
plot(x_shiny_sand,y_shiny_sand,'LineWidth', 1.35);
hold on;
plot(x_acrylic,y_acrylic,'LineWidth', 1.35)

title("IR Sensor Data with Various Material Samples")
xlabel("Relative Distance (mm)")
ylabel("Sensor Voltage (V)")
legend({'Steel','Shiny Al','Sand Blasted Al','Shiny/Sand Blasted Al','Acrylic'},'Location','northeast','Orientation','vertical')

%% Capacitive sensor

clear;

x_steel = xlsread('lab1.xlsx','Capacitive','C3:C1251');
y_steel = xlsread('lab1.xlsx','Capacitive','D3:D1251');

x_shiny = xlsread('lab1.xlsx','Capacitive','E3:E1392');
y_shiny = xlsread('lab1.xlsx','Capacitive','F3:F1392');

x_sand = xlsread('lab1.xlsx','Capacitive','G3:G1298');
y_sand = xlsread('lab1.xlsx','Capacitive','H3:H1298');

x_shiny_sand = xlsread('lab1.xlsx','Capacitive','I3:I1358');
y_shiny_sand = xlsread('lab1.xlsx','Capacitive','J3:J1358');

x_acrylic = xlsread('lab1.xlsx','Capacitive','K3:K1472');
y_acrylic = xlsread('lab1.xlsx','Capacitive','L3:L1472');

%plot
plot(x_steel,y_steel,'LineWidth', 1.35);
hold on;
plot(x_shiny,y_shiny,'LineWidth', 1.35);
hold on;
plot(x_sand,y_sand,'LineWidth', 1.35);
hold on;
plot(x_shiny_sand,y_shiny_sand,'LineWidth', 1.35);
hold on;
plot(x_acrylic,y_acrylic,'LineWidth', 1.35)

title("Capacitive Sensor Data with Various Material Samples")
xlabel("Relative Distance (mm)")
ylabel("Sensor Voltage (V)")
legend({'Steel','Shiny Al','Sand Blasted Al','Shiny/Sand Blasted Al','Acrylic'},'Location','northeast','Orientation','vertical')

%% Eddy sensor

clear;

x_steel = xlsread('lab1.xlsx','Eddy','C3:C1251');
y_steel = xlsread('lab1.xlsx','Eddy','D3:D1251');

x_shiny = xlsread('lab1.xlsx','Eddy','E3:E1392');
y_shiny = xlsread('lab1.xlsx','Eddy','F3:F1392');

x_sand = xlsread('lab1.xlsx','Eddy','G3:G1298');
y_sand = xlsread('lab1.xlsx','Eddy','H3:H1298');

x_shiny_sand = xlsread('lab1.xlsx','Eddy','I3:I1358');
y_shiny_sand = xlsread('lab1.xlsx','Eddy','J3:J1358');

x_acrylic = xlsread('lab1.xlsx','Eddy','K3:K1472');
y_acrylic = xlsread('lab1.xlsx','Eddy','L3:L1472');

%plot
plot(x_steel,y_steel,'LineWidth', 1.35);
hold on;
plot(x_shiny,y_shiny,'LineWidth', 1.35);
hold on;
plot(x_sand,y_sand,'LineWidth', 1.35);
hold on;
plot(x_shiny_sand,y_shiny_sand,'LineWidth', 1.35);
hold on;
plot(x_acrylic,y_acrylic,'LineWidth', 1.35)

title("Eddy Sensor Data with Various Material Samples")
xlabel("Relative Distance (mm)")
ylabel("Sensor Voltage (V)")
legend({'Steel','Shiny Al','Sand Blasted Al','Shiny/Sand Blasted Al','Acrylic'},'Location','northeast','Orientation','vertical')

%% %% LED sensor

clear;

x_steel = xlsread('lab1.xlsx','LED','C3:C1251');
y_steel = xlsread('lab1.xlsx','LED','D3:D1251');

x_shiny = xlsread('lab1.xlsx','LED','E3:E1392');
y_shiny = xlsread('lab1.xlsx','LED','F3:F1392');

x_sand = xlsread('lab1.xlsx','LED','G3:G1298');
y_sand = xlsread('lab1.xlsx','LED','H3:H1298');

x_shiny_sand = xlsread('lab1.xlsx','LED','I3:I1358');
y_shiny_sand = xlsread('lab1.xlsx','LED','J3:J1358');

x_acrylic = xlsread('lab1.xlsx','LED','K3:K1472');
y_acrylic = xlsread('lab1.xlsx','LED','L3:L1472');

%plot
plot(x_steel,y_steel,'LineWidth', 1.35);
hold on;
plot(x_shiny,y_shiny,'LineWidth', 1.35);
hold on;
plot(x_sand,y_sand,'LineWidth', 1.35);
hold on;
plot(x_shiny_sand,y_shiny_sand,'LineWidth', 1.35);
hold on;
plot(x_acrylic,y_acrylic,'LineWidth', 1.35)

title("LED Sensor Data with Various Material Samples")
xlabel("Relative Distance (mm)")
ylabel("Sensor Voltage (V)")
legend({'Steel','Shiny Al','Sand Blasted Al','Shiny/Sand Blasted Al','Acrylic'},'Location','northeast','Orientation','vertical')

%% LED calibration curve
clear all;
clf;
close all;

x_min = 15.1;
x_max = 25.1;

x_steel = xlsread('lab1.xlsx','LED','C3:C1251');
y_steel = xlsread('lab1.xlsx','LED','D3:D1251');

x_shiny = xlsread('lab1.xlsx','LED','E3:E1392');
y_shiny = xlsread('lab1.xlsx','LED','F3:F1392');

x_sand = xlsread('lab1.xlsx','LED','G3:G1298');
y_sand = xlsread('lab1.xlsx','LED','H3:H1298');

x_shiny_sand = xlsread('lab1.xlsx','LED','I3:I1358');
y_shiny_sand = xlsread('lab1.xlsx','LED','J3:J1358');

x_acrylic = xlsread('lab1.xlsx','LED','K3:K1472');
y_acrylic = xlsread('lab1.xlsx','LED','L3:L1472');

% steel
j = 1;
x_steel_up = [];
y_steel_up = [];
for i = 1 : int32(length(x_steel)/2)
    if x_steel(i) >= x_min && x_steel(i) <= x_max
        x_steel_up(j) = x_steel(i);
        y_steel_up(j) = y_steel(i);
        j = j + 1;
    end
end

% shiny Al
j = 1;
x_shiny_up = [];
y_shiny_up = [];
for i = 1 : int32(length(x_shiny)/2)
    if x_shiny(i) >= x_min && x_shiny(i) <= x_max
        x_shiny_up(j) = x_shiny(i);
        y_shiny_up(j) = y_shiny(i);
        j = j + 1;
    end
end

% shiny_sand Al
j = 1;
x_shiny_sand_up = [];
y_shiny_sand_up = [];
for i = 1 : int32(length(x_shiny_sand)/2)
    if x_shiny_sand(i) >= x_min && x_shiny_sand(i) <= x_max
        x_shiny_sand_up(j) = x_shiny_sand(i);
        y_shiny_sand_up(j) = y_shiny_sand(i);
        j = j + 1;
    end
end

% sand Al
j = 1;
x_sand_up = [];
y_sand_up = [];
for i = 1 : int32(length(x_sand)/2)
    if x_sand(i) >= x_min && x_sand(i) <= x_max
        x_sand_up(j) = x_sand(i);
        y_sand_up(j) = y_sand(i);
        j = j + 1;
    end
end

% acrylic
j = 1;
x_acrylic_up = [];
y_acrylic_up = [];
for i = 1 : int32(length(x_acrylic)/2)
    if x_acrylic(i) >= x_min && x_acrylic(i) <= x_max
        x_acrylic_up(j) = x_acrylic(i);
        y_acrylic_up(j) = y_acrylic(i);
        j = j + 1;
    end
end

%calibration equations
p_steel = polyfit(x_steel_up, y_steel_up, 1)
y_steel_up_calib = x_steel_up*p_steel(1) + p_steel(2);
eq_steel = sprintf("Steel calibration: %fx  %f", p_steel(1), p_steel(2))

p_shiny = polyfit(x_shiny_up, y_shiny_up, 1)
y_shiny_up_calib = x_shiny_up*p_shiny(1) + p_shiny(2);
eq_shiny = sprintf("Shiny Al calibration: %fx  %f", p_shiny(1), p_shiny(2))

p_sand = polyfit(x_sand_up, y_sand_up, 1)
y_sand_up_calib = x_sand_up*p_sand(1) + p_sand(2);
eq_sand = sprintf("Sandblasted Al calibration: %fx  %f", p_sand(1), p_sand(2))

p_shiny_sand = polyfit(x_shiny_sand_up, y_shiny_sand_up, 1)
y_shiny_sand_up_calib = x_shiny_sand_up*p_shiny_sand(1) + p_shiny_sand(2);
eq_shiny_sand = sprintf("Shiny Sandblasted Al calibration: %fx  %f", p_shiny_sand(1), p_shiny_sand(2))

p_acrylic = polyfit(x_acrylic_up, y_acrylic_up, 1)
y_acrylic_up_calib = x_acrylic_up*p_acrylic(1) + p_acrylic(2);
eq_acrylic = sprintf("Acrylic calibration: %fx + %f", p_acrylic(1), p_acrylic(2))


%plot
plot_colors = ["#0072BD", "#D95319", "#EDB120", "#7E2F8E", "#77AC30", "#0072BD", "#D95319", "#EDB120", "#7E2F8E", "#77AC30"];
colororder(plot_colors);

plot(x_steel_up,y_steel_up,'LineWidth', 1.35);
hold on;
plot(x_shiny_up,y_shiny_up,'LineWidth', 1.35);
hold on;
plot(x_shiny_sand_up,y_shiny_sand_up,'LineWidth', 1.35);
hold on;
plot(x_sand_up,y_sand_up,'LineWidth', 1.35);
hold on;
plot(x_acrylic_up,y_acrylic_up,'LineWidth', 1.35);
% calibration equations
hold on;
plot(x_steel_up,y_steel_up_calib,"--", 'LineWidth', 1.35);
hold on;
plot(x_shiny_up,y_shiny_up_calib,"--", 'LineWidth', 1.35);
hold on;
plot(x_sand_up,y_sand_up_calib,"--", 'LineWidth', 1.35);
hold on;
plot(x_shiny_sand_up,y_shiny_sand_up_calib,"--", 'LineWidth', 1.35);
hold on;
plot(x_acrylic_up,y_acrylic_up_calib,"--", 'LineWidth', 1.35);

title("LED Sensor Calibration")
xlabel("Relative Distance (mm)")
ylabel("Sensor Voltage (V)")
xlim([x_min x_max])
ylim([0 10])
legend({'Steel','Shiny Al','Sand Blasted Al','Shiny/Sand Blasted Al','Acrylic',eq_steel,eq_shiny,eq_sand,eq_shiny_sand,eq_acrylic},'Location','eastoutside','Orientation','vertical')
saveas(gcf,'3_led.png')
