function [featmat,expnames] = siRNA_basicwrapper(inpath,featnamepath,featfilename)
%This function builds a feature matrix using recursive_buildFeaturemat.m
%then splits the features into desired units and appends the experiment
%names as indices.
%
%INPUTS:
%inpath - string containing the path to your master folder that
%contains the feature files.
%featnamepath - string pointing to a matfile containing the feature names
%in these experiments
%featfilename - string specifying what the name of the file we are looking
%for is. Here we expect a .csv file as outputed by the feature extraction.
%The default is 'features.csv'
%
%
%OUTPUTS:
%featmat - a single feature matrix with an index list per-experiment in the
%first column
%
%Written by: Devin P Sullivan January 13, 2016

if nargin<2
    [featnamepath] = findFeatNameFile(inpath);
end

if nargin<3
    featfilename = 'features.csv';
end

%%%PARAMETER BLOCK%%%
%%%define parameters%%%
%output directory path
outputdir = './siRNAoutput';
%leading name for featuresets
fnames = {...
    'experimentIndex',...
    'position_stats:',...
    'feature_set1:',...
    'feature_set2:',...
    'feature_set3:',...
    'feature_set4:',...
    'feature_set5:',...
    'feature_set6:',...
    };
%what each feature set actually means
fsets = {...
    'experimentIndex'...
    ;'position_stats'...
    ; '/nucStats'...
    ; '/nucStats_prot-as-nuc'...
    ; '/nucStats_tub-as-nuc'...
    ; '/intensity_wholecell'...
    ; '/intensity_nuc'...
    ; '/intensity_cyto'};

masteroutname = [outputdir,filesep,'master_features.mat'];

%%%MAKE FEATURE MATRIX%%%
if ~exist(masteroutname,'file')
    
    %make the place to store things
    if ~isdir(outputdir)
        mkdir(outputdir)
    end
    
    %run the recursive script to build the feature matrix and the experiment
    %names
    [featmat,expnames] = recursive_buildFeaturemat(inpath,featfilename);
    
    %load the feature names
    load(featnamepath)
    
    %make the number codes and append them for each experiment
    uexp = unique(expnames);
    expnum = zeros(size(expnames,1),1);
    for i = 1:numel(uexp)
        expnum(strcmpi(expnames,uexp{i})) = i;
        
    end
    
    featmat_wind = [expnum,featmat];
    feature_names = [{'experimentIndex'},feature_names];
    
    %save our results
    save(masteroutname,'featmat_wind','feature_names','expnum');
    
    splitFeatSets(featmat_wind,feature_names,outputdir,fsets)
else
    load(masteroutname)
end

%Make a matrix exactly like old results and save as a csv
%
%intensity values followed by position values
%old feature names
fnames_old = {'fov_no',...
    'green_av_nuc','green_av_cyto','green_av_cell',...
    'yellow_av_nuc','yellow_av_cyto','yellow_av_cell',...
    'red_av_nuc','red_av_cyto','red_av_cell',...
    'green_int_nuc','green_int_cyto','green_int_cell',...
    'yellow_int_nuc','yellow_int_cyto','yellow_int_cell',...
    'red_int_nuc','red_int_cyto','red_int_cell',...
    'obj_center_x','obj_center_y','obj_upperleft_x','obj_upperleft_y','width_x','width_y'};

%First load the different intensity features
int_whole = load([outputdir,filesep,fnames{6}(1:end-1),'_splitfeats.mat']);
int_nuc = load([outputdir,filesep,fnames{7}(1:end-1),'_splitfeats.mat']);
int_cyto = load([outputdir,filesep,fnames{8}(1:end-1),'_splitfeats.mat']);

%now find the correct features for the respective channels
channels = {'green','yellow','red'};
which_metric = {'av','total'};
featmat_av = zeros(size(int_whole.features,1),9);
featmat_int = zeros(size(int_whole.features,1),9);
for i = 1:numel(channels)
    currchannel = ~cellfun(@isempty,strfind(int_whole.featnames,channels{i}));
    avmetric = ~cellfun(@isempty,strfind(int_whole.featnames,which_metric{1}));
    
    startind = ((i-1)*3)+1;
    
    %Note: '&' is the symbol for logical multiplication
    featmat_av(:,startind:startind+2) =  [...
        int_nuc.features(:,currchannel&avmetric),...
        int_cyto.features(:,currchannel&avmetric),...
        int_whole.features(:,currchannel&avmetric)];
    
    
    featmat_int(:,startind:startind+2) =  [...
        int_nuc.features(:,currchannel&(~avmetric)),...
        int_cyto.features(:,currchannel&(~avmetric)),...
        int_whole.features(:,currchannel&(~avmetric))];
end

pos_stats = load([outputdir,filesep,fnames{2}(1:end-1),'_splitfeats.mat']);
featmat_old = [expnum,featmat_av,featmat_int,pos_stats.features(:,2:end)];

output_old = [outputdir,filesep,'siRNA_out.mat'];
save(output_old,'featmat_old','fnames_old');


