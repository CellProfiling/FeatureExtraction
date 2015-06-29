function regions = waterwrap( nucim, cellim)

MINNUCLEUSDIAMETER = 6;
MAXNUCLEUSDIAMETER = 14;
IMAGEPIXELSIZE = 0.05;

minarea = (MINNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;
maxarea = (MAXNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;

% determine foreground seeds
fgs = fgseeds( nucim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE);

% process cell image
cellim_proc = getcellimg( cellim);

% determine background seeds
bgs = bgseeds( cellim_proc, MINNUCLEUSDIAMETER, IMAGEPIXELSIZE);

% combine seeds
seeds = fgs + bgs;

% perform seeded watershed
MA = max(cellim_proc(:));
regions = seededwatershed( MA-cellim_proc,seeds,4);
