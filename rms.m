function out=rms(in,dim)

if nargin<2
	[~,dim]=find(size(in)~=1,1,'first');
end

out=sqrt(sum(in.^2,dim)./size(in,dim));
