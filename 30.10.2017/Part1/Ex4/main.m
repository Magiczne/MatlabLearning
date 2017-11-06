clear all;
clc;

x = 0 : 0.1 : 1;
y1 = x;
y2 = exp(x);
y3 = log2(x);

figure(1);
subplot(2, 2, 1:2);
plot(x, y1);

subplot(2, 2, 3);
plot(x, y2);

subplot(2, 2, 4);
plot(x, y3);