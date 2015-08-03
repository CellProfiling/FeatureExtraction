function splitFeatSets(totfeatures,totfeatnames,outputdir,fsets)
%This function splits feature sets calculated in the production. 
%
%INPUTS: 
%features - an nxm matrix where n is the number of observations (cells) and
%m is the number of features. 
%featnames - a 1xm cell array of feature names 
%fsets - a 1xm cell array of the feature sets used in the current production
%pipeline. 
%
%OUTPUTS: 
%
%
%Written by: Devin P Sullivan 31,07,2015

if nargin<4
    %This is the list from get_concatenated_region_features.m (line 51). 
    fsets = {...
    ''...
    ; '/original_nuc-as-prot'...
    ; '/nucStats'...
    ; '/nucStats_prot-as-nuc'...
    ; '/original_tub-as-prot'...
    ; '/nucStats_tub-as-nuc'...
    ; '/total_protein'...
    ; '/total_dapi'};
    %also position stats which are added to the BEGINNING of the feature
    %list 
    fsets = {'position_stats',fsets{:}}';
end 

%if the output place doesn't exist we have to create it
if ~isdir(outputdir)
    mkdir(outputdir)
end


%find feature sets present in the features given 
[setnames,rawfeatnames] = strtok(totfeatnames,':');
rawfeatnames = rawfeatnames(2:end);
setnames = unique(setnames);
%First split all fsets and save them 
for i = 1:length(setnames)
    setinds = findstr_cell(totfeatnames,setnames{i},0);
    features = totfeatures(:,setinds);
    featnames = totfeatnames(setinds);
    save([outputdir,filesep,fsets{i},'_splitfeats.mat'],'features','featnames');
    clear features
end





