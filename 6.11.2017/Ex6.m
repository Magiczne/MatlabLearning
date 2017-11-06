clear all;
clc;

x = 1:0.1:3*pi;
y = sin(x);

% figure(1);
% comet(x, y);
% grid on;
% 
% t =  -10 * pi : pi / 250 : 10 * pi;
% x2 = (cos(2*t) .^ 2) .* sin(t);
% y2 = (sin(2*t) .^ 2) .* cos(t);
% 
% figure(2);
% comet3(x2, x2, t);
% grid on;

% figure(3);
for k = 1:16
plot(fft(eye(k+16)))
axis equal
M(k) = getframe;
end
movie(M,3)