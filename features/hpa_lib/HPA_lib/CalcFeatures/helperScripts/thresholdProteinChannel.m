function protstruct = thresholdProteinChannel(protstruct,optimize,protein_channel_blank)
%This function applies the standard thresholding procedure to the protein
%channel and updates the structure corresponding with this channel 
%
%INPUTS: 
%protstruct - a struct containing the standard fields listed below
%optimize - a flag of whether to optimize results 
%protein_channel_blank - a flag that indicates that we already know the
%protein channel does not contain fluorescence (for any region). 
%
%OUTPUTS: 
%protstruct - a struct with the following fields updated
%  channel_thr - the threshold of the 'channel' field chosen by graythresh
%  channel_mthr - a secondary threshold above the 'channel_thr' as determined
%by graythresh
%  channel_fg - uint intensity valued foreground for the 'channel' field
%greater than 'channel_thr', filtered to have a certain size
%  channel_objectsizes - array of object sizes found in 'channel_fg'
%  channel_mfg - uint intensity valued "super"foreground of the 'channel'
%field greater than the 'channel_mthr' field
%  channel_mobjectsizes - array of object sizes found in 'channel_mfg'
%  channel_large_fg - foreground only including objects greater than
%1/(fract_large) of the largest foreground object from 'channel_fg' 
%  channel_large_objectsizes - array of object sizes found in
%'channel_large_fg'
%  channel_large_mfg - foreground only including objects greater than
%1/(fract_large) of the largest foreground object from 'channel_mfg' 
%  channel_large_mobjectsizes - array of object sizes found in
%'channel_large_mfg'
%
%Written by: ???
%
%Edited by: 
%Devin P Sullivan 29,07,2015 - changed from script to function, pulled out
%parameters and documented for clarity

if nargin<2 || isempty(optimize)
    optimize = 1;
end

if nargin<3 || isempty(protein_channel_blank)
    protein_channel_blank = 0;
end


%DPS 29,07,2015 - pulled out parameters 
%Parameters:
%number to multiply the threshold from graythresh by
uintmax = 255;%this needs to be changed if using uint16 images 
%minimum area of objects kept in 'channel_fg'
minobjarea = 5;
%fraction of the largest object kept in 'channel_large_fg'
fract_large = 5;

if isempty(protstruct.channel_thr)
  tmp_prot = protstruct.channel;

% $$$   if optimize && protein_channel_blank
% $$$     tmp_prot = zeros(2, 2);
% $$$   end
  if optimize && protein_channel_blank
  else
      
    protstruct.channel_thr = graythresh( ...
        tmp_prot(tmp_prot>min(tmp_prot(:))))*uintmax;

    protstruct.channel_mthr = graythresh( ...
        tmp_prot(tmp_prot>protstruct.channel_thr))*uintmax;

    protstruct.channel_fg = tmp_prot;
    protstruct.channel_fg(tmp_prot<=protstruct.channel_thr) = 0;

    protstruct.channel_mfg = tmp_prot;
    protstruct.channel_mfg(tmp_prot<=protstruct.channel_mthr) = 0;



    tmp_bwl = bwlabel(protstruct.channel_fg>0, 4);
    
    tmp_props = regionprops(tmp_bwl,'Area');
    tmp_stats = zeros(length(tmp_props),1);
    for j = 1:length(tmp_props)
        tmp_stats(j,:) = tmp_props(j).Area;
    end

    %DPS 29,07,2015 - pulled out parameter for minimum object area
%     tmp_idx = find(tmp_stats>5);
    tmp_idx = find(tmp_stats>minobjarea);
    tmp_bw = ismember(tmp_bwl, tmp_idx);
    protstruct.channel_fg(~tmp_bw) = 0;
    protstruct.channel_objectsizes = tmp_stats(tmp_idx);


    tmp_idx = find(tmp_stats>max(tmp_stats(:))/fract_large);
    tmp_bw = ismember(tmp_bwl, tmp_idx);
    protstruct.channel_large_fg = tmp_prot;
    protstruct.channel_large_fg(~tmp_bw) = 0;
    
    tmp_bwl = bwlabel(tmp_bw, 4);
    
    %DPS 29,07,2015 - changed based on matlab suggestion to use less memory
    tmp_props = regionprops(tmp_bwl,'Area');
%     tmp_props = regionprops(logical(tmp_bwl),'Area');
    tmp_stats = zeros(length(tmp_props),1);
    for j = 1:length(tmp_props)
        tmp_stats(j,:) = tmp_props(j).Area;
    end

    protstruct.channel_large_objectsizes = tmp_stats;



    tmp_bwl = bwlabel(protstruct.channel_mfg>0, 4);
    
    %DPS 29,07,2015 - changed based on matlab suggestion to use less memory
    tmp_props = regionprops(tmp_bwl,'Area');
%     tmp_props = regionprops(logical(tmp_bwl),'Area');
    tmp_stats = zeros(length(tmp_props),1);
    for j = 1:length(tmp_props)
        tmp_stats(j,:) = tmp_props(j).Area;
    end

    tmp_idx = find(tmp_stats>minobjarea);
    tmp_bw = ismember(tmp_bwl, tmp_idx);
    protstruct.channel_mfg(~tmp_bw) = 0;
    protstruct.channel_mobjectsizes = tmp_stats(tmp_idx);


    tmp_idx = find(tmp_stats>max(tmp_stats(:))/fract_large);
    tmp_bw = ismember(tmp_bwl, tmp_idx);
    protstruct.channel_large_mfg = tmp_prot;
    protstruct.channel_large_mfg(~tmp_bw) = 0;
    
    tmp_bwl = bwlabel(tmp_bw, 4);
    
      %DPS 29,07,2015 - changed based on matlab suggestion to use less memory
    tmp_props = regionprops(tmp_bwl,'Area');
%     tmp_props = regionprops(logical(tmp_bwl),'Area');
    tmp_stats = zeros(length(tmp_props),1);
    for j = 1:length(tmp_props)
        tmp_stats(j,:) = tmp_props(j).Area;
    end

    protstruct.channel_large_mobjectsizes = tmp_stats;

    %DPS 28,07,2015 - Adding a check if the region has a forground. 
    %Have I mentioned I REALLY HATE invisible variable
    %passing. It has to be the dumbest and hardest to follow thing you can
    %do.
    %A
    if max(protstruct.channel_fg(:))==0
        warning('No foreground found for protein channel! This will cause some NaN values and this region should probably be discarded')
    end
  end
  
end
