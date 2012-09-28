function y=resampAndFilter(x,currentFs,desiredFs)
	
% For initial design, I did the following
	% Wp = [100 6e3]./(desiredFs/2);
	% Ws = [40 7e3]./(desiredFs/2);
	% Rp = 3; 
	% Rs = 60;
	% [n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);
	% [b,a] = cheby2(n,Rs,Ws);
	% freqz(b,a,512,fs);
	%
	% n ends up being 6.  I use butter instead of cheby for smoother filter

if currentFs ~= desiredFs
    x = resample(x,desiredFs,currentFs);
end

Wp = [100 6e3]./(desiredFs/2); 
[b,a]=butter(n,Wp);

y = filtfilt(b,a,x);
