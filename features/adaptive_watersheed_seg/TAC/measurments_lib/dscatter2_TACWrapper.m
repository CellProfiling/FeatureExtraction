% ----------------------------------------------------------------------------------------------------------
% Created as part of TACTICS v2.x Toolbox under BSD License
% TACTICS (Totally Automated Cell Tracking In Confinement Systems) is a Matlab toolbox for High Content Analysis (HCA) of fluorescence tagged proteins organization within tracked cells. It designed to provide a platform for analysis of Multi-Channel Single-Cell Tracking and High-Trough Output Quantification of Imaged lymphocytes in Microfabricated grids arrays.
% We wish to make TACTICS V2.x available, in executable form, free for academic research use distributed under BSD License.
% IN ADDITION, SINCE TACTICS USE THIRD OPEN-CODE LIBRARY (I.E TRACKING ALGORITHEMS, FILTERS, GUI TOOLS, ETC) APPLICABLE ACKNOLEDMENTS HAVE TO BE SAVED TO ITS AUTHORS.
% ----------------------------------------------------------------------------------------------------------
% Copyright (c) 2010-2013, Raz Shimoni
% All rights reserved.
% Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
% Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
% Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
% ----------------------------------------------------------------------------------------------------------
%
% NOTES-
% Although TACTICS is free it does require Matlab commercial license.
% We do not expect co-authorship for any use of TACTICS. However, we would appreciate if TACTICS would be mentioned in the acknowledgments when it used for publications and/or including the next citation: [enter our Bioinformatics]
% We are looking for collaborations and wiling to setup new components customized by the requirements in exchange to co-authorship.
%  Support and feedbacks
% TACTICS is supported trough Matlab file exchange forums or contact us directly. Updates are expected regularly. We are happy to accept any suggestions to improve the automation capability and the quality of the analysis.
%
% For more information please contact:
% Centre for Micro-Photonics (CMP)
% The Faculty of Engineering and Industrial Sciences (FEIS)
% Swinburne University of Technology, Melbourne, Australia
% URL: http://www.swinburne.edu.au/engineering/cmp/
% Email: RShimoni@groupwise.swin.edu.au
% ----------------------------------------------------------------------------------------------------------
% Note for developers- Future version will include better structure and documentation.
% Sorrry, Raz.
% Code starts here:
function [X,Y,msize,col,marker] = dscatter2_TACWrapper(X,Y )
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
% THE POSSIBILITY OF SUCH DAMAGE. .
% Important: This file may include some code editing to enable incorporation with TACTICS Toolbox
% ___________________________________________________________________________
%   dscatter2_TACWrapper code was extracted from DSCATTER function
%   DSCATTER creates a scatter plot coloured by density.
%
%   DSCATTER(X,Y) creates a scatterplot of X and Y at the locations
%   specified by the vectors X and Y (which must be the same size), colored
%   by the density of the points.
%
%   DSCATTER(...,'MARKER',M) allows you to set the marker for the
%   scatter plot. Default is 's', square.
%
%   DSCATTER(...,'MSIZE',MS) allows you to set the marker size for the
%   scatter plot. Default is 10.
%
%   DSCATTER(...,'FILLED',false) sets the markers in the scatter plot to be
%   outline. The default is to use filled markers.
%
%   DSCATTER(...,'PLOTTYPE',TYPE) allows you to create other ways of
%   plotting the scatter data. Options are "surf','mesh' and 'contour'.
%   These create surf, mesh and contour plots colored by density of the
%   scatter data.
%
%   DSCATTER(...,'BINS',[NX,NY]) allows you to set the number of bins used
%   for the 2D histogram used to estimate the density. The default is to
%   use the number of unique values in X and Y up to a maximum of 200.
%
%   DSCATTER(...,'SMOOTHING',LAMBDA) allows you to set the smoothing factor
%   used by the density estimator. The default value is 20 which roughly
%   means that the smoothing is over 20 bins around a given point.
%
%   DSCATTER(...,'LOGY',true) uses a log scale for the yaxis.
%
%   Examples:
%
%       [data, params] = fcsread('SampleFACS');
%       dscatter(data(:,1),10.^(data(:,2)/256),'log',1)
%       % Add contours
%       hold on
%       dscatter(data(:,1),10.^(data(:,2)/256),'log',1,'plottype','contour')
%       hold off
%       xlabel(params(1).LongName); ylabel(params(2).LongName);
%
%   See also FCSREAD, SCATTER.

% Copyright 2003-2004 The MathWorks, Inc.
% $Revision:  $   $Date:  $

% Reference:
% Paul H. C. Eilers and Jelle J. Goeman
% Enhancing scatterplots with smoothed densities
% Bioinformatics, Mar 2004; 20: 623 - 628.
if  size(X,2)> size(X,1)
    X=X';
end
if  size(Y,2)> size(Y,1)
    Y=Y';
end



lambda = [];
nbins = [];
plottype = 'scatter';
contourFlag = false;
msize = 10;
marker = 's';
logy = false;
filled = true;


minx = min(X,[],1);
maxx = max(X,[],1);
miny = min(Y,[],1);
maxy = max(Y,[],1);

if isempty(nbins)
    nbins = [min(numel(unique(X)),200) ,min(numel(unique(Y)),200) ]
end
nbins=[100    100  ];

if isempty(lambda)
    lambda = 15;
end

edges1 = linspace(minx, maxx, nbins(1)+1);
ctrs1 = edges1(1:end-1) + .5*diff(edges1);
edges1 = [-Inf edges1(2:end-1) Inf];
edges2 = linspace(miny, maxy, nbins(2)+1);
ctrs2 = edges2(1:end-1) + .5*diff(edges2);
edges2 = [-Inf edges2(2:end-1) Inf];

[n,p] = size(X);
bin = zeros(n,2);
% Reverse the columns to put the first column of X along the horizontal
% axis, the second along the vertical.
[dum,bin(:,2)] = histc(X,edges1);
[dum,bin(:,1)] = histc(Y,edges2);
H = accumarray(bin,1,nbins([2 1])) ./ n;
G = smooth1D(H,nbins(2)/lambda);
F = smooth1D(G',nbins(1)/lambda)';







F = F./max(F(:));
ind = sub2ind(size(F),bin(:,1),bin(:,2));
col = F(ind);


function Z =  smooth1D(Y,lambda)

[m,n] = size(Y);
E = eye(m);
D1 = diff(E,1);
D2 = diff(D1,1);
P = lambda.^2 .* D2'*D2 + 2.*lambda .* D1'*D1;
Z = (E + P) \ Y;


