clear all;
clc;

% Ad 1.
O = ones(5, 4);
Z = zeros(5, 4);
R = rand(5, 4);

% Ad 2.
A = magic(4);
B = randn(4);
C = [1;2;3;4;5;6;7;8];
D = 1:1:8;

% Ad 3.
A(:,2)

% Ad 4.
E = [ A(:,1); B(:,4) ];

AB = A * B;
BA = B * A;
ABC = A * B * C(1:4);

% Ad 4.1.
ABC1 = A(1:3,1:3) * B(1:3,1:3) * C(1:3);
ABC2 = A(2:4,1:3) * B(1:3, 1) * C(1)

% Ad 4.2.
ABC3 = A(1:2, 1:2) * B(1:2, 1:2) * C(1:2);