function [can_start, final_name, final_exists] = chunk_start(path, fname, final_extension)
    %[can_start, final_name, final_exists] = ...
    %    chunk_start(path, fname, final_extension)
    %chunk_finish(path, fname)
    %  chunk_start checks if a certain unit of work has been done or is being 
    %  computed. The path is the location of both the final and temporary/lock
    %  files. Final files are assumed to be named [fname '.mat'] by default,
    %  but the extension can be changed with the optional argument
    %  final_extension. Temporary files are named [fname '.tmp']. chunk_finish
    %  just deletes the temporary file.
    %
    %  Copyright 2008-2011 Taraz Buck/tebuck at cmu.
    %
    % 2011-12-30 tebuck: Adding job id, if applicable, for greater
    % differences between cluster jobs without hoping for clock or
    % hostname differences.

    if nargin < 3
        final_extension = '.mat';
    end
		temp_name = [path '/' fname '.tmp'];
		%final_name = [path '/' fname '.mat'];
		final_name = [path '/' fname final_extension];
    can_start = true;
    final_exists = false;
    [r, n] = system('hostname');
    n2 = getenv('PBS_JOBID');
    n2 = regexprep(n2, '[\r\n]', '');
    options.Format = 'double';
    options.Method = 'SHA-512';
    %hash = DataHash([clock, cputime, n], options);
    hash = DataHash([clock, cputime, n, n2], options);
    wait_time = sum(hash .* (256 .^ ((0:63) - 64)));
    %pause(mod(sum([clock cputime])*100, 1.));
    %pause(mod(sum([clock cputime])*50, .5));
    %pause(mod(sum([clock cputime])*25, .25));
    pause(mod(wait_time, .5));
		if exist(final_name)
			can_start = false;
			final_exists = true;
			return;
		end
		if exist(temp_name)
			can_start = false
			return;
		end
		tmpvar = 1;
		save( temp_name, 'tmpvar' );

