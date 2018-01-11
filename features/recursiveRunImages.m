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

inpath = submitstruct.indir;

extensions_default = {'blue','green','red','yellow'};
%extensions_default = {'C01','C00','C03','C02'};
%     extension_dapi  = extensions{1};%e.g. 'blue.tif'
%     extension_ab    = extensions{2};%e.g. 'green.tif'
%     extension_mtub  = extensions{3};%e.g. 'red.tif'
%     extension_er    = extensions{4};%e.g. 'yellow.tif'

segchannels_default = {'mt','er'};
submitstruct = ml_initparam(submitstruct,struct('indir',pwd,'outdir',pwd,'resolution',0.08,'color',[],'extensions',{extensions_default},'pattern','','mstype','confocal','seg_channels',{segchannels_default}));

listdirs = ml_ls(inpath);

%first check if any of the files found are the images we are looking for
imgslist = listdirs(~cellfun(@isempty,strfind(listdirs,imgtype)))
numimgs = length(imgslist)
imgslist = imgslist(~cellfun(@isempty,strfind(imgslist,submitstruct.extensions{2})));
numimgs_ext = length(imgslist)

%for all the images we have in this level
for i = 1:length(imgslist)
    currinpath = [inpath,filesep,imgslist{i}(1:end-length(imgtype))];
    imgfilebase = currinpath(1:end-length(submitstruct.extensions{2}));
    %double check that all the requested channels are present.
    allthere = 1;
    for j = 1:length(submitstruct.extensions)
        currextfile = [imgfilebase,submitstruct.extensions{j},imgtype];
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
    extensions = strcat(submitstruct.extensions,imgtype);
    %submit a job
    tstart = tic;
    [~,exit_code] = process_img(submitstruct.indir,submitstruct.outdir,submitstruct.resolution,submitstruct.color,extensions,submitstruct.pattern,submitstruct.mstype,submitstruct.seg_channels,[],1);
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
