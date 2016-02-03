function [outfeats,outnames] = getUniqueFeats(infeats,innames)
%This helper function combines non-unique features
%This code assumes the features are arranged such that each row is an
%observation and each column is a feature
%
%Written by: Devin P Sullivan 2015-09-09

%Remove any nan and inf values 
%Remove any NaNs
nanvals = ~isnan(sum(infeats,1));
features = infeats(:,nanvals);
names = innames(nanvals);


%Remove any infs
infvals = ~isinf(sum(features,1));
features = features(:,infvals);
names = names(infvals);

%Remove values with no variance 
varfeats = var(features);
if sum(varfeats==0)>0
    warning(['Some features have no varience. Removing those. ',...
        'This may be due to a missing image channel (er), ',...
        'or an error in feature calculation. Check yourself before you wreck yourself.'])
    
    keepinds = varfeats~=0;
    features = features(:,keepinds);
    removed_novarnames = names(~keepinds);
    names = names(keepinds);
    
end

%get the unique feature locations 
[ufeats,ia,ic] = unique(features','rows');

%make sure we actually have to do some work. If not, don't do it! 
if size(ufeats,1)==size(features,2)
    disp('All feature values were unique. returning original data.')
    outfeats = features;
    outnames = names;
    return
end

%loop through the unique values and combine the names appropriately
outnames = cell(1,length(ia));
for i = 1:length(ia)
    originds = find(ic==i);
    if length(originds)>1
        disp('multiple features match');
        checkme = 1
        [FS,fname] = strtok(names(originds),':');
%         [compartment,fnamewocompartment] = strtok(fname,'_');
        contains_er = cellfun(@(x)strcmpi(x(2:3),'er'),fname);
%         contains_er = cellfun(@(x)strcmpi(x(2:end),'er'),compartment);% - this regular expression doesn't work because some features are 'er_' and others are 'er:'
        if any(contains_er)
            disp('er feature detected, removing feature as no er channel was given for cellcycle data. Double check this is true for your data')
            outnames{i} = strjoin(innames(originds(~contains_er)),'--');%this will still join names if there are greater than 1 duplicate that is non-er
        else
            
            warning('merging feature values.')
            %If all the feature names are identical, we can just save
            %FS--FS: featurename
            if all(strcmpi(fname{1},fname))
                outnames{i} = [strjoin(FS,'&'),fname{1}];
            else
                outnames{i} = strjoin(innames(originds),'--');
                hmmm = 1
            end
            innames(originds)'
%             outnames{i} = strjoin(innames(originds),'--');
        end
       
    else
        outnames{i} = names{originds};
    end
end

outfeats = ufeats';