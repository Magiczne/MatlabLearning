% Date: 13.11.2017
% Author: Micha³ Kleszczyñski

clear all;
silence_data = load('cisza.txt');
processed_data = tabulate(silence_data(:, 1));

% Ex 1.
most_common_value = most_common( processed_data );

% Ex 2.
[ silence_start, silence_end ] = find_longest( silence_data(:, 2) );

% Ex 3.
figure1 = figure;
% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% Create bar
bar( processed_data(:, 2) );
% Create xlabel
xlabel('Pomiar [dB]');
% Create title
title('Iloœæ wyst¹pieñ poszczególnych pomiarów');
% Create ylabel
ylabel('Liczba wyst¹pieñ');
% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[0 57]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XColor',[0 0 0],'XTick',[1 10 20 30 40 50 57],'XTickLabel',...
    {'16.8','17.7','18.7','19.7','20.7','22.8','27.5'},'YColor',[0 0 0],...
    'ZColor',[0 0 0]);

