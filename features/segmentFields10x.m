function [regions_cell regions_nuc] = segmentFields10x(nucim, cellim, erim)

warning('This is an outdated method and should be removed. If you are still using this, please consider using segmentFields.m')

% nucim is the the input image of the DAPI to segment the seeds for the 
% cell masks.
% 
% cellim is the input image of the tubulin channel to segment the outer
% border of the cell extent. 
%
% regions_cell is a matrix with same size as the input image matrix nucim 
% and cellim with cell objects masks labelled with integer going from 0 
% (background),1 (top-left corner object) to total number of objects 
%(bottom-right corner of the image).
%
% regions_nuc is a matrix with same size as the input image matrix nucim 
% and cellim with nuclear objects masks labelled with integer going from 0 
%(background), 1 (top-left corner object) to total number of objects 
% (bottom-right corner of the image).
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
% 12 November 2012 - Elton Rexhepaj

IMAGEPIXELSIZE = 1; % um/px

MINNUCLEUSDIAMETER = 4;
MAXNUCLEUSDIAMETER = 200;

filetype = '.tif';

% nucim = imread(strtrim(infilename_dapi));
% cellim = imread(strtrim(infilename_er));

[regions_cell regions_nuc]= segmentation10x( nucim, cellim, erim, MINNUCLEUSDIAMETER, MAXNUCLEUSDIAMETER, IMAGEPIXELSIZE);

% figure;imshow(label2rgb(bwlabel(regions_cell,8)));

% % saving results
% imwrite( regions, outfilename);
% 
% fclose(fid);
% delete(tmpfile);

