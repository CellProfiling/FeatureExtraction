function [cell_feat, exit_code] = process_img(in_folder,out_folder,resolution,channels,pattern,mstype,steps,run_partial_scans)
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
%
%channels (old 'extensions') - nx2 cell array of suffixes identifying each channel (column 1)
% and what segmentation process to use the channel in (column 2)
%The program expects the following order separated from the main body by '_' or '--'
%in column 1 of the cell array
%     extension_dapi  = extensions{1};%e.g. 'blue.tif'
%     extension_ab    = extensions{2};%e.g. 'green.tif'
%     extension_mtub  = extensions{3};%e.g. 'red.tif'
%     extension_er    = extensions{4};%e.g. 'yellow.tif'
%column 2 of the channels is either 
%     0/empty - not used in segmentation
%     1       - used to segment nucleus
%     2       - used to segment cell shape
%
%pattern - a string specifying a part of a file name you wish to use. This
%field may be used in the case where you have multiple files in a folder
%but only wish to use some (e.g. thumbnails and full sized images). If no
%pattern is desired, leave blank [].
%
%mstype - string specifying the microscope type. Currently 'confocal' or
%'widefield' are supported. This impacts segmentation. The default is
%'confocal' if this is not specified.

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
%D. P. Sullivan 08,02,2018 - changed 'extensions' to include seg_channels
%info in an nx2 cell array and renamed to 'channels' to be more consistent. 
%Eliminated seg_channels input.

disp('~~You are running the HPA production feature extraction version 4.0~~')

segskips= [];
skipimage = [];
cell_feat = [];


addpath(genpath('./hpa_lib'),'-begin');
addpath(genpath('./adaptive_watersheed_seg'),'-begin');

faillist = [];
exit_code   = 0;

%DPS 25,11,2015 - added 'mstype' var so we can have types of microscopes
%for segmentation. Widefield microscopes require less blurring for good
%segmentation as they are already blurry.
%Currently accepted values are 'confocal', and 'widefield'
if nargin<6 || isempty(mstype)
    mstype = 'confocal';
end

%DPS 22,09,2015 - added 'pattern' var so we can handle sub-patterns in
%addition to extensions.
if nargin<5 || isempty(pattern)
    pattern = '';
end

%DPS 08,02,2018 - renamed 'extensions' to 'channels' and merged with
%segmentation info
%DPS 04,08,2015 - added 'extensions' field so that we can handle multiple
%file-naming conventions. This should not break the former pipeline
if (nargin<4 || isempty(channels))
    fprintf(['You have not passed a "channels" variable. We will assume you are using the HPA production channels.\n ',...
        'please make sure your files are names accordingly:\n',...
        '1."*_blue.tif" - nucleus \n 2."*_green.tif" - protein of interest \n',...
        '3."*_red.tif" - microtubules \n "*_yellow.tif" - er \n'])
    %Must specify at least 1 nuclear segmentation segmentation channel!
    numchannels = 4;
    channels = cell(numchannels,2);
    %specify reference channel(s) for nucleus
    channels(1,:) = {'_blue.tif',1};
    %specify reference channel(s) for cell shape
    channels(2,1) = {'_red.tif',2};
    channels(3,1) = {'_yellow.tif',2};
    %specify protein of interest
    channels(4,1) = {'_green.tif',0};
end

if nargin<7 || isempty(steps)
    steps(1) = true;
    steps(2) = true;
    steps(3) = true;
end

if nargin<8 || isempty(run_partial_scans)
    run_partial_scans = 0;
end

warning('off', 'MATLAB:MKDIR:DirectoryExists');
warning('off', 'Images:imfeature:obsoleteFunction');

filename = out_folder,'/feature_extraction_HPA';
mkdir(filename);

%% Init

if(steps(1))
    
    image_path = fullfile(in_folder);
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
        currpath = fullfile([image_path,filesep,currdir]);
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
    
    processed_path = fullfile([out_folder,'/featextraction_rawdata/']);
    mkdir(processed_path);
    
    feature_names = [];
    
end


%% Remaining script to run image-segmentation and feature extraction
exit_code = zeros(1,length(label_subdirectories));
for index = 1:length(label_subdirectories)
%     if(step2)
        
        
        
        %set up the subfolder stuff
        curr_out_folder = fullfile([out_folder,filesep,label_subdirectories{index}]);
        if ~isdir(curr_out_folder)
            mkdir(curr_out_folder)
        end
        
        
        %DPS 10/08/15 - Defining key words and adding auto detection of
        %channels left blank by the user.
        %Keywords allowed: 'nuclear','tubulin','er','protein'
        base_naming_convention.blank_channels = {};
        base_naming_convention.blank_channels = cellfun(@isempty,channels(:,1));
        base_naming_convention.channels = channels;
%         *base_naming_convention.protein_channel  = extension_ab;
%         *base_naming_convention.nuclear_channel  = extension_dapi;
%         *base_naming_convention.tubulin_channel  = extension_mtub;
%         *base_naming_convention.er_channel       = extension_er;
        
        %DPS 09,02,2018 - not sure if it is important what channel you use
        %here. Trying the first one as a test. 
        base_naming_convention.segmentation_suffix = base_naming_convention.channels{1,1};
        %DPS 22,09,2015 - added pattern field to allow for wild card
        %specification
        base_naming_convention.pattern = pattern;
        
        %DPS 25,11,2015 - added mstype field to allow for specific segmenation
        base_naming_convention.mstype = mstype;
        
        %DPS 25,11,2015 - added mstype field to allow for specific segmenation
%         base_naming_convention.seg_channel = channels(:,2);
        

        image_subdirectory = [image_path, filesep, (label_subdirectories{index}), filesep];
        
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
        
        storage_subdirectory    = [processed_path, (label_subdirectories{index}), filesep];
        
        if(steps(2))
%         try
            
            %DPS 06/08/15 - adding support for partially scanned images
            %Check if images need to be trimmed, trim them and updated the
            %directory field.
            %     [image_subdirectory] = trimImages(image_subdirectory,base_naming_convention,out_folder);
            %DPS 10/08/15 - After discussing with Emma, we will now mark images
            %that are partial scans and not trim images
            [nucfiles{index}, skipimage{index}] = preprocessImages(image_subdirectory,base_naming_convention,curr_out_folder)
            if any(skipimage{index}==1)
                
                cell_feat = [];
                disp('skipimage was triggered. See error code in skipimage variable.')
                skipimage
                exit_code(index) = 1;%HPAIT requested only 1 error code...
                continue
            end
            
            %%DPS 09,02,2018 - sweet jesus. Terrible. I'm going to have to
            %%think about how to handle this in the new channels
            %%structure...
            %After discussion with Emma Lundberg, we will allow a partial
            %nuclear scan iff the ER scan appears full. If any other channel
            %has a partial scan, or both ER and nuc do, fail the image.
            %Note, order goes [nuc,prot,mt,er]
            if any(any(skipimage{index}==2)) && ~run_partial_scans
                if (skipimage{index}(1)==2 && ~skipimage{index}(4)) || (~skipimage{index}(1)==2 && skipimage{index}(4))
                    warning('potential partial scan for either Nuc or ER, however the other appears ok. Continue at your own risk.');
                else
                    cell_feat = [];
                    exit_code(index) = 1;%again, HPAIT requested only 1 error code...
                    continue
                end
            elseif any(any(skipimage{index}==2)) && run_partial_scans
                warning('You are running an image that may contain a partial scan. proceed at your own risk!!')
            end
            
            [label_features{index}, feature_names,...
                feature_computation_time, cell_seed, nucleus_seed,...
                segskips,slf_names] = get_concatenated_region_features(...
                image_subdirectory,storage_subdirectory, ...
                base_naming_convention, label_names{index},...
                true, false, resolution);
            %image_path, storage_path,
            %base_naming_convention, label_name,
            %optimize, use_segmentation_suffix_in_list,resolution)
            %DPS 20150924 - added support for cell array within our for loop of
            %subfolders (fields)
            %         regions_results     =   cell2mat(label_features);
            regions_results = cat(1,label_features{:});
            
            % read cell (x,y) centers and bounding box values
            infiletype = [];
            if findstr(base_naming_convention.channels{1,1},'.tif');
                infiletype = 'tif';
            elseif findstr(base_naming_convention.channels{1,1},'.TIF');
                infiletype = 'TIF';
            else
                warning('This image does not appear to be a tif (or TIF). Trying to separate file type. Assuming fileparts will give correct answer.')
                [~,~,nucext] = fileparts(base_naming_convention.channel{1,1});
                infiletype = nucext(2:end);
            end
            if strcmp(base_naming_convention.channels{1,1}(end-2:end),'.gz')
                infiletype = [infiletype,'.gz'];
            end
            
            
            
            pngsuff = strrep(base_naming_convention.segmentation_suffix,infiletype,'png.gz');
            %nucpngsuff = strrep(base_naming_convention.protein_channel,['.',infiletype],'_nuc.png.gz');
            dir_png         = dir(fullfile([storage_subdirectory,filesep,'*',pngsuff]));
            
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
		currpath = [storage_subdirectory,filesep,char(dir_png(i).name)];
                bw_seg = ml_readimage(fullfile(currpath));
                if sum(bw_seg(:))==0 || length(unique(bw_seg))==1
                    warning(['Image ', currpath,' seems to be blank!']);
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
                    warning(['Image ', currpath,' seems to be blank!'])
                end
            end
            
            position_results = cat(1,position_stats{:});
            
            if sum(position_results(:))>0
                cell_feat  = [position_results regions_results];
                %DPS 30,07,2015 - added feature name save and concatenation of
                %position stats to feature names
                feature_names = [pos_stats_names feature_names];
                slf_names = [pos_stats_names, slf_names];
                save(fullfile([curr_out_folder,filesep,'feature_names.mat']),'feature_names','slf_names');
                csvwrite(fullfile([curr_out_folder,filesep,label_subdirectories{index},'_features.csv']), cell_feat);
                
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
                save(fullfile([curr_out_folder,filesep,'feature_names.mat']),'feature_names');
                csvwrite(fullfile([curr_out_folder,filesep,label_subdirectories{index},'_features.csv']), cell_feat);
                faillist = [faillist,image_subdirectory];
            else
                cell_feat = 0;
                exit_code(i) = 122;
                disp('Segmentation error occuring during feature extraction 63x/40x');
                faillist = [faillist,image_subdirectory];
                %             exit(exit_code);
            end
            
            save(fullfile([curr_out_folder,filesep,'listOfFailed.mat']),'faillist','skipimage','segskips')
%         catch
%             faillist = [faillist,image_subdirectory];
            %save([curr_out_folder,filesep,'listOfFailed.mat'],'faillist','skipimage','segskips')
%             cell_feat = [];
%             exit_code(index) = 122;
%             continue
            %
            %disp('An error occuring during feature extraction 63x/40x');
            %exit(exit_code);
%         end
        
        %         end
        % save([out_folder,filesep,'listOfFailed_tot.mat'],'faillist')
    end
    %% create segmentation masks
    
    if(steps(3))
        %%%DPS 2015-07-09  Not sure where I is supposed to be coming from without a for loop!
        % Read images - this step is not necessary. %DPS 2016-06-07
        
        %     im_dapi     =   imread(list_dapi(i).name);
        %     im_ab       =   imread(list_ab(i).name);
        %     im_mtub     =   imread(list_mtub(i).name);
        %     im_er       =   imread(list_er(i).name);
        
        % Segment the nucleus and cell extent mask
        
        if ~exist('cell_seed','var')
            [cell_seed, nucleus_seed, segskips] = segmentFields(image_subdirectory, storage_subdirectory, base_naming_convention,resolution);
        end
        
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
        
        %alpha_ch(cell_seed>0)                       = 3;
        alpha_ch(cyto_seed>0)                       = 2;
        alpha_ch(nucleus_seed>0&cell_seed>0)        = 1;
        alpha_ch(plasmaMem)                         = 4;
        
        %         imwrite(double(merge_mask),[curr_out_folder,'/segmentation_',label_subdirectories{index},'.png'],'Alpha',alpha_ch/255);
        outpath = [curr_out_folder,filesep,label_subdirectories{index},'_segmentation.png'];
	imwrite(cell_seed.*uint16(alpha_ch<4),outpath,'Alpha',alpha_ch./65535);
        gzip(outpath)
	delete(outpath)
        % merge the output from the image set with other ABs image set data
        % previously analysed (if multiple ABs are included or if analysis is
        % run at the plate level)
    end
end
%exit(exit_code);
