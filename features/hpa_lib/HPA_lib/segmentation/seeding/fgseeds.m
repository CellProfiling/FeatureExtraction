function seeds = fgseeds( dna, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE)
%
%Written by: Unknown
%
%Edited by: 
%Devin P Sullivan 11/08/15 - added conversion for uint16 iamges. 

if ~isa(dna,'unit8')
    warning('The DNA image appears to not be uint8 as expected by fgseeds.m. Converting to uint8. This may result in loss of data.')
    dna = uint8(double(dna)./double(max(dna(:))).*255);
end

minarea = (MINNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;
maxarea = (MAXNUCLEUSDIAMETER/IMAGEPIXELSIZE/2)^2*pi;

%% determine foreground seeds
[c b] = imhist(dna);
[a ind] = max(c);

nuc = imerode(dna>b(ind),strel('disk',round(MINNUCLEUSDIAMETER/IMAGEPIXELSIZE/8)));
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
