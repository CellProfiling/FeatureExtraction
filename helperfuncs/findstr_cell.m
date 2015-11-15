function inds = findstr_cell(strcell,substr,casei)
%This is a short helper function to find the indices of a cell array of
%strings that contain a certain substring
%
%INPUTS:
%strcell - cell array of strings
%substr - substring that you would like to find
%casei - a flag to tell if you would like to do a case insensitive search
%
%OUTPUTS:
%inds - linear indexing of the indicies that 
%
%Written by: Devin P Sullivan 31,07,2015

if nargin<3
    disp('No case option given to findstr_cell, performing case sensitive matching.')
    casei = 0;
end

%If it's case insensitive, just make both lower case
if casei
    strcell = lower(strcell);
    substr = lower(substr);
end

%now perform the find.
inds = find(~cellfun(@isempty,strfind(strcell,substr))>0);