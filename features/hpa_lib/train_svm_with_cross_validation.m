function [] = train_svm_with_cross_validation(...
  complete_features, complete_labels, number_splits, save_filename, feature_selection_method)
%function [model, best_parameters, predicted_labels] = train_svm_with_cross_validation(...
  
  if ~exist('save_filename', 'var')
    save_filename = [train_svm_with_cross_validation, '_results'];
  end
  if ~exist('feature_selection_method', 'var')
    feature_selection_method = 'sda';
  end
  
  [number_data, number_features] = size(complete_features)
  
  % Jieyue's:
  %[penalties, parameters] = meshgrid(2.^(2:2:8), 2.^(-2:2:4)); 
  % LIBSVM guide ("A practical guide to support vector
  % classification"):
  [penalties, parameters] = meshgrid(2.^(-5:2:15), 2.^(-15:2:3)); 
  % Sets random seed, so could do this in parallel:
  outer_splits = partition(complete_labels, number_splits); 
  [outer_training_indices, outer_testing_indices] = partedsets(outer_splits); 
  
% $$$   options = '-s 0 -t 2 -b 1 -q ';
  options = '-s 0 -t 2 -b 1 ';
  options_suffix_format = '-c %e -g %e';
% $$$   options_grid = arrayfun(@(x, y) (num2str([x, y], options_suffix_format)), penalties, parameters, 'UniformOutput', false);
  % Correct but forgot to use before 2011-12-01 04:00 :( :
  options_grid = arrayfun(@(x, y)[options, (num2str([x, y], options_suffix_format))], penalties, parameters, 'UniformOutput', false);
  
  
  if exist([save_filename, '.mat'], 'file')
    load([save_filename, '.mat'])
  else
    completed_splits = false(number_splits, 1); 

    for outer_index = 1:number_splits
      outer_filename = [save_filename, num2str(outer_index, '_outer%d')];
      [can_start, final_name, final_exists] = ...
          chunk_start('.', outer_filename);
      if (~can_start)
        if final_exists
          completed_splits(outer_index)=true; 
        end
        continue
      end

      outer_training_features = complete_features(outer_training_indices{outer_index}, :); 
      outer_training_labels = complete_labels(outer_training_indices{outer_index}, :); 
      outer_testing_features = complete_features(outer_testing_indices{outer_index}, :); 
      outer_testing_labels = complete_labels(outer_testing_indices{outer_index}, :); 

      % Sets random seed, so could do this in parallel:
      inner_splits = partition(outer_training_labels, number_splits); 
      [inner_training_indices, inner_testing_indices] = partedsets(inner_splits); 
      % Select features and options:
      feature_selection_counts = zeros(number_features, 1); 
      inner_model_accuracies_sums = zeros(size(options_grid)); 
      for inner_index = 1:number_splits
        inner_training_features = outer_training_features(inner_training_indices{inner_index}, :); 
        inner_training_labels = outer_training_labels(inner_training_indices{inner_index}, :); 
        inner_testing_features = outer_training_features(inner_testing_indices{inner_index}, :); 
        inner_testing_labels = outer_training_labels(inner_testing_indices{inner_index}, :); 
        % Standardize:
        [inner_training_features, inner_testing_features, inner_training_mean, inner_training_standard_deviation] = ...
            standardizeFeatures(inner_training_features, inner_testing_features); 
        % Select:
        inner_feature_indices = featureSelection(...
          inner_training_features, ...
          inner_training_labels, ...
          feature_selection_method, [mfilename, num2str([outer_index, inner_index], '_set%03d_%03d')]);
        whos inner_feature_indices
        feature_selection_counts(inner_feature_indices)=feature_selection_counts(inner_feature_indices) + 1; 
        inner_training_features = inner_training_features(:, inner_feature_indices); 
        % Train:
        %options_grid{1}
        inner_models = cellfun(...
          @(options_set)svmtrain(inner_training_labels, inner_training_features, options_set), ...
          options_grid...
          );
% $$$       [inner_model_predictions, inner_model_accuracies, inner_model_weights] = arrayfun(...
% $$$         @(trained_model)svmpredict(inner_testing_labels, inner_testing_features, trained_model, '-q'), ...
% $$$         inner_models, 'UniformOutput', false...
% $$$         );
        % Test:
        [inner_model_predictions, inner_model_accuracies, inner_model_weights] = arrayfun(...
          @(trained_model)svmpredict(inner_testing_labels, inner_testing_features, trained_model), ...
          inner_models, 'UniformOutput', false...
          );
        %inner_model_accuracies
        %inner_model_accuracies = cell2mat(inner_model_accuracies)
        %[inner_best_accuracy, inner_best_options_index] =
        %max(inner_model_accuracies(:))
        % Evaluate:
% $$$       % Not class-wise, but that involves NaNs maybe?:
% $$$       inner_model_accuracies = cellfun(...
% $$$         @(predictions, ground_truth)sum(predictions == ground_truth) / length(ground_truth), inner_model_predictions...
% $$$         )
        % Still not class-wise:
        inner_model_accuracies = cellfun(...
          @(accuracies)accuracies(1), inner_model_accuracies...
          );
        %whos inner_model_accuracies_sums inner_model_accuracies
        inner_model_accuracies_sums = inner_model_accuracies_sums + inner_model_accuracies; 
      end
      inner_model_accuracies_means = inner_model_accuracies_sums ./ number_splits; 
      [inner_best_accuracy, inner_best_options_index] = max(inner_model_accuracies_means(:))
      inner_best_penalty = penalties(inner_best_options_index)
      inner_best_parameter = parameters(inner_best_options_index)
      %error('Implementation yet unfinished below this line!')

      % Standardize:
      % Use the best features and options to build a classifier for
      % all of the training data:
      [outer_training_features, outer_testing_features, outer_training_mean, outer_training_standard_deviation] = ...
          standardizeFeatures(outer_training_features, outer_testing_features); 
      % Select:
      outer_feature_indices = find(feature_selection_counts > 0);
      whos outer_feature_indices
      outer_training_features = outer_training_features(:, outer_feature_indices); 
      % Train:
      outer_model = svmtrain(outer_training_labels, outer_training_features, options_grid{inner_best_options_index}); 
      % Test:
      [outer_model_predictions, outer_model_accuracies, outer_model_weights] = ...
          svmpredict(outer_testing_labels, outer_testing_features, outer_model);
      [probabilistic_outer_model_predictions, probabilistic_outer_model_accuracies, outer_model_weights] = ...
          svmpredict(outer_testing_labels, outer_testing_features, outer_model, '-b 1');
      % Evaluate:
      % Still not class-wise:
      outer_model_accuracies = outer_model_accuracies(1)

      save(final_name, 'number_splits', 'save_filename', 'feature_selection_method'...
           , 'outer_index', 'inner_model_accuracies_means', 'feature_selection_counts'...
           , 'outer_model', 'outer_model_predictions', 'outer_model_accuracies', 'outer_model_weights'...
           , 'outer_model_accuracies', 'probabilistic_outer_model_predictions', 'probabilistic_outer_model_accuracies')
      chunk_finish('.', outer_filename);
      completed_splits(outer_index)=true; 
    end
    
    if all(completed_splits)
      accuracies = arrayfun(...
        @(outer_index)load([save_filename, num2str(outer_index, '_outer%d')], 'outer_model_accuracies'), ...
        1:number_splits);
      %accuracies = cell2mat({accuracies.outer_model_accuracies}');
      accuracies = cell2mat({accuracies.outer_model_accuracies}') * 1e-2;
      mean_testing_accuracy = mean(accuracies)
      standard_deviation_testing_accuracy = std(accuracies)
      % Kohavi 1995, "A Study of Cross-Validation and Bootstrap for Accuracy Estimation and Model Selection:"
      %variance_testing_accuracy = mean_testing_accuracy * 1e-2 * (1. - mean_testing_accuracy * 1e-2) ./ number_data
      %variance_testing_accuracy = mean_testing_accuracy * (1. - mean_testing_accuracy * 1e-2) ./ number_data
      kohavi_variance_testing_accuracy = mean_testing_accuracy * (1. - mean_testing_accuracy) ./ number_data
      kohavi_standard_deviation_testing_accuracy = sqrt(kohavi_variance_testing_accuracy)
      gamma = .95
      z = norminv((1. + gamma) * .5, 0, 1);
      kohavi_gamma_confidence_interval = (...
        2 * number_data * mean_testing_accuracy + z^2 + ([-1, 1] .* z .* sqrt(...
          4 * number_data * mean_testing_accuracy + z^2 - 4 * number_data * mean_testing_accuracy^2 ...
          ))) ./ (2 * (number_data + z^2))

      predictions = arrayfun(...
        @(outer_index)load([save_filename, num2str(outer_index, '_outer%d')], 'outer_model_predictions'), ...
        1:number_splits);
      %predictions
      %size(predictions(1).outer_model_predictions)
      predictions = cell2mat({predictions.outer_model_predictions}');
      weights = arrayfun(...
        @(outer_index)load([save_filename, num2str(outer_index, '_outer%d')], 'outer_model_weights'), ...
        1:number_splits);
      %weights
      weights = cell2mat({weights.outer_model_weights}');
      true_labels = arrayfun(...
        @(outer_index)complete_labels(outer_testing_indices{outer_index}, :), ...
        1:number_splits ...
        , 'UniformOutput', false);
      true_labels = cell2mat(true_labels');
      
      [confusion_matrix, accuracy, weighted_confusion_matrix, weighted_accuracy] = ...
          conmatrix(true_labels, predictions)

    end
    
  end

end
  