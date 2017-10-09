clear all;
clc;

% macierze
X = eye(5);
A = eye(5, 6);

ones(5);
ones(5, 6);

zeros(5);
zeros(5, 6);

% wektory
linspace(1, 52);
linspace(1, 52, 155);

logspace(1, 52);
logspace(1, 52, 155);

% pseudolosowe
rand(5);
rand(5, 6);
randn(5);
randn(5, 6);

% others
magic(5);
reshape(X, 5, 5);
tril(A);
triu(A);
repmat(A, 2, 2);