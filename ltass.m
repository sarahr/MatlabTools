% LTASS: Computes long-term average speech spectrum via FFT
% Usage: mag=ltass(w,rate,twin,thop,nfft);
% w: input waveform
% rate: sample rate in Hz (default 10000 Hz)
% twin: frame length in ms (default: 10 ms)
% thop: frame update in ms (default: 5 ms)
% nfft: FFT window length (default: 256 samples)

function mag=ltass(w,rate,twin,thop,nfft);

n = max(size(w));
if ~exist('rate','var') rate=10000; end;
if ~exist('twin','var') twin=10; end;
if ~exist('thop','var') thop=5; end;
if ~exist('nfft','var') nfft=256; end;

nwin=rate/1000*twin;
nhop=rate/1000*thop;
p=20.*log10(fftpsd(w,rate,nfft,nwin,nhop)+eps)';
mag=mean(p');
