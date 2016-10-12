function [protfieldstruct,nucfieldstruct,tubfieldstruct,erfieldstruct,maskfieldstruct] = maskAllChannels(protfieldstruct,nucfieldstruct,tubfieldstruct,erfieldstruct,maskfieldstruct)
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
    protfieldstruct.channel = removergb(imread(protfieldstruct.channel_path));
elseif protfieldstruct.isempty
    warning('You are using a blank "protein" channel! Are you sure you want to do this?')
    protfieldstruct.channel = zeros(size(maskfieldstruct.channel));
end

% if isempty(nucfieldstruct.channel)
if isempty(nucfieldstruct.channel) && ~nucfieldstruct.isempty
    nucfieldstruct.channel = removergb(imread(nucfieldstruct.channel_path));
elseif nucfieldstruct.isempty
    nucfieldstruct.channel = zeros(size(maskfieldstruct.channel));
end

% if isempty(tubfieldstruct.channel)
if isempty(tubfieldstruct.channel) && ~tubfieldstruct.isempty
    tubfieldstruct.channel = removergb(imread(tubfieldstruct.channel_path));
elseif tubfieldstruct.isempty
    tubfieldstruct.channel = zeros(size(maskfieldstruct.channel));
end

% if isempty(erfieldstruct.channel)
if isempty(erfieldstruct.channel) && ~erfieldstruct.isempty
    erfieldstruct.channel = removergb(imread(erfieldstruct.channel_path));
elseif erfieldstruct.isempty
    erfieldstruct.channel = zeros(size(maskfieldstruct.channel));
end


%DPS 17,08,2015 - Need to add support for other datatypes. Specifically,
%uint16 images are getting assigned to uint8 without conversion leading to
%very saturated images. 
%No longer convert the mask to uint8 here because it is a labeled image and
%we want to have up to 65,000 cells in the image.
% maskfieldstruct.channel = convert_to_uint8(maskfieldstruct.channel);
maskfieldstruct.channel = double(maskfieldstruct.channel);
protfieldstruct.channel = convert_to_uint8(protfieldstruct.channel);
nucfieldstruct.channel = convert_to_uint8(nucfieldstruct.channel);
tubfieldstruct.channel = convert_to_uint8(tubfieldstruct.channel);
erfieldstruct.channel = convert_to_uint8(erfieldstruct.channel);


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
%     bwtmp = maskfieldstruct.channel==max(maskfieldstruct.channel(:));
    %bw2 never appears to be used, commenting it out. - DPS 05,08,2015
%     bw2 = imopen(bwtmp,ones(11,11));
    
%DPS 2015,10,22 - This is now done in the segmentation to avoid destroying
%signal. 
%     %DPS 05,08,2015 - For voronoi segmentation, because the borders can
%     %have sharp angles there may be hanging pixels at cell junctions that
%     %are not considered "connected". (this should never happen in watershed
%     %segmentation). To eliminate these hanging pixels we filter for groups
%     %of pixels bigger than min_cell_size.
%     %This is hardcoded because it's a very conservative number only meant
%     %to remove hanging pixels not estimate cell size. If a cell is smaller
%     %than 5 pixels at any resolution, it is likely that you could not
%     %segment a nucleus inside it as is our practice.
%     min_cell_size = 5;%microns
%     bw3 = bwareaopen(bwtmp,min_cell_size);
    
    %The labeling is now done in segmentation to ensure that all channels
    %have matching labels (cell to nucleus for example)
%     bwl = bwlabel(bwtmp,4);
%     bwl = bwlabel(bw3,4);
    bwl = maskfieldstruct.channel;
    
    %DPS 2015,10,20 - making a hack for when we want cytoplasm to
    %ensure that we always have the same number of cells
    %See calcRegionFeat for where we add this field to the struct
    if isfield(maskfieldstruct,'channel_path_nuc')
        nucimg = imread(maskfieldstruct.channel_path_nuc);
        bwl = bwl.*double(~nucimg);
        clear nucimg
    end
    
    s = size(maskfieldstruct.channel);
    %ma = max(bwl(:));
    imgvallist = unique(bwl(:));
    small_objs = 0;
    
    %for tmp_i=1:ma
    
    for tmp_i=1:(length(imgvallist)-1)
        %imagesc(bwl==tmp_i); title(num2str([ma, tmp_i], 'total %d, index %d'));pause;
        
        %start at 2 because 1 should always be the background (0) 
        [r c] = find(bwl==imgvallist(tmp_i+1));
        
        %now we have to check if the cell actually has any cytoplasm. if
        %not, we need to keep it, but make it a 0 pixel. 
        if isempty(r)
            r = 1;
            c = 1;
        end
        
        minr = min(r);  maxr = max(r);  minc = min(c);  maxc = max(c);
        newIm = uint8(zeros(maxr-minr+1,maxc-minc+1));
        idx = (c-1)*s(1)+r;
        idx2 = (c-min(c))*(max(r)-minr+1)+r-min(r)+1;
        
        maskfieldstruct.channel_regions{tmp_i} = newIm;
        maskfieldstruct.channel_regions{tmp_i}(idx2) = 1;

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
            small_objs = 1;
        end
        
    end
    
    if small_objs==1
        warning('Very small objects detected (<10 pixels diameter). Double check this is expected.')
    end
end
