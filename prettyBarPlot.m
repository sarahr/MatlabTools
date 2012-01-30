function handle=prettyBarPlot(vals,names,axislabel,confWidths,direction,fontType,sigfigs)

	% handle=prettyBarPlot(vals,names,axislabel,confWidths,direction,fontType)
	%
	% Inputs-
	%	vals				= vector containing the correlation values you want to plot
	%	names				= cell array of strings containing names for each case
	%	axislabel			= string for the axis label
	%	confWidths			= 2 column matrix containing widths of lower and upper bounds from the mean; specify as false to skip
	%		CORRELATION ANALYSIS
	%			confwidths=intervalEstimationOfCorrCoeff(vals,numberPerCondition); % 95% confidence by default
	%			lower=vals(:)-confwidths(:,1);
	%			upper=confwidths(:,2)-vals(:);
	%			confWidths=[lower(:) upper(:)];
	%		STMI BONFERRONI
	%			use the halfwidths from multcompare (see abbie_multcompare and/or statTesting)
	%	direction			= plot the bars horizontally ('h') or vertically ('v')
	%	fontType = defaults to 'Times' (use something like 'Helvetica Neue' for powerpoints 
	%
	%
	%	NOTE: for HASQI + Loizou Objective measures plotting of r and stde, 
	%		axisPos = [0.20462962962963,0.222222222222222,0.723148148148148,0.702777777777778];

%% Fill in missing inputs {{{
if nargin<7, sigfigs=[]; end;
if nargin<6, fontType=[]; end;
if nargin<5, direction=[]; end;
if nargin<4, confWidths=[]; end;
if nargin<3, axislabel=[]; end;
% }}}

%% Set defaults {{{
if isempty(sigfigs), sigfigs=2; end;
if isempty(fontType), fontType='Times'; end;
if isempty(direction), direction='h'; end;
if isempty(confWidths), confWidths=false; end;
if isempty(axislabel), axislabel='|r_p|'; end;
% }}}

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
	'FontName',fontType,...
	'FontWeight','normal',...
	'GridLineStyle','-',...
	'Box','off');
set(handle,'ShowBaseLine','off',...
	'LineWidth',1.2);
handleToLabelFunction(['$' axislabel '$'],...
	'interpreter','latex',...
	'FontSize',30);

% Add confidence intervals
if not(islogical(confWidths))
	if strcmp(direction,'v')
		xandy=[(1:length(vals)).' vals(:)];
	else
		xandy=[vals(:) (1:length(vals)).'];
	end
	
	errorHandle=handleToErrorBarFunc(xandy(:,1),xandy(:,2),...
		confWidths(:,1),confWidths(:,2),'k-'); % NOTE this 'k-' is causing problems with the vertical case
	set(errorHandle,...
		'LineWidth',1.75,...
		'Color',accentColor*[1 1 1]);
end

% Add text labels of the values
for ii=1:length(vals)
	if not(islogical(confWidths))
		whereToPutValue=vals(ii)+confWidths(ii,2);
	else
		whereToPutValue=vals(ii);
	end
	if strcmp(direction,'v')
		xandy=[ii,whereToPutValue+0.02*diff(get(gca,'YLim'))];
	else
		xandy=[whereToPutValue+0.02*diff(get(gca,'XLim')),ii];
	end
	text(xandy(1),xandy(2),...
		sprintf(['%1.' num2str(sigfigs) 'f'],vals(ii)),...
		'FontSize',fontSize,...
		'FontName',fontType,...
		'FontWeight','bold');
end
