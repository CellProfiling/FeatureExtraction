function [myline,mycoords,outmat,X,Y] = bresenham_TACWrapper(mymat,mycoordinates,Value)
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
myline=[];mycoords=[];outmat=[];X=[];Y=[];
% BRESENHAM: Generate a line profile of a 2d image 
%            using Bresenham's algorithm
% [myline,mycoords] = bresenham(mymat,mycoordinates,dispFlag)
%
% - For a demo purpose, try >> bresenham();
%
% - mymat is an input image matrix.
%
% - mycoordinates is coordinate of the form: [x1, y1; x2, y2]
%   which can be obtained from ginput function
%
% - dispFlag will show the image with a line if it is 1
%
% - myline is the output line
%
% - mycoords is the same as mycoordinates if provided. 
%            if not it will be the output from ginput() 
% Author: N. Chattrapiban
%
% Ref: nprotech: Chackrit Sangkaew; Citec
% Ref: http://en.wikipedia.org/wiki/Bresenham's_line_algorithm
% 
% See also: tut_line_algorithm

% if nargin < 1, % for demo purpose
%     pxl = 20;
%     mymat = 1:pxl^2;
%     mymat = reshape(mymat,pxl,pxl);
%     disp('This is a demo.')
% end

% if nargin < 2, % if no coordinate provided
%     imagesc(mymat); axis image;
%     disp('Click two points on the image.')
%     %[mycoordinates(1:2),mycoordinates(3:4)] = ginput(2);
%     mycoordinates = ginput(2);
% end

% if nargin < 3, dispFlag = 1; end

outmat = mymat;
mycoords = mycoordinates;
if isempty(mycoords)==1
    return
end

if sum(mycoords)==0
    return
end

 
x = round(mycoords(:,1));
y = round(mycoords(:,2));
steep = (abs(y(2)-y(1)) > abs(x(2)-x(1)));

if steep, [x,y] = swap(x,y); end

if x(1)>x(2), 
    [x(1),x(2)] = swap(x(1),x(2));
    [y(1),y(2)] = swap(y(1),y(2));
end

delx = x(2)-x(1);
dely = abs(y(2)-y(1));
error = 0;
x_n = x(1);
y_n = y(1);
if y(1) < y(2), ystep = 1; else ystep = -1; end 
for n = 1:delx+1
    if steep,
        myline(n) = mymat(x_n,y_n);
        outmat(x_n,y_n) = Value;
        X(n) = x_n;
        Y(n) = y_n;
    else
        myline(n) = mymat(y_n,x_n);
        outmat(y_n,x_n) = Value;
        X(n) = y_n;
        Y(n) = x_n;
    end    
    x_n = x_n + 1;
    error = error + dely;
    if bitshift(error,1) >= delx, % same as -> if 2*error >= delx, 
        y_n = y_n + ystep;
        error = error - delx;
    end    
end
% % -> a(y,x)
% if dispFlag, imagesc(outmat); end
% %plot(1:delx,myline)

function [q,r] = swap(s,t)
% function SWAP
q = t; r = s;
