function exampleErrorplot

xval = [1:10];
yval = (rand(1,10)*10)';%make it on the scale of 1-10
yerror = rand(1,10)';%make it on the scale 0-1 (1/10 orig)

ydata = [yval-yerror,yval,yval+yerror];

xlabelstr = 'well number';
ylabelstr = 'expression level';
titlestr = 'your title    .'; %(for no title write '') - the title spacing is messed up so the period forces the full title to be visible
plottype = 'errorbar';%the type of plotting you want
plotstyle = {'--b','.-b','--b'};%cell array of how you want your plot to look
newfigure = 1;%boolean flag of if you want a new figure or not

niceplot(xval,ydata,xlabelstr,ylabelstr,titlestr,plottype,plotstyle,newfigure)


%%%Do it again for your other data 
xval2 = [1:10];
yval2 = (rand(1,10)*12)';%make it on the scale of 1-10
yerror2 = rand(1,10)';%make it on the scale 0-1 (1/10 orig)

ydata = [yval2-yerror2,yval2,yval2+yerror2];

%xlabelstr = 'well number';
%ylabelstr = 'expression level';
%titlestr = 'your title'; %(for no title write '')
plottype = 'errorbar';%the type of plotting you want
plotstyle = {'--r','.-r','--r'};%cell array of how you want your plot to look
newfigure = 0;%boolean flag of if you want a new figure or not

niceplot(xval,ydata,xlabelstr,ylabelstr,titlestr,plottype,plotstyle,newfigure)

