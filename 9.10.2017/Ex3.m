clear all;
clc;

V1 = -10:pi/50:10;
V2 = -10:pi/50:10;

sinV1 = sin(V1);
cosV2 = cos(V2);

% ekstrema
[sinMax, sinMaxIdx] = max(sinV1);
[sinMin, sinMinIdx] = min(sinV1);
[cosMax, cosMaxIdx] = max(cosV2);
[cosMin, cosMinIdx] = min(cosV2);

% Rysowanie wykresów
figure(1)
plot(V1, sinV1, V2, cosV2); 
hold on;
plot(V1(sinMaxIdx), sinMax, 'r*');
plot(V1(sinMinIdx), sinMin, 'bp');

% Figure 2
doubleSinx = 2 * sin(V1);
sin2x = sin(2 * V1);
sinsin = sinV1 .* sinV1;

%wartosci
[ dsxMax, dsxMaxIdx ] = max(doubleSinx);
[ sin2xMax, sin2xMaxIdx ] = max(sin2x);
[ sinsinMax, sinsinMaxIdx ] = max(sinsin);

[ dsxMin, dsxMinIdx ] = min(doubleSinx);
[ sin2xMin, sin2xMinIdx ] = min(sin2x);
[ sinsinMin, sinsinMinIdx ] = min(sinsin);

figure(2);
plot(V1, doubleSinx, V1, sin2x, V1, sinsin);
hold on;
plot(V1(dsxMaxIdx), dsxMax, 'r*');
plot(V1(dsxMinIdx), dsxMin, 'r*');

plot(V1(sin2xMaxIdx), sin2xMax, 'r*');
plot(V1(sin2xMinIdx), sin2xMin, 'r*');

plot(V1(sinsinMaxIdx), sinsinMax, 'r*');
plot(V1(sinsinMinIdx), sinsinMin, 'r*');

% Figure 3
V3 = 1:1:1000;
V4 = 1:1:1000000;
V5 = 1:.1:10;

sqrtV3 = sqrt(V3);
logV4 = log(V4);

figure(3);
plot(V3, sqrtV3);

figure(4);
plot(V4, logV4);

figure(5);
plot(V5, 2.^V5, V5, 2.1.^V5)