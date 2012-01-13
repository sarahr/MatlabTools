function pval=wolfestest(X)

	% FUNCTION pval=wolfestest(X)
	%
	% X(:,1) is the reference signal
	%
	% see D. A. Wolfe, Testing Equality of Related Correlation-Coefficients, Biometrika, vol. 63, no. 1, pp. 214215, 1976.
	
	

[n,~]=size(X);

X(:,2:3)=zscore(X(:,2:3)); % Standardize since std(X(:,2) must be equal to std(X(:,3))
if sign(corr(X(:,1),X(:,2)))~=sign(corr(X(:,1),X(:,3)))
	X(:,3)= -X(:,3); % X2 and X3 must be define such that rho12 and rho13 have the same sign
end
r=corr(X(:,2)-X(:,3),X(:,1));
t=r*sqrt(n-2)/sqrt(1-r^2);
pval=2*tcdf(-abs(t),n-2);
