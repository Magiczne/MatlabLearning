clear all;
clc;

x = -5:5;
y = -10:10;

[X, Y] = meshgrid(x, y);

Z = X .^ 3 + 3 .* X .* Y .^ 2 + 12 .* X .* Y;

figure(1);
mesh(X, Y, Z);
colorbar;a

figure(2);
surf(X, Y, Z);
colorbar;
