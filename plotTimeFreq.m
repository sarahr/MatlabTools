function plotTimeFreq(theFillInTheBlankGram,freqs)

	 % FUNCTION plotTimeFreq(theFillInTheBlankGram,freqs)
	 %
	 % theFillInTheBlankGram:	time by freq (i.e. time along first dim)
	 % freqs:					vector of freqs
	 %								length=size(theFillInTheBlankGram,2)

secondsPerFrame=0.008;  % Assumption
fMarkers=[250 500 1000 2000 4000];

N_timeFrames=size(theFillInTheBlankGram,1);
N_freqChannels=size(theFillInTheBlankGram,2);
time=linspacestep(0,secondsPerFrame,N_timeFrames);

imagesc(theFillInTheBlankGram.'); 
axis('xy');
% caxis([-90 -30]);  % not sure what to do with this yet TODO

set(gca,'XTick',interp1(time,1:N_timeFrames,time(1):0.5:time(end)),...
	'XTickLabel',time(1):0.5:time(end));
set(gca,'YTick',interp1(freqs,1:N_freqChannels,fMarkers),...
	'YTickLabel',fMarkers);

xlabel('Time (s)');
ylabel('Frequency (Hz)');
