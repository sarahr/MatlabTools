function out=limitToOne(in)

out = (in-min(in(:)))/diff(minAndMax(in(:)))*2-1;

