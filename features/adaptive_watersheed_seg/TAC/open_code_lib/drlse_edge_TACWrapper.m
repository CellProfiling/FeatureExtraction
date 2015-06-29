function matrix_out = drlse_edge_TACWrapper(matrix_in,iter_outer,handles )
%%DO NOT EDIT_________________________________________________________________ 
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
% HOUGHCIRCLES detects multiple disks (coins) in an image using Hough
if nargin==1
    iter_outer=40;
end%   This Matlab code implements an edge-based active contour model as an
%  application of the Distance Regularized Level Set Evolution (DRLSE) formulation in Li et al's paper:
%
%      C. Li, C. Xu, C. Gui, M. D. Fox, "Distance Regularized Level Set Evolution and Its Application to Image Segmentation", 
%        IEEE Trans. Image Processing, vol. 19 (12), pp.3243-3254, 2010.
%
%  Input:
%      phi_0: level set function to be updated by level set evolution
%      g: edge indicator function
%      mu: weight of distance regularization term
%      timestep: time step
%      lambda: weight of the weighted length term
%      alfa:   weight of the weighted area term
%      epsilon: width of Dirac Delta function
%      iter: number of iterations
%      potentialFunction: choice of potential function in distance regularization term. 
%              As mentioned in the above paper, two choices are provided: potentialFunction='single-well' or
%              potentialFunction='double-well', which correspond to the potential functions p1 (single-well) 
%              and p2 (double-well), respectively.%
%  Output:
%      phi: updated level set function after level set evolution
%
% Author: Chunming Li, all rights reserved
% E-mail: lchunming@gmail.com   
%         li_chunming@hotmail.com 
% URL:  http://www.engr.uconn.edu/~cmli/

  
  
 


 matrix_in=double(matrix_in); 
 sigma=1.5;     % scale parameter in Gaussian kernel
G=fspecial('gaussian',15,sigma);
 matrix_in=conv2( matrix_in,G,'same');  % smooth image by Gaussiin convolution
  
 
[Ix,Iy]=gradient( matrix_in);
f=Ix.^2+Iy.^2;
g=1./(1+f);  % edge indicator function. 
epsilon=  1.5; % the papramater in the definition of smoothed Dirac function
timestep= 5 ;  % time step
mu=0.2/timestep;  % coefficient of the internal (penalizing) energy term P(\phi)
lambda=5; % coefficient of the weighted length term L(phi)c
c0= 2;   
initialLSF=c0*ones(size( matrix_in));
w=4;
initialLSF(w+1:end-w, w+1:end-w)=0;  % zero level set is on the boundary of R.  
initialLSF(w+2:end-w-1, w+2: end-w-1)=-c0; % negative constant -c0 inside of R, postive constant c0 outside of R.
u=initialLSF; 
phi=initialLSF; 
alfa= 1.5;  % coefficient of the weighted area term A(phi)

iter_inner=5;  

potential=2;  
if potential ==1
    potentialFunction = 'single-well';  % use single well potential p1(s)=0.5*(s-1)^2, which is good for region-based model 
elseif potential == 2
    potentialFunction = 'double-well';  % use double-well potential in Eq. (16), which is good for both edge and region based models
else
    potentialFunction = 'double-well';  % default choice of potential function
end




 
if nargin==3
% start level set evolution
for n=1:iter_outer
    phi = drlse_edge2(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);
    if mod(n,2)==0 
        axes(handles.axes2);cla
        imagesc( matrix_in,[0, 255]); axis off; axis equal;    hold on;  contour(phi, [0,0], 'k');
    end
end
else
% start level set evolution
for n=1:iter_outer
    phi = drlse_edge2(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);
    if mod(n,2)==0 
        axes(handles.axes2);cla
        imagesc( matrix_in,[0, 255]); axis off; axis equal;   hold on;  contour(phi, [0,0], 'k');
    end
end
end
% refine the zero level contour by further level set evolution with alfa=0
alfa=0;
iter_refine = 10;
phi = drlse_edge2(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);

finalLSF=phi;
if nargin==3
axes(handles.axes2);cla
imagesc( matrix_in,[0, 255]); axis off; axis equal;   hold on;  contour(phi, [0,0], 'k');
hold on;  contour(phi, [0,0], 'r');
str=['Final zero level contour, ', num2str(iter_outer*iter_inner+iter_refine), ' iterations'];title(str);
end
  
[ xy,~]=contour(phi, [0,0]); 
matrix_out=zeros(size(matrix_in)); 
matrix_out= roipoly(matrix_out,xy(1,:),xy(2,:)); 
 
function phi = drlse_edge2(phi_0, g, lambda,mu, alfa, epsilon, timestep, iter, potentialFunction)
%  
phi=phi_0;
[vx, vy]=gradient(g);
for k=1:iter
    phi=NeumannBoundCond(phi);
    [phi_x,phi_y]=gradient(phi);
    s=sqrt(phi_x.^2 + phi_y.^2);
    smallNumber=1e-10;  
    Nx=phi_x./(s+smallNumber); % add a small positive number to avoid division by zero
    Ny=phi_y./(s+smallNumber);
    curvature=div(Nx,Ny);
    if strcmp(potentialFunction,'single-well')
        distRegTerm = 4*del2(phi)-curvature;  % compute distance regularization term in equation (13) with the single-well potential p1.
    elseif strcmp(potentialFunction,'double-well');
        distRegTerm=distReg_p2(phi);  % compute the distance regularization term in eqaution (13) with the double-well potential p2.
    else
        disp('Error: Wrong choice of potential function. Please input the string "single-well" or "double-well" in the drlse_edge function.');
    end        
    diracPhi=Dirac(phi,epsilon);
    areaTerm=diracPhi.*g; % balloon/pressure force
    edgeTerm=diracPhi.*(vx.*Nx+vy.*Ny) + diracPhi.*g.*curvature;
    phi=phi + timestep*(mu*distRegTerm + lambda*edgeTerm + alfa*areaTerm);
end


function f = distReg_p2(phi)
% compute the distance regularization term with the double-well potential p2 in eqaution (16)
[phi_x,phi_y]=gradient(phi);
s=sqrt(phi_x.^2 + phi_y.^2);
a=(s>=0) & (s<=1);
b=(s>1);
ps=a.*sin(2*pi*s)/(2*pi)+b.*(s-1);  % compute first order derivative of the double-well potential p2 in eqaution (16)
dps=((ps~=0).*ps+(ps==0))./((s~=0).*s+(s==0));  % compute d_p(s)=p'(s)/s in equation (10). As s-->0, we have d_p(s)-->1 according to equation (18)
f = div(dps.*phi_x - phi_x, dps.*phi_y - phi_y) + 4*del2(phi);  

function f = div(nx,ny)
[nxx,~]=gradient(nx);  
[~,nyy]=gradient(ny);
f=nxx+nyy;

function f = Dirac(x, sigma)
f=(1/2/sigma)*(1+cos(pi*x/sigma));
b = (x<=sigma) & (x>=-sigma);
f = f.*b;

function g = NeumannBoundCond(f)
% Make a function satisfy Neumann boundary condition
[nrow,ncol] = size(f);
g = f;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);  
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);          
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);  