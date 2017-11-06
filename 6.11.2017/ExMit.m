clf;
[x, y, z] = meshgrid(-3:0.1:3);
u = x .* x + cos(4*x) + 3;         % x-component of vector field
v = sin(4*x) - sin(2*y);      % y-component of vector field
w = -z;                       % z-component of vector field

[cx, cy, cz] = meshgrid([-1 0 1]);
h = coneplot(x, y, z, u, v, w, cx, cy, cz, 9);
set(h, 'FaceColor', 'r', 'EdgeColor', 'none');
camlight; lighting gouraud;

grid on; box on;
axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]);
view(-30, 60);