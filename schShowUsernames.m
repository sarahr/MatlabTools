function schShowUsernames(in)

	if nargin < 1
		try
			in = findResource('scheduler','Configuration','NeuroCluster');	
		catch
			error('SCHSHOWUSERNAME requires you to pass the jobmanager variable.');
		end
	end

	for ii = 1:size(in.Jobs)
		disp(in.Jobs(ii).UserName);
	end

end
