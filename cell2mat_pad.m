function theMat=cell2mat_pad(theCell)

% FUNCTION theMat=cell2mat_pad(theCell)

lengths=cellfun(@length,theCell);
theMat=zeros(max(lengths),numel(theCell));
for ii = 1:numel(theCell)
	theMat(1:lengths(ii),ii) = theCell{ii};
end
