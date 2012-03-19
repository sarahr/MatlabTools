function z = ceil2(x,y)
%ceil2 rounds number up to nearest multiple of arbitrary precision.
%   Z = ceil2(X,Y) rounds X up to nearest multiple of Y.
%
%
% See also ceil.

%% defensive programming
error(nargchk(2,2,nargin))
error(nargoutchk(0,1,nargout))
if numel(y)>1
  error('Y must be scalar')
end

%%
z = ceil(x/y)*y;
