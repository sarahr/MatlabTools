function mse=meansquareerror(x,y)

	% FUNCTION mse=meansquareerror(x,y)
	%
	% x and y can be matrices or vectors

	mse=mean((x(:)-y(:)).^2);
