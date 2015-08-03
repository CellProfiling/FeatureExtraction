function [featuresunique,names_unique] = removeFeatReplicates(features,featnames)
%This function takes a feature matrix and returns only unique columns
%(feature values)
%
%INPUTS: 
%features - an nxm matrix where n is the number of observations (cells) and
%m is the number of features. 
%featnames - a 1xm cell array of feature names 
%
%OUTPUTS:
%featuresunique - an nx(m-r) matrix where r is the number of replicates
%removed from the feature matrix
%names_unique - a 1x(m-r) cell array of unique feature names 
%
%Written by: Devin P. Sullivan 

%There are two ways to find unique features,
%1. By feature value
%2. By feature name
%The advantage of type 1 is that you do not eliminate features with unique
%values. If values are not unique and the names are we will have to choose
%a name. 
%I will also check type 2 to make sure that features get unique names. If
%names are not unique and the values are then we will assign a new name to
%the duplicate name to ensure unique names 

%Convert to cell
featcell = num2cell(features',2);
featsstr = num2str(features');
featcellstr = cellstr(featsstr);
%separate only names from feature sets 
[fsets,fnames] = strtok(featnames,':');
%append the feature names to cell array 
featvals_w_names=[char(featcellstr),char(fnames)];
[uniquevals,indsu,indsorig] = unique(featvals_w_names,'rows');

%Get numeric values and new names
featuresunique = features(:,indsu);
names_unique = strcat('fsetmerged',fnames(indsu));



% %First get all the unique feature values. 
% [ufeatvals,ia,ic] = unique(features','rows');
% 
% %Then sort them
% [indsu,indsorig] = sort(ic);
% 
% %Then test where the sorted inds are equal
% indsu2 = [indsu(2:end);NaN];
% indsu3 = [NaN;indsu(1:end-1)];
% repfeatsL = [indsu==indsu2];
% repfeatsR = [indsu==indsu3];
% repfeats = (repfeatsL+repfeatsR)>0;
% 
% indsreporig = indsorig(repfeats);
% 
% %get the names of the replicated features 
% repnames = featnames(indsreporig);
% %split the names into parts 
% [repsetname,repnameonly] = strtok(repnames,':');
% 
% %because these are sorted, we should see that the names with the same
% %values are next to each other
% %figure out if the names are also matching 
% featsleft = 1;
% while featsleft>0
%     
%     %if both the feature value and name are the same, remove the feature 
%     if all(features(:,indsreporig(i))==features(:,indsreporig(i+1)))
%        if strcmpi(repnameonly(i),repnameonly(i+1))
%            disp('Replicate features found, eliminating duplicates with the name ',repnameonly{i})
%            fname2{i} = 
%        end
%         
%     end
%     
% end
 












