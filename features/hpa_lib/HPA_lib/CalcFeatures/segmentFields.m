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
  naming_convention.seg_channel = {'er','mt'};
elseif exist('naming_convention', 'var') && strcmpi(naming_convention, 'IFconfocal_CellCycle')
  naming_convention = struct(); 
  naming_convention.protein_channel = '_ch00'; 
  naming_convention.nuclear_channel = '_ch01'; 
  naming_convention.tubulin_channel = '_ch03'; 
  naming_convention.er_channel = '_ch02'; 
  naming_convention.segmentation_suffix = naming_convention.protein_channel; 
  naming_convention.mstype = 'confocal';
  naming_convention.seg_channel = {'er','mt'};
end

if ~isfield(naming_convention,'seg_channel')
    naming_convention.seg_channel = {'er','mt'};
end

if (resolution==63)
    warning('You appear to be using an outdated version. Resolution should now be specified as um/pixel.');
    IMAGEPIXELSIZE = 0.05; % um/px
%     MINNUCLEUSDIAMETER = 4; %um
%     MAXNUCLEUSDIAMETER = 40; %um
elseif ~isempty(resolution)
    disp('We are assuming you entered your resolution in um/px')
    IMAGEPIXELSIZE = resolution; % um/px
else
    IMAGEPIXELSIZE = 0.1; % um/px
%     MINNUCLEUSDIAMETER = 4; %um
%     MAXNUCLEUSDIAMETER = 40; %um
end

%This may change if the cell type changes, but probably not too much. For
%now we will keep them as constants and tell the user
%Bionumbers - for HeLa cells, ~10um
warning('We assume that nuclei in your image are between 4 and 40 um. If this is not correct please adjust the lines of code below.')
    MINNUCLEUSDIAMETER = 4; %um
    MAXNUCLEUSDIAMETER = 40; %um

if findstr(naming_convention.nuclear_channel,'.tif');
    filetype = 'tif';
elseif findstr(naming_convention.nuclear_channel,'.TIF');
    filetype = 'TIF';
else 
    warning('This image does not appear to be a tif (or TIF). Trying to separate file type. Assuming fileparts will give correct answer.')
    [~,~,nucext] = fileparts(naming_convention.nuclear_channel);
    filetype = nucext(2:end);
end
    
% filetype = 'tif';

%greparg = '| grep green';
%DPS 05,08,2015 - adding support for naming_conventions to begin with a "-"
dashlocs = strfind(naming_convention.protein_channel,'-')
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
%uout = unixfind( readdir, filetype, greparg);
readdir
naming_convention.protein_channel
%filetype is now added before in process_63x.m
% uout = ml_ls([readdir,filesep,'*',naming_convention.pattern,'*',naming_convention.protein_channel])
uout = ml_ls([readdir,'*',naming_convention.pattern,'*',naming_convention.protein_channel])
%uout = [readdir,filesep,uout]
%readlist = listmatlabformat( uout);
readlist = uout;

%adjust readdir in case it's not right
[readdir,filename,exttype] = fileparts(readlist{1});
readdir_ = strrep(readdir,'/','_');

%uout_nuc = findreplacestring(uout, naming_convention.protein_channel, naming_convention.nuclear_channel);
uout_nuc = strrep(uout,naming_convention.protein_channel,naming_convention.nuclear_channel);
%uout_tub = findreplacestring(uout, naming_convention.protein_channel, naming_convention.tubulin_channel);
uout_tub = strrep(uout,naming_convention.protein_channel,naming_convention.tubulin_channel);
%uout_er = findreplacestring(uout, naming_convention.protein_channel, naming_convention.er_channel);
uout_er = strrep(uout,naming_convention.protein_channel,naming_convention.er_channel);
%readlist_nuc = listmatlabformat( uout_nuc);
readlist_nuc = uout_nuc;
%readlist_tub = listmatlabformat( uout_tub);
readlist_tub = uout_tub;
%readlist_er = listmatlabformat( uout_er);
readlist_er = uout_er;
% $$$ if strcmpi(naming_convention.nuclear_channel, 'ignore_channel')
% $$$   readlist_nuc = repmat({''}, size(readlist)); 
% $$$ else
% $$$   uout_nuc = findreplacestring(uout, naming_convention.protein_channel, naming_convention.nuclear_channel);
% $$$   readlist_nuc = listmatlabformat( uout_nuc);
% $$$ end
% $$$ uout_tub = findreplacestring(uout, naming_convention.protein_channel, naming_convention.tubulin_channel);
% $$$ uout_er = findreplacestring(uout, naming_convention.protein_channel, naming_convention.er_channel);
% $$$ readlist_tub = listmatlabformat( uout_tub);
% $$$ readlist_er = listmatlabformat( uout_er);

uout
mout = uout;
mout
%mout = findreplacestring( mout, naming_convention.protein_channel, naming_convention.segmentation_suffix);
mout = strrep(mout,naming_convention.protein_channel,naming_convention.segmentation_suffix);
%mout = findreplacestring( uout, '/', '_');
%mout = findreplacestring( mout, '/', '_');
writedir_ = [writedir '/']
%readdir_
%mout
%mout = findreplacestring( mout, readdir_,writedir_);
mout = strrep(mout,readdir,writedir);
%mout = findreplacestring( mout, '.tif','.png');

nucwritelist = strrep(mout,['.',filetype],'_nuc.png');
cytowritelist = strrep(mout,['.',filetype],'_cyto.png');


mout = strrep(mout,filetype,'png');

writelist = mout;%listmatlabformat( mout);
writelist'
mkdir(writedir,'/tmp')

%DPS 10/08/15 - adding variable to track the blank channels 
skipimgs = zeros(length(readlist),1);

for i=1:length(readlist)
%    i
%     if exist(writelist{i},'file')
%         continue;
%     end

    tmpfile = writelist{i};
    tmpfile(find(tmpfile=='/')) = [];
    tmpfile(find(tmpfile=='.')) = [];
    tmpfile = [writedir '/tmp/' tmpfile '.txt'];

    if exist(tmpfile,'file')
        continue;
    end
    fid = fopen(tmpfile,'w');

    disp(readlist_nuc{i})
    nucim = imread(strtrim(readlist_nuc{i}));
    
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
    if any(strcmpi(naming_convention.seg_channel,'er')) && (~isempty(naming_convention.er_channel) && ~any(strcmpi(naming_convention.blank_channels,'er')))
        erim = imread(strtrim(readlist_er{i}));
    else
        erim = zeros(size(nucim));
    end
    %Then check MT
%     if ~isempty(naming_convention.tubulin_channel) && ~any(strcmpi(naming_convention.blank_channels,'mt'))
    if any(strcmpi(naming_convention.seg_channel,'mt')) && (~isempty(naming_convention.tubulin_channel) && ~any(strcmpi(naming_convention.blank_channels,'mt')))
        mtim = imread(strtrim(readlist_er{i}));
    else
        mtim = zeros(size(nucim));
    end
    %Then combine them
    cellim = imadd(erim,mtim);
    
    %If neither existed, use Voronoi. If the sum is 0, there is no signal
    %for either ER or MT. 
    if sum(cellim(:)) == 0
        warning(['No ER or MT naming convention given, or both are blank.',...
            'Defaulting to Voronoi segmentation using nuclei as seeds.'])
        cellim = [];
    end

    microscope_type = naming_convention.mstype;
    [regions, nucseeds] = segmentation( nucim, cellim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE, microscope_type);
    if max(nucseeds(:))==0
        warning('No nuclei found in the image after segmentation. This image appears to be blank!')
        skipimgs(i) = 1;
    elseif max(regions(:))==0
        warning('No cell regions found in the image after segmentation. This image appears to be blank!')
        skipimgs(i) = 2;
    end
    
    % saving results
    disp(['writing image ',writelist{i}])
    %DPS - I'm using uint16 here so we can have 65,000 objects (cells) per image. 
    regions = uint16(bwlabel(regions,4));
    nucseg = uint16(nucseeds==max(nucseeds(:))).*(regions);
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
    
%     cytoseg = (regions>0)-nucseg;
%     imwrite(cytoseg,cytowritelist{i});
    imwrite( regions, writelist{i});
    
    %2015/10/19 DPS - save the nuclear segmentations too! 
    imwrite( nucseg, nucwritelist{i});
    
    fclose(fid);
    delete(tmpfile);
end
