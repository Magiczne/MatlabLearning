clear all;
clc;

T1 = rand(3, 3, 3);
sum(sum(sum(T1)))
min(min(min(T1)))
max(max(max(T1)))
mean(mean(mean(T1)))

T2 = sum(T1)

T3 = T1(:,:,1) * T1(:,:,3)


T4 = rand(3, 3, 3, 3);
T5 = rand(3, 3, 3, 3, 3);