function fighandle=plotsurfinterp(x,y,z,YTicks,YTickLabelsCell)

	% FUNCTION fighandle=plotspectrogram(x,y,z,fighandle) TODO
	%

% if nargin<4
	% fighandle=figure;
% end
% fill in input checks TODO


surf(x,y,z);
view(0,90);
graycolormap=colormap(gray);
colormap(flipud(graycolormap));
shading(gca,'interp');

set(gca,'YScale','log');
grid('off');
set(gca,'Box','on');

xlim([min(x) max(x)]);
ylim([min(y) max(y)]);

if nargin>3
	set(gca,'YTick',YTicks,'YTickLabel',YTickLabelsCell);
end
