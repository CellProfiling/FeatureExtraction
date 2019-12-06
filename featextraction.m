function featextraction(funcdir, analyzedir, resolution, special_color, override, runcellcycle)
addpath(genpath(strcat(funcdir, '/feature_extraction')));
addpath(genpath(strcat(funcdir,'/cellcycle')));
try
	[arr exit_status] = process_img(strcat(analyzedir,'/In'),strcat(analyzedir,'/Out'), resolution, special_color, override);
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
		catch
			exit(123);
		end
	end
end
exit(exit_status(1));
