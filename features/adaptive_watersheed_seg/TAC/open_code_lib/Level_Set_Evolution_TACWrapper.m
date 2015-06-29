function [ii]=Level_Set_Evolution_TACWrapper(matrix_in)
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

% This Matlab file demomstrates the level set method in Li et al's paper
%    "Level Set Evolution Without Re-initialization: A New Variational Formulation"
%    in Proceedings of CVPR'05, vol. 1, pp. 430-436.
% Author: Chunming Li, all rights reserved.
% E-mail: li_chunming@hotmail.com
% URL:  http://www.engr.uconn.edu/~cmli/

% clear all;
% close all;
% Img = imread('twocells.bmp');  % The same cell image in the paper is used here
 
 
 
 


[Ix,Iy]=gradient(matrix_in);
f=Ix.^2+Iy.^2;
g=1./(1+f);  % edge indicator function.
epsilon=1.5; % the papramater in the definition of smoothed Dirac function
timestep=50 ;  % time step
mu=0.2/timestep;  % coefficient of the internal (penalizing) energy term P(\phi)
lambda=5; % coefficient of the weighted length term Lg(\phi)
alf=1.5;  % coefficient of the weighted area term Ag(\phi);
[nrow, ncol]=size(matrix_in);  
c0=4;   
initialLSF=c0*ones(nrow,ncol);
w=8;
initialLSF(w+1:end-w, w+1:end-w)=0;  % zero level set is on the boundary of R.  
initialLSF(w+2:end-w-1, w+2: end-w-1)=-c0; % negative constant -c0 inside of R, postive constant c0 outside of R.
u=initialLSF; 
 max_L =10; ii=1;
 while max_L >3
   ii=ii+1  ;
    if ii>200 
            max_L =-1
        end
   u_temp=u;
  [vx,vy]=gradient(g); 
    for k=1:2% numIter 
     [nrow,ncol] = size(u_temp); 
    u_temp([1 nrow],[1 ncol]) = u_temp([3 nrow-2],[3 ncol-2]);  
    u_temp([1 nrow],2:end-1) = u_temp([3 nrow-2],2:end-1);          
    u_temp(2:end-1,[1 ncol]) = u_temp(2:end-1,[3 ncol-2]);        



    [ux,uy]=gradient(u_temp); 
    normDu=sqrt(ux.^2 + uy.^2 + 1e-10);
    Nx=ux./normDu;
    Ny=uy./normDu;
 
  
diracU=(1/2/epsilon)*(1+cos(pi*u_temp/epsilon));
b = (u_temp<=epsilon) & (u_temp>=-epsilon);
diracU = diracU.*b;
    
 
 [nxx,junk]=gradient(Nx);  
[junk,nyy]=gradient(Ny);
K=nxx+nyy;
    weightedLengthTerm=lambda*diracU.*(vx.*Nx + vy.*Ny + g.*K);
    penalizingTerm=mu*(4*del2(u_temp)-K);
    weightedAreaTerm=alf.*diracU.*g;
    u_temp=u_temp+timestep*(weightedLengthTerm + weightedAreaTerm + penalizingTerm);  % update the level set function
    end


    u=u_temp;




          if mod(ii,20)==0
           pause(0.001); 
            D =  u; 
              D(D>0) =-Inf; 
              L = watershed(D); 
%               figure(1)
%                 imagesc(L)
            max_L =max(max(L)) ;
          end
        
 end
 
 pause(0.5)
