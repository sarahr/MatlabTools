function x_l=basebandSignal(x,f_0)

	t=0:(length(x)-1);
	% x_analytic=hilbert(x);
	% x_l=abs(2.*x_analytic.*exp(-1i*2*pi*f_0*t));
	
	x_hat=imag(hilbert(x));
	x_i=x.*cos(2*pi*f_0.*t)+x_hat.*sin(2*pi*f_0.*t);
	x_q=x_hat.*cos(2*pi*f_0.*t)-x.*sin(2*pi*f_0.*t);
	x_l=abs(x_i+1i*x_q);
