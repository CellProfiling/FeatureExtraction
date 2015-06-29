function [regionStats obj_labels_nuc obj_labels_cyto obj_labels_cells] = process_image(regions,nuc_seed,ab_ch,mtub_ch,er_ch)

% regions is the the input binary image of the for the cell masks.
%
% nuc_seed is the the input binary image of the for the nuclei masks.
%
% ab_ch is the raw IF pixels values from the antibody channel
%
% mtub_ch is the raw IF pixels values from the mtubulin channel
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

% Define local variables

regionStats         =   [];
obj_labels_nuc      =   [];
obj_labels_cyto     =   [];
obj_labels_cells    =   [];

obj_connectivity    = 4;
obj_labels_cells    = bwlabeln(regions,obj_connectivity);
obj_labels_nuc      = bwlabeln(nuc_seed,obj_connectivity);

obj_labels_cyto     = obj_labels_cells;
field_imdummy       = zeros(size(regions));
mas_nuc             = 1-regions;

if(max(obj_labels_cells(:))>1)
    
    obj_labels_cyto(nuc_seed==1)=   0;
    
    [B3,I3,J3]  = unique(obj_labels_cyto);
    
    filt_cell                   =   (~ismember(obj_labels_cells(:),B3(2:end)));
    obj_labels_cells(filt_cell) =   0;
    
    filt_cell                       =   obj_labels_cells;
    filt_cell(obj_labels_cyto>0)    =   0;
    obj_labels_nuc                  =   filt_cell;
    
    stats_props =  {'Centroid','PixelValues','BoundingBox','Area'};
    
    % match sub-cell labels for the same cells
    
    obj_labels_nuc(obj_labels_nuc>0)        =   obj_labels_cells(obj_labels_nuc>0);
    
    % compute IF stats nucleus
    
    STATS_NUC_ER   = struct2cell(regionprops(obj_labels_nuc, er_ch, stats_props));
    STATS_NUC_MTUB = struct2cell(regionprops(obj_labels_nuc, mtub_ch, stats_props));
    STATS_NUC_AB   = struct2cell(regionprops(obj_labels_nuc, ab_ch, stats_props));
    
    STATS_CELL_ER   = struct2cell(regionprops(obj_labels_cells, er_ch,stats_props));
    STATS_CELL_MTUB = struct2cell(regionprops(obj_labels_cells, mtub_ch,stats_props));
    STATS_CELL_AB   = struct2cell(regionprops(obj_labels_cells, ab_ch, stats_props));
    
    STATS_CYTO_ER   = struct2cell(regionprops(obj_labels_cyto, er_ch,stats_props));
    STATS_CYTO_MTUB = struct2cell(regionprops(obj_labels_cyto, mtub_ch,stats_props));
    STATS_CYTO_AB   = struct2cell(regionprops(obj_labels_cyto, ab_ch,stats_props));
    
    area_filt       = cell2mat(STATS_NUC_MTUB(1,:));
    
    % Filter all small (i.e. Areaa<50px) and extremely large objects (area_filt>1000)
    
    cell_filt_indx  = find(area_filt>50 & area_filt<1000);
    
    STATS_NUC_ER = STATS_NUC_ER(:,cell_filt_indx);
    STATS_NUC_MTUB = STATS_NUC_MTUB(:,cell_filt_indx);
    STATS_NUC_AB = STATS_NUC_AB(:,cell_filt_indx);
    STATS_CELL_ER = STATS_CELL_ER(:,cell_filt_indx);
    STATS_CELL_MTUB = STATS_CELL_MTUB(:,cell_filt_indx);
    STATS_CELL_AB = STATS_CELL_AB(:,cell_filt_indx);
    STATS_CYTO_ER = STATS_CYTO_ER(:,cell_filt_indx);
    STATS_CYTO_MTUB = STATS_CYTO_MTUB(:,cell_filt_indx);
    STATS_CYTO_AB = STATS_CYTO_AB(:,cell_filt_indx);
    
    % measure average intensity values on the antibody channel
    
    nuc_avg_int_ab      =   cellfun(@mean,STATS_NUC_AB(4,:))';
    cell_avg_int_ab     =   cellfun(@mean,STATS_CELL_AB(4,:))';
    cyto_avg_int_ab     =   cellfun(@mean,STATS_CYTO_AB(4,:))';
    
    % measure average intensity values on the microtubule channel
    
    nuc_avg_int_mtub    =   cellfun(@mean,STATS_NUC_MTUB(4,:))';
    cell_avg_int_mtub   =   cellfun(@mean,STATS_CELL_MTUB(4,:))';
    cyto_avg_int_mtub   =   cellfun(@mean,STATS_CYTO_MTUB(4,:))';
    
    % measure average intensity values on the ER channel
    
    nuc_avg_int_er    =   cellfun(@mean,STATS_NUC_ER(4,:))';
    cell_avg_int_er   =   cellfun(@mean,STATS_CELL_ER(4,:))';
    cyto_avg_int_er   =   cellfun(@mean,STATS_CYTO_ER(4,:))';
    
    % measure total intensity values on the ab channel
    
    nuc_tot_int_ab      =  cellfun(@sum,STATS_NUC_AB(4,:))';
    cell_tot_int_ab     =  cellfun(@sum,STATS_CELL_AB(4,:))';
    cyto_tot_int_ab     =  cellfun(@sum,STATS_CYTO_AB(4,:))';
    
    % measure total intensity values on the mtub channel
    
    nuc_tot_int_mtub    =   cellfun(@sum,STATS_NUC_MTUB(4,:))';
    cell_tot_int_mtub   =   cellfun(@sum,STATS_CELL_MTUB(4,:))';
    cyto_tot_int_mtub   =   cellfun(@sum,STATS_CYTO_MTUB(4,:))';
    
    % measure total intensity values on the er channel
    
    nuc_tot_int_er    =   cellfun(@sum,STATS_NUC_ER(4,:))';
    cell_tot_int_er   =   cellfun(@sum,STATS_CELL_ER(4,:))';
    cyto_tot_int_er   =   cellfun(@sum,STATS_CYTO_ER(4,:))';
    
    size_results            =   size(cyto_tot_int_er);
    position_stats          =   zeros(size_results(1,1),6);
    position_stats(:,1:2)   =   reshape(cell2mat(STATS_NUC_AB(2,:)),2,size_results(1,1))';
    position_stats(:,3:6)   =   reshape(cell2mat(STATS_NUC_AB(3,:)),4,size_results(1,1))';
    
    % Rounding the (x.y) corner of the bounding box to the nearest right
    % TopLeftPixels .i.e +0.5
    
    position_stats(:,3:6)   = position_stats(:,3:6) +0.5;
    
    regionStats             =   [nuc_avg_int_ab cyto_avg_int_ab cell_avg_int_ab ...
        nuc_avg_int_er cyto_avg_int_er cell_avg_int_er ...
        nuc_avg_int_mtub cyto_avg_int_mtub cell_avg_int_mtub ...
        nuc_tot_int_ab cyto_tot_int_ab cell_tot_int_ab ...
        nuc_tot_int_er cyto_tot_int_er cell_tot_int_er ...
        nuc_tot_int_mtub cyto_tot_int_mtub cell_tot_int_mtub ...
        position_stats];
    
end