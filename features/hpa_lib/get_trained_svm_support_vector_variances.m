function [support_vector_feature_variances] = get_trained_svm_support_vector_variances(...
  complete_features, complete_labels, number_splits, save_filename)
  
  if ~exist('save_filename', 'var')
    save_filename = [train_svm_with_cross_validation, '_results'];
  end
  if ~exist('feature_selection_method', 'var')
    feature_selection_method = 'sda';
  end
  
  [number_data, number_features] = size(complete_features)
  
  outer_splits = partition(complete_labels, number_splits); 
  [outer_training_indices, outer_testing_indices] = partedsets(outer_splits); 
  
  options = '-s 0 -t 2 -b 1 -q';
  
  feature_selection_counts = arrayfun(...
    @(outer_index)getfield(load([save_filename, num2str(outer_index, '_outer%d')], ...
                                'feature_selection_counts'), 'feature_selection_counts')', ...
    1:number_splits...
    , 'UniformOutput', false);
  feature_selection_counts = cell2mat(feature_selection_counts');
  %feature_selection_counts
      
  support_vectors = arrayfun(...
    @(outer_index)load([save_filename, num2str(outer_index, '_outer%d')], 'outer_model'), ...
    1:number_splits);
  support_vectors = arrayfun(...
    @(outer_index)support_vectors(outer_index).outer_model.SVs, ...
    1:number_splits...
    , 'UniformOutput', false);
  %support_vectors'
  support_vector_feature_variances = zeros(number_splits, number_features); 
  for split_index = 1:number_splits
    support_vector_feature_variances(split_index, feature_selection_counts(split_index, :) > 0)=...
        var(support_vectors{split_index}, 1); 
  end
  %support_vector_feature_variances

end
  