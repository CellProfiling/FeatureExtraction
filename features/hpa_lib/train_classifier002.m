function [] = train_classifier002()

  start_time = tic;

  %addpath(genpath('/home/jieyuel/share/HPA_lib/HPA_lib'));
  addpath(genpath('./HPA_lib'));
  addpath(genpath('./DataHash'));
  addpath(genpath('./explode_implode'));
  warning('off', 'MATLAB:MKDIR:DirectoryExists');
  warning('off', 'Images:imfeature:obsoleteFunction');

  filename = mfilename;
  mkdir(filename)
  n = getenv('PBS_JOBID');
  n = regexprep(n, '[\r\n]', '');
  date_text = datestr(now(), 'yyyymmddHHMMSSFFF')
  diary([filename '/' 'log' date_text ...
         '_' n '.txt']);

  image_path = '/share/images/HPA/images/IFconfocal_CellCycle/CELL_CYCLE_ANNOTATED_IMAGES/';
  % The word "class" creates a new class (that is, from
  % object-oriented programming) in VoiceCode, hence the odd name
  % of label_image_list, etc.
  % MPhase empty 2011-11-10 00:54
  %  'MPhaseCyclinB1Training' ...
  label_subdirectories = { ...
    'G1PhaseCyclinB1Training', ...
    'G2PhaseCyclinB1Training', ...
    'SPhaseCyclinB1Training', ...
    };
  label_names = {...
    'phase_G1', ...
    'phase_G2', ...
    'phase_S', ...
                };
  number_labels = length(label_subdirectories); 
  label_features = cell(1, number_labels);
  %processed_path = './processed_data_for_concatenated/';
  processed_path = './processed_data/';
  mkdir(processed_path)
  feature_names = []
  for index = 1:number_labels
    image_subdirectory = [image_path, label_subdirectories{index}, filesep];
    %processed_subdirectory = [processed_path, filesep, label_subdirectories{index}, filesep];
    storage_subdirectory = [processed_path, label_subdirectories{index}, filesep];

% $$$     [features, feature_names] = get_concatenated_region_features(image_subdirectory, storage_subdirectory, [], label_names{index});
    [label_features{index}, feature_names] = get_concatenated_region_features(image_subdirectory, storage_subdirectory, [], label_names{index}, true);
    whos feature*
  end

  
  %error('Implementation yet unfinished below this line!')
  
  
  % Concatenate all features:
% $$$   clear label_features
% $$$   for index = 1:number_labels
% $$$     label_features(index, 1)=load(feature_filenames{index}); 
% $$$   end
% $$$   %label_features
% $$$   complete_features = cat(1, label_features.allfeatures);
% $$$   complete_labels = arrayfun(...
% $$$     @(index)ones(size(label_features(index).allfeatures, 1), 1) .* index, ...
% $$$     (1:number_labels)', 'UniformOutput', false); 
% $$$   complete_labels = cat(...
% $$$     1, complete_labels{:}); 
  
  label_features
  %complete_features = cat(1, label_features(:));
  complete_features = cat(1, label_features{:});
  complete_labels = cell2mat(arrayfun(...
    @(index)ones(size(label_features{index}, 1), 1) .* index, ...
    (1:number_labels)', 'UniformOutput', false)); 
  % Remove NaN and zero-variance features:
  good_columns = (sum(isnan(complete_features), 1) == 0) & (std(complete_features, 0, 1) > 0); 
  complete_features = complete_features(:, good_columns); 
  feature_names = feature_names(good_columns); 
% $$$   good_rows = sum(isnan(complete_features), 2) == 0; 
% $$$   complete_features = complete_features(good_rows, :); 
% $$$   complete_labels = complete_labels(good_rows, :); 
  number_data_per_label = arrayfun(@(index)sum(complete_labels == index), 1:number_labels)
  number_features = size(complete_features, 2)
  
  % Feature set combinations to try (each used with SDA and no
  % featsel):
  feature_set_combinations = {...
    [1], ...
    [2], ...
    [3], ...
    [4], ...
    [5], ...
    [6], ...
    [2, 3], ...
    [2, 3, 5, 6], ...
    [1:6], ...
                   }
  number_feature_set_combinations = length(feature_set_combinations)
  feature_set_combination_suffixes = cellfun(...
    @(x)implode(cellfun(@(x)num2str(x), num2cell(x), 'UniformOutput', false), ','), ...
    feature_set_combinations, 'UniformOutput', false);
  %feature_set_indices = arrayfun(@(index)strmatch(num2str(index, 'feature_set%d:'), feature_names(:)), 1:6)';
  feature_set_indices = arrayfun(@(index)strmatch(num2str(index, 'feature_set%d:'), feature_names(:)), 1:6, 'UniformOutput', false)';
  feature_set_indices2 = false(length(feature_set_indices), number_features);
  for set_index = 1:length(feature_set_indices)
    feature_set_indices2(set_index, feature_set_indices{set_index}) = true;
  end
  feature_set_indices = feature_set_indices2;
  whos
  
  %error('Implementation yet unfinished below this line!')
  
  for combination_index = 1:number_feature_set_combinations
    % Partition data into training and testing sets for cross
    % validation:
    sda_filename = [filename, '/comb_', feature_set_combination_suffixes{combination_index}, '_sda']
    no_feature_selection_filename = [filename, '/comb_', feature_set_combination_suffixes{combination_index}, '_nofeatsel']
    number_splits = 10

    combination_feature_indices = max(feature_set_indices(feature_set_combinations{combination_index}, :), [], 1); 
    min(find(combination_feature_indices))
    max(find(combination_feature_indices))
    combination_features = complete_features(:, combination_feature_indices); 
    
    time_so_far = toc(start_time)

    disp('########################################')
    disp('########################################')
    disp('########################################')
    disp([num2str(number_splits, '%d-fold CV'), ', feature sets ', feature_set_combination_suffixes{combination_index}, ', SDA:'])
    %disp('')
    train_svm_with_cross_validation(...
      combination_features, complete_labels, number_splits, sda_filename, 'sda');

    time_so_far = toc(start_time)

    disp('########################################')
    disp('########################################')
    disp('########################################')
    disp([num2str(number_splits, '%d-fold CV'), ', feature sets ', feature_set_combination_suffixes{combination_index}, ', no feature selection:'])
    train_svm_with_cross_validation(...
      combination_features, complete_labels, number_splits, no_feature_selection_filename, 'none');
  
  end
  
  time_so_far = toc(start_time)

  
  diary('off')
  
  
end
  
  
  