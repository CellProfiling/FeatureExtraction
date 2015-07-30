function [cell_feat, exit_code] = process_63x(in_folder,out_folder,resolution, color)

addpath(genpath('./hpa_lib'),'-begin');
addpath(genpath('./adaptive_watersheed_seg'),'-begin');

exit_code   = 0;

if(resolution==63)
	resolution = 1;
else
	resolution = 0;
end

step1   = true;
step2   = true;
step3   = false;%true;

warning('off', 'MATLAB:MKDIR:DirectoryExists');
warning('off', 'Images:imfeature:obsoleteFunction');

filename = out_folder,'/feature_extraction_HPA';
mkdir(filename);

extention_dapi  = '_blue.tif';
extention_ab    = '_green.tif';
extention_mtub  = '_red.tif';
extention_er    = strcat('_', color, '.tif');

list_ab     = rdir_list(char([in_folder,'/*',extention_ab]));
list_dapi   = rdir_list(char([in_folder,'/*',extention_dapi]));
list_mtub   = rdir_list(char([in_folder,'/*',extention_mtub]));
list_er     = rdir_list(char([in_folder,'/*',extention_er]));

%list_ab     = rdir_list(char([in_folder,'/*','/*',extention_ab]));
%list_dapi   = rdir_list(char([in_folder,'/*','/*',extention_dapi]));
%list_mtub   = rdir_list(char([in_folder,'/*','/*',extention_mtub]));
%list_er     = rdir_list(char([in_folder,'/*','/*',extention_er]));


%% Init

if(step1)
    
    image_path = in_folder;
    dirlist    = dir(image_path);
    %dirlist
    start_time = tic;
    
    n = getenv('PBS_JOBID');
    n = regexprep(n, '[\r\n]', '');
    date_text = datestr(now(), 'yyyymmddHHMMSSFFF')
    diary([filename '/' 'log' date_text ...
        '_' n '.txt']);
    
    padnumb = 2; % Offset for directory brousing and data analysis
    
    label_subdirectories = cell(1,1);
    dirlist.name
    currind = 1;
    %breaking = breakme 
    for i=1:length(dirlist)
%         currdir = dirlist(i+padnumb).name;
        currdir = dirlist(i).name;
        if any(strcmpi(currdir,{'.','..','.DS_Store'}))
            continue
        end
        label_subdirectories{currind} = currdir;
        currind = currind+1;
    end
    
    label_names = label_subdirectories;
    
    number_labels = length(label_subdirectories);
    label_features = cell(1, number_labels);
    
    processed_path = out_folder,'/featextraction_rawdata/';
    mkdir(processed_path);
        
    feature_names = [];
    
end


%% Remaining script to run image-segmentation and feature extraction

if(step2)
    
    base_naming_convention.protein_channel  = extention_ab;
    base_naming_convention.nuclear_channel  = extention_dapi;
    base_naming_convention.tubulin_channel  = extention_mtub;
    base_naming_convention.er_channel       = extention_er;
    base_naming_convention.blank_channels = {};
    
    base_naming_convention.segmentation_suffix = base_naming_convention.protein_channel;
        
    index  = 1;
   
    label_subdirectories 
    image_subdirectory      = [image_path, '/', (label_subdirectories{index}), filesep]
    image_path
    %storage_subdirectory    = [processed_path, (label_subdirectories{index}), filesep];
    storage_subdirectory    = processed_path;
    %label_subdirectories{index}
    %image_subdirectory
    %storage_subdirectory
    disp('In 63x code')
    %try
        [label_features{index}, feature_names, feature_computation_time, cell_seed, nucleus_seed] = get_concatenated_region_features(image_subdirectory, storage_subdirectory, base_naming_convention, label_names{index}, true, false, resolution);
        regions_results     =   cell2mat(label_features);
        
        % read cell (x,y) centers and bounding box values
        
        dir_png         = dir([storage_subdirectory,'/*.png']);
        
	%%%DPS 2015/07/09 - I don't understand how this ever worked without a for loop unless they were running on one image at a time. I am changing now
	position_stats = zeros(size(regions_results,1),7);
	currstart = 1;
	for i = 1:length(dir_png)
	%bw_seg          = imread([storage_subdirectory,'/',char(dir_png(1).name)]);
        bw_seg = imread([storage_subdirectory,'/',char(dir_png(i).name)]);
	nucstats_seg    = regionprops(bwlabel(bw_seg,4),'Centroid','BoundingBox','Area');
        
        if(length(nucstats_seg)>0)
            
            %num_cells = size(regions_results);
            %num_cells = num_cells(1,1);
            num_cells = length(nucstats_seg);
	    %position_stats(1:num_cells,1) = [nucstats_seg(1:num_cells).Area]';
	    position_stats(currstart:currstart+num_cells-1,1)      =   [nucstats_seg.Area]';
            position_stats(currstart:currstart+num_cells-1,2:3)    =   reshape([nucstats_seg(1:num_cells).Centroid],2,num_cells)';
            position_stats(currstart:currstart+num_cells-1,4:7)    =   reshape([nucstats_seg(1:num_cells).BoundingBox],4,num_cells)';
            
            time_so_far = toc(start_time);
            currstart = currstart+num_cells;
            %size(regions_results)
            %size(position_stats)
	
	else
	    warning(['Image ', storage_subdirectory,'/',char(dir_png(i).name),' seems to be blank!'])
	end
	end

	if sum(position_stats(:))>0
            cell_feat  = [position_stats regions_results];
            csvwrite([out_folder,'/','features.csv'], [position_stats regions_results]);
            
        else
	    breaking = breakme
            cell_feat = 0;
            exit_code = 1;
            disp('Segmentation error occuring during feature extraction 63x/40x');
            exit(exit_code);
        end
        
    %catch
        %cell_feat = 0;
        %exit_code = 1;
        %disp('Segmentation error occuring during feature extraction 63x/40x');
        %exit(exit_code);
    %end
end


%% create segmentation masks 

if(step3)
   %%%DPS 2015-07-09  Not sure where I is supposed to be coming from without a for loop!  
    % Read images
    
    im_dapi     =   imread(list_dapi(i).name);
    im_ab       =   imread(list_ab(i).name);
    im_mtub     =   imread(list_mtub(i).name);
    im_er       =   imread(list_er(i).name);
    
    % Segment the nucleus and cell extent mask
    
    cyto_seed   =   cell_seed & (~(nucleus_seed>0));
    
    % create cell perimeter
    
    perim_thick = 5 ; % defines number of pixels thickness of the perimeter
    bw2         = bwmorph(cell_seed,'erode',perim_thick);
    bw3         = bwmorph(cell_seed,'remove');
    plasmaMem   = bwmorph(bw3,'dilate',perim_thick-2);%imshow((plasmaMem));
    
    % save output images in the output directory
    
    alpha_ch       = plasmaMem*0;
    merge_mask     = alpha_ch;
    max_alpha      = 5000;
    
    alpha_ch(cell_seed>0)                       = 3;
    alpha_ch(cyto_seed>0)                       = 2;
    alpha_ch(nucleus_seed>0&cell_seed>0)        = 1;
    alpha_ch(plasmaMem)                         = 4;
         
    imwrite(double(merge_mask),[out_folder,'/segmentation.png'],'Alpha',alpha_ch/255);
    
    % merge the output from the image set with other ABs image set data
    % previously analysed (if multiple ABs are included or if analysis is 
    % run at the plate level)  
end

% exit(exit_code);
