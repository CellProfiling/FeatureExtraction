function genPHeatMap(datamat,xlabels,ylabels,minmax,savename)

h = figure('Position', [100, 100, 1549, 895]);

%rare phenotypes with rare localizations will be HIGHLY ENRICHED

%%%get scale P-values
if nargin<4 || isempty(minmax)
    mincolor = 0;
    maxcolor = 1;
else
    mincolor = min(minmax);
    maxcolor = max(minmax);
end

numcolors = 10;
numunique = length(unique(datamat(:)));
if numunique<numcolors
    numcolors = numunique;
end

% datamat(datamat>maxcolor) = NaN;
% lnphenoVSloc = log(phenoVSloc_acprob_diff);
% lnphenoVSloc(lnphenoVSloc==-Inf) = NaN;
% heatmap(lnphenoVSloc, [locnames], [phenonames_woCMPO], '%0.2f','TickAngle',45,'ShowAllTicks',true, 'Colormap', 'money', ...
heatmap(datamat, [xlabels], [ylabels], '%0.2f','TickAngle',45,'ShowAllTicks',true, 'Colormap', @(N) linspecer(N,'twosided'), ...
    'Colorbar', true,'ColorLevels',numcolors,'NaNColor', [0 0 0],'UseLogColormap', true,'MinColorValue', ...
    mincolor, 'MaxColorValue', maxcolor,'UseLogColormap', true,'FontSize',20);

set(gca,'FontSize',20)
set(gca,'color','none')

if nargin<5 || isempty(savename)
    warning('No save path specified for heatmap, not saving!')
else
    set(gcf, 'PaperPositionMode','auto')
    saveas(gcf,[savename],'tif')
end
hold off
