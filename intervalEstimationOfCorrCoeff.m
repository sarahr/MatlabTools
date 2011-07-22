function rho=intervalEstimationOfCorrCoeff(r,n)

	% rho=intervalEstimationOfCorrCoeff(r,n)
	%
	% Provides a 95% confidence interval for the underlying correlation coefficient rho 
	% See page 502 of Fundamentals of Biostatistics (6th edition) by Bernard Rosner

z=0.5.*log((1+r(:))./(1-r(:)));
z_delta=1.96/sqrt(n-3);
z_l=z-z_delta;
z_h=z+z_delta;

rho=[(exp(2.*z_l)-1)./(exp(2.*z_l)+1) ...
	(exp(2.*z_h)-1)./(exp(2.*z_h)+1)];
