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
function [MATRIX_out ]=break_track(MATRIX_in,frame_index,cell_index,n,last_cell)
%   save all
%
%   figure
%   imagesc(rand(4,4))
%   return
%  frame_index - frame before division ( where the cross mark is)
%  cell_index
%  n
%  last_cell
%  pause

MATRIX_out=zeros(size(MATRIX_in,1),size(MATRIX_in,2)+2);
%  -----
MATRIX_out(:,1:(cell_index*2-2))=MATRIX_in(:,1:(cell_index*2-2));%1
%  -----
MATRIX_out(1:frame_index, (cell_index*2-1):(cell_index*2)) = MATRIX_in(1:frame_index, (cell_index*2-1):(cell_index*2)) ;%2
%  -----


for ii=2:2:(last_cell-2+2*n)  %find the place where to put the new track (ii)
    X=MATRIX_in(:,ii-1)  ;
    X2=X  ;
    X=X(X~=0);
    start_X=find(ismember(X2,X(1))) ; start_X=start_X(1);
    if frame_index<start_X
        break
    end
end

MATRIX_out(:,cell_index*2+1:ii-2)=MATRIX_in(:,cell_index*2+1:ii-2);%3
%  -----

V=MATRIX_in(:,cell_index*2-1) ;
index_X=find(ismember(V,0));
V(index_X)=[]  ;
if isempty(index_X)==1
    start_X=0;
else
    start_X=length(index_X);
end
end_X=length(V)+start_X;


MATRIX_out((frame_index+1):end_X,  (ii-1):ii) = MATRIX_in((frame_index+1):end_X, (cell_index*2-1):(cell_index*2)); %4
MATRIX_out(:,(ii+1):end)=  MATRIX_in(:,(ii-1):end);%5


%
%    jj=1;
%   for ii=2:2:size(MATRIX_out,2)
%        X= MATRIX_out(:,ii-1)  ;
%        X2=X  ;
%        X=X(X~=0);
%        start_X=find(ismember(X2,X(1))) ; start_X_vec(jj)=start_X(1) ;jj=jj+1;
%   end
%    [~,order_vec]=sort(start_X_vec);
%    order_vec=order_vec*2;
%    MATRIX_out2=zeros(size(MATRIX_out));
%
%
%    jj=1;
% for ii=2:2:size(MATRIX_out,2)
%         MATRIX_out2(:,ii-1:ii)=MATRIX_out(:,order_vec(jj)-1:order_vec(jj)) ;
%         jj=jj+1;
% end
%