function [regions, fgs]= segmentation( nucim, cellim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE)

%Edited by:
%Devin Sullivan July 13, 2015 - added support for voronoi segmentation
%Devin P Sullivan Aug 7, 2015 - added support for partially scanned nuclear
%image.

minarea = (MINNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;
maxarea = (MAXNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;

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

fgs = fgseeds( nucim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE);

if(IMAGEPIXELSIZE==0.1)
    nucim_p = bwmorph((fgs),'open',2);
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
    seeds = fgs + bgs;
    
    % perform seeded watershed
    MA = max(cellim_proc(:));
    regions = seededwatershed(MA-cellim_proc,seeds,4);
else
    %use voronoi segmentation to approximate cells
    regions = ~(ml_getvoronoi(fgs));
    
    %because we use all the nuclei to get more accurate cell shapes we now
    %have to eliminate "cells" where nuclei are touching the border to be
    %consistent with previous code. 
    %Note: cells with full nuclei but cytoplasm touching the border are
    %removed in post processing.
    
    %first find regions in image
    imgobjs = bwconncomp(regions,4);
    
    %get the value of nuclei touching the border 
    nucvallist = unique(fgs(:));
    bordernucval = nucvallist(2);%the first should always be 0
    bordernucimg = fgs==bordernucval;
    
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
    
    
end
%figure;subplot(1,2,1);imshow(cellim_proc);subplot(1,2,2);imshow(regions);

disp('end');