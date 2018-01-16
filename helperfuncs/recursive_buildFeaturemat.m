function [featmat,expnames,badpaths] = recursive_buildFeaturemat(inpath,featfilename,recursiveind,includecellindex,removeedgecells,start_col)
%This function takes a file output structure, finds the features.csv files
%for each experiment, splits the features and compiles the desired features
%into a single feature matrix
%
%INPUTS:
%inpath - string containing the path to your master folder that
%contains the feature files.
%featfilename - string specifying what the name of the file we are looking
%for is. Here we expect a .csv file as outputed by the feature extraction.
%The default is 'features.csv'
%recursiveind - this is a simple housekeeping argument and can be ignored. 
%includecellindex - if true, the expnames will include a cell index as well
%
%OUTPUTS:
%featmat - a single feature matrix with an index list per-experiment in the
%first column
%expnames - cell array of experiment names for future reference
%badpaths - cell array of bad experiments that failed
%
%Written by: Devin P Sullivan January 13, 2016
%Edited by:
%D. Sullivan 03,04,2016 - added "badpath" output for experiments that have
%a bad feature matrix size
%
%C. Winsnes 12,09,2016 - Added includecellindex input to have cell ids.


badpaths = {};
badpathstmp2 = {};
if nargin<2
    featfilename = 'features.csv';
end

if nargin<3 || isempty(recursiveind)
    recursiveind = 1;
end

if nargin<4 || isempty(includecellindex)
    includecellindex = 0;
end

if nargin<5 || isempty(removeedgecells)
    removeedgecells = 1;
end

if nargin<6 || isempty(start_col)
    start_col = [];
end

listdirs = ml_ls(inpath);

% [~,~,filetype] = fileparts(featfilename);

%first check if any of the files found are the images we are looking for
featfilelist = listdirs(~cellfun(@isempty,strfind(listdirs,featfilename)));

% filelist = filelist(~cellfun(@isempty,strfind(listdirs,submitstruct.extensions{2})));
featmat = [];
expnames = {};
for i = 1:length(featfilelist)
      currpath = [inpath,filesep,featfilelist{i}];
      currinfolders = strsplit(currpath,filesep);
      currimgname = currinfolders{end-1};
      
      %Check if file is empty
      currinfo = dir(currpath);
      if currinfo.bytes==0
          fprintf(['No data found in:',currpath,' \n skipping for now.\n'])
          continue
      end
      
      if ~isempty(start_col)
          currfeats = csvread(currpath,0,start_col);
      else
          currfeats = csvread(currpath);
      end
%       currsegpath = [inpath,filesep,strrep(featfilelist{i},'features.csv','segmentation.png'];
%       [currseg,map,currtrans] = imread(currsegpath);
      
      featmat = [featmat;currfeats];
      if includecellindex
        f = @(index) strcat(currinfolders{end-2}, '_', currimgname, '_', num2str(index));

        cellnames = arrayfun(f, transpose(1:size(featmat,1)), 'UniformOutput', 0);
        expnames = [expnames; cellnames];
      else
        expnames = [expnames;repmat({[currinfolders{end-2},'_',currimgname]},size(featmat,1),1)];
      end

end


%eliminate non-dirs
listdirs(~cellfun(@isdir,strcat([inpath,filesep],listdirs))) = [];
numexperiments = length(listdirs)



%recurse for each directory
newrecursiveind = recursiveind+1;
for j = 1:numexperiments
    currpath = [inpath,filesep,listdirs{j}]
   
    [featmattmp,expnamestmp,badpathstmp] = recursive_buildFeaturemat(currpath,featfilename,newrecursiveind,includecellindex,removeedgecells,start_col);
    if size(featmattmp,2)~=size(featmat,2) && (size(featmat,2)~=0 && size(featmattmp,2)~=0)
        warning(['something is wrong with the matrix for image ',currpath,...
            ' its size is ',size(featmattmp)])
%         badpathstmp2 = [badpaths,currpath];
        badpaths = [badpaths;badpathstmp;currpath];
    else
        featmat = [featmat;featmattmp];
        expnames = [expnames;expnamestmp];
    end
end
