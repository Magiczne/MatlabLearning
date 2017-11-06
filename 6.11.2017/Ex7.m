clear all;
clc;

t = 0 : 0.1 : 10;

for k = 1:100
    tmp = t(1:k);
    
    plot( tmp .* cos(tmp), tmp .* sin(tmp) );
    axis equal
    M(k) = getframe;
end

movie(M,3)