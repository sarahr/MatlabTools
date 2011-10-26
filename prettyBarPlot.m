function handle=prettyBarPlot(vals,names,axislabel,confInt,handleToBarPlotFunc)

	% handle=prettyBarPlot(vals,names,axislabel,confInt,handleToBarPlotFunc)
	%
	% Inputs-
	%	vals				= vector containing the correlation values you want to plot
	%	names				= cell array of strings containing names for each case
	%	axislabel			= string for the axis label
	%	confInt				= 2 column matrix containing lower and upper bounds; specify as false to skip
	%		CORRELATION ANALYSIS
	%			confwidths=intervalEstimationOfCorrCoeff(vals,numberPerCondition); % 95% confidence by default
	%			lower=vals(:)-confwidths(:,1);
	%			upper=confwidths(:,2)-vals(:);
	%			confInt=[lower(:) upper(:)];
	%		STMI BONFERRONI
	%			use the halfwidths from multcompare (see abbie_multcompare and/or statTesting)
	%	handleToBarPlotFunc	= handle to the plotting function (defaults to @barh)
	%						 call bar to plot vertical bars
	%						 call barh to plot horizontal bars


if nargin<5
	handleToBarPlotFunc=@barh;
end
if nargin<4
	confInt=false;
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
	'XGrid','on',...
	'YLim',[0.5 length(vals)+0.5],...
	'YLimMode','manual',...
	'YTickMode','manual',...
	'YTick',1:length(vals),...
	'YTickLabelMode','manual',...
	'YTickLabel',names,...
	'FontSize',fontSize,...
	'FontName','Helvetica Neue',...
	'FontWeight','normal',...
	'GridLineStyle','-',...
	'Box','off');
set(handle,'ShowBaseLine','off',...
	'LineWidth',1.2);
xlabel(['$' axislabel '$'],...
	'interpreter','latex',...
	'FontSize',30);

% Add confidence intervals
if not(islogical(confInt))
	errorHandle=errorbar_x(vals(:).',1:length(vals),...
		confInt(:,1),confInt(:,2),'k-');
	set(errorHandle,...
		'LineWidth',1.75,...
		'Color',accentColor*[1 1 1]);
end

% Add text labels of the values
for ii=1:length(vals)
	if exist('confInt','var')
		xPosForText=confInt(ii,2)+vals(ii);
	else
		xPosForText=vals(ii);
	end
	defaultXaxisLength=diff(get(gca,'XLim'));
	text(xPosForText+0.02*defaultXaxisLength,ii,...
		sprintf('%1.2f',vals(ii)),...
		'FontSize',fontSize,...
		'FontName','Helvetica Neue',...
		'FontWeight','bold');
end
