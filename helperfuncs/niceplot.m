function H = niceplot(xval,yval,xlabelstr,ylabelstr,titlestr,plottype,plotstyle,newfigure)
%NICEPLOT Helper function to plot something that is readable and savable in a new figure window.
%
%Inputs:
%
% xval = vector of x values 
% yval = vector of y values
% xlabelstr = string for name of the x variable
% ylabelstr = string for name of the y variable
% titlestr = optional string to label the figure with a title
% plottype = string of plot type (scatter,plot,semilogx,semilogy,loglog)
% plotstyle = string e.g. '.' or '-B'
%
%Outputs:
% h = figure handle
%
%Author: Devin Sullivan 6/17/13

% Copyright (C) 2007-2013  Murphy Lab
% Carnegie Mellon University
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published
% by the Free Software Foundation; either version 2 of the License,
% or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
% 02110-1301, USA.
%
% For additional information visit http://murphylab.web.cmu.edu or
% send email to murphy@cmu.edu

if nargin<8
    newfigure=1;
end

if nargin<7
    plotstyle = '.';
elseif nargin==5
    plotstyle = '.';
    plottype = 'scatter';
elseif nargin==4
    plotstyle = '.';
    plottype = 'scatter';
    titlestr = '';
end

if newfigure
    H = figure('Position', [100, 100, 1800, 1040]);%H = figure
else 
    H = gcf
    hold on
end

%figure out if we are making an error bar plot
errorcolor_notset = 0;
if any(size(yval))==3 && ~strcmpi(plottype,'errorbar')
    disp('We have a set of y values, ignoring style and making an error plot.')
    plottype = 'errorbar';
    errorcolor_notset = 1;
    
end

switch plottype

    case 'scatter'
        %figure,scatter(xval,yval,100,plotstyle);
        scatter(xval,yval,100,plotstyle);
    case 'plot'
        %figure,plot(xval,yval,plotstyle,'Linewidth',2,'MarkerSize',20);
        plot(xval,yval,plotstyle,'Linewidth',2,'MarkerSize',50);
    case 'semilogx'
        %figure,semilogx(xval,yval,plotstyle,'Linewidth',2,'MarkerSize',20);
        semilogx(xval,yval,plotstyle,'Linewidth',2,'MarkerSize',20);
    case 'semilogy'
        %figure,semilogy(xval,yval,plotstyle,'Linewidth',2,'MarkerSize',20);
        semilogy(xval,yval,plotstyle,'Linewidth',2,'MarkerSize',20);
    case 'loglog'
        %figure,loglog(xval,yval,plotstyle,'Linewidth',2,'MarkerSize',20);
        loglog(xval,yval,plotstyle,'Linewidth',2,'MarkerSize',20);
    case 'errorbar'
        %check that we have a cell array for the plot styles 
        if ~iscell(plotstyle)
            warning('errorbar plot requested without cell array of plot styles. Using default -- style for error lines')
            plotstyle = {'--',plotstyle,'--'};
        end
        %make sure the y values are the way we are expecting them
        if size(yval,1)==3 && size(yval,2)~=3
            yval = yval';
        end
        %first plot the mean 
        plotobj = plot(xval,yval(:,2),plotstyle{2},'Linewidth',2,'MarkerSize',20);
        hold on
        lincol = get(plotobj, 'Color');
        %now plot the error bars
        currplot = plot(xval,yval(:,1),plotstyle{1},'Linewidth',1,'MarkerSize',20);
        
        %if they were not specified, set the color of error line 
        if errorcolor_notset
            set(currplot, 'Color',lincol);
        end
        plot(xval,yval(:,3),plotstyle{3},'Linewidth',1,'MarkerSize',20);
        %if they were not specified, set the color of error line
        if errorcolor_notset
            set(currplot, 'Color',lincol);
        end
        hold off
    otherwise
        disp('Sorry, unrecognized plot type');
        return
end
title(titlestr,'FontSize',20,'Fontname','Ariel')
xlabel(xlabelstr,'FontSize',20,'Fontname','Ariel');
ylabel(ylabelstr,'FontSize',20,'Fontname','Ariel');
set(gca,'FontSize',20)
set(gcf, 'PaperPositionMode', 'auto');