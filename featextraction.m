function featextraction(funcdir, analyzedir, resolution, special_color, override, runcellcycle, pattern, mstype)
addpath(genpath(strcat(funcdir, '/features')));
addpath(genpath(strcat(funcdir, '/helperfuncs')));
addpath(genpath(strcat(funcdir,'/cellcycle')));
addpath(genpath(fullfile(funcdir, '../hpa_cc_matlab')));
try
	[arr exit_status] = process_img(strcat(analyzedir,'/In'),strcat(analyzedir,'/Out'), resolution, special_color, override, pattern, mstype);
catch e
    fprintf(2, 'Threw id: %s\n', e.identifier);
    fprintf(2, 'Threw message: %s\n', e.message);
    getReport(e)
	exit(122);
end

if exit_status(1)==0
	if runcellcycle==1
		try
			predict_CCpos_fov(recursive_getPaths(strcat(analyzedir,'/Out/in'), '_features.csv'));
		catch e
			fprintf(2, 'Threw id: %s\n', e.identifier);
			fprintf(2, 'Threw message: %s\n', e.message);
			getReport(e)
			exit(123);
		end
	end
end
exit(exit_status(1));
