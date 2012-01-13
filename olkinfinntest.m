function [pval,chiSq,dof]=olkinfinntest(X)
	
	% FUNCTION chiSq=olkinfinntest(X)
	%
	% X is n-by-k (reference variable in first column)
	%
	% See I. OLKIN and J. FINN, “Testing Correlated Correlations,” Psychological Bulletin, vol. 108, no. 2, pp. 330–333, 1990.
	
	[n,k]=size(X);
	r=corr(X);

	u=r(1,3:end)-r(1,2);
	sigma_inf=zeros(k-2);
	for jj=3:k
		for ll=3:k
			if jj==ll
				sigma_inf(jj-2,ll-2)=var_inf_uj(r([1 2 jj],[1 2 jj]),n);
			else
				sigma_inf(jj-2,ll-2)=cov_inf_uj_ul(r([1 2 jj ll],[1 2 jj ll]),n);
			end
		end
	end
	chiSq=(u/sigma_inf)*u';
	dof=k-2;
	pval=1-chi2cdf(chiSq,dof);

end % end of main function 





function out=var_inf_rij(r,n) % r is a scalar
	out=(1/n)*(1-r^2)^2;
end
function out=cov_inf_rij_rik(r,n) % r is 3-by-3
	% this simplies to (1-r^2)^2/n for the case var_rij
	out=(1/n)*((r(2,3)-0.5*r(1,2)*r(1,3))*(1-r(1,2)^2-r(1,3)^2)+0.5*r(1,2)*r(1,3)*r(2,3)^2);
end
% function out=cov_inf_rij_rkl(r,n) % r is 4-by-4 NOTE doesn't get used
	% r=corr(X);
	% out=(1/size(X,1))*(0.5*r(1,2)*r(3,4)*(r(1,3)^2+r(1,4)^2+r(2,3)^2+r(2,4)^2)...
		% +(r(1,3)*r(2,4)+r(1,4)*r(2,3))...
		% -(r(1,2)*r(1,3)*r(1,4)+r(2,1)*r(2,3)*r(2,4)+r(3,1)*r(3,2)*r(3,4)+r(4,1)*r(4,2)*r(4,3)));
% end
function out=var_inf_uj(r,n) % r is 3-by-3 (1,2,j)
	out=(1/n)*(1-r(1,3)^2)^2+(1/n)*(1-r(1,2)^2)^2-2*cov_inf_rij_rik(r,n);
end
function out=cov_inf_uj_ul(r,n) % r is 4-by-4 (1,2,j,l)
	out=var_inf_uj(r(1:3,1:3),n)+var_inf_uj(r([1 2 4],[1 2 4]),n)+2*cov_inf_rij_rik(r([1 3 4],[1 3 4]),n)...
		-2*cov_inf_rij_rik(r([1 2 4],[1 2 4]),n)-2*cov_inf_rij_rik(r(1:3,1:3),n)+2*var_inf_rij(r(1,2),n);
end
