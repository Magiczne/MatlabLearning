clear all;
clc;

Ainv =  [-0.4474 0.5263 0.2632 0.8421;
 0.3421 -0.5789 0.2105 -0.5263;
0.0263 0.2632 -0.3684 0.4211;
 -0.0789 0.2105 0.1053 -0.2632];

A = inv(Ainv)
detA = det(A);
Aprim = A'

eigA = eig(A);
rankA = rank(A);
diagA = diag(A);

% Elementy niediagonalne
notDiagonal = A - diagA

flipLrA = fliplr(A)
flipUdA = flipud(A)