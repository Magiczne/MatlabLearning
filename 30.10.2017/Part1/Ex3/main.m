clear all;
clc;

x = 0 : 0.1 : pi/4;

y = sin(x)
y2 = x;

figure(1);
hold on;
plot(x, y);
plot(x, y2);
hold off;