function filelist=ls2list(filter)
% ls2list creates a list of files that meet the filter requirements
% filelist=ls2list(filter)
%	filelist= matlab list of the files that match the filter requirements.
%	filter= string to used with unix ls command to select files.
% Note: This is unix dependant code.

if nargin<1, filter=''; end
%[dummy fl]=unix(['ls -m ' filter]);
[~,fl]=unix(['ls -m ',filter]);
commas=findstr(fl,',');

if ~isempty(strfind(fl,'No such file or directory'))
	filelist = {};
elseif isempty(commas)
	filelist = {removeCarriageReturns(fl)};
else
	filelist = cell(1,length(commas)+1);
	filelist{length(commas)+1} = removeCarriageReturns(fl(commas(end)+2:end));
	for ii=length(commas):-1:2
		filelist{ii}=removeCarriageReturns(fl(commas(ii-1)+2:commas(ii)-1));
	end
	filelist{1}=removeCarriageReturns(fl(1:commas(1)-1));
end

end % end of function

% --- Sub function: REMOVECARRIAGERETURNS ---
function out = removeCarriageReturns(in)
    out = char(in((double(in)~=10) & (double(in)~=13)));
end
