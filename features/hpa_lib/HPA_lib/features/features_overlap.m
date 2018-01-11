function [ofeat,oname,slfname] = features_overlap( prot, procprot, procref, refname)
% Takes uint8 images, already thresholded but with intensity

if ~exist('refname','var')
    refname = 'ref';
end

% Threshold by Otsu's method

obj_prot = procprot>0;
obj_ref = procref>0;

area_prot = sum(obj_prot(:));
area_ref = sum(obj_ref(:));

overlap = obj_prot & obj_ref;
areaOverlap = sum(overlap(:));

%DPS 29,07,2015 - added warning for when no objects are present.
if area_prot==0
    warning('No objects in filtered protein channel. intersect_area_to_prot_area and prot_nuc_pixel_distance_to_prot_area will be NaN.')
end
%slf_34.165
intersect_area_to_prot_area = areaOverlap / area_prot;
%slf_34.166
intersect_area_to_ref_area = areaOverlap / area_ref;
%slf_34.167
intersect_inten_to_prot_inten = sum(prot(obj_ref)) / sum(prot(:));
%slf_34.173
dist_ref = bwdist(obj_ref);
prot_nuc_pixel_distance_to_prot_area = sum(dist_ref(obj_prot))/area_prot;


ofeat = [intersect_area_to_prot_area intersect_area_to_ref_area ...
    intersect_inten_to_prot_inten ...
    prot_nuc_pixel_distance_to_prot_area];

oname = {'Fraction of protein object area that overlaps the reference area', ...
    'Fraction of referece area that overlaps the protein area', ...
    'Fraction of protein intensity that overlaps the reference area', ...
    'Avg distace of protein containing pixel to nearest pixel of reference'};
slfname = {'slf_34.165','slf_34.166','slf_34.167','slf_34.173'};

for i=1:length(oname)
    oname{i} = [refname ':' oname{i}];
    slfname{i} = [refname ':' slfname{i}];
end


return

