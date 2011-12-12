% Script to run inside the catch section of try-catch statements

%% Don't forget to specify the following before calling this script {{{
%{
pathToSave
errorInfo
%}
%% }}}
[~,computeridentifier] = system('hostname');
computeridentifier=computeridentifier(...
	not((computeridentifier==char(10))|(computeridentifier==char(13))));
send_mail('abbiekressner+matlab@gmail.com',...
    ['MATLAB error on ' computeridentifier],...
	getReport(errorInfo,'extended'));
fprintf(['\n--> Caught error in try-catch on ' datestr(now) '.\n']); 
whos
fprintf('================================================\n');
fprintf('Show error report...\n');
fprintf('================================================\n');

if ischar(pathToSave)
	fprintf('================================================\n');
	fprintf(['Saving the workspace at ...\n\t' pathToSave datestr(now,'yymmdd_HHMM') '_error.mat\n\n']); 
	fprintf('================================================\n');
	try
		save([pathToSave datestr(now,'yymmdd_HHMM') '_error.mat']);
	catch %#ok
		fprintf('Saving failed.\n');
	end
end

rethrow(errorInfo);
