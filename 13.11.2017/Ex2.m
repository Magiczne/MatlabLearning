clear all;
clc;

syms x;
syms y;
syms m;

[ x, y ] = solve('x+m*y=m', 'x+2*y=1');

m = 3;
w1 = subs(x);
disp(w1);