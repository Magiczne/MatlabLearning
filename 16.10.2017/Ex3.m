clc;

V = 2:2:10000;

tic;

Vmax = V(1);
for i = 2 : 1 : length(V)
	if V(i) > Vmax
		Vmax = V(i);
	end
end

toc

tic;
Vmax2 = max(V);
toc