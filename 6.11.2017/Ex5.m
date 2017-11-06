clear all;
clc;

figure(1);
t = 0:.1:12; 
x = t; 
y = sin(t); 
z = cos(t);
plot3(x, y, z);
grid on; 

figure(2);
x1 = [ 1 1 -1 1 ];
y1 = [ 4 4 4 4 ];
z1 = [ -1 1 1 -1 ];
x2 = [ 1 1 1 1 ];
y2 = [ 4 4 1 4 ];
z2 = [ -1 1 1 -1 ];

hold on;
plot3(x1, y1, z1, 'b', 'LineWidth', 6);
plot3(x2, y2, z2, 'r', 'LineWidth', 6);
hold off;
grid on;
axis equal;

figure(3);
hold on;
fill3(x1, y1, z1, 'r', 'LineWidth', 6);
fill3(x2, y2, z2, 'b', 'LineWidth', 6);
hold off;
grid on;
axis equal;
