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
function [matrix,iii,jjj,kk]=intensity_split_function(x,y,matrix,temp)

steep = (abs(y(2)-y(1)) > abs(x(2)-x(1)));
if steep, [x,y] = swap(x,y); end
if x(1)>x(2),
    [x(1),x(2)] = swap(x(1),x(2));
    [y(1),y(2)] = swap(y(1),y(2));
end

% if matrix(x(1))~0


delx = x(2)-x(1);
dely = abs(y(2)-y(1));
error = 0;
x_n = x(1);
y_n = y(1);
if y(1) < y(2), ystep = 1; else ystep = -1; end
for n = 1:delx+1
    if steep,
        myline(n) = matrix(x_n,y_n);
        X(n) = x_n;
        Y(n) = y_n;
    else
        myline(n) = matrix(y_n,x_n);
        X(n) = y_n;
        Y(n) = x_n;
    end
    x_n = x_n + 1;
    
    error = error + dely ;
    try
        if bitshift(error,1) >= delx, % same as -> if 2*error >= delx,
            y_n = y_n + ystep;
            error = error - delx;
        end
    end
end
%%%%
Index=find(myline);
jj=X(min(Index));ii=Y(min(Index));% ii,jj %is the start point
matrix(jj,ii)=0; %start with 0, and make the rest of the path 0
if isempty(jj)==1 %could not split
    
end
if isempty(ii)==1  %could not split
    
end
kk=1; split_lineX(kk)=ii; split_lineY(kk)=jj;
jjj=X(max(Index));iii=Y(max(Index));
while   abs(ii-iii)+abs(jj-jjj)~=0
    if ii<iii && jj>jjj
        NeibX=[ii ii+1 ii+1];  NeibY=[jj-1 jj-1 jj];
    end
    if ii==iii && jj>jjj
        NeibX=[ii-1 ii ii+1];  NeibY=[jj-1 jj-1 jj-1];
    end
    if ii>iii && jj>jjj
        NeibX=[ii-1 ii ii-1];  NeibY=[jj-1 jj-1 jj];
    end
    if ii<iii && jj<jjj
        NeibX=[ii+1 ii+1 ii ];  NeibY=[jj  jj+1 jj+1];
    end
    if ii==iii && jj<jjj
        NeibX=[ii-1 ii  ii+1] ; NeibY=[jj+1 jj+1 jj+1] ;
    end
    if ii>iii && jj<jjj
        NeibX=[ii-1 ii-1 ii];  NeibY=[jj jj+1 jj+1];
    end
    if ii<iii && jj==jjj
        NeibX=[ii+1 ii+1 ii+1];  NeibY=[jj-1 jj  jj+1];
    end
    if ii>iii && jj==jjj
        NeibX=[ii-1 ii-1 ii-1];  NeibY=[jj-1 jj  jj+1];
    end
    
    NeibVec=[temp(NeibY(1),NeibX(1))  temp(NeibY(2),NeibX(2)) temp(NeibY(3),NeibX(3))]  ;
    [~,b]=min(NeibVec);
    ii= NeibX(b);jj= NeibY(b);
    split_lineX(kk)=ii; split_lineY(kk)=jj; kk=kk+1;
    matrix(jj,ii)=0; temp(jj,ii)=temp(jj,ii)+temp(jj,ii)*10;
    if kk>100% could not split even after 100 repeats
        matrix=[];trmp=[]; ii=0;iii=0; jj=0; jjj=0;
    end
end