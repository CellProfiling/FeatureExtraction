function masterProductionFeatures(infolder,outfolder)
%This function loops through a production image and extracts features
%
%Written by: Devin P Sullivan 05,08,2015

%Channel index for production
%green - HPA antibody
%blue - DAPI
%yellow - ER
%red - tubule marker

%%%DEFINE PARAMETERS%%%

%define extensions for siRNA images
%Define each channel suffix. Each should be a string indicating the color
%channel acquired on the microscope. If any channel is not present in this
%experiment enter ''.
% green: Protein of interest (Antibody)
% blue: Dapi
% yellow: ER
% PRODUCTION
% red: Microtubules
grext = '_green';
blueext = '_blue';
yellowext = '_yellow';
redext = '_red';
%CCMarkers
% grext = '_ch00';
% blueext = '_ch01';
% yellowext = '_ch03';
% redext = '_ch02';


%the final 'extensions' matrix is compiled in the order process_img.m is
%expecting the channels. 
extensions = {blueext,grext,redext,yellowext};

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
    outfolder = ['/server/plate/'];
end


%The 'color' variable is an outdated variable included in process_img.m. It
%should be left blank unless you are sure you need it and know what it does.
%default: []
color = [];

%Define the resolution of the images in um/pixel. This information is used
%when performing segmentation to determine the expected size of a cell in
%microns. This should be a double.
%default: THIS IS REQUIRED. THERE IS NO DEFAULT FOR THIS VARIABLE
% resolution = 0.65;%10x I guess, I thought it would be 40x
resolution = 0.08;

%Define which channels you wish to use for segmentation. This is a cell
%array of either 'mt' and/or 'er'. If voronoi segmentation is desired,
%leave this as an empty cell array as such: {}. If you don't know what this
%is doing, don't change it.
%defalut: {'er','mt'}
seg_channels = {'er','mt'};%this is the default and should be used for production
% seg_channels = {'mt'};%this is the value used for CC markers

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
imgtype = '.tif';%this is the default and should be used for production
%%%

%%%Set up the submissionstruct%%%
submitstruct.indir = infolder;
submitstruct.outdir = outfolder;
submitstruct.resolution = resolution;
submitstruct.color = color;
submitstruct.extensions = extensions;
submitstruct.pattern = imgpattern;
submitstruct.mstype = mstype;
submitstruct.seg_channels = seg_channels;
%%%

%%%Find and run the images in the specified path%%%
recursiveRunImages(submitstruct,dirpatterns,imgtype)

