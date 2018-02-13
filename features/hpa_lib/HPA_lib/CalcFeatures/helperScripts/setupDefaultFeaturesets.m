function [feature_set_naming_conventions,feature_set_feature_names]  = setupDefaultFeaturesets(base_naming_convention)

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

% number_feature_sets = length(feature_set_directories)
disp('setting naming conventions')
nucseg_val = 1;
cellseg_val = 2; 
prot_val = 0;
usedinds = zeros(size(base_naming_convention.channels,1),1);
blank_channels = base_naming_convention.blank_channels;
base_naming_convention.blank_channels = {};

prot_ind = get_naming_inds(base_naming_convention.channels,prot_val);
base_naming_convention.protein_channel = base_naming_convention.channels{prot_ind,1};
usedinds(prot_ind) = 1;
if blank_channels(prot_ind)
    base_naming_convention.blank_channels = {base_naming_convention.blank_channels{:};'protein'};
end
    

nucseg_inds = get_naming_inds(base_naming_convention.channels,nucseg_val);
firstnuc_ind = find(nucseg_inds,1,'first');
base_naming_convention.nuclear_channel = base_naming_convention.channels{firstnuc_ind,1};
usedinds(firstnuc_ind) = 1;
if blank_channels(firstnuc_ind)
    base_naming_convention.blank_channels = {base_naming_convention.blank_channels{:};'nuclear'};
end
cellseg_inds = get_naming_inds(base_naming_convention.channels,cellseg_val);
firstcell_ind = find(cellseg_inds,1,'first');
base_naming_convention.tubulin_channel = base_naming_convention.channels{firstcell_ind,1};
usedinds(firstcell_ind) = 1;
if blank_channels(firstcell_ind)
    base_naming_convention.blank_channels = {base_naming_convention.blank_channels{:};'tubulin'};
end
base_naming_convention.er_channel = base_naming_convention.channels{~usedinds,1};
if blank_channels(firstcell_ind)
    base_naming_convention.blank_channels = {base_naming_convention.blank_channels{:};'er'};
end

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
nucmasksuffix = base_naming_convention.segmentation_suffix;
% cytomasksuffix = strrep(nucmasksuffix,'.tif','_cyto.png');

if strfind(nucmasksuffix,'.tif');
    nucmasksuffix = strrep(nucmasksuffix,'.tif','_nuc.png.gz');
elseif strfind(nucmasksuffix,'.TIF');
    nucmasksuffix = strrep(nucmasksuffix,'.TIF','_nuc.png.gz');
else 
    warning('This image does not appear to be a tif (or TIF). Trying to separate file type. Assuming fileparts will give correct answer.')
    [~,~,nucext] = fileparts(nucmasksuffix);
    nucmasksuffix = strrep(nucmasksuffix,nucext,'_nuc.png.gz');
end
if strcmp(base_naming_convention.protein_channel(end-2:end),'.gz')
    nucmasksuffix = nucmasksuffix(1:end-3);%if it already had a gz, remove the extra one
end
    
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


end

function inds = get_naming_inds(channels,val)
    inds = cell2mat(cellfun(@(x) ~isempty(x)&&x==val,channels(:,2),'UniformOutput',0));
end