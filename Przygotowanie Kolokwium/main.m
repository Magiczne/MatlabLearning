clear all;
clc;

X = round(999 * rand(10, 10) + 1);

[ rows, cols ] = find(rem(X, 3) == 0);