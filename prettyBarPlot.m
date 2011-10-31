function handle=prettyBarPlot(vals,names,axislabel,confIntWidths,direction)

	% handle=prettyBarPlot(vals,names,axislabel,confIntWidths,handleToBarPlotFunc)
	%
	% Inputs-
	%	vals				= vector containing the correlation values you want to plot
	%	names				= cell array of strings containing names for each case
	%	axislabel			= string for the axis label
	%	confIntWidths		= 2 column matrix containing widths of lower and upper bounds from the mean; specify as false to skip
	%		CORRELATION ANALYSIS
	%			confwidths=intervalEstimationOfCorrCoeff(vals,numberPerCondition); % 95% confidence by default
	%		STMI BONFERRONI
	%			use the halfwidths from multcompare (see abbie_multcompare and/or statTesting)
	%	direction			= plot the bars horizontally ('h') or vertically ('v')


if nargin<5
	direction='h';
end
if strcmp(direction,'v')
	handleToBarPlotFunc=@bar;
	handleToErrorBarFunc=@errorbar;
	whichAxisContainsGroupNames='X';
	whichAxisContainsTheValues='Y';
	handleToLabelFunction=@ylabel;
else
	handleToBarPlotFunc=@barh;
	handleToErrorBarFunc=@errorbar_x;
	whichAxisContainsGroupNames='Y';
	whichAxisContainsTheValues='X';
	handleToLabelFunction=@xlabel;
end
if nargin<4
	confIntWidths=false;
end
if nargin<3
	axislabel='|r_p|';
end

accentColor=0.5;
mainBarColor=0.2;
fontSize=20;

figure('color','white');
hold on;

handle=handleToBarPlotFunc(vals,0.7,'FaceColor',mainBarColor*[1 1 1],'Edgecolor',accentColor*[1 1 1]);

set(gca,...
	'TickDir','out',...
	[whichAxisContainsTheValues 'Grid'],'on',...
	[whichAxisContainsGroupNames 'Lim'],[0.5 length(vals)+0.5],...
	[whichAxisContainsGroupNames 'LimMode'],'manual',...
	[whichAxisContainsGroupNames 'TickMode'],'manual',...
	[whichAxisContainsGroupNames 'Tick'],1:length(vals),...
	[whichAxisContainsGroupNames 'TickLabelMode'],'manual',...
	[whichAxisContainsGroupNames 'TickLabel'],names,...
	'FontSize',fontSize,...
	'FontName','Helvetica Neue',...
	'FontWeight','normal',...
	'GridLineStyle','-',...
	'Box','off');
set(handle,'ShowBaseLine','off',...
	'LineWidth',1.2);
handleToLabelFunction(['$' axislabel '$'],...
	'interpreter','latex',...
	'FontSize',30);

% Add confidence intervals
if not(islogical(confIntWidths))
	if strcmp(direction,'v')
		xandy=[(1:length(vals)).' vals(:)];
	else
		xandy=[vals(:) (1:length(vals)).'];
	end
	
	errorHandle=handleToErrorBarFunc(xandy(:,1),xandy(:,2),...
		confIntWidths(:,1),confIntWidths(:,2),'k-'); % NOTE this 'k-' is causing problems with the vertical case
	set(errorHandle,...
		'LineWidth',1.75,...
		'Color',accentColor*[1 1 1]);
end

% Add text labels of the values
for ii=1:length(vals)
	if exist('confIntWidths','var')
		whereToPutValue=vals(ii)+confIntWidths(ii,2);
	else
		whereToPutValue=vals(ii);
	end
	if strcmp(direction,'v')
		xandy=[ii,whereToPutValue+0.02*diff(get(gca,'YLim'))];
	else
		xandy=[whereToPutValue+0.02*diff(get(gca,'XLim')),ii];
	end
	text(xandy(1),xandy(2),...
		sprintf('%1.2f',vals(ii)),...
		'FontSize',fontSize,...
		'FontName','Helvetica Neue',...
		'FontWeight','bold');
end
