function plotgammatonegram(x,fs)


	fMin=125;
	fMax=7e3;
	nFilters=128;
	windowTime=0.016;
	hopTime=0.008;
	fMarkers=[250 500 1000 2000 4000];


	gammatonegram_x=gammatonegram(x,fs,windowTime,hopTime,nFilters,fMin,fMax);

	imagesc(20*log10(gammatonegram_x)); 
	axis('xy');
	caxis([-90 -30]);

	cf=flipud(ERBSpace(fMin,fMax,nFilters));
	set(gca,'YTick',interp1(cf,1:nFilters,fMarkers),...
		'YTickLabel',fMarkers);
	set(gca,'XTick',interp1(linspacestep(0,hopTime,size(gammatonegram_x,2)),...
			1:size(gammatonegram_x,2),...
			0:0.5:(size(gammatonegram_x,2)-1)*hopTime),...
		'XTickLabel',0:0.5:(size(gammatonegram_x,2)-1)*hopTime);

	ylabel('Frequency (Hz)');
	xlabel('Time (s)');
