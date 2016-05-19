function add_to_featmat(newfeats,existingmatpath,outputname)
%This function concatenates a pre-existing feature matrix with a new one.
%BE CAREFUL:
%This assumes that the features have the same names and are in the same
%order.
%
%INPUTS:
%newfeats - This is either a feature matrix or a struct containing a
%feature matrix named 'features' and a set of feature names named 'featnames'.
%existingmatpath - this is the path to the existing feature matrix. It is
%assumed to contain at least two items, a matrix 'features', and a cell array
%'featnames'. - if not specified, this item is ignored and only the new
%matrix is saved. 
%outputname - string containing path and name of desired output file. If
%none is provided, this is set to the current working directory and the
%name 'outfeatures.mat'. A warning is displayed informing the user of this.
%
%OUTPUTS: 
%The result of this file is a new file in the 'outputname' containing a
%'features' matrix and 'featnames' cell array. 
%
%
%Written by: 
%Devin P. Sullivan 03,04,2016


if nargin<3
    warning(['no output path given, saving in ',pwd,'as "outfeatures.mat".'])
    
    outputname = [pwd,filesep,'outfeatures.mat'];
end

newfeatnames = [];
newfeatmat = [];
if isstruct(newfeats)
    newfeatmat = newfeats.features;
    newfeatnames = newfeats.featnames;
else
    newfeatmat = newfeats;
end


if nargin<2 || isempty(existingmatpath)
    features = newfeatmat;
    featnames = newfeatnames;
else
    efeats = load(existingmatpath)
    features = [efeats.features;newfeatmat];
    %prefer the old names in case only the matrix for the new features was
    %passed.
    featnames = efeats.featnames;
end

save(outputname,'features','featnames')