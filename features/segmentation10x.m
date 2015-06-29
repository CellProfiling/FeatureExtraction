function [regions_cell regions_nuc] = segmentation10x( nucim, cellim, erim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE)

%% Addjust local path

addpath(genpath('./segmentation/seeding'),'-begin');
addpath(genpath('./segmentation/watershed'),'-begin');
addpath(genpath('./segmentation/arch'),'-begin');
addpath(genpath('./segmentation/output'),'-begin');

% minarea = (MINNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;
% maxarea = (MAXNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;

% MINNUCLEUSDIAMETER = 4;
% MAXNUCLEUSDIAMETER = 200;

%figure;imshow(nucim)
%figure;imshow(cellim)

% determine foreground seeds
fgs = fgseeds( nucim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE);

fgs2 = bwmorph(fgs,'dilate',3);
regions_nuc = bwmorph(fgs2,'erode',3);

%figure;imshow(fgs3)

% merge er & mtub channel
merge_ch    = imadd(erim,cellim); 

% process cell image
cellim_proc = getcellimg(merge_ch);
%figure;imshow(cellim_proc)

% determine background seeds
bgs = bgseeds( cellim_proc, MINNUCLEUSDIAMETER, IMAGEPIXELSIZE);
%figure;imshow(bgs)

% combine seeds
seeds = fgs + bgs;
%figure;imshow(seeds)

% perform seeded watershed
MA = max(cellim_proc(:));
regions_cell = seededwatershed( MA-cellim_proc,seeds,4);

% subplot(1,3,1);imshow(regions_cell);subplot(1,3,2);imshow((fgs));subplot(1,3,3);imshow((cellim));

% disp('end');