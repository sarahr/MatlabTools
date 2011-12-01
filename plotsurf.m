function fighandle=plotsurf(x,y,z,YTicks,YTickLabelsCell)

	% FUNCTION fighandle=plotspectrogram(x,y,z,fighandle) TODO
	%

% if nargin<4
	% fighandle=figure;
% end
% fill in input checks TODO


fighandle=surf(x,y,z);
view(0,90);
graycolormap=colormap(gray);
colormap(flipud(graycolormap));
shading(gca,'flat');

set(gca,'YScale','log');
grid('off');
set(gca,'Box','on');
axis('tight');

if nargin>3
	set(gca,'YTick',YTicks,'YTickLabel',YTickLabelsCell);
end
