
    function [matrix_out]=canny_TACWrapper(matrix)
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

 
 
                 
                    % CANNY - Canny edge detection
%
% Function to perform Canny edge detection. Code uses modifications as
% suggested by Fleck (IEEE PAMI No. 3, Vol. 14. March 1992. pp 337-345)
% 
% 
%
% Returns:      edge strength image (gradient amplitude) 
% Copyright (c) 1999-2003 Peter Kovesi
% School of Computer Science & Software Engineering
% The University of Western Australia
% http://www.csse.uwa.edu.au/
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.

% April 1999    Original version
% January 2003  Error in calculation of d2 corrected


 [rows, cols] = size(matrix);
%  matrix = double(matrix);         % Ensure double 

h =  [  matrix(:,2:cols)  zeros(rows,1) ] - [  zeros(rows,1)  matrix(:,1:cols-1)  ];
v =  [  matrix(2:rows,:); zeros(1,cols) ] - [  zeros(1,cols); matrix(1:rows-1,:)  ];
d1 = [  matrix(2:rows,2:cols) zeros(rows-1,1); zeros(1,cols) ] - ...
                               [ zeros(1,cols); zeros(rows-1,1) matrix(1:rows-1,1:cols-1)  ];
d2 = [  zeros(1,cols); matrix(1:rows-1,2:cols) zeros(rows-1,1);  ] - ...
                               [ zeros(rows-1,1) matrix(2:rows,1:cols-1); zeros(1,cols)   ];

X = h + (d1 + d2)/2.0;
Y = v + (d1 - d2)/2.0;

 matrix_out = sqrt(X.*X + Y.*Y); % Gradient amplitude.
 
 