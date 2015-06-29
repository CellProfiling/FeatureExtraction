function constidx=ml_constidx(X)

%ML_CONSTIDX find columns with constant values in a matrix
%   CONSTIDX=ML_CONSTIDX(X) returns a vector of indices of 
%   columns with all elements identical in X

% Copyright (C) 2006  Murphy Lab
% Carnegie Mellon University
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published
% by the Free Software Foundation; either version 2 of the License,
% or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
% 02110-1301, USA.
%
% For additional information visit http://murphylab.web.cmu.edu or
% send email to murphy@cmu.edu

% An alternative way
% minX=min(X,[],1);
% maxX=max(X,[],1);
% constidx=find(minX==maxX)

varX=sum(abs(X(1:end-1,:)-X(2:end,:)),1);
constidx=find(varX==0);
