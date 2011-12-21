function gammatonegram_x=plotgammatonegram(x,fs)


	fMin=125;
	fMax=7e3;
	nFilters=128;
	windowTime=0.016;
	hopTime=0.008;


	gammatonegram_x=gammatonegram(x,fs,windowTime,hopTime,nFilters,fMin,fMax);

	cf=flipud(ERBSpace(fMin,fMax,nFilters));
	plotTimeFreq(20*log10(gammatonegram_x).',cf); 
	caxis([-90 -30]);
