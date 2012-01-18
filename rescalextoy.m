function xhat=rescalextoy(x,y)

	% FUNCTION XHAT=RESCALEXTOY(X,Y)
	%
	% Linearly rescale x such that it's min matches the min of y and it's max
	% matches the max of y

slope=(min(y)-max(y))/(min(x)-max(x));
yint=max(y)-slope*max(x);
xhat=slope*x+yint;
