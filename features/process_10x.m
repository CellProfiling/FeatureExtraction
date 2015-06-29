function [regions_results, exit_code] = process_10x(in_folder,out_folder, color)

% input_folder is the directory storing all plate images however could be 
% changed to a folder containing only the fielf of view imageset - red,blue 
% and green channel images are required to be present.
%
% output_folder is the directory storing the result of the processed set of
% input images. If Run on a plate folder all data will be summarized in the
% one integrated table. Mask of nuclear and cell extent are stored as jpegs
% in the same output folder.
%
% Copyright (C) 2012  Science for life laborary
% KTH
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

regions_results = 0;
exit_code       = 0;

%% Addjust local path
addpath(genpath('./hpa_lib'),'-begin');
addpath(genpath('./adaptive_watersheed_seg'),'-begin');

%addpath(genpath('./segmentation/seeding'),'-begin');
%addpath(genpath('./segmentation/watershed'),'-begin');
%addpath(genpath('./segmentation/arch'),'-begin');
%addpath(genpath('./segmentation/output'),'-begin');


%% Define local variables

input_folder    = in_folder;
output_folder   = out_folder;

extention_dapi  = '_blue.tif';
extention_ab    = '_green.tif';
extention_mtub  = '_red.tif';
extention_er    = strcat('_', color, '.tif');

plate_wildcard  = 'exp*';
gene_wildcard   = '*';
chamb_wildcard  = '*';
field_wildcard  = 'field*';

% define list of imput images to be analysed from the input folder 

list_ab     = rdir_list(char([in_folder,'/*','/*',extention_ab]));
list_dapi   = rdir_list(char([in_folder,'/*','/*',extention_dapi]));
list_mtub   = rdir_list(char([in_folder,'/*','/*',extention_mtub]));
list_er     = rdir_list(char([in_folder,'/*','/*',extention_er]));

% list_ab     = rdir_list(char([input_folder,'/*',extention_ab]));
% list_dapi   = rdir_list(char([input_folder,'/*',extention_dapi]));
% list_mtub   = rdir_list(char([input_folder,'/*',extention_mtub]));
% list_er     = rdir_list(char([input_folder,'/*',extention_er]));

% initiate the final result table and variable to store total analysis time
% of each antibody image-set

allresults_tab  = [];
execution_time  = zeros(length(list_ab),1);

% Iterate throught all ABs image set to extract intensity measurement at
% the sub-cellullar level

for i=1:length(list_dapi)
    time1 = cputime;

    % Read images
    
    im_dapi     =   imread(list_dapi(i).name);
    im_ab       =   imread(list_ab(i).name);
    im_mtub     =   imread(list_mtub(i).name);
    im_er       =   imread(list_er(i).name);
    
    % Segment the nucleus and cell extent mask
    
    [regions nuc_seed]  =   segmentFields10x(im_dapi, im_mtub, im_er);
    
    % Extract IF intensity measurements from the masks computed above 
    
    [stats_imregions nucleus_seed cyto_seed cell_seed]     =   process_image(regions,nuc_seed,im_ab,im_mtub,im_er);
    
    if(~isempty(stats_imregions))
        
        % create cell perimeter
        
        perim_thick = 5 ; % defines number of pixels thickness of the perimeter
        bw2         = bwmorph(cell_seed,'erode',perim_thick);
        bw3         = bwmorph(cell_seed,'remove');
        plasmaMem   = bwmorph(bw3,'dilate',perim_thick-2);%imshow((plasmaMem));
        
        % save output images in the output directory
        
        alpha_ch       = plasmaMem*0;
        merge_mask     = alpha_ch;
        max_alpha      = 5000;
        
        alpha_ch(cell_seed>0)                       = 3;
        alpha_ch(cyto_seed>0)                       = 2;
        alpha_ch(nucleus_seed>0&cell_seed>0)        = 1;
        alpha_ch(plasmaMem)                         = 4;
        
        imwrite(double(merge_mask),[out_folder,'/','segmentation.png'],'Alpha',alpha_ch/255);
        
        % merge the output from the image set with other ABs image set data
        % previously analysed (if multiple ABs are included or if analysis is
        % run at the plate level)
        
        size_statsimregions =   size(stats_imregions);
        index_images        =   ones(size_statsimregions(1),1)*i;
        allresults_tab      =   [allresults_tab ;  index_images stats_imregions];
        execution_time(i)   =   cputime - time1;
    else
        exit_code = 1;
        disp('Segmentation error occuring during feature extraction 10x');
        exit(exit_code);
    end
end

% Save whole matlab environment including the output variales in the local
% output directory as a MAT file and as csv only if there is some cell
% segmented

if(numel(allresults_tab)>0)
    
    %save(char([output_folder,'/','matlab_results_wrk_env4.mat']));
    regions_results             =   allresults_tab;
    regions_results(:,22:end)   =   floor(regions_results(:,22:end));
    
    csvwrite([out_folder,'/','features.csv'],regions_results);
else
     exit_code = 1;
     disp('Segmentation error occuring during feature extraction 10x');
     exit(exit_code);
end

%% To add if segmentation of clustered cells need to be optimised 
%% (the path to the source code is already added)
%% Elto Rexhepaj - 

%  % adjusted watersheed segmentation
%     
%     cellbw4_1 = cellsegm.splitcells(BW_mrph(1:700,1:700),1,1);
%             cellbw4_2 = cellsegm.splitcells(BW_mrph(701:end,1:700),1,1);
%             cellbw4_3 = cellsegm.splitcells(BW_mrph(1:700,701:end),1,1);
%             cellbw4_4 = cellsegm.splitcells(BW_mrph(701:end,701:end),1,1);
%             
%             cellbw4 = [cellbw4_1 cellbw4_3;cellbw4_2 cellbw4_4];
%             
%             LB = 50;
%             UB = 1000;
%             Iout = xor(bwareaopen(cellbw4,LB),  bwareaopen(cellbw4,UB));


disp('End');