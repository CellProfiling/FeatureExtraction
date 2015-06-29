function [] = compute_region_features()

  %addpath(genpath('/home/jieyuel/share/HPA_lib/HPA_lib'));
  addpath(genpath('./HPA_lib'));
  warning('off', 'MATLAB:MKDIR:DirectoryExists');
  warning('off', 'Images:imfeature:obsoleteFunction');

  filename = mfilename;
  mkdir(filename)
  n = getenv('PBS_JOBID');
  n = regexprep(n, '[\r\n]', '');
  date_text = datestr(now(), 'yyyymmddHHMMSSFFF')
  diary([filename '/' 'log' date_text ...
         '_' n '.txt']);

  image_path = '/share/images/HPA/images/IFconfocal_CellCycle/CELL_CYCLE_ANNOTATED_IMAGES'
  %  'SPhaseDapiOnlyTraining' ...
  % MPhase empty 2011-11-10 00:54
  %  'MPhaseCyclinB1Training' ...
  class_subdirectories = { ...
    'G1PhaseCyclinB1Training' ...
    'G2PhaseCyclinB1Training' ...
    'SPhaseCyclinB1Training' ...
    }
  processed_path = './processed_data'
  mkdir(processed_path)
  for index = 1:length(class_subdirectories)
    image_subdirectory = [image_path, filesep, class_subdirectories{index}, filesep]
    processed_subdirectory = [processed_path, filesep, class_subdirectories{index}, filesep]
    mkdir(processed_subdirectory)
    segmentFields(...
      image_subdirectory, ...
      processed_subdirectory, ...
      'IFconfocal_CellCycle');
% $$$     calcRegionFeat(processed_subdirectory); 
    calcRegionFeat(image_subdirectory, processed_subdirectory, processed_subdirectory, 'IFconfocal_CellCycle'); 
  
    % Without cyclin:
    calcRegionFeat(image_subdirectory, processed_subdirectory, processed_subdirectory, 'IFconfocal_CellCycle', 'nuclear'); 
  
    % My nuclear features:
    calcRegionFeat(image_subdirectory, processed_subdirectory, processed_subdirectory, 'IFconfocal_CellCycle', 'protein', {'nucStats'}); 
  
    % My protein intensity feature:
    calcRegionFeat(image_subdirectory, processed_subdirectory, processed_subdirectory, 'IFconfocal_CellCycle', 'protein', {'protTotalIntensity'}); 
  end
  
  
