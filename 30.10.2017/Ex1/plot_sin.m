function plot_sin(Y1)
%CREATEFIGURE(Y1)
%  Y1:  vector of y data

%  Auto-generated by MATLAB on 30-Oct-2017 13:12:11

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'Position',[0.13 0.11 0.775 0.815]);
hold(axes1,'on');

% Create plot
plot(Y1,'LineWidth',2,'Color',[0 0 0]);

% Create light
light('Parent',axes1,...
    'Position',[-0.998235971216192 0.0329332460969392 0.0493998691454088]);

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 70]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',14,'XColor',[0 0 0],'XGrid','on','YColor',[0 0 0],...
    'YGrid','on','ZColor',[0 0 0]);
% Create arrow
annotation(figure1,'arrow',[0.489655172413793 0.488965517241379],...
    [0.112595419847328 0.923664122137404]);

% Create arrow
annotation(figure1,'arrow',[0.129655172413793 0.904137931034483],...
    [0.516175572519084 0.519083969465649]);

