clear all;
clc;

Y = round(rand(10, 4) * 100);

% Bar3
figure(1);
subplot(1, 3, 1);
bar3(Y, 'detached');

subplot(1, 3, 2);
bar3(Y, 'grouped');

subplot(1, 3, 3);
bar3(Y, 'stacked');

% Bar3h
figure(2);
subplot(1, 3, 1);
bar3h(Y, 'detached');

subplot(1, 3, 2);
bar3h(Y, 'grouped');

subplot(1, 3, 3);
bar3h(Y, 'stacked');

% Pie3
figure(3);
pie3(Y(1, :));

% Pie
figure(4);
pie(Y(3:4, :));