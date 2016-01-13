function [featnamepath] = findFeatNameFile(inpath)
%This function finds the location of a feature_names.mat file in the file
%structure. Once one is found, this path is passed back and all the rest
%are ignored. 

featnamepath = [];

filename = 'feature_names.mat';

listdirs = ml_ls(inpath);

featnamelist = listdirs(~cellfun(@isempty,strfind(listdirs,filename)));

if ~isempty(featnamelist)
    featnamepath = [inpath,filesep,featnamelist{1}];
    return
end

%eliminate non-dirs
listdirs(~cellfun(@isdir,strcat([inpath,filesep],listdirs))) = [];
numexperiments = length(listdirs);



%recurse for each directory
for j = 1:numexperiments
    currpath = [inpath,filesep,listdirs{j}]
    featnamepath = findFeatNameFile(currpath);
    if ~isempty(featnamepath)
        return
    end
end