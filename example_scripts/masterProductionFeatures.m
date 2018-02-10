function masterProductionFeatures(infolder,outfolder)
%This function loops through a production image and extracts features
%
%Written by: Devin P Sullivan 05,08,2015

%Updated by:
%First. Middle. Last day,month,year - update
%D. P. Sullivan 08,02,2018 - created paired extension and segmentation
%structure to allow for flexible combinations of channels to be used in
%segmentation. In cases where multiple channels are used in one
%segmentation, those channels will be added together. 
%
%%%

%Channel index for production
%green - HPA antibody
%blue - DAPI
%yellow - ER
%red - tubule marker

%%%DEFINE PARAMETERS%%%

% PRODUCTION
% green: Protein of interest (Antibody)
% blue: Dapi
% yellow: ER
% red: Microtubules
%Define each channel suffix, segmentation pair. Each should be a string indicating the
%channel acquired on the microscope. 
%If any channel is not present in this experiment enter ''. -- this should
%be automatically handled now DPS 08,02,2018
%the structure of this is 
%{'name_substring',seg_value}
%name_substring - substring in file name specifying that channel
%seg_value - numeric indicator of how to use channel in segmentation
%            can take 3 values:
%0 - do not use this channel in segmentation
%1 - use this channel for nuclear segmentation
%2 - use this channel for cell segmentation
%if not specified, the channel will not be used for segmentation
%If voronoi cell segmentation is desired, do not declare any seg_value=2
%create channels object
%Must specify at least 1 nuclear segmentation segmentation channel!
numchannels = 4;
channels = cell(numchannels,2); 
%specify reference channel(s) for nucleus 
channels(1,:) = {'_blue',1};
%specify reference channel(s) for cell shape
channels(2,:) = {'_red',2};
channels(3,:) = {'_yellow',2};
%specify protein of interest
channels(4,:) = {'_green',0};

%Another possible example using only one cell shape segmentor
%CCMarkers
% grext = {'_ch00',0};
% blueext = {'_ch01',1};
% yellowext = {'_ch03',0};
% redext = {'_ch02',2};

%Define the parent directory where your images are located. This should be
%a string.
%default: THIS IS REQUIRED. THERE IS NO DEFAULT FOR THIS VARIABLE
%infolder = '/Users/devinsullivan/Documents/CellCycle/markers_cc_21_01/';
%infolder = '/proj/snic2015-6-49/cyclinImages/TRAINING/INPUT_IMAGES/';
if nargin<1
    infolder = '/server/plate/plate_well*';%%%THIS IS AN EXAMPLE
end

%Define where to put the results from this analysis. This should be a
%string. It is a good idea to add the date so that we see when it was
%created and can trace the version of the repo etc. 
%default: pwd
%outfolder = ['/Users/devinsullivan/Documents/CellCycle/markersfeatures_out',strrep(date,'-','')];
%outfolder = ['/proj/snic2015-6-49/cellcycle_recalc/features_out',strrep(date,'-','')];
%outfolder = ['/Users/devinsullivan/Documents/siRNA/features_out','18Dec2015'];
if nargin<2 || isempty(outfolder)
    outfolder = '/server/plate/';
end

%Define the resolution of the images in um/pixel. This information is used
%when performing segmentation to determine the expected size of a cell in
%microns. This should be a double.
%default: THIS IS REQUIRED. THERE IS NO DEFAULT FOR THIS VARIABLE
% resolution = 0.65;%our 10x 
resolution = 0.08;%our 63x

%Define the patterns for the subfolders you wish to look for images in.
%This should be a cell array of strings. Each string is a substring at the
%level of the folder(s) you wish to comput on. If the recursion goes deeper
%than the specified set of patterns, all folders will be checked. If you
%simply wish to check all folders, simply enter an empty array as such: {}
%default: {}
% dirpatterns = {'subfolder','experiment','slide'};
dirpatterns = {};

%Define the substring in each image you wish to check. This can help weed
%out thumbnails, but generally isn't necessary. If not necessary, leave as
%an empty string.
%default: ''
imgpattern = '';

%Define the microscope type the image was taken on. This is a string that
%may take the values 'confocal' or 'widefield'. For all production images
%'confocal' is appropriate. This is used to determine how much blurring
%should be used. 
%default: 'confocal'
mstype = 'confocal';%this is the default and should be used for production

%Define the type of image we are looking for. This should be a string.
%default: '.tif'.
%ml_readimage should now support .gz files as well. DPS 05,08,2018
imgtype = '.tif';%this is the default and should be used for production
%%%

%%%Set up the submissionstruct%%%
submitstruct.indir = infolder;
submitstruct.outdir = outfolder;
submitstruct.resolution = resolution;
submitstruct.pattern = imgpattern;
submitstruct.mstype = mstype;
submitstruct.channels = channels;
% submitstruct.color = color; -- depricated parameter
% submitstruct.extensions = extensions; -- now encorperated into 'channels'
% submitstruct.seg_channels = seg_channels; -- now encorperated into 'channels'
%%%

%%%Find and run the images in the specified path%%%
recursiveRunImages(submitstruct,dirpatterns,imgtype)

