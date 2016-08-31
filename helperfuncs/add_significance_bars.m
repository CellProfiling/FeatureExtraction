function add_significance_bars(pvals,cmat,psig,h)

%if given a figure handle, make it the current figure
if nargin==4
    figure(h)
end

increase_height = false;
msize = 5;

%if not given a significance level, set it to 0.05
if nargin<3 || isempty(psig)
    psig = 0.05;
end

%set up significance tic marks
yt = get(gca, 'YTick');
maxyval = (max(yt)*(1+0.1*sum(pvals<psig)+0.2));
axis([xlim min([min(yt),0]) maxyval])
yrange_scale = (maxyval-max(yt))*0.5;
%xt = [1:length(boxnames)];
%xt = get(gca, 'XTick');
hold on
numStars = 1;
for i = 1:length(pvals)
    if pvals(i)<psig
        if increase_height
            yline = max(yt)+(yrange_scale*numStars);
        else
            yline = max(yt)+yrange_scale;
        end
        %plot(xt([cmat(i,1) cmat(i,2)]), [1 1]*yline, '-k','Linewidth',2)
        plot([cmat(i,1) cmat(i,2)], [1 1]*yline, '-k','Linewidth',2)
        %x_mean = mean(xt([cmat(i,1) cmat(i,2)]));
        x_mean = mean([cmat(i,1) cmat(i,2)]);
        if numStars>1
            range_scale = abs(cmat(i,1)-cmat(i,2))*0.05;
            x_starrange = [x_mean-range_scale*x_mean,x_mean+range_scale];
            x_starlocs = linspace(x_starrange(1),x_starrange(2),numStars);
        else
            x_starlocs = x_mean;
        end
        plot(x_starlocs, repmat((yline+yrange_scale/2),1,numStars), '*k','MarkerSize',msize,'Linewidth',2)
        numStars = numStars+1;
    end
    
end
hold off

set(gcf, 'PaperPositionMode', 'auto');
set(gca,'LineWidth',1.5)
%saveas(gcf,['EccentricityPlot_v2_2016','.png'])