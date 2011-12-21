function [y,themin,themax]=normalizeZeroToOne(x,themin,themax)

if nargin<2
	themin=min(x(:));
end
y=x-themin;

if nargin<3
	themax=max(y(:));
end
y=y/themax;
