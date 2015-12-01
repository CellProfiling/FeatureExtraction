function [regions, regions_nuc]= segmentation( nucim, cellim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE, microscope_type)

%Edited by:
%Devin Sullivan July 13, 2015 - added support for voronoi segmentation
%Devin P Sullivan Aug 7, 2015 - added support for partially scanned nuclear
%image.

if nargin<6 || isempty(microscope_type)
    microscope_type = 'confocal';
end

minarea = (MINNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;
maxarea = (MAXNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;

% dilation = round((MINNUCLEUSDIAMETER/IMAGEPIXELSIZE)/2)+1;

% %make sure that the nuclear channel is fully scanned. If not, trim the
% %image to the last scanned line. Note this may be verticle or horizontal
% %depending on the microscope, but generally should be horizontal.
% nucx = sum(nucim,1);
% nucy = sum(nucim,2);
% xrange = nucx>0;
% yrange = nucy>0;
% xstart = find(xrange,1,'first');
% if xstart~=1
%     warning('no nuclear fluorescence in beginning of x image. Skipping to second column with fluorescence.')
%     %here we use the 2nd column instead of the first since there was an
%     %error in acquisition and we want to be sure to eliminate the last
%     %incorrectly scanned one.
%     xstart = xstart+1;
% end
% 
% xend = find(xrange,1,'last');
% if xend~=size(nucim,2)
%     warning('no nuclear fluorescence in end of x image. Skipping to second to last column with fluorescence.')
%     %here we use the 2nd to last column instead of the first since there was an
%     %error in acquisition and we want to be sure to eliminate the last
%     %incorrectly scanned one.
%     xend = xend-1;
% 
% end
% ystart = find(yrange,1,'first');
% if ystart~=1
%     warning('no nuclear fluorescence in beginning of y image. Skipping to second column with fluorescence.')
%     %here we use the 2nd column instead of the first since there was an
%     %error in acquisition and we want to be sure to eliminate the last
%     %incorrectly scanned one.
%     ystart = ystart+1;
% end
% 
% yend = find(yrange,1,'last');
% if yend~=size(nucim,2)
%     warning('no nuclear fluorescence in end of y image. Skipping to second to last column with fluorescence.')
%     %here we use the 2nd to last column instead of the first since there was an
%     %error in acquisition and we want to be sure to eliminate the last
%     %incorrectly scanned one.
%     yend = yend-1;
% 
% end
% 
% 
% nucim = nucim(ystart:yend,xstart:xend);

% determine foreground seeds

% morphological closing to remove artificial pixels from touching nucleis
if strcmpi(microscope_type,'confocal')
    regions_nuc = fgseeds( nucim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE);
elseif strcmpi(microscope_type,'widefield')
    regions_nuc = fgseeds_wf( nucim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE);
else
    error('Unrecognized microscope type given. Please choose which microscope type you used or add to this if-else a segmentation for your scope type.')
end
    

% %This actually fills holes and makes nuclei more contiguous 
% regions_nuc2 = bwmorph(regions_nuc,'dilate',dilation);
% regions_nuc = bwmorph(regions_nuc2,'erode',dilation);


if(IMAGEPIXELSIZE==0.1)
    nucim_p = bwmorph((regions_nuc),'open',2);
end

%check if the cellim is actually empty or even just a bit of noise
if quantile(cellim(:),0.999)==0
    warning('Cell image given is less that 0.1% non-zero pixels. Using voronoi segmentation.')
    cellim = [];
end

% process cell image
%Devin S. 2015,07,13 - Added support for voronoi segmentation
if ~isempty(cellim)
    cellim_proc = getcellimg(( cellim));
    
    
    % determine background seeds
    bgs = bgseeds( cellim_proc, MINNUCLEUSDIAMETER, IMAGEPIXELSIZE);
    %figure;subplot(1,2,1);imshow(cellim_proc);subplot(1,2,2);imshow(bgs);
    
    % combine seeds
    %DPS 2015,10,22 - This should be depricated code, but using the refined
    %nuclear segmentation gives much better segmentations, so updating it here
    %as well.
    % seeds = regions_nuc + bgs;
    seeds = uint8(regions_nuc)*255+bgs;

    
    % perform seeded watershed
    MA = max(cellim_proc(:));
    regions = seededwatershed(MA-cellim_proc,seeds,4);
    
else
    %use voronoi segmentation to approximate cells
    regions = ~(ml_getvoronoi(regions_nuc));
    
    %because we use all the nuclei to get more accurate cell shapes we now
    %have to eliminate "cells" where nuclei are touching the border to be
    %consistent with previous code. 
    %Note: cells with full nuclei but cytoplasm touching the border are
    %removed in post processing.
    
    %first find regions in image
    imgobjs = bwconncomp(regions,4);
    
    %get the value of nuclei touching the border 
    nucvallist = unique(regions_nuc(:));
    if length(nucvallist)>2
        bordernucval = nucvallist(2);%the first should always be 0
        bordernucimg = regions_nuc==bordernucval;
    else
        bordernucimg = zeros(size(regions_nuc));
    end
    
    %then loop through each region and eliminate the offending ones 
    for i = 1:imgobjs.NumObjects
        %create a temporary image for testing 
        tmpimg = zeros(size(regions));
        %fill the current region of the temporary image 
        tmpimg(imgobjs.PixelIdxList{i}) = 1;
        
        %check if the image overlaps with any of the nuclei touching the
        %edge of the image 
        if sum(sum(tmpimg.*bordernucimg))>0
            disp(['Eliminating cell object ', num2str(i), ' because nuclei touches the boundary'])
            regions(imgobjs.PixelIdxList{i}) = 0;
        end
        
        
    end
    
    %DPS 05,08,2015 - For voronoi segmentation, because the borders can
    %have sharp angles there may be hanging pixels at cell junctions that
    %are not considered "connected". (this should never happen in watershed
    %segmentation). To eliminate these hanging pixels we filter for groups
    %of pixels bigger than min_cell_size.
    %This is hardcoded because it's a very conservative number only meant
    %to remove hanging pixels not estimate cell size. If a cell is smaller
    %than 5 pixels at any resolution, it is likely that you could not
    %segment a nucleus inside it as is our practice.
%     bw3 = bwareaopen(regions,round(minarea/2));
    se = strel('disk',2,0);
    regions = ~imdilate(~regions,se);

    
    
end
%figure;subplot(1,2,1);imshow(cellim_proc);subplot(1,2,2);imshow(regions);

disp('end');