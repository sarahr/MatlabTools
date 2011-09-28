function mse=meansquareerror(x,y)

	% FUNCTION mse=meansquareerror(x,y)

	mse=mean((x(:)-y(:)).^2);
