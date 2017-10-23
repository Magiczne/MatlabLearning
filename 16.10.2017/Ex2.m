clear all;
clc;

s = input('Lubisz placki?', 's');

while ~strcmp(s, 't') && ~strcmp(s, 'T')
    s = input('Lubisz placki?', 's');
end