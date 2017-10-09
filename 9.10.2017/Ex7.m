clear all;
clc;

load('tablica_dobra.mat')

who

size(tablica55)

max(max(tablica55))
min(min(tablica55))
mean(mean(tablica55))
sum(sum(tablica55))

arrayMax = max(max(max(tablica55)))
arrayMin = min(min(min(tablica55)))
mean(mean(mean(tablica55)))
sum(sum(sum(tablica55)))

det(tablica55(1:3,1:3,1))
inv(tablica55(2:4,2:4,2))
eig(tablica55(1:3,1:3,3))
rank(tablica55(:,:,4))
diag(tablica55(:,:,5))
fliplr(tablica55(:,:,6))
flipud(tablica55(:,:,7))
rot90(tablica55(:,:,7))

idxsMin = find(tablica55 == arrayMax)
idxsMax = find(tablica55 == arrayMin)

xxx = reshape(tablica55, 1, numel(tablica55))

figure(1);
plot(1:1:numel(tablica55), xxx);
hold on;
plot(idxsMin, arrayMin, 'r*');
plot(idxsMax, arrayMax, 'b*');

