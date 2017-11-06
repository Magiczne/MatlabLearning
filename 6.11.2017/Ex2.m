clear all;
clc;

[X, Y] = meshgrid( 0:0.25:10, 0:0.25:5 );
Z = sin(Y) .* cos(X);

% pierwsze okno ma zawieraæ trzy wykresy mesh
figure(1);
subplot(2,2,1:2);
mesh(X, Y, Z)
title('wykres siatkowy');
subplot(2,2,3);
meshc(X, Y, Z);
title('wykres siatkowy + poziomice');
subplot(2,2,4);
meshz(X, Y, Z);
title('wykres siatkowy + zas³ony');

% drugie okno ma zawieraæ jeden wykres waterfall 
figure(2);
waterfall(X, Y, Z);
title('waterfall');

% trzecie okno ma zawieraæ trzy wykresy surf
figure(3);
subplot(2,2,1:2);
surf(X, Y, Z);
title('wykres powierzchniowy');
subplot(2,2,3);
surfc(X, Y, Z);
title('wykres powierzchniowy + poziomice');
subplot(2,2,4);
surfl(X, Y, Z);
title('wykres powierzchniowy + cieniowanie');

% w czwartym oknie na dwóch wykresach dla surf proszê sprawdziæ jak dzia³a
% przejrzystoœæ alpha
figure(4);
subplot(1, 3, 1);
surf(X, Y, Z);
alpha(0.1);
subplot(1, 3, 2);
surf(X, Y, Z);
alpha(0.5);
% wykorzystuj¹c funkcje mesh, proszê sprawdziæ te¿ ukrywanie krawêdzi:
subplot(1, 3, 3);
mesh(X, Y, Z);
hidden on;

% w pi¹tym oknie sterujemy kolorem i wyœwietlaniem siatki oraz kolorem
% powierzchni
figure(5);
subplot(2, 2, 1);
surf(X, Y, Z, 'FaceColor',[0.5 0.5 0.5], 'EdgeColor','red');

subplot(2, 2, 2);
surf(X, Y, Z, 'FaceColor','blue', 'EdgeColor','none');

subplot(2, 2, 3);
surf(X, Y, Z, 'FaceColor',[0.5 0.5 0.5], 'EdgeColor','red');
camlight right;

subplot(2, 2, 4);
surf(X, Y, Z, 'FaceColor',[0.5 0.5 0.5], 'EdgeColor','red');
camlight right;
lighting gouraud;

% w szóstym oknie æwiczymy cienie
figure(6);
Z2 = X .* exp(-X.^2 - Y.^2);

subplot(1, 3, 1);
surf(X, Y, Z2);
shading flat;

subplot(1, 3, 1);
surf(X, Y, Z2);
shading interp;

subplot(1, 3, 1);
surf(X, Y, Z2);
shading faceted;

% w siódmym oknie zobaczymy jakie s¹ mo¿liwoœci wyœwietlania poziomic. 
[X7, Y7] = meshgrid( 0:0.1:10, 0:0.1:5 );
Z7 = sin(Y7) .* cos(X7);

figure(7);
subplot(2, 4, 1:2);
meshc(X7, Y7, Z7);

subplot(2, 4, 3:4);
contour(X7, Y7, Z7, 3);

subplot(2, 4, 5);
[c, h] = contour(X7, Y7, Z7, 3);
clabel(c, h);

subplot(2, 4, 6:7);
contour(X7, Y7, Z7, 5);

subplot(2, 4, 8);
contour(X7, Y7, Z7, 30);