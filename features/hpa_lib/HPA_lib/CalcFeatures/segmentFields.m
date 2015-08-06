function [regions, nucseeds] = segmentFields(readdir, writedir, naming_convention,resolution)

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
elseif exist('naming_convention', 'var') && strcmpi(naming_convention, 'IFconfocal_CellCycle')
  naming_convention = struct(); 
  naming_convention.protein_channel = '_ch00'; 
  naming_convention.nuclear_channel = '_ch01'; 
  naming_convention.tubulin_channel = '_ch03'; 
  naming_convention.er_channel = '_ch02'; 
  naming_convention.segmentation_suffix = naming_convention.protein_channel; 
end

if (resolution==1)
    IMAGEPIXELSIZE = 0.05; % um/px
    MINNUCLEUSDIAMETER = 4; %um
    MAXNUCLEUSDIAMETER = 40; %um
else
    IMAGEPIXELSIZE = 0.1; % um/px
    MINNUCLEUSDIAMETER = 4; %um
    MAXNUCLEUSDIAMETER = 40; %um
end

filetype = 'tif';

%greparg = '| grep green';
%DPS 05,08,2015 - adding support for naming_conventions to begin with a "-"
dashlocs = strfind(naming_convention.protein_channel,'-')
if any(dashlocs==1)
    %adding two slashes escapes the special character '-' at the beginning
    %of the pattern. This only needs to be done if the dash is at the start
    %of the pattern.
%     naming_convention.protein_channel = ['\\',naming_convention.protein_channel];
    greparg = ['| grep \\', naming_convention.protein_channel]
else
    greparg = ['| grep ', naming_convention.protein_channel]
end



ind = find(readdir=='/');
readdir_ = readdir;
readdir_(ind) = '_';
uout = unixfind( readdir, filetype, greparg);
readlist = listmatlabformat( uout);

%adjust readdir in case it's not right
[readdir,filename,exttype] = fileparts(readlist{1});
readdir_ = strrep(readdir,'/','_');

uout_nuc = findreplacestring(uout, naming_convention.protein_channel, naming_convention.nuclear_channel);
uout_tub = findreplacestring(uout, naming_convention.protein_channel, naming_convention.tubulin_channel);
uout_er = findreplacestring(uout, naming_convention.protein_channel, naming_convention.er_channel);
readlist_nuc = listmatlabformat( uout_nuc);
readlist_tub = listmatlabformat( uout_tub);
readlist_er = listmatlabformat( uout_er);
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
mout = findreplacestring( mout, naming_convention.protein_channel, naming_convention.segmentation_suffix);
%mout = findreplacestring( uout, '/', '_');
%mout = findreplacestring( mout, '/', '_');
writedir_ = [writedir '/']
%readdir_
%mout
%mout = findreplacestring( mout, readdir_,writedir_);
mout = strrep(mout,readdir,writedir);
mout = findreplacestring( mout, '.tif','.png');

writelist = listmatlabformat( mout);
writelist'
mkdir(writedir,'/tmp')
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

    nucim = imread(strtrim(readlist_nuc{i}));
    
    %Devin S. 2015,07,13 - Added voronoi segmentation when ER channel is
    %not present. This is for Peter Thul's golgi project
    %Checks both whether the path has been left blank or if the
    %'blank_channels' option has been specified
    if ~isfield(naming_convention,'blank_channels')
        naming_convention.blank_channels = {};
    end
    if ~isempty(naming_convention.er_channel) && ~any(strcmpi(naming_convention.blank_channels,'er'))
        cellim = imread(strtrim(readlist_er{i}));
    else
        warning(['No ER naming convention given.',...
            ' If you wish to use MT for segmentation please specify this',...
            ' path in the naming_convention.er_channel.\n',...
            'Otherwise defaulting to Voronoi segmentation using nuclei'])
        cellim = [];
    end

    [regions, nucseeds] = segmentation( nucim, cellim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE);

    % saving results
    disp(['writing image ',writelist{i}])
    imwrite( regions, writelist{i});

    fclose(fid);
    delete(tmpfile);
end
