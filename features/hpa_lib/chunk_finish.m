function chunk_finish(path, fname)
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


		temp_name = [path '/' fname '.tmp'];
		%final_name = [path '/' fname '.mat'];
		if ( exist(temp_name) )
      delete(temp_name);
		end

