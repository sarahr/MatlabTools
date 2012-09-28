function handle=prettyBarPlot_breakaxis(vals,names,axislabel,confWidths,direction,fontType,sigfigs,...
		X,percent)

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

% Check that nothing is between X(2) and X(3)
if any(vals>X(2) & vals<X(3))
	error('You have values in the "no-zone".');
end

% Map to new xaxis
rangeOfNewMapping=(X(2)-X(1))/percent;
newX=[X(1:2) (percent+0.05)*rangeOfNewMapping+X(1) rangeOfNewMapping+X(1)];
vals_mapped=vals;
m_lessthanX2=(newX(2)-newX(1))/(X(2)-X(1));
b_lessthanX2=newX(2)-X(2)*m_lessthanX2;
m_greaterthanX3=(newX(4)-newX(3))/(X(4)-X(3));
b_greaterthanX3=newX(4)-X(4)*m_greaterthanX3;
ind=(vals<=X(2));
vals_mapped(ind)=m_lessthanX2*vals_mapped(ind)+b_lessthanX2;
ind=(vals>=X(3));
vals_mapped(ind)=m_greaterthanX3*vals_mapped(ind)+b_greaterthanX3;

% Do the plotting
handle=handleToBarPlotFunc(vals_mapped,0.7,'FaceColor',mainBarColor*[1 1 1],'Edgecolor',accentColor*[1 1 1]);

% Add the group names and axis labels
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

% Show the axis break
	% ytick=get(gca,'YTick');
	% text(mean(Y(2:3)),0.5,'//','fontsize',20);
	% text(mean(Y(2:3)),ytick(end)+0.5,'//','fontsize',20);

	howmanyzigs=10;
	ylim=get(gca,'YLim');
	yy = linspace(ylim(1)-0.5,ylim(end)+0.5,howmanyzigs+1);

	mid_gap=(percent+0.025)*rangeOfNewMapping+X(1);
	gap_halfwidth=0.0075*rangeOfNewMapping;
	xx = repmat([mid_gap+gap_halfwidth mid_gap-gap_halfwidth],1,floor(howmanyzigs/2));
	if length(xx)<length(yy)
		xx=[mid_gap-gap_halfwidth xx]; 
	end
	pathofpatch_x=[xx(:)+gap_halfwidth; flipud(xx(:)-gap_halfwidth)];
	pathofpatch_y=[yy(:); flipud(yy(:))];
	patch(pathofpatch_x,pathofpatch_y,[1 1 1],'LineWidth',1.2);
	line([pathofpatch_x(end) pathofpatch_x(1)],min(pathofpatch_y)*ones(1,2),...
		'Color',[1 1 1],'LineWidth',1.2);
	line([pathofpatch_x(length(pathofpatch_y)/2) pathofpatch_x(length(pathofpatch_y)/2+1)],...
		pathofpatch_y(length(pathofpatch_y)/2)*ones(1,2),...
		'Color',[1 1 1],'LineWidth',1.2);

	% remap tick marks, and 'erase' them in the gap
	set(gca,[whichAxisContainsTheValues 'Tick'],0:10:newX(2));

% Add confidence intervals
if not(islogical(confWidths))
	if strcmp(direction,'v')
		xandy=[(1:length(vals_mapped)).' vals_mapped(:)];
	else
		xandy=[vals_mapped(:) (1:length(vals_mapped)).'];
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
		whereToPutValue=vals_mapped(ii)+confWidths(ii,2);
	else
		whereToPutValue=vals_mapped(ii);
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
