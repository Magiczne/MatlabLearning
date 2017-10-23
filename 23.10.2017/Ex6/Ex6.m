clear all;
clc;

% W = floor(rand(1, 10000) * 100 + 1);
W = floor(rand(100, 100) * 100 + 1);

ile_parzystych = count_even(W);
[suma, srednia] = sum_and_avg(W);
[suma2, srednia2] = sum_and_avg_when_can_divide_by_3(W);
[Wmin, Wmax] = min_and_max_when_can_be_divided_by_5(W);
[Wmin2, Wmax2] = min_and_max_when_can_be_divided_by(W, 2);
