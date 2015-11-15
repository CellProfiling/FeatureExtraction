function images_to_get = getOrigCell(datapath,posfeatpath,region_feat_allpath,localimgpath,outname,chnames)
%This function grabs the image corresponding to a protein of interest
%
%
%Written by: Devin P Sullivan 

%To generate the poi I did 
%>>scatter(keepfeats(:,1),keepfeats(:,3))
%>>selectdata
%I then selected the points that were outliers in keepfeats(:,3).



if nargin<1
    datapath = '/Users/devinsullivan/Documents/CellCycle/cellcycle/regression_reboot/nuctexture_outliers.mat';
end

if nargin<2
    posfeatpath = '/Users/devinsullivan/Documents/CellCycle/cellcycle/regression_reboot/cyclinBDS4split/position_stats_splitfeats.mat';
end

if nargin<3
    region_feat_allpath = '/Users/devinsullivan/Documents/CellCycle/cyclin_analysis_fixedfeatures/Dataset4/cyclinB1/experiment1/features/regionfeatures_all.mat';
end

if nargin<4
    localimgpath = '/Users/devinsullivan/Documents/CellCycle/TRAINING/INPUT_IMAGES/DATASET4_INPUTIMAGES/experiment1/';
end

if isstruct(localimgpath)
    maskpath = localimgpath.maskpath;
    localimgpath = localimgpath.localimgpath;
end

if nargin<5
    outname = 'nuctexture_outlier';
end

%load our data with points of interest saved in a variable called 'poi'
load(datapath)
if exist('pickedpoints','var')
    poi = pickedpoints;
end

%load the list of images they come from 
load(region_feat_allpath,'imagelist')

%load the locations of everything 
posfeats = load(posfeatpath);
ulxind = strcmpi(posfeats.featnames,'position_stats:BoundingBox_ulx');
ulyind = strcmpi(posfeats.featnames,'position_stats:BoundingBox_uly');
wxind = strcmpi(posfeats.featnames,'position_stats:BoundingBox_wx');
wyind = strcmpi(posfeats.featnames,'position_stats:BoundingBox_wy');
cxind = strcmpi(posfeats.featnames,'position_stats:Centroid_x');
cyind = strcmpi(posfeats.featnames,'position_stats:Centroid_y');




% find the images that are of interest 
images_to_get = imagelist(poi)';
pos_poi = posfeats.features(poi,:);

%Get the center of each cell of interest based on position stats in terms
%of linear indexing 
cxtmp = pos_poi(:,cxind);
cytmp = pos_poi(:,cyind);


%get the file parts 
[folder,filename,ext] = cellfun(@fileparts,images_to_get,'UniformOutput',false);


%All the files should be in the folder for localimgpath
%Read the original image for the various channels 
%Default Channel index 
if nargin<6
    %ch00 - Cyclin B1
    chnames.greensuffix = 'ch00';
    %ch01 - Nucleus
    chnames.bluesuffix = 'ch01';
    %ch02 - MT
    chnames.redsuffix = 'ch02';
    chnames.masksuffix = chnames.greensuffix;
end
%ch03 - Cyclin E1, nuclear 
%cycEsuffix = 'ch03'; - we do not use this one

for i = 1:length(images_to_get)
    %remove the suffix from the current file name 
    nameparts = strsplit(filename{i},'_');
    currfilename = strjoin(nameparts(1:end-1),'_');
       
    if ~isempty(chnames.greensuffix)
        origgreen =  double(imread([localimgpath,filesep,currfilename,'_',chnames.greensuffix,'.tif']));
    end
%     orignuc =  double(imread([localimgpath,filesep,currfilename,'_',nucsuffix,'.tif']));
    
    %get the mask and remove surrounding cells
    if ~isempty(chnames.masksuffix)
        if exist('maskpath','var')
            origmask = imread([maskpath,filesep,currfilename,'_',chnames.masksuffix,'.png']);
        else
            origmask = imread([localimgpath,filesep,'_',currfilename,'_',chnames.masksuffix,'.png']);
        end
    else
        try
            origmask = imread([localimgpath,filesep,'_',currfilename,'_',chnames.bluesuffix,'.png']);
        catch 
            warning('Mask path not found. Taking the whole image')
            origmask = ones(size(origgreen));
        end
    end
    
    %separate the cells in the mask
    segcells = bwconncomp(origmask,4);
    %find the cell we want
    indcent = sub2ind(size(origmask),ceil(cytmp(i)),ceil(cxtmp(i)));
    cellind = cellfun(@(x)sum(find(x==indcent))>0,segcells.PixelIdxList)
    cellmask = zeros(size(origmask));
    cellmask(segcells.PixelIdxList{cellind}) = 1;
    %make it tri-colored also
    cellmask = repmat(cellmask,1,1,3);
    
    if ~isempty(chnames.bluesuffix)
        origblue =  double(imread([localimgpath,filesep,currfilename,'_',chnames.bluesuffix,'.tif']));
    else
        origblue = zeros(size(origmask));
    end
    
    if ~isempty(chnames.redsuffix)
        origred =  double(imread([localimgpath,filesep,currfilename,'_',chnames.redsuffix,'.tif']));
    else
        origred = zeros(size(origmask));
    end
    
    if ~isempty(chnames.deepredsuffix)
        origred =  origred+double(imread([localimgpath,filesep,currfilename,'_',chnames.deepredsuffix,'.tif']));
    end
    
    %create a tri-colored image for the original 
    tricolorimg = zeros(size(origgreen,1),size(origgreen,2),3);
    tricolorimg(:,:,1) = origred./max(origred(:));
    tricolorimg(:,:,2) = origgreen./max(origgreen(:));
    tricolorimg(:,:,3) = origblue./max(origblue(:));
    
    
%     imshow(tricolorimg,[]) 

    %mask the tricolored image for our current cell 
    tricolorimg = tricolorimg.*cellmask;
    

    %get the current bounding box to show
    currulx = pos_poi(i,ulxind);
    curruly = pos_poi(i,ulyind);
    currwx = pos_poi(i,wxind);
    currwy = pos_poi(i,wyind);
    
%     cellofinterest = tricolorimg(currulx:currulx+currwx,curruly:curruly+currwy,:);
    endy = min(ceil(curruly+currwy),size(tricolorimg,1));
    endx = min(ceil(currulx+currwx),size(tricolorimg,2));
    cellofinterest = tricolorimg(ceil(curruly):endy,ceil(currulx):endx,:);
    
    imwrite(cellofinterest,[pwd,filesep,outname,num2str(i),'_wmask.tif'])
    save([pwd,filesep,outname,num2str(i),'_cellfile.mat'])
    
    
    %cut out cell of interest
%     coi_color = tricolorimg(
    
    
end
    

