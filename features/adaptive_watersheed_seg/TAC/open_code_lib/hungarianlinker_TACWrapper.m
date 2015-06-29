function [   target_indices ] = hungarianlinker_TACWrapper(source, target, max_distance)
%DO NOT EDIT_________________________________________________________________ 
% This file is located in TACTICS open code library.
% All rights reserved to its original authors.
% Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
% Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
% Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer 
% in the documentation and/or other materials provided with the distribution.  
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
% THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
% INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
% OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
% THE POSSIBILITY OF SUCH DAMAGE. 
% Important: This file may include some code editing to enable incorporation with TACTICS Toolbox
% ___________________________________________________________________________ 

% Downloaded from http://www.mathworks.com/matlabcentral/fileexchange/34040-simple-tracker/content/SimpleTracker/hungarianlinker.m, 2012. 
% From Simple Tracker by Jean-Yves Tinevez   <jeanyves.tinevez@gmail.com> , Simple multiple particle tracker with gap closing.
 
 

    if nargin < 3
        max_distance = Inf;
    end

    n_source_points = size(source, 1);
    n_target_points = size(target, 1);
    
    D = NaN(n_source_points, n_target_points);
    
    % Build distance matrix
    for i = 1 : n_source_points
        
        % Pick one source point
        current_point = source(i, :);
        
        % Compute square distance to all target points
        diff_coords = target - repmat(current_point, n_target_points, 1);
        square_dist = sum(diff_coords.^2, 2);
        
        % Store them
        D(i, :) = square_dist;
        
    end
    
    % Deal with maximal linking distance: we simply mark these links as already
    % treated, so that they can never generate a link.
    D ( D > max_distance * max_distance ) = Inf;
    
    % Find the optimal assignment is simple as calling Yi Cao excellent FEX
    % submission.
    [ target_indices total_cost ] = munkres_TACWrapper(D);
    % Set unmatched sources to -1
    target_indices ( target_indices  == 0 ) = -1;
    
    % Collect distances
    target_distances = NaN(numel(target_indices), 1);
    for i = 1 : numel(target_indices)
        if target_indices(i) < 0
            continue
        end
        
        target_distances(i) = sqrt ( D ( i , target_indices(i)) );
        
    end
    
    unassigned_targets = setdiff ( 1 : n_target_points , target_indices );
    
    
end 
 
