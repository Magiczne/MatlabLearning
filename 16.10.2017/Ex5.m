clear all;
clc;

load('dane.mat');

x = dane(:, 1:2);

[~, idx, cnt] = unique(x, 'rows', 'first');

oubt = dane(idx, :);    

cnt = accumarray(cnt, ones(size(cnt)));