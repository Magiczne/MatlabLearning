clear all;
clc;

M1 = eye(100, 1000);
M2 = ones(100, 1000);
M3 = zeros(100, 1000);

savefile = 'ex5data.mat';
save(savefile, 'M1', 'M2');