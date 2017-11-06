clear all;
clc;

% Preprare data
x = -pi : .1 : pi;
y = sin(x);
z = cos(x);
a = tan(x);

% Sin
figure(1);
plot(x, y, 'bh:');
grid on;
legend('sin');
title('Sin(x)')
xlabel('x');
ylabel('y');

% Cos
figure(2);
plot(x, z, 'rs');
grid on;
legend('cos');
title('Cos(x)')
xlabel('x');
ylabel('y');

% Tan
figure(3);
plot(x, a, 'ko--');
grid on;
legend('tan');
title('Tan(x)')
xlabel('x');
ylabel('y');
axis([ -1.5 1.5 min(a) max(a) ]);

