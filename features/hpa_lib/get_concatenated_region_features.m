function [features, feature_names, feature_computation_time, cell_regions , nuc_regions, skipimgs] = get_concatenated_region_features(...
    image_path, storage_path, base_naming_convention, label_name, optimize, use_segmentation_suffix_in_list,resolution)
%
%Written by: Unknown
%
%Edited by:
%Devin P Sullivan 10/08/15 - added 'skipimgs' variable to track blank
%images

start_time = tic;

%   addpath(genpath('./HPA_lib'));
%   addpath(genpath('./DataHash'));
warning('off', 'MATLAB:MKDIR:DirectoryExists');
% warning('off', 'Images:imfeature:obsoleteFunction');


% $$$   mask_path = [storage_path, 'segmentation/'];
mask_path = storage_path;
metadata_path = [storage_path, '/metadata/'];

mkdir(storage_path)
mkdir(mask_path)
mkdir(metadata_path)

if ~exist('label_name', 'var')
    label_name = '';
end

if ~exist('optimize', 'var')
    optimize = false;
end

if ~exist('use_segmentation_suffix_in_list', 'var')
    use_segmentation_suffix_in_list = false;
end

if nargout > 2
    feature_computation_time = 0;
end
disp('segmenting fields')
%DPS 10/08/15 - adding field for tracking blank images
%   [cell_regions, nuc_regions] = segmentFields(image_path, mask_path, base_naming_convention,resolution);
[cell_regions, nuc_regions,skipimgs] = segmentFields(image_path, mask_path, base_naming_convention,resolution);
% nuc_regions = imfill(nuc_regions,'holes');
%   figure;imshow(label2rgb(bwlabel(cell_regions)));
%   figure;imshow(label2rgb(bwlabel(nuc_regions)));
disp('getting nuclear region feats')
nucstats_seg = regionprops(bwlabel(nuc_regions),'Centroid','BoundingBox');


if use_segmentation_suffix_in_list
    base_naming_convention2 = base_naming_convention;
    base_naming_convention2.protein_channel = base_naming_convention2.segmentation_suffix;
    imagelist = listImages(image_path, storage_path, base_naming_convention2)';
else
    imagelist = listImages(image_path, storage_path, base_naming_convention)';
end
label_list = repmat({label_name}, length(imagelist), 1);

feature_set_directories = {...
    ''...
    ; '/original_nuc-as-prot'...
    ; '/nucStats'...
    ; '/nucStats_prot-as-nuc'...
    ; '/original_tub-as-prot'...
    ; '/nucStats_tub-as-nuc'...
    ; '/intensity_wholecell'...
    ; '/intensity_nuc'...
    ; '/intensity_cyto'}
%     ; '/total_protein'...
%     ; '/total_dapi'...
%     ; '/total_nucprot'...
%     ; '/nucprotfeats'}

number_feature_sets = length(feature_set_directories)
disp('setting naming conventions')
feature_set_naming_conventions = repmat({base_naming_convention}, size(feature_set_directories));
feature_set_naming_conventions = repmat({base_naming_convention}, size(feature_set_directories));
feature_set_naming_conventions{2}.protein_channel = base_naming_convention.nuclear_channel;
%DPS 05,08,2015 - resetting the 'blank' channel each feature set screws
%things up if a channel is actually missing. We need to ADD the blank
%name to the base naming convention!
%   feature_set_naming_conventions{2}.blank_channels = {'nuclear'};
feature_set_naming_conventions{2}.blank_channels = [base_naming_convention.blank_channels,{'nuclear'}];
feature_set_naming_conventions{4}.nuclear_channel = base_naming_convention.protein_channel;
feature_set_naming_conventions{5}.protein_channel = base_naming_convention.tubulin_channel;
%DPS 05,08,2015 - resetting the 'blank' channel each feature set screws
%things up if a channel is actually missing. We need to ADD the blank
%name to the base naming convention!
%   feature_set_naming_conventions{5}.blank_channels = {'tubulin'};
feature_set_naming_conventions{5}.blank_channels = [base_naming_convention.blank_channels,{'tubulin'}];
feature_set_naming_conventions{6}.nuclear_channel = base_naming_convention.tubulin_channel;

% new code
%feature_set_naming_conventions{7}.protein_channel = base_naming_convention.protein_channel;
%feature_set_naming_conventions{8}.protein_channel = base_naming_convention.nuclear_channel;

%DPS 2015/10/19 - Protein within nucleus features 
nucmasksuffix = base_naming_convention.protein_channel;
% cytomasksuffix = strrep(nucmasksuffix,'.tif','_cyto.png');
nucmasksuffix = strrep(nucmasksuffix,'.tif','_nuc.png');

feature_set_naming_conventions{8}.segmentation_suffix = nucmasksuffix;
feature_set_naming_conventions{9} = rmfield(feature_set_naming_conventions{9},'segmentation_suffix');
feature_set_naming_conventions{9}.segmentation_suffix.nuc = nucmasksuffix;
feature_set_naming_conventions{9}.segmentation_suffix.cell = ...
    feature_set_naming_conventions{1}.segmentation_suffix;

%%%tmp
%     feature_set_naming_conventions{1}.segmentation_suffix = feature_set_naming_conventions{9}.segmentation_suffix;
%%%%%%%%%

feature_set_feature_names = repmat({[]}, size(feature_set_directories));
feature_set_feature_names{3} = {'nucStats'};
feature_set_feature_names{4} = {'nucStats'};
feature_set_feature_names{6} = {'nucStats'};

% new code
%feature_set_feature_names{7} = {'protTotalIntensity'};
%feature_set_feature_names{8} = {'protTotalIntensity'};
feature_set_feature_names{7} = {'IntensityStats'};
feature_set_feature_names{8} = {'IntensityStats'};
feature_set_feature_names{9} = {'IntensityStats'};

%DPS 2015/10/19 - Protein within nucleus features 
% feature_set_feature_names{9} = {'protTotalIntensity'};


feature_set_naming_conventions{:}
feature_set_feature_names{:}

features = cell(1, 0);
feature_names = cell(1, 0);
% $$$   for index = 1:20
% $$$     warning('DEBUG: feature_set_index = 5')
% $$$   end
% $$$   for feature_set_index = 5
for feature_set_index = 1:number_feature_sets
%     if feature_set_index >= 7
%         holdup = 1
%     end
    
    %%The segmentation suffix determines the save path and whether the
    %%output will be computed. Here they are all set to 'green', meaning
    %%when we compute the shuffled channels, they will actually not
    %%compute because the same fset name was computed for 'green'
    %%already.
    %%To fix this we will set the 'segmentation_suffix' to the
    %%'protein_channel' suffix for each feature set
    %       feature_set_naming_conventions{feature_set_index}.segmentation_suffix = feature_set_naming_conventions{feature_set_index}.protein_channel;
    
    %%
    
    %feature_set_index
    % Compute features:
    %feature_set_subdirectory = [storage_path(1:end - 1), feature_set_directories{feature_set_index}, filesep];
    feature_set_subdirectory = storage_path
    %image_path
    %mask_path
    disp(['calculating features on set index ', num2str(feature_set_index),'.'])
    calcRegionFeat(image_path, mask_path, feature_set_subdirectory, ...
        feature_set_naming_conventions{feature_set_index}, ...
        feature_set_feature_names{feature_set_index}, ...
        optimize);
    
    % Dummy metadata needed for Jieyue's HPA_lib code:
    classlabels = label_list;
    staining = repmat({'2:Moderate'}, size(label_list));
    specificity = ones(size(label_list));
    cellabels = ones(size(label_list));
    antibodyids = -ones(size(label_list));
    save([metadata_path, 'hpalistsall.mat'], ...
        'imagelist','antibodyids','classlabels','cellabels','specificity','staining');
    
    % Combine features into one file:
    %%D. Sullivan 10/09/2015 - need to now define the more explicit
    %sub-feature file suffix
%     if isempty(feature_set_feature_names{feature_set_index})
      %20150923 - Since the file extension may have more than one '.' in it strtok
      %will no longer work! 
      [~,protsuff,~] = fileparts(feature_set_naming_conventions{feature_set_index}.protein_channel);
      [~,nucsuff,~] = fileparts(feature_set_naming_conventions{feature_set_index}.nuclear_channel);
      [~,tubsuff,~] = fileparts(feature_set_naming_conventions{feature_set_index}.tubulin_channel);
      [~,ersuff,~] = fileparts(feature_set_naming_conventions{feature_set_index}.er_channel);
      if isstruct(feature_set_naming_conventions{feature_set_index}.segmentation_suffix)
          [~,segsuff1,~] = fileparts(feature_set_naming_conventions{feature_set_index}.segmentation_suffix.nuc);
          [~,segsuff2,~] = fileparts(feature_set_naming_conventions{feature_set_index}.segmentation_suffix.cell);
          segsuff = [segsuff1,segsuff2];
      else
          [~,segsuff,~] = fileparts(feature_set_naming_conventions{feature_set_index}.segmentation_suffix);
      end
%       [~,segsuff,~] = fileparts(feature_set_naming_conventions{feature_set_index}.segmentation_suffix);
      featsuffix = [protsuff,nucsuff,tubsuff,ersuff,segsuff];
%         featsuffix = [strtok(feature_set_naming_conventions{feature_set_index}.protein_channel,'.'),...
%             strtok(feature_set_naming_conventions{feature_set_index}.nuclear_channel,'.'),...
%             strtok(feature_set_naming_conventions{feature_set_index}.tubulin_channel,'.'),...
%             strtok(feature_set_naming_conventions{feature_set_index}.er_channel,'.'),...
%             strtok(feature_set_naming_conventions{feature_set_index}.segmentation_suffix,'.')];
%     else
%         featsuffix = [strtok(feature_set_naming_conventions{feature_set_index}.protein_channel,'.'),...
%             strtok(feature_set_naming_conventions{feature_set_index}.nuclear_channel,'.'),...
%             strtok(feature_set_naming_conventions{feature_set_index}.tubulin_channel,'.'),...
%             strtok(feature_set_naming_conventions{feature_set_index}.er_channel,'.'),...
%             strtok(feature_set_naming_conventions{feature_set_index}.segmentation_suffix,'.'),...
%             '_',feature_set_feature_names{feature_set_index}{1}];
%     end
    %%
    
    data_filename = [feature_set_subdirectory, '/features/regionfeatures_all.mat'];
    [data_filename, computation_time] = ...
        loadAllRegionFeatures(...
        [feature_set_subdirectory, '/features/region/'], metadata_path, image_path, ...
        data_filename, feature_set_feature_names{feature_set_index},featsuffix);
    %     [data_filename, computation_time] = ...
    %         loadAllRegionFeatures(...
    %           [feature_set_subdirectory, '/features/region/'], metadata_path, image_path, ...
    %           data_filename, feature_set_feature_names{feature_set_index});
    if exist('feature_computation_time', 'var')
        feature_computation_time = feature_computation_time + computation_time;
    end
    
    % Load features:
    data = load(data_filename);
    features{1, feature_set_index} = data.allfeatures;
    feature_names = [feature_names, strcat(num2str(feature_set_index, 'feature_set%d:'), data.names)];
    %whos feature*
    
end
disp('making feature matrix')
%features
features = cell2mat(features);
%whos feature*
%feature_names

%error('Implementation yet unfinished below this line!')

warning('on', 'MATLAB:MKDIR:DirectoryExists');
warning('on', 'Images:imfeature:obsoleteFunction');

end
