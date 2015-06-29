function degrees = ANGLE_DEG_2D_TACWrapper( p1, p2, p3 )
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

p1=p1';
p2=p2';
p3=p3';
%*****************************************************************************80
%
%% Based on ANGLE_DEG_2D, Matlab function that returns the angle swept out between two rays in 2D.
%
%  Discussion:
%
%    Except for the zero angle case, it should be true that
%
%      ANGLE_DEG_2D(P1,P2,P3) + ANGLE_DEG_2D(P3,P2,P1) = 360.0
%
%        P1
%        /
%       /
%      /
%     /
%    P2--------->P3
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    04 December 2010
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, real P1(2,1), P2(2,1), P3(2,1), define the rays
%    P1 - P2 and P3 - P2 which in turn define the angle.
%
%    Output, real VALUE, the angle swept out by the rays, measured
%    in degrees.  0 <= VALUE < 360.  If either ray has zero length,
%    then VALUE is set to 0.
%
  p(1,1) = ( p3(1,1) - p2(1,1) ) * ( p1(1,1) - p2(1,1) ) ...
         + ( p3(2,1) - p2(2,1) ) * ( p1(2,1) - p2(2,1) );

  p(2,1) = ( p3(1,1) - p2(1,1) ) * ( p1(2,1) - p2(2,1) ) ...
         - ( p3(2,1) - p2(2,1) ) * ( p1(1,1) - p2(1,1) );

  if ( p(1,1) == 0.0 & p(2,1) == 0.0 )
    radians = 0.0;
    return
  end

  radians = atan2 ( p(2,1), p(1,1) );

  if ( radians < 0.0 )
    radians = radians + 2.0 * pi;
  end

  
  degrees = ( radians / pi ) * 180.0;
  return
end

