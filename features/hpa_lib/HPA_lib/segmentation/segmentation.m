function [regions, fgs]= segmentation( nucim, cellim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE)

%Edited by:
%Devin Sullivan July 13, 2015 - added support for voronoi segmentation

minarea = (MINNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;
maxarea = (MAXNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;

% determine foreground seeds

% morphological closing to remove artificial pixels from touching nucleis

fgs = fgseeds( nucim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE);

if(IMAGEPIXELSIZE==0.1)
    nucim_p = bwmorph((fgs),'open',2);
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
    
end
%figure;subplot(1,2,1);imshow(cellim_proc);subplot(1,2,2);imshow(regions);

disp('end');