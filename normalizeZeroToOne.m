function y=normalizeZeroToOne(x)

y=x-min(x(:));
y=y./max(y(:));
