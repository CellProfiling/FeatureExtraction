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


function Cell_Projection_watershed_function(handles,n,Vs) %3
Data=Get_Cell_stack(handles,n,Vs) ;
maxi=[];
projection=[];
if isempty(findstr('Y_Rotation',Vs))~=1
    for ii=1:size(Data,2)
        temp1= Data(ii).cdata,2 ;
        temp2=zeros(size(temp1));
        temp2(temp1>0)=1;
        temp3 = bwdist(~temp2);
        temp3 = -temp3;
        temp3(~temp2) = -Inf;
        temp3 = watershed(temp3);
        projection(ii).cdata= nanmean(temp3,2) ;
        
        
    end
    maxi=zeros(1,size(projection,2));
    for ii=1: size(projection,2)
        maxi(ii)= size(projection(ii).cdata,1);
    end
end
if isempty(findstr('X_Rotation',Vs))~=1
    for ii=1:size(Data,2)
        temp1= Data(ii).cdata,2 ;
        temp2=zeros(size(temp1));
        temp2(temp1>0)=1;
        temp3 = bwdist(~temp2);
        temp3 = -temp3;
        temp3(~temp2) = -Inf;
        temp3 = watershed(temp3);
        projection(ii).cdata= sum(temp3 ) ;
        
    end
    maxi=zeros(1,size(projection,1));
    for ii=1: size(projection,2)
        maxi(ii)= size(projection(ii).cdata,2);
    end
end
if isempty(findstr('Rotate_by_maximum_pixel',Vs))~=1
    for ii=1:size(Data,2)
        %  projection(ii).cdata=nanmean(Data(ii).cdata,2);
    end
    maxi=zeros(1,size(projection,2));
    for ii=1: size(projection,2)
        maxi(ii)= size(projection(ii).cdata,1);
    end
end
if isempty(maxi)==1
    'Rotate by what??'
end

scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
figure('color','w','units','pixels','position', scrsz) ;
imagesc(projection_matrix);
Div_Cells_str=get(handles.Div_Cells,'string');   n_tag= char(Div_Cells_str(n));
projection_str=strcat('Cell- ',Vs,'-Projection-',num2str(n_tag));
title(projection_str,'fontsize',14)
xlabel('Frames')
ylabel('Projection of cell intensity')
axis tight

