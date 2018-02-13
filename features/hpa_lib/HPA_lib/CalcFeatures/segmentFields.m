function [regions, nucseeds,skipimgs] = segmentFields(readdir, writedir, naming_convention,resolution)

% function segmentFields
% readdir is the directory storing all images;
% writedir is the directory for writing segmentation masks.

% Copyright (C) 2010  Murphy Lab
% Carnegie Mellon University
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published
% by the Free Software Foundation; either version 2 of the License,
% or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
% 02110-1301, USA.
%
% For additional information visit http://murphylab.web.cmu.edu or
% send email to murphy@cmu.edu

% 10 Jan 10 - Jieyue Li
% 2011-11-09 tebuck: adding option to use IFconfocal_CellCycle-like
% image names.
% $$$ % 2011-11-15 tebuck: if naming_convention.nuclear_channel is
% $$$ % 'ignore_channel', it is now set to a blank image the size of the
% $$$ % protein image. Added IFconfocal_CellCycle_nuclear-focus
% $$$ % naming_convention.
% 2011-12-07 tebuck: adding option
% naming_convention.segmentation_suffix to allow reordering
% channels without erroneously affecting segmentation.
%2015,07,13 DPSullivan - added support for voronoi segmentation and
%cleaned up code 
%2015,08,05 DPSullivan - added support for base naming convention that
%starts with a "-", this previously would fail because grep would try to
%use it as an option field rather than a search term.
%2015,08,10 DPSullivan - added field for tracking blank images. 
%2018,09,02 DPSullivan - changed to flexible channels... lots of changes

nucseg_val = 1;%immutable code for which channel(s) to use as seg. for nucleus
regions = [];

if ~exist('readdir','var')
    readdir = '/images/HPA/images/IFconfocal/';
end
if ~exist('writedir','var')
    writedir = './data/masks/';
end

if ~exist('naming_convention', 'var') || strcmpi(naming_convention, 'IFconfocal')
  naming_convention = struct(); 
  naming_convention.protein_channel = 'green'; 
  naming_convention.nuclear_channel = 'blue'; 
  naming_convention.tubulin_channel = 'red'; 
  naming_convention.er_channel = 'yellow'; 
  naming_convention.segmentation_suffix = naming_convention.protein_channel;
  naming_convention.mstype = 'confocal';
%   naming_convention.seg_channel = {'er','mt'};
elseif exist('naming_convention', 'var') && strcmpi(naming_convention, 'IFconfocal_CellCycle')
  naming_convention = struct(); 
  naming_convention.protein_channel = '_ch00'; 
  naming_convention.nuclear_channel = '_ch01'; 
  naming_convention.tubulin_channel = '_ch03'; 
  naming_convention.er_channel = '_ch02'; 
  naming_convention.segmentation_suffix = naming_convention.protein_channel; 
  naming_convention.mstype = 'confocal';
%   naming_convention.seg_channel = {'er','mt'};
end

% if ~isfield(naming_convention,'seg_channel')
%     naming_convention.seg_channel = {'er','mt'};
% end

if (resolution==63)
    error('You appear to be using an outdated version. Resolution should now be specified as um/pixel.');
%     IMAGEPIXELSIZE = 0.08; % um/px
elseif ~isempty(resolution)
    disp('We are assuming you entered your resolution in um/px')
    IMAGEPIXELSIZE = resolution; % um/px
else
    warning('flying resolution blind is not smart. using 0.1 um/px.')
    IMAGEPIXELSIZE = 0.1; % um/px
end

%This may change if the cell type changes, but probably not too much. For
%now we will keep them as constants and tell the user
%Bionumbers - for HeLa cells, ~10um
warning('We assume that nuclei in your image are between 4 and 40 um. If this is not correct please adjust the lines of code below.')
    MINNUCLEUSDIAMETER = 4; %um
    MAXNUCLEUSDIAMETER = 40; %um

nucseg_inds = cell2mat(cellfun(@(x) ~isempty(x)&&x==nucseg_val,naming_convention.channels(:,2),'UniformOutput',0));
firstnuc_ind = find(nucseg_inds,1,'first');
nuc_naming = naming_convention.channels{firstnuc_ind,1};
if strfind(nuc_naming,'.tif');
    filetype = 'tif';
elseif strfind(nuc_naming,'.TIF');
    filetype = 'TIF';
else 
    warning('This image does not appear to be a tif (or TIF). Trying to separate file type. Assuming fileparts will give correct answer.')
    [~,~,nucext] = fileparts(nuc_naming);
    filetype = nucext(2:end);
end
    
% filetype = 'tif';

%greparg = '| grep green';
%DPS 05,08,2015 - adding support for naming_conventions to begin with a "-"
try
    dashlocs = cell2mat(strfind(naming_convention.channels(:,1),'-'));
catch
    dashlocs = [];
end
if any(dashlocs==1)
    %adding two slashes escapes the special character '-' at the beginning
    %of the pattern. This only needs to be done if the dash is at the start
    %of the pattern.
%     naming_convention.protein_channel = ['\\',naming_convention.protein_channel];
    %greparg = ['| grep \\', naming_convention.protein_channel]
else
    %greparg = ['| grep ', naming_convention.protein_channel]
end

ind = find(readdir=='/');
readdir_ = readdir;
readdir_(ind) = '_';

%filetype is now added before in process_63x.m
readlist = ml_ls([readdir,'*',naming_convention.pattern,'*',naming_convention.channels{firstnuc_ind,1}]);

%adjust readdir in case it's not right
[readdir,filename,exttype] = fileparts(readlist{1});
%add filesep to the relative path if we are sitting in the
%working directory. This prevents replacing other '.' characters in the
%file string later on. 
if strcmpi(readdir,'.')
    readdir = ['.',filesep];
end
readdir_ = strrep(readdir,'/','_');

mout = readlist;
mout = strrep(mout,naming_convention.channels{firstnuc_ind,1},naming_convention.segmentation_suffix);
writedir_ = [writedir '/']
mout = strrep(mout,readdir,writedir);


nucwritelist = strrep(mout,['.',filetype],'_nuc.png.gz');
cytowritelist = strrep(mout,['.',filetype],'_cyto.png.gz');


mout = strrep(mout,filetype,'png.gz');

writelist = mout;%listmatlabformat( mout);
writelist'
mkdir(writedir,'/tmp')

%DPS 10/08/15 - adding variable to track the blank channels 
skipimgs = zeros(length(readlist),1);


for i=1:length(readlist)
    
    if exist(nucwritelist{i},'file') && exist(cytowritelist{i},'file')
        continue
    end
    
    tmpfile = writelist{i};
    tmpfile(find(tmpfile=='/')) = [];
    tmpfile(find(tmpfile=='.')) = [];
    tmpfile = [writedir '/tmp/' tmpfile '.txt'];

    if exist(tmpfile,'file')
        disp('Temporary file already exists, removing it')
        
        delete(tmpfile)
        %Instead of skipping and continuing we will now re-do the image if
        %the temporary file is found. I have not found the skipping feature
        %is the one we want by default and makes the code very annoying to
        %run. Removing the old file is to ensure that we don't impact the
        %code later on. 
        %continue;
    end
%     fid = fopen(tmpfile,'w');

    %DPS 09,02,2018 - refactor for flexible channels
    nucim = [];
    for j = 1:length(nucseg_inds)
        if ~nucseg_inds(j)
            continue
        end
        currimg = strrep(readlist{i},naming_convention.channels{firstnuc_ind,1},naming_convention.channels{j,1});
        disp(currimg)
        curr_nucim = ml_readimage(strtrim(currimg));
    
        %check nuc might be rgb
        curr_nucim = removergb(curr_nucim);
        
        if isempty(nucim)
            nucim = double(curr_nucim);
        else 
            nucim = imadd(double(nucim),double(curr_nucim));
        end
    
    end
    if isempty(nucim)
        error('no nuclear segmentation image loaded. This is required')
    end
    
    %Devin S. 2015,07,13 - Added voronoi segmentation when ER channel is
    %not present. This is for Peter Thul's golgi project
    %Checks both whether the path has been left blank or if the
    %'blank_channels' option has been specified
    if ~isfield(naming_convention,'blank_channels')
        naming_convention.blank_channels = {};
    end
    
    %DPS 2015,10,20 - since we are no longer concerned with keeping the
    %code the same as before, we can take some steps to make it better. 
    %Here we will use the strategy of combining ER and MT for cell
    %segmentation was done in the 10x code. 
    %First check ER
    %if ~isempty(naming_convention.er_channel) && ~any(strcmpi(naming_convention.blank_channels,'er'))
    %DPS 25/11/2015 - Adding 'seg_channel' to naming_convention struct to
    %specify what channels we want to use 
    %DPS 09/02/2018 - Making flexible channels
    %Use .*0 here to ensure we match the expected data type (class)
    cellim = nucim.*0;
    for j = 1:size(naming_convention.channels,1)
    if (naming_convention.channels{j,2}==2 && (~isempty(naming_convention.channels{j,1}) && ~naming_convention.blank_channels(j)))
        currimg = strrep(readlist{i},naming_convention.channels{firstnuc_ind,1},naming_convention.channels{j,1});
        cellim = imadd(double(cellim),double(ml_readimage(strtrim(currimg))));
    else
        continue
    end
    
    %check image, might be rgb
    cellim = removergb(cellim);

    end
       
    
    %If neither existed, use Voronoi. If the sum is 0, there is no signal
    %for either ER or MT. 
    if sum(cellim(:)) == 0
        warning(['No cell segmentation channels given, or all are blank.',...
            'Defaulting to Voronoi segmentation using nuclei as seeds.'])
        cellim = [];
    end

    microscope_type = naming_convention.mstype;
    [regions, nucseeds] = segmentation( nucim, cellim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE, microscope_type);
    
    % saving results
    disp(['writing image ',writelist{i}])
    %DPS - I'm using uint16 here so we can have 65,000 objects (cells) per image. 
    regions = uint16(bwlabel(regions,4));
    %DPS - 20,08,16 added the extra max requiring the value chosen to be at
    %least 1. This prevents the image from being totally black.
    nucseg = uint16(nucseeds==max([max(nucseeds(:)),1])).*(regions);
    nucseg = imfill(nucseg,'holes');
    
    
    %DPS 11/27/15 - make sure there is a 1-1 mapping for regions to nuc. so
    %if a nuc is removed for touching an edge, remove the cell
    nucvals = unique(nucseg);
    cellvals = unique(regions);
    %regions2 = regions;
    for cellind = 1:length(cellvals)
        if sum(cellvals(cellind)==nucvals)==0
            regions(regions==cellvals(cellind)) = 0;
        end
    end
    
    if max(nucseg(:))==0
        warning('No nuclei found in the image after segmentation. This image appears to be blank!')
        skipimgs(i) = 1;
%     elseif max(regions(:))==0
    %modified slightly to be more robust. Sometimes all 1 segmentation is
    %returned.
    elseif length(unique(regions(:)))==1
        warning('No cell regions found in the image after segmentation. This image appears to be blank!')
        skipimgs(i) = 2;
    end
    
    
%     cytoseg = (regions>0)-nucseg;

    currwrite = strsplit(writelist{i},'.gz');
    imwrite( regions, currwrite{1});
    unix(['gzip ' currwrite{1}]);

    
    %2015/10/19 DPS - save the nuclear segmentations too! 
    currwrite = strsplit(nucwritelist{i},'.gz');
    imwrite( nucseg, currwrite{1});
    unix(['gzip ' currwrite{1}]);
    
end
