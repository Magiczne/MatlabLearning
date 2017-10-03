% Polynomials
clear all;
clc;

p = [3, -1, 1, -4, -5];
pDer1 = polyder(p);
pDer2 = polyder(pDer1);

r = roots(p);
r1 = roots(pDer1);
r2 = roots(pDer2);

% polyval(p, [])

sampleVal = polyval(p, 0);
sampleVal2 = polyval(p, -2000);
sampleVal3 = polyval(p, -654);

p2 = poly([1 -1 8 -1/4]);

p3 = conv(p, p2);
magic = deconv(p, p2);
[magic1, magic2] = deconv(p, p2);

disp('Pierwiastki p:');
disp(r);

disp('Pierwiastki 1 pochodnej: ');
disp(r1);

disp('Pierwiastki 2 pochodnej: ');
disp(r2);

disp('Wartoœci w punktach: ');
disp(['p(0) = ', num2str(sampleVal)]);
disp(['p(-2000) = ', num2str(sampleVal2)]);
disp(['p(-654) = ', num2str(sampleVal3)]);

disp('Wielomian p2');
disp(p2);

disp('Wektor wspolczynnikow: ');
disp(p3);

disp('Iloraz i reszta: ');
disp('Iloraz: ');
disp(magic2);

disp('Reszta: ');
disp(magic1);