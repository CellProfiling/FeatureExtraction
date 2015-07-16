function cells_mask = ml_getvoronoi(nuclei_mask)
%function mask_all = ml_getvoronoi( nuclei_mask)
% Notice that morphological filtering is applied in this function, but the
% actual selection of which regions are to be deleted is determined from
% the seeding code.

%Edited by: 
%Devin P. Sullivan July 13, 2015 - updated call to voronoi built-in
%function. No longer requires Qhull-specific options. 

conn = 4;

nrows = size(nuclei_mask,1);
ncols = size(nuclei_mask,2);
newIm = zeros([nrows,ncols]);

bwl = bwlabel(nuclei_mask,conn);
stats = regionprops(bwl,'Centroid');%'Eccentricity','ConvexArea','Area');

NDIMS = 2;
objCofs = zeros(NDIMS,length(stats));
if length(stats)>1
    for i=1:length(stats)
        objCofs(:,i)=stats(i).Centroid';
    end
else
% if only one Centroid, return entire image as mask
    cells_mask=newIm;
    return
end
    

% Compute Voronoi diagram
% [vx, vy] = voronoi( objCofs(2,:), objCofs(1,:), {'QJ'} );
[vx, vy] = voronoi( objCofs(2,:), objCofs(1,:));
vx = round(vx);
vy = round(vy);


vx = [vx [1 1; 1 nrows; nrows nrows; nrows 1]'];
vy = [vy [1 ncols; ncols ncols; ncols 1; 1 1]'];

% Connect all the vertices of the Voronoi diagram
for i = 1:size(vx,2)
    pts = ml_getlinepts(round([vx(1,i) vy(1,i)]),round([vx(2,i) vy(2,i)]));
    ng = sum(pts<=0,2)+(pts(:,1)>size(newIm,1))+(pts(:,2)>size(newIm,2));
    pts(ng>0,:) = [];
    
    newIm(pts(:,1) + (pts(:,2)-1)*nrows) = 1;
end

segLabel = bwlabel(~newIm,conn);
% figure,imshow(newIm,[]),title('newIm')

cells_mask = newIm;
% t = (newIm & nuclei_mask);
% figure,imshow(t,[]),title('t')
% [r c] = find(t);
% g = ~imfill(~nuclei_mask,[r c],conn);
% figure,imshow(g,[]),title('g')
% 
% [r c] = find((nuclei_mask>0)-g);
% [r2 c2] = find(nuclei_mask>0 & nuclei_mask<max(nuclei_mask(:)));
% cells_mask = ~imfill(~segLabel,[[r; r2] [c; c2]],conn);
% figure,imshow(cells_mask,[]),title('cells_mask')
