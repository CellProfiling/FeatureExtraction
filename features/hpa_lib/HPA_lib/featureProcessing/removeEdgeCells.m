function [prunedfeats,eliminds] = removeEdgeCells(features,featnames,imgsize)
%This function removes any cells that are on the edges of the image using
%the position statistics
%
%INPUTS: 
%features - an nxm matrix where n is the number of observations (cells) and
%m is the number of features. 
%featnames - a 1xm cell array of feature names 
%imgsize - the size of the input images in pixels
%
%OUTPUTS: 
%prunedfeats - an (n-e)xm matrix where e are the number of cells found to
%be touching an image edge.
%
%Written by: Devin P. Sullivan 31,07,2015


if nargin<3
    imgsize = [2048,2048];%[1728,1728];
end

if length(imgsize)==1
    disp('Only one dimension provided. assuming square input image.')
    imgsize = [imgsize,imgsize];
end

%If no set of feature names was given, assume that the position stats are
%the first features and in the order that they are assigned in
%process_63x.m
if nargin<2
    pos_stats_names = cell(1,7);
    %area
    pos_stats_names{1} = 'position_stats:Area';
    %center of mass location
    pos_stats_names{2} = 'position_stats:Centroid_x';
    pos_stats_names{3} = 'position_stats:Centroid_y';
    %bounding box
    pos_stats_names{4} = 'position_stats:BoundingBox_ulx';
    pos_stats_names{5} = 'position_stats:BoundingBox_uly';
    pos_stats_names{6} = 'position_stats:BoundingBox_wx';
    pos_stats_names{7} = 'position_stats:BoundingBox_wy';
    featnames = pos_stats_names;
end

%here we want case-insensitve matches 
casei = 1;

%Find the indices of all the position statistics
posinds = findstr_cell(featnames,'position_stats',casei);
%Extract the features and names we want to look at
posfeats = features(:,posinds);
posnames = featnames(posinds);

%Check cells location
%get upper left x value from coordinate
ulxvals = posfeats(:,findstr_cell(posnames,'_ulx',casei));
%get upper left y value from coordinate
ulyvals = posfeats(:,findstr_cell(posnames,'_uly',casei));
%get lower right x value from coordinate 
wxvals = posfeats(:,findstr_cell(posnames,'_wx',casei));
%get lower right y value from coordinate 
wyvals = posfeats(:,findstr_cell(posnames,'_wy',casei));


%%%CHECK THIS%%%
% %make lower right x values 
lrxvals = ulxvals + wxvals;
% %make lower right y values 
%  lryvals = ulyvals - wyvals;
lryvals = ulyvals + wyvals;



%initialize the indicies for any cells we find to be touching the edge of
%the image
eliminds = zeros(size(posfeats,1),1);

%check that the upper left of the bounding box is not outside the image 
% eliminds = (ulxvals<1)+(ceil(ulyvals)==imgsize(2));
%DPS 19,08,15 - adding greater-than or equals in case all images are not
%the same size. We will therefore eliminate cells that are outsize this
%range
eliminds = (ulxvals<1)+(ceil(ulyvals)>=imgsize(2));

%check if the bottom right is in the image
% eliminds = eliminds + (ceil(lrxvals)==imgsize(1)) + (lryvals<1);
%DPS 19,08,15 - adding greater-than or equals in case all images are not
%the same size. We will therefore eliminate cells that are outsize this
%range
eliminds = eliminds + (ceil(lrxvals)>=imgsize(1)) + (lryvals<1);

%get rid of all cells touching edges
prunedfeats = features(~eliminds,:);







