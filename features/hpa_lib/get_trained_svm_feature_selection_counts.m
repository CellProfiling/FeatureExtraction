function [feature_selection_counts] = get_trained_svm_feature_selection_counts(...
  complete_features, complete_labels, number_splits, save_filename)
  
  if ~exist('save_filename', 'var')
    save_filename = [train_svm_with_cross_validation, '_results'];
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

end
  