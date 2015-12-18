function [feature_set_naming_conventions,feature_set_feature_names]  = setupLowResFeaturesets(base_naming_convention)

feature_set_directories = {...
    ; '/nucStats'...
    ; '/nucStats_prot-as-nuc'...
    ; '/nucStats_tub-as-nuc'...
    ; '/intensity_wholecell'...
    ; '/intensity_nuc'...
    ; '/intensity_cyto'}

% feature_set_directories = {...
%     ''...
%     ; '/original_nuc-as-prot'...
%     ; '/nucStats'...
%     ; '/nucStats_prot-as-nuc'...
%     ; '/original_tub-as-prot'...
%     ; '/nucStats_tub-as-nuc'...
%     ; '/intensity_wholecell'...
%     ; '/intensity_nuc'...
%     ; '/intensity_cyto'}
%     ; '/total_protein'...
%     ; '/total_dapi'...
%     ; '/total_nucprot'...
%     ; '/nucprotfeats'}

% number_feature_sets = length(feature_set_directories)
disp('setting naming conventions')
feature_set_naming_conventions = repmat({base_naming_convention}, size(feature_set_directories));
feature_set_naming_conventions = repmat({base_naming_convention}, size(feature_set_directories));

%DPS 05,08,2015 - resetting the 'blank' channel each feature set screws
%things up if a channel is actually missing. We need to ADD the blank
%name to the base naming convention!
%   feature_set_naming_conventions{2}.blank_channels = {'nuclear'};
feature_set_naming_conventions{2}.nuclear_channel = base_naming_convention.protein_channel;

%DPS 05,08,2015 - resetting the 'blank' channel each feature set screws
%things up if a channel is actually missing. We need to ADD the blank
%name to the base naming convention!
%   feature_set_naming_conventions{5}.blank_channels = {'tubulin'};
feature_set_naming_conventions{3}.nuclear_channel = base_naming_convention.tubulin_channel;


%DPS 2015/10/19 - Protein within nucleus features 
nucmasksuffix = base_naming_convention.protein_channel;
% cytomasksuffix = strrep(nucmasksuffix,'.tif','_cyto.png');

if strfind(nucmasksuffix,'.tif');
    nucmasksuffix = strrep(nucmasksuffix,'.tif','_nuc.png');
elseif strfind(nucmasksuffix,'.TIF');
    nucmasksuffix = strrep(nucmasksuffix,'.TIF','_nuc.png');
else 
    warning('This image does not appear to be a tif (or TIF). Trying to separate file type. Assuming fileparts will give correct answer.')
    [~,~,nucext] = fileparts(nucmasksuffix);
    nucmasksuffix = strrep(nucmasksuffix,nucext,'_nuc.png');
end
    
feature_set_naming_conventions{5}.segmentation_suffix = nucmasksuffix;
feature_set_naming_conventions{6} = rmfield(feature_set_naming_conventions{6},'segmentation_suffix');
feature_set_naming_conventions{6}.segmentation_suffix.nuc = nucmasksuffix;
feature_set_naming_conventions{6}.segmentation_suffix.cell = ...
    feature_set_naming_conventions{1}.segmentation_suffix;

%%%tmp
%     feature_set_naming_conventions{1}.segmentation_suffix = feature_set_naming_conventions{9}.segmentation_suffix;
%%%%%%%%%

feature_set_feature_names = repmat({[]}, size(feature_set_directories));
feature_set_feature_names{1} = {'nucStats'};
feature_set_feature_names{2} = {'nucStats'};
feature_set_feature_names{3} = {'nucStats'};

% new code
feature_set_feature_names{4} = {'IntensityStats'};
feature_set_feature_names{5} = {'IntensityStats'};
feature_set_feature_names{6} = {'IntensityStats'};

%DPS 2015/10/19 - Protein within nucleus features 
% feature_set_feature_names{9} = {'protTotalIntensity'};


feature_set_naming_conventions{:}
feature_set_feature_names{:}


% $$$   for index = 1:20
% $$$     warning('DEBUG: feature_set_index = 5')
% $$$   end
% $$$   for feature_set_index = 5