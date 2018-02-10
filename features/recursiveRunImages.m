function recursiveRunImages(submitstruct,pattern,imgtype,recursiveind)
%This function should loop through each directory it finds until it finds
%images of the specified type (default .tif) at which point it will submit
%a feature calculation job. 
%
%INPUTS: 
%inpath - a string pointing to the path we are working on
%submitstruct - the structure specifying the inputs and outputs for the job
%submission
%pattern - a string or cell array specifying what if any special substring
%   we should look for. If not provided we will assume we want to look in
%   all directories
%imgtype - a string specifying the file extension type we should be looking
%   for. If not provided this will default to '.tif'
%recursiveind - this is used to keep track of how far down we are in the
%case the pattern is a cell array. 

if nargin<1
    submitstruct = struct;
end

if nargin<3 || isempty(imgtype)
    imgtype = '.tif';
end

if nargin<2
    pattern = '';
end

if nargin<4
    recursiveind = 1;
end

%Define parameters 
nucseg_val = 1;

inpath = submitstruct.indir;

%%DPS 08,02,2018 - extensions and segchannels are now done via the 'channels' variable
channels_default = cell(4,2);
%specify reference channel(s) for nucleus 
channels_default(1,:) = {'_blue',1};
%specify reference channel(s) for cell shape
channels_default(2,:) = {'_red',2};
channels_default(3,:) = {'_yellow',2};
%specify protein of interest
channels_default(4,:) = {'_green',0};

submitstruct = ml_initparam(submitstruct,struct('indir',pwd,'outdir',pwd,'resolution',0.08,'color',[],'channels',{channels_default},'pattern','','mstype','confocal'));

listdirs = ml_ls(inpath);

%first check if any of the files found are the images we are looking for
imgslist = listdirs(~cellfun(@isempty,strfind(listdirs,imgtype)));
%%DPS 08,02,2018 - changing to paired 'channels' variable to make what
%channels are used for segmentation more flexible
try
    %look up the nuclear images since that is the one channel that is required
    %to have at least one specified for segmentation
    nucseg_inds = cell2mat(cellfun(@(x) ~isempty(x)&&x==nucseg_val,submitstruct.channels(:,2),'UniformOutput',0));
    %If more than 1 nuclear seg channel is specified, make sure we only take 1.
    %Here we arbitrarily choose the first. It doesn't matter
    first_nucseg_ind = find(nucseg_inds,1,'first');
    %create the list of images
    imgslist = imgslist(~cellfun(@isempty,strfind(imgslist,submitstruct.channels{first_nucseg_ind,1})));
catch
    error('no nuclear segmentation channel found. Nuclear channel required for running. Please see submitstruct.channels')
end
%%

%for all the images we have in this level
for i = 1:length(imgslist)
    currinpath = [inpath,filesep,imgslist{i}(1:end-length(imgtype))];
    imgfilebase = currinpath(1:end-length(submitstruct.channels{first_nucseg_ind,1}));
    %%
    %double check that all the requested channels are present.
    allthere = 1;
    for j = 1:size(submitstruct.channels,1)
        %DPS 08,02,2018 - change to use channels
        currextfile = [imgfilebase,submitstruct.channels{j,1},imgtype];
        if ~exist(currextfile)
            currextfile
            allthere = 0;
        end
    end
    if ~allthere
        disp(['Can not compute requested features for the file ', imgslist{i},', some files are missing. skipping'])
        continue
    end
    
    [parfolder,currfilename,ext] = fileparts(imgfilebase);
    finalresult = [submitstruct.outdir,filesep,currfilename,filesep,'features.csv'];
    if exist(finalresult,'file')
        disp('Already computed! skipping for now.')
        continue
    end
    
%     currinpath = [inpath,filesep,imgslist{i}];
    submitstruct.indir = imgfilebase;
    extensions = submitstruct.channels;
    extensions(:,1) = strcat(extensions(:,1),imgtype);
    %submit a job
    tstart = tic;
    [~,exit_code] = process_img(submitstruct.indir,submitstruct.outdir,submitstruct.resolution,extensions,submitstruct.pattern,submitstruct.mstype,[],1);
    telapsed = toc(tstart)
    telapsed
end

%remove anything that is not an experiment directory
if ~iscell(pattern) 
    listdirs(cellfun(@isempty,strfind(listdirs,pattern))) = [];
elseif recursiveind>length(pattern)
    warning('further into recursion than patterns provided. Taking all directories from this level down.')
    %don't eliminate any dirs from listdir
else
listdirs(cellfun(@isempty,strfind(listdirs,pattern{recursiveind}))) = [];
end

%eliminate non-dirs
listdirs(~cellfun(@isdir,strcat([inpath,filesep],listdirs))) = [];
numexperiments = length(listdirs)


%recurse for each directory
newrecursiveind = recursiveind+1;
for j = 1:numexperiments
    currinpath = [inpath,filesep,listdirs{j}]
    curroutpath = [submitstruct.outdir,filesep,listdirs{j}];
    currsubmitstruct = submitstruct;
    currsubmitstruct.indir = currinpath;
    currsubmitstruct.outdir = curroutpath;
    recursiveRunImages(currsubmitstruct,pattern,imgtype,newrecursiveind)
    
end
