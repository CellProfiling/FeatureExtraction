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
    %DPS 2015,10,20 - updated to have the intensity statistics as in the
    %10x pipeline.
    fsets = {...
    ''...
    ; '/original_nuc-as-prot'...
    ; '/nucStats'...
    ; '/nucStats_prot-as-nuc'...
    ; '/original_tub-as-prot'...
    ; '/nucStats_tub-as-nuc'...
    ; '/intensity_wholecell'...
    ; '/intensity_nuc'...
    ; '/intensity_cyto'}
    %; '/total_dapi'};
    %also position stats which are added to the BEGINNING of the feature
    %list 
    fsets = {'position_stats',fsets{:}}';
    fnames = {...
    'position_stats'...
    ;'feature_set1'...
    ;'feature_set2'...
    ;'feature_set3'...
    ;'feature_set4'...
    ;'feature_set5'...
    ;'feature_set6'...
    ;'feature_set7'...
    ;'feature_set8'...
    ;'feature_set9'...
    };

    fsets = [fsets,fnames];
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
    if size(fsets,2)==2
        currind = strcmpi(setnames{i},fsets(:,2));
        currname = fsets{currind,1};
    elseif sum(strcmpi(setnames{i},fsets))==0
        warning('Setname does not match any given pattern, using setname directly')
        currname = setnames{i}
    else
        disp('setname found')
        currname = setnames{i};
    end
    setinds = findstr_cell(totfeatnames,setnames{i},0);
    features = totfeatures(:,setinds);
    featnames = totfeatnames(setinds);
    save([outputdir,filesep,currname,'_splitfeats.mat'],'features','featnames','fsets','setnames','i');
    clear features featnames
end


%Split basic stats 
% feature_set1:nuc:Fraction of protein intensity that overlaps the reference area
%get the signal in nuc,cyto,tot. 
%first load the feature for total fluorescence
%then load the feature for fractional fluorescence in nuc



