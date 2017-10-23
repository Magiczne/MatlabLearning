clc;

tic;
    V = round(rand(1000, 1) * 100);
toc

V2 = zeros(1000, 1);
tic;
    for i = 1 : 1 : 1000
        V2(i) = round(rand() * 100);
    end
toc


Vmax = max(V);
Vmin = min(V);

VminIndexes = find(V == Vmin);

Vis10 = find(V == 10);
length(Vis10)