clear all;
clc;

syms x;
syms y;
syms z;

[ x, y, z ] = solve('x+2*y+3*z=4', '4*x+6*y+6*z=1', '2*x-y-2*z=2');