function localimgpath = getSingleCell_all(posfeats,posnames,localimgpath,maskpath,outname,chnames)
%This function grabs the image corresponding to a protein of interest
%
%
%Written by: Devin P Sullivan

%To generate the poi I did
%>>scatter(keepfeats(:,1),keepfeats(:,3))
%>>selectdata
%I then selected the points that were outliers in keepfeats(:,3).

if ~isdir(outname)
    mkdir(outname)
end

ulxind = strcmpi(posnames,'position_stats:BoundingBox_ulx');
ulyind = strcmpi(posnames,'position_stats:BoundingBox_uly');
wxind = strcmpi(posnames,'position_stats:BoundingBox_wx');
wyind = strcmpi(posnames,'position_stats:BoundingBox_wy');
cxind = strcmpi(posnames,'position_stats:Centroid_x');
cyind = strcmpi(posnames,'position_stats:Centroid_y');




% find the images that are of interest
% images_to_get = imagelist(poi)';
% pos_poi = posfeats(poi,:);

%Get the center of each cell of interest based on position stats in terms
%of linear indexing
cxtmp = posfeats(:,cxind);
cytmp = posfeats(:,cyind);

if ~iscell(localimgpath)
    localimglist = {localimgpath};
end

%get the file parts
[folder,filename,ext] = cellfun(@fileparts,localimglist,'UniformOutput',false);


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

% for i = 1:size(posfeats,1)
%remove the suffix from the current file name
%     nameparts = strsplit(filename{i},'_');
%     currfilename = strjoin(nameparts(1:end-1),'_');

if ~isempty(chnames.greensuffix)
    origgreen =  double(imread([localimgpath,chnames.greensuffix]));
end
%     orignuc =  double(imread([localimgpath,filesep,currfilename,'_',nucsuffix,'.tif']));

%get the mask and remove surrounding cells
if ~isempty(chnames.masksuffix)
    if exist('maskpath','var')
        origmask = imread([maskpath,chnames.masksuffix]);
    else
        origmask = imread([localimgpath,chnames.masksuffix]);
    end
else
    try
        origmask = imread([localimgpath,chnames.bluesuffix]);
    catch
        warning('Mask path not found. Taking the whole image')
        origmask = ones(size(origgreen));
    end
end


%separate the cells in the mask
segcells = bwconncomp(origmask,4);

%Create the tricolored image
if ~isempty(chnames.bluesuffix)
    origblue =  double(imread([localimgpath,chnames.bluesuffix]));
else
    origblue = zeros(size(origmask));
end

if ~isempty(chnames.redsuffix)
    origred =  double(imread([localimgpath,chnames.redsuffix]));
else
    origred = zeros(size(origmask));
end

if isfield(chnames,'deepredsuffix') && ~isempty(chnames.deepredsuffix)
    origred =  origred+double(imread([localimgpath,chnames.deepredsuffix]));
end

%create a tri-colored image for the original
tricolorimg = zeros(size(origgreen,1),size(origgreen,2),3);
tricolorimg(:,:,1) = origred./max(origred(:));
tricolorimg(:,:,2) = origgreen./max(origgreen(:));
tricolorimg(:,:,3) = origblue./max(origblue(:));


%     imshow(tricolorimg,[])


for i = 1:size(posfeats,1)
    %find the cell we want
    indcent = sub2ind(size(origmask),ceil(cytmp(i)),ceil(cxtmp(i)));
    cellind = cellfun(@(x)sum(find(x==indcent))>0,segcells.PixelIdxList)
%     cellmask = zeros(size(origmask));
%     cellmask(segcells.PixelIdxList{cellind}) = 1;
    %make it tri-colored also
%     cellmask = repmat(cellmask,1,1,3);
    
    
    %mask the tricolored image for our current cell
    cellcolorimg = tricolorimg;%.*cellmask;
    
    
    %get the current bounding box to show
    currulx = posfeats(i,ulxind);
    curruly = posfeats(i,ulyind);
    currwx = posfeats(i,wxind);
    currwy = posfeats(i,wyind);
    
    %     cellofinterest = tricolorimg(currulx:currulx+currwx,curruly:curruly+currwy,:);
    endy = min(ceil(curruly+currwy),size(tricolorimg,1));
    endx = min(ceil(currulx+currwx),size(tricolorimg,2));
    cellofinterest = cellcolorimg(ceil(curruly):endy,ceil(currulx):endx,:);
    
    imwrite(cellofinterest,[outname,num2str(i),'_wmask.tif'])
    save([outname,num2str(i),'_cellfile.mat'])
    
    
    %cut out cell of interest
    %     coi_color = tricolorimg(
    
    
end


