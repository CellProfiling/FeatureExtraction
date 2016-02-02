function seeds = fgseeds( dna, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE)
%
%Written by: Unknown
%
%Edited by: 
%Devin P Sullivan 11/08/15 - added conversion for uint16 images. 

if ~isa(dna,'unit8')
    warning('The DNA image appears to not be uint8 as expected by fgseeds.m. Converting to uint8. This may result in loss of data.')
    dna = uint8(double(dna)./double(max(dna(:))).*255);
end

nucD_inpixels = MINNUCLEUSDIAMETER/IMAGEPIXELSIZE;
minarea = (MINNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;
maxarea = (MAXNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;

%% determine foreground seeds
[c b] = imhist(dna);
[a ind] = max(c);

%DPS - 10/19/15
%Do some minor blurring first to try to get a more accurate nuclear
%segmentation.
%Using slightly different blurring for low resolution to ensure that we do
%not blur too much when there is a small number of pixels. 
if (nucD_inpixels)>10
    dtmp = fspecial('disk',round(nucD_inpixels)/2);
    tmp = imfilter(dna,dtmp,'replicate');
    rcthresh = ml_rcthreshold(tmp);
    nuc = (tmp>rcthresh);
%     nuc = imerode(dna>b(ind),strel('disk',round(nucD_inpixels/8)));
else
    dtmp = fspecial('disk',round(MINNUCLEUSDIAMETER/4));
    tmp = imfilter(dna,dtmp,'replicate');
    rcthresh = ml_rcthreshold(tmp);
    nuc = (tmp>rcthresh);
%     nuc = imerode(dna>b(ind),strel('disk',round(MINNUCLEUSDIAMETER/IMAGEPIXELSIZE/8)));
end

seeds = nuc>0;

% filter away very small objects
bwl = bwlabel(seeds, 4);
props = regionprops( bwl, 'Area');
stats = zeros(size(props));
for i=1:length(props)
    stats(i) = props(i).Area;
end
idx = find(stats>minarea/2);
seeds = ismember(bwl,idx);
seeds = 255*uint8(seeds);

idx = find(stats>maxarea | stats<minarea);
idx2 = unique([bwl(:,1)' bwl(:,end)' bwl(1,:) bwl(end,:)]);
idx2(idx2==0) = [];
idx = unique([idx' idx2]);
seeds = seeds - 127*uint8(ismember(bwl,idx));

%DPS 2015,10,22
%This actually fills holes and makes nuclei more contiguous 
dilation = round((MINNUCLEUSDIAMETER/IMAGEPIXELSIZE)/8)+1;
fgs2 = bwmorph(seeds,'dilate',dilation);
seeds = bwmorph(fgs2,'erode',dilation);

%% double check if nuclei are within the size limits. If not, delete them. 
%this makes sure we didn't accidently make things that are really big or
%small in the process of dilating and shrinking. 

%%Copy-pasta code. Should probably put this in a function
% filter away very small objects
bwl = bwlabel(seeds, 4);
props = regionprops( bwl, 'Area');
stats = zeros(size(props));
for i=1:length(props)
    stats(i) = props(i).Area;
end
idx = find(stats>minarea/2);
seeds = ismember(bwl,idx);
seeds = 255*uint8(seeds);

idx = find(stats>maxarea | stats<minarea);
idx2 = unique([bwl(:,1)' bwl(:,end)' bwl(1,:) bwl(end,:)]);
idx2(idx2==0) = [];
idx = unique([idx' idx2]);
seeds = seeds - 127*uint8(ismember(bwl,idx));


