clear all;
clc;

syms x;
syms y;

w1 = (x^4 + 3*x^2 + 10*x - 5) * (5*y^3 - y);
w2 = x^3 - 6*x^2 + 11*x - 6;
w3 = x^3 - y^3;

expand_w1 = expand(w1);
horner_w2 = horner(w2);
factor_w3 = factor(w3);

sum12 = collect(w1 + w2, x);
oneminus2 = collect(w1 - w2, y);
onetimes2 = collect(w1 * w2, x);
one2 = collect(w1 / w2, y);