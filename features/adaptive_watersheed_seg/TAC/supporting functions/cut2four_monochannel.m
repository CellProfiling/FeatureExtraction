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
function [Y_L,Y_R, X_L, X_R]=cut2four_monochannel(temp_Segmention,temp_matrix,str_in)
%TAKES A CELL AS INPUT, GIVES 4 CELLS PARTS AS OUTPUT

L = bwlabel(temp_Segmention,4);
stats = regionprops(L,'Orientation') ;
Orientation_varriable=stats.Orientation+90;
if  Orientation_varriable<0
    Orientation_varriable=Orientation_varriable+270 ;
end
matrix2=  imrotate(temp_Segmention,-Orientation_varriable) ;

I=smooth(smooth(smooth(smooth(smooth(smooth(smooth(smooth(smooth(mean(matrix2))))))))));
[~,maxs_location]=findpeaks(I);
if isempty(maxs_location)==1
    maxs_location=find(ismember(I,max(I)));
    maxs_location=maxs_location(round(length(maxs_location)/2));
end
II=I(min(maxs_location):max(maxs_location));
maxi=max(II);
max_index= find(ismember(II,maxi))+min(maxs_location);
matrix3=matrix2;
matrix3(:,max_index)=0;
L = bwlabel(matrix3,4);
matrix4=ismember(L,1) ;
matrix5=ismember(L,2);
I=smooth(smooth(smooth(smooth(smooth(smooth(smooth(smooth(smooth(mean(matrix4,2))'))))))));
[~,maxs_location]=findpeaks(I);
if isempty(maxs_location)==1
    maxs_location=find(ismember(I,max(I)));
    maxs_location=maxs_location(round(length(maxs_location)/2));
end
II=I(min(maxs_location):max(maxs_location));
mini=min(II);
min_index= find(ismember(II,mini))+min(maxs_location);
min_index1= min_index(round(length(min_index)/2));
I=smooth(smooth(smooth(smooth(smooth(smooth(smooth(smooth(smooth(mean(matrix5,2))'))))))));
[~,maxs_location]=findpeaks(I);
if isempty(maxs_location)==1
    maxs_location=find(ismember(I,max(I)));
    maxs_location=maxs_location(round(length(maxs_location)/2));
end
II=I(min(maxs_location):max(maxs_location));
mini=min(II);
min_index= find(ismember(II,mini))+min(maxs_location);
min_index2= min_index(round(length(min_index)/2));
position_in=[1 min_index1 ;  size(matrix2,2) min_index2 ];
[~,~,matrix8,~,Y] = bresenham_TACWrapper(matrix2,position_in,0);
position_in(4)= position_in(4)+1 ;
[~,~,matrix8,~,Y] = bresenham_TACWrapper(matrix8,position_in,0);
position_in(4)= position_in(4)-1 ;
position_in(3)= position_in(3)+1 ;
[~,~,matrix8,~,Y] = bresenham_TACWrapper(matrix8,position_in,0);
L = bwlabel(matrix8,4);
matrix9=ismember(L,1) ;
matrix10=ismember(L,2);
matrix9(:,max_index)=0;
matrix10(:,max_index)=0;


%
% figure(1)
% imagesc( matrix9)
% figure(2)
% imagesc( matrix10)
% pause
L = bwlabel(matrix9,4);
Y_R=ismember(L,1) ;
Y_L=ismember(L,2) ;
L = bwlabel(matrix10,4);
X_L=ismember(L,1) ;
X_R=ismember(L,2) ;



temp_matrix=  imrotate(temp_matrix,-Orientation_varriable) ;

if strcmp(str_in,'Area') ==1
    Y_L =sum(sum(Y_L));
    Y_R =sum(sum(Y_R));
    X_L =sum(sum(X_L));
    X_R =sum(sum(X_R));
elseif strcmp(str_in,'I_per_A') ==1
    Y_L = sum(sum(Y_L.*temp_matrix)) / sum(sum(Y_L));
    Y_R = sum(sum(Y_R.*temp_matrix)) / sum(sum(Y_R));
    X_L = sum(sum(X_L.*temp_matrix)) / sum(sum(X_L));
    X_R = sum(sum(X_R.*temp_matrix)) / sum(sum(X_R));
elseif strcmp(str_in,'Intensity') ==1
    Y_L =sum(sum(Y_L.*temp_matrix)) ;
    Y_R =sum(sum(Y_R.*temp_matrix)) ;
    X_L =sum(sum(X_L.*temp_matrix)) ;
    X_R =sum(sum(X_R.*temp_matrix)) ;
end