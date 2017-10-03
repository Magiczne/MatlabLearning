% Exercise 1
clear all;
clc;

meters = input('Enter meters to calculate: ');

cm = meters / 100;
inches = meters * 39.37;
feet = meters * 3.28;
yards = meters * 1.09;
miles = meters * 0.00062;

disp([num2str(meters), ' [m] = ']);
disp([num2str(cm), ' [cm]']);
disp([num2str(inches), ' [inches]']);
disp([num2str(feet), ' [feet]']);
disp([num2str(yards), ' [yards]']);
disp([num2str(miles), ' [miles]']);