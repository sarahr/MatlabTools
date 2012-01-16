function A = vandern(v,n)
%VANDER Vandermonde matrix.
%   A = VANDER(V) returns the Vandermonde matrix whose columns
%   are powers of the vector V, that is A(i,j) = v(i)^(n-j).
%
%   Class support for input V:
%      float: double, single

%   Copyright 1984-2004 The MathWorks, Inc. 
%   $Revision: 5.9.4.1 $  $Date: 2004/07/05 17:01:29 $

v = v(:);
A = ones([length(v) n+1],class(v));
for j = n:-1:1
    A(:,j) = v.*A(:,j+1);
end
