function [protfieldstruct,nucfieldstruct,tubfieldstruct,erfieldstruct] = maskAllChannels(protfieldstruct,nucfieldstruct,tubfieldstruct,erfieldstruct,maskfieldstruct)
%
%This function modifies the structures for each channel in the HPA
%production pipelin by reading in the original image and making sub-images
%for each cell segmented using the segmentation code.
%
%This script was turned into a function to track the variables and what is
%happening since no documentation was provided in the original script
%
%INPUTS: 
%protfieldstruct,nucfieldstruct,tubfieldstruct,erfieldstruct,
%maskfieldstruct - structs containing fields of a standard object for HPA
%production (see below this header)
%
%OUTPUTS: 
%protfieldstruct,nucfieldstruct,tubfieldstruct,erfieldstruct - standard
%structs with the following fields updated if they were blank previously
%using the image stored in the location examplestruct.channel_path
%examplestruct.channel - raw image for that channel
%examplestruct.channel_regions - cell array of images for cells segmented
%from the image
%examplestruct.isempty - binary flag that tells if the image in channel is
% <0.1% non-zero pixels.
%
%
%Created by: Unknown
%
%Edited by: 
%Devin P Sullivan 28,07,2015 - created function and added documentation
%Devin P Sullivan 28,07,2015 - added isempty check for each channel
%Devin P Sullivan 05,08,2015 - added blank_channel check 

%This is very inefficient code and could be a single function called 4
%times, but for the sake of not changing production code I will leave it
%for now - DPS 28,07,2015

%%%Standard fields for the struct objects 
% cleanobject.channel_path = [];
% cleanobject.channel = [];
% cleanobject.channel_mcp = [];
% cleanobject.channel_filtered = [];
% cleanobject.channel_thr = [];
% cleanobject.channel_mthr = [];
% cleanobject.channel_fg = [];
% cleanobject.channel_regions = [];
% cleanobject.channel_objectsizes = [];
% cleanobject.downsampled2x = [];
% cleanobject.downsampled2x_filtered = [];
% cleanobject.downsampled2x_thr = [];
% cleanobject.downsampled2x_mthr = [];
% cleanobject.downsampled2x_fg = [];
% cleanobject.downsampled2x_objectsizes = [];
% cleanobject.downsampled4x = [];
% %DPS - 28,07,2015 Adding field to track if the channel is empty for when we
% %are reading it in (see maskAllChannels.m)
% cleanobject.isempty = [];
%%%

%parameters: 
%This is quantile value for checking if an image has fluorescence in it. 
%It is quite low and probably could be higher
quant_thresh = 0.999;

%%%
%First check that the images have not yet been loaded into the channel
%field
%DPS 05,08,2015 - Check if the channel is slated to be empty. If so, no
%need to try to load it into the channel field

%DPS 05,08,2015 - Moved this to first because there should always at least
%be a mask image and it will give the size for other blank images.
% if isempty(maskfieldstruct.channel)
if isempty(maskfieldstruct.channel) && ~maskfieldstruct.isempty
    maskfieldstruct.channel = imread(maskfieldstruct.channel_path);
end

% if isempty(protfieldstruct.channel) 
if isempty(protfieldstruct.channel) && ~protfieldstruct.isempty
    disp(['Protein field structure path is: ',protfieldstruct.channel_path]);
    protfieldstruct.channel = imread(protfieldstruct.channel_path);
elseif protfieldstruct.isempty
    warning('You are using a blank "protein" channel! Are you sure you want to do this?')
    protfieldstruct.channel = zeros(size(maskfieldstruct.channel));
end

% if isempty(nucfieldstruct.channel)
if isempty(nucfieldstruct.channel) && ~nucfieldstruct.isempty
    nucfieldstruct.channel = imread(nucfieldstruct.channel_path);
elseif nucfieldstruct.isempty
    nucfieldstruct.channel = zeros(size(maskfieldstruct.channel));
end

% if isempty(tubfieldstruct.channel)
if isempty(tubfieldstruct.channel) && ~tubfieldstruct.isempty
    tubfieldstruct.channel = imread(tubfieldstruct.channel_path);
elseif tubfieldstruct.isempty
    tubfieldstruct.channel = zeros(size(maskfieldstruct.channel));
end

% if isempty(erfieldstruct.channel)
if isempty(erfieldstruct.channel) && ~erfieldstruct.isempty
    erfieldstruct.channel = imread(erfieldstruct.channel_path);
elseif erfieldstruct.isempty
    erfieldstruct.channel = zeros(size(maskfieldstruct.channel));
end

% % if isempty(maskfieldstruct.channel)
% if isempty(maskfieldstruct.channel) && ~maskfieldstruct.isempty
%     maskfieldstruct.channel = imread(maskfieldstruct.channel_path);
% end
%%%

%%%DPS 28,07,2015 - check if the channel is empty (or mostly empty)
protfieldstruct.isempty = protfieldstruct.isempty+checkIsEmpty(protfieldstruct.channel,quant_thresh);
if protfieldstruct.isempty
    warning('Protein image appears to be empty!')
end
nucfieldstruct.isempty = nucfieldstruct.isempty+checkIsEmpty(nucfieldstruct.channel,quant_thresh);
if nucfieldstruct.isempty
    warning('Nucleus image appears to be empty!')
end
tubfieldstruct.isempty = tubfieldstruct.isempty+checkIsEmpty(tubfieldstruct.channel,quant_thresh);
if tubfieldstruct.isempty
    warning('Tubulin image appears to be empty!')
end
erfieldstruct.isempty = erfieldstruct.isempty+checkIsEmpty(erfieldstruct.channel,quant_thresh);
if erfieldstruct.isempty
    warning('ER image appears to be empty!')
end

%%%
%Then check that the image hasn't already been split into regions using the
%segmentation. 
tmp_indexer = zeros(4,1);
if isempty( protfieldstruct.channel_regions)
    tmp_indexer(1) = 1;
end
if isempty( nucfieldstruct.channel_regions)
    tmp_indexer(2) = 1;
end
if isempty( tubfieldstruct.channel_regions)
    tmp_indexer(3) = 1;
end
if isempty( erfieldstruct.channel_regions)
    tmp_indexer(4) = 1;
end
%%%

%%%
%If there are some that haven't been done yet, do them.
if sum(tmp_indexer==0)~=length(tmp_indexer)
    bwtmp = maskfieldstruct.channel==max(maskfieldstruct.channel(:));
    %bw2 never appears to be used, commenting it out. - DPS 05,08,2015
%     bw2 = imopen(bwtmp,ones(11,11));
    
    %DPS 05,08,2015 - For voronoi segmentation, because the borders can
    %have sharp angles there may be hanging pixels at cell junctions that
    %are not considered "connected". (this should never happen in watershed
    %segmentation). To eliminate these hanging pixels we filter for groups
    %of pixels bigger than min_cell_size.
    %This is hardcoded because it's a very conservative number only meant
    %to remove hanging pixels not estimate cell size. If a cell is smaller
    %than 5 pixels at any resolution, it is likely that you could not
    %segment a nucleus inside it as is our practice.
    min_cell_size = 5;%pixels
    bw3 = bwareaopen(bwtmp,min_cell_size);
    
%     bwl = bwlabel(bwtmp,4);
    bwl = bwlabel(bw3,4);
    s = size(maskfieldstruct.channel);
    ma = max(bwl(:));

    for tmp_i=1:ma
        %imagesc(bwl==tmp_i); title(num2str([ma, tmp_i], 'total %d, index %d'));pause;
        [r c] = find(bwl==tmp_i);
        minr = min(r);  maxr = max(r);  minc = min(c);  maxc = max(c);
        newIm = uint8(zeros(maxr-minr+1,maxc-minc+1));
        idx = (c-1)*s(1)+r;
        idx2 = (c-min(c))*(max(r)-minr+1)+r-min(r)+1;

        if tmp_indexer(1)
            newIm(idx2) = protfieldstruct.channel(idx);
            protfieldstruct.channel_regions{tmp_i} = newIm;
        end
    
        if tmp_indexer(2)
            newIm(idx2) = nucfieldstruct.channel(idx);
            nucfieldstruct.channel_regions{tmp_i} = newIm;
        end

        if tmp_indexer(3)
            newIm(idx2) = tubfieldstruct.channel(idx);
            tubfieldstruct.channel_regions{tmp_i} = newIm;
        end
    
        if tmp_indexer(4)
            newIm(idx2) = erfieldstruct.channel(idx);
            erfieldstruct.channel_regions{tmp_i} = newIm;
        end
        
        if size(newIm,1)<10
            something_is_wrong = 1
        end
        
    end
end
