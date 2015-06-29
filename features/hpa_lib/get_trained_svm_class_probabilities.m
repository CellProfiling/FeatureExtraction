function [class_probabilities] = get_trained_svm_class_probabilities(...
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
  
% $$$   class_probability_sets = arrayfun(...
% $$$     @(outer_index)getfield(load([save_filename, num2str(outer_index, '_outer%d')], ...
% $$$                                 'outer_model_weights'), 'outer_model_weights'), ...
% $$$     1:number_splits...
% $$$     , 'UniformOutput', false);
% $$$   %class_probabilities{1}
% $$$   %class_probabilities = cell2mat(class_probability_sets');
% $$$   class_probabilities = zeros(number_data, size(class_probability_sets{1}, 2)); 
% $$$   for split_index = 1:number_splits
% $$$     outer_filename = [save_filename, num2str(outer_index, '_outer%d')];
% $$$     class_probabilities(outer_testing_indices{split_index}, :)=class_probability_sets{split_index}; 
% $$$   end

  % Forgot to output proper probabilities, so redoing here:
  class_probabilities = zeros(number_data, length(unique(complete_labels))); 
  for outer_index = 1:number_splits
    outer_filename = [save_filename, num2str(outer_index, '_outer%d')];
% $$$     outer_model = getfield(load([save_filename, num2str(outer_index, '_outer%d')], ...
% $$$                                 'outer_model'), 'outer_model'); 
    load([save_filename, num2str(outer_index, '_outer%d')]); 

    outer_training_features = complete_features(outer_training_indices{outer_index}, :); 
    outer_training_labels = complete_labels(outer_training_indices{outer_index}, :); 
    outer_testing_features = complete_features(outer_testing_indices{outer_index}, :); 
    outer_testing_labels = complete_labels(outer_testing_indices{outer_index}, :); 
    % Standardize:
    % Use the best features and options to build a classifier for
    % all of the training data:
    [outer_training_features, outer_testing_features, outer_training_mean, outer_training_standard_deviation] = ...
        standardizeFeatures(outer_training_features, outer_testing_features); 
    % Select:
    outer_feature_indices = find(feature_selection_counts > 0);
    %whos outer_feature_indices
    outer_training_features = outer_training_features(:, outer_feature_indices); 

    [a, b, c] = svmpredict(outer_testing_labels, outer_testing_features, outer_model, '-b 1');
    %whos
    class_probabilities(outer_testing_indices{outer_index}, :) = c; 
  end
  %class_probabilities
  

end
  