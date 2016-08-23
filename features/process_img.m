function [cell_feat, exit_code] = process_img(in_folder,out_folder,resolution,color,extensions,pattern,mstype,seg_channels)
%This function is used to process images for production in the Subcellular
%Human Protein Atlas.
%
%INPUTS:
%in_folder - string containing path to image or folder of images - if a
%whole folder is passed, all images in the folder will be treated as one
%experiment and output into a single data matrix
%
%out_folder - string containing path to where the results will be saved.
%
%resolution - double in units of microns/pixel. This is used for
%segmentation, the default is 0.08 (63x)
%
%color - optional antiquated field. Leave blank []
%
%extensions - cell array of suffixes identifying each channel. The program
%expects the following order separated from the main body by '_' or '--'.
%     extension_dapi  = extensions{1};%e.g. 'blue.tif'
%     extension_ab    = extensions{2};%e.g. 'green.tif'
%     extension_mtub  = extensions{3};%e.g. 'red.tif'
%     extension_er    = extensions{4};%e.g. 'yellow.tif'
%
%pattern - a string specifying a part of a file name you wish to use. This
%field may be used in the case where you have multiple files in a folder
%but only wish to use some (e.g. thumbnails and full sized images). If no
%pattern is desired, leave blank [].
%
%mstype - string specifying the microscope type. Currently 'confocal' or
%'widefield' are supported. This impacts segmentation. The default is
%'confocal' if this is not specified.
%
%seg_channels - a cell array specifying which channels to use for
%segmentation. This field is default seg_channels = {'er','mt'}; for
%production. Only change if you wish to use different channels. For Voronoi
%segmentation specify an empty cell array: seg_channels = {}.

%OUTPUTS:
%This code generates several outputs in a set of folders. The output
%folders will contain the name of the input file(s).

%Written by: Elton Date-unknown
%
%Edited by: (dd,mm,yy)
%Devin P Sullivan 04,08,2015 - added 'extensions' input
%Devin P Sullivan 20,10,2015 - merging multiple resolutions that have
%replicate code to one code base for high efficiency, reliability and
%easier code managment.

segskips= [];
skipimage = [];


addpath(genpath('./hpa_lib'),'-begin');
addpath(genpath('./adaptive_watersheed_seg'),'-begin');

faillist = [];
exit_code   = 0;

if nargin<8
    seg_channels = {'er','mt'};
end

%DPS 25,11,2015 - added 'mstype' var so we can have types of microscopes
%for segmentation. Widefield microscopes require less blurring for good
%segmentation as they are already blurry.
%Currently accepted values are 'confocal', and 'widefield'
if nargin<7 || isempty(mstype)
    mstype = 'confocal';
end

%DPS 22,09,2015 - added 'pattern' var so we can handle sub-patterns in
%addition to extensions.
if nargin<6
    pattern = '';
end

%DPS 04,08,2015 - added 'extensions' field so that we can handle multiple
%file-naming conventions. This should not break the former pipeline
if (nargin<5 || isempty(extensions)) && ~iscell(color)
    fprintf(['You have not passed an "extensions" variable or full list of colors. We will assume you are using the HPA production channels.\n ',...
        'please make sure your files are names accordingly:\n',...
        '1."*_blue.tif" - nucleus \n 2."*_green.tif" - protein of interest \n',...
        '3."*_red.tif" - microtubules \n lastly, the "color" variable is used as the segmentation channel usually "yellow" corresponding to er \n'])
    extension_dapi  = '_blue.tif';
    extension_ab    = '_green.tif';
    extension_mtub  = '_red.tif';
    %For historical reasons 'color' is separate and we are trying to make
    %the script such that it breaks nothing in the current pipeline
    extension_er    = strcat('_', color, '.tif');
elseif iscell(color)
    %if someone has passed a cell array of color, process it
    fprintf(['You have passed a cell array for the "color" variable. Make sure it is in the correct order',...
        'It will be parsed as follows:\n 1.nucleus \n 2.protein of interest \n 3.microtubules \n 4.segmentation channel (usually er or tubules)\n'])
    extension_dapi  = color{1};
    extension_ab    = color{2};
    extension_mtub  = color{3};
    extension_er    = color{4};
else
    fprintf(['You have passed a cell array for the "extensions" variable. Make sure it is in the correct order',...
        'It will be parsed as follows:\n 1.nucleus \n 2.protein of interest \n 3.microtubules \n 4.segmentation channel (usually er or tubules)\n'])
    extension_dapi  = extensions{1};
    extension_ab    = extensions{2};
    extension_mtub  = extensions{3};
    %For historical reasons 'color' is separate and we are trying to make
    %the script such that it breaks nothing in the current pipeline
    %extension_er    = strcat('_', color, '.tif');
    if length(extensions)==4
        extension_er = extensions{4};
    elseif ~isempty(color)
        warning('no 4th extension provided. Trying to use the outdated "color" parameter')
        extension_er    = strcat(color, '.tif');
    else
        extension_er = '';
    end
end


%DPS 2015,10,20 - the resolution should now be passed in as um/pixel
% if(resolution==63)
%     resolution = 1;
% else
%     resolution = 0;
% end

step1   = true;
step2   = true;
step3   = true;

warning('off', 'MATLAB:MKDIR:DirectoryExists');
warning('off', 'Images:imfeature:obsoleteFunction');

filename = out_folder,'/feature_extraction_HPA';
mkdir(filename);

% extension_dapi  = '_blue.tif';
% extension_ab    = '_green.tif';
% extension_mtub  = '_red.tif';
% extension_er    = strcat('_', color, '.tif');

%
% list_ab     = rdir_list(char([in_folder,'/*',pattern,extension_ab]));
% list_dapi   = rdir_list(char([in_folder,'/*',pattern,extension_dapi]));
% list_mtub   = rdir_list(char([in_folder,'/*',pattern,extension_mtub]));
% list_er     = rdir_list(char([in_folder,'/*',pattern,extension_er]));

% list_ab     = rdir_list(char([in_folder,'/*',extension_ab]));
% list_dapi   = rdir_list(char([in_folder,'/*',extension_dapi]));
% list_mtub   = rdir_list(char([in_folder,'/*',extension_mtub]));
% list_er     = rdir_list(char([in_folder,'/*',extension_er]));

%list_ab     = rdir_list(char([in_folder,'/*','/*',extension_ab]));
%list_dapi   = rdir_list(char([in_folder,'/*','/*',extension_dapi]));
%list_mtub   = rdir_list(char([in_folder,'/*','/*',extension_mtub]));
%list_er     = rdir_list(char([in_folder,'/*','/*',extension_er]));


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
    
    for i=1:length(dirlist)
        %         currdir = dirlist(i+padnumb).name;
        currdir = dirlist(i).name;
        currpath = [image_path,filesep,currdir];
        if any(strcmpi(currdir,{'.','..','.DS_Store','tmp'})) || ~isdir(currpath)
            continue
        end
        label_subdirectories{currind} = currdir;
        currind = currind+1;
    end
    
    if strcmpi(image_path(end),filesep)
        image_path = image_path(1:end-1);
    end
    if isempty(label_subdirectories{1})
        pathparts = strsplit(image_path,'/');
        label_subdirectories{1} = pathparts{end};
        
        
    end
    
    label_names = label_subdirectories;
    
    number_labels = length(label_subdirectories);
    label_features = cell(1, number_labels);
    
    processed_path = [out_folder,'/featextraction_rawdata/'];
    mkdir(processed_path);
    
    feature_names = [];
    
end


%% Remaining script to run image-segmentation and feature extraction
exit_code = zeros(1,length(label_subdirectories));
for index = 1:length(label_subdirectories)
    if(step2)
        
        
        
        %set up the subfolder stuff
        curr_out_folder = [out_folder,filesep,label_subdirectories{index}];
        
        %DPS 10/08/15 - Defining key words and adding auto detection of
        %channels left blank by the user.
        %Keywords allowed: 'nuclear','tubulin','er','protein'
        base_naming_convention.blank_channels = {};
        
        base_naming_convention.protein_channel  = extension_ab;
        if isempty(extension_ab)
            base_naming_convention.blank_channels = [base_naming_convention.blank_channels,{'protein'}];
        end
        base_naming_convention.nuclear_channel  = extension_dapi;
        if isempty(extension_dapi)
            base_naming_convention.blank_channels = [base_naming_convention.blank_channels,{'nuclear'}];
        end
        base_naming_convention.tubulin_channel  = extension_mtub;
        if isempty(extension_mtub)
            base_naming_convention.blank_channels = [base_naming_convention.blank_channels,{'tubulin'}];
        end
        base_naming_convention.er_channel       = extension_er;
        if isempty(extension_er)
            base_naming_convention.blank_channels = [base_naming_convention.blank_channels,{'er'}];
        end
        
        
        if isempty(color)
            disp('No "color" variable passed for a segmentation channel suffix. Assuming this channel is not present')
            base_naming_convention.blank_channels = {'er'};
        end
        
        base_naming_convention.segmentation_suffix = base_naming_convention.protein_channel;
        %DPS 22,09,2015 - added pattern field to allow for wild card
        %specification
        base_naming_convention.pattern = pattern;
        
        %DPS 25,11,2015 - added mstype field to allow for specific segmenation
        base_naming_convention.mstype = mstype;
        
        %DPS 25,11,2015 - added mstype field to allow for specific segmenation
        base_naming_convention.seg_channel = seg_channels;
        
        
        %         index  = 1;
        
        %         label_subdirectories
        image_subdirectory      = [image_path, filesep, (label_subdirectories{index}), filesep]
        
        %DPS - 28,07,2015  Adding support for direct parent directories rather
        %than directories of directories
        if ~isdir(image_subdirectory)
            image_subdirectory = [image_path, filesep];
            %DPS - 09,11,2015 Adding support for direct file pattern names
            %rather than directories or directories of directories.
            if ~isdir(image_subdirectory)
                image_subdirectory = image_path;
            end
        end
        %         image_path
        storage_subdirectory    = [processed_path, (label_subdirectories{index}), filesep];
        %         storage_subdirectory    = processed_path;
        %label_subdirectories{index}
        %image_subdirectory
        %storage_subdirectory
        %disp('In 63x code')
%         try
        
        %DPS 06/08/15 - adding support for partially scanned images
        %Check if images need to be trimmed, trim them and updated the
        %directory field.
        %     [image_subdirectory] = trimImages(image_subdirectory,base_naming_convention,out_folder);
        %DPS 10/08/15 - After discussing with Emma, we will now mark images
        %that are partial scans and not trim images
        [nucfiles{index}, skipimage{index}] = preprocessImages(image_subdirectory,base_naming_convention,curr_out_folder)
        if any(any(skipimage{index}==1))
            cell_feat = [];
            exit_code(index) = 1;
            continue
        end
        
        if any(any(skipimage{index}==2))
            warning('potential partial scan, continue at your own risk')
        end
        
        
        %DPS 11/08/15 - Need to eliminate folders that don't have any files in
        %them (that match our naming convention).
        %         if skipimage{index}==inf
        %             cell_feat = [];
        %             exit_code = 1;
        %             return
        %         end
        
        [label_features{index}, feature_names, feature_computation_time, cell_seed, nucleus_seed,segskips] = get_concatenated_region_features(image_subdirectory, storage_subdirectory, base_naming_convention, label_names{index}, true, false, resolution);
        %DPS 20150924 - added support for cell array within our for loop of
        %subfolders (fields)
        %         regions_results     =   cell2mat(label_features);
        regions_results = cat(1,label_features{:});
        
        % read cell (x,y) centers and bounding box values
        infiletype = [];
        if findstr(base_naming_convention.nuclear_channel,'.tif');
            infiletype = 'tif';
        elseif findstr(base_naming_convention.nuclear_channel,'.TIF');
            infiletype = 'TIF';
        else
            warning('This image does not appear to be a tif (or TIF). Trying to separate file type. Assuming fileparts will give correct answer.')
            [~,~,nucext] = fileparts(base_naming_convention.nuclear_channel);
            infiletype = nucext(2:end);
        end
        
        
        
        pngsuff = strrep(base_naming_convention.protein_channel,infiletype,'png');
        nucpngsuff = strrep(base_naming_convention.protein_channel,['.',infiletype],'_nuc.png');
        dir_png         = dir([storage_subdirectory,filesep,'*',pngsuff]);
        
        %%%DPS 2015/07/09 - I don't understand how this ever worked without a for loop unless they were running on one image at a time. I am changing now
        position_stats{index} = zeros(size(label_features{index},1),7);
        %DPS 30,07,2015 - Adding variable to track variable names; 7 position
        %stats are calculated
        pos_stats_names = cell(1,7);
        %area
        pos_stats_names{1} = 'position_stats:Area';
        %center of mass location
        pos_stats_names{2} = 'position_stats:Centroid_x';
        pos_stats_names{3} = 'position_stats:Centroid_y';
        %bounding box
        pos_stats_names{4} = 'position_stats:BoundingBox_ulx';
        pos_stats_names{5} = 'position_stats:BoundingBox_uly';
        pos_stats_names{6} = 'position_stats:BoundingBox_wx';
        pos_stats_names{7} = 'position_stats:BoundingBox_wy';
        currstart = 1;
        for i = 1:length(dir_png)
            %bw_seg          = imread([storage_subdirectory,'/',char(dir_png(1).name)]);
            bw_seg = imread([storage_subdirectory,'/',char(dir_png(i).name)]);
            if sum(bw_seg(:))==0 || length(unique(bw_seg))==1
                warning(['Image ', storage_subdirectory,'/',char(dir_png(i).name),' seems to be blank!'])
                continue
            end
            cell_seg    = regionprops(bwlabel(bw_seg,4),'Centroid','BoundingBox','Area');
            
            if(length(cell_seg)>0)
                
                %num_cells = size(regions_results);
                %num_cells = num_cells(1,1);
                num_cells = length(cell_seg);
                %position_stats(1:num_cells,1) = [nucstats_seg(1:num_cells).Area]';
                position_stats{index}(currstart:currstart+num_cells-1,1)      =   [cell_seg.Area]';
                position_stats{index}(currstart:currstart+num_cells-1,2:3)    =   reshape([cell_seg(1:num_cells).Centroid],2,num_cells)';
                position_stats{index}(currstart:currstart+num_cells-1,4:7)    =   reshape([cell_seg(1:num_cells).BoundingBox],4,num_cells)';
                
                time_so_far = toc(start_time);
                currstart = currstart+num_cells;
                %size(regions_results)
                %size(position_stats)
                
            else
                warning(['Image ', storage_subdirectory,'/',char(dir_png(i).name),' seems to be blank!'])
            end
        end
        
        position_results = cat(1,position_stats{:});
        
        if sum(position_results(:))>0
            cell_feat  = [position_results regions_results];
            %DPS 30,07,2015 - added feature name save and concatenation of
            %position stats to feature names
            feature_names = [pos_stats_names feature_names];
            save([curr_out_folder,filesep,'feature_names.mat'],'feature_names');
            csvwrite([curr_out_folder,'/','features.csv'], cell_feat);
            
        elseif sum(skipimage{:}>0)==length(dir_png) || sum(segskips>=1)==length(dir_png)
            fprintf(['There was no fluorescence for any images in ',in_folder, '. We will not bother saving the features.\n'])
            cell_feat = [];
            faillist = [faillist,image_subdirectory];
            exit_code(index) = 1;
        elseif sum(segskips>1)==length(dir_png)
            fprintf(['There was no cell regions for any images in ',in_folder, '. Position stats will be blank.\n'])
            cell_feat  = [position_results regions_results];
            %DPS 30,07,2015 - added feature name save and concatenation of
            %position stats to feature names
            feature_names = [pos_stats_names feature_names];
            save([curr_out_folder,filesep,'feature_names.mat'],'feature_names');
            csvwrite([curr_out_folder,'/','features.csv'], cell_feat);
            faillist = [faillist,image_subdirectory];
        else
            cell_feat = 0;
            exit_code(i) = 122;
            disp('Segmentation error occuring during feature extraction 63x/40x');
            faillist = [faillist,image_subdirectory];
%             exit(exit_code);
        end
        
        save([curr_out_folder,filesep,'listOfFailed.mat'],'faillist','skipimage','segskips')
%         catch
%                     faillist = [faillist,image_subdirectory];
%                     %save([curr_out_folder,filesep,'listOfFailed.mat'],'faillist','skipimage','segskips')
%                     cell_feat = [];
%                     exit_code(index) = 122;
%                     continue
        %
        %disp('An error occuring during feature extraction 63x/40x');
        %exit(exit_code);
%         end
        
%         end
        % save([out_folder,filesep,'listOfFailed_tot.mat'],'faillist')
    end
    %% create segmentation masks
    
    if(step3)
        %%%DPS 2015-07-09  Not sure where I is supposed to be coming from without a for loop!
        % Read images - this step is not necessary. %DPS 2016-06-07
        
        %     im_dapi     =   imread(list_dapi(i).name);
        %     im_ab       =   imread(list_ab(i).name);
        %     im_mtub     =   imread(list_mtub(i).name);
        %     im_er       =   imread(list_er(i).name);
        
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
        
        imwrite(double(merge_mask),[curr_out_folder,'/segmentation_',label_subdirectories{index},'.png'],'Alpha',alpha_ch/255);
        
        % merge the output from the image set with other ABs image set data
        % previously analysed (if multiple ABs are included or if analysis is
        % run at the plate level)
    end
end
%exit(exit_code);
