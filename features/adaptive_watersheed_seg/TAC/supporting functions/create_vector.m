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
function [vector, jj]=create_vector(MATRIX,handles,start_frame)
% vector is the trajectories of cell number start_frame in the
% MATRIX (the table). jj is the first frame that this cell appears.

%one of the most important functions!
%takes the matrix from table and the first frame where the cell appears as an inputs

if start_frame>size(MATRIX,2)
    Y=wavread('Error');
    h = errordlg('Input has to be smaller than the number of cells tracked.','Error');
    sound(Y,22000);
    return
end

vector=MATRIX(:,start_frame);
for ii=1:length(vector);
    if vector(ii)>0
        break
    end
end
jj=ii;
n=length(vector);
index_zeros=find(ismember(vector,0));
vector=MATRIX(jj:jj+n-length(index_zeros)-1,start_frame:start_frame+1);
n=size(vector,1);
vector(:,end+1)=nan(n,1);
%now vectors is a matrix where width is = x , y , the L number is
%regionprops:
try
    track_what=get(handles.track_by,'Value') ;
    track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ;
catch
    track_what= get(handles.track_what2,'value');
end
% the  location is from the coresponding Centroids data
for ii=1:n
    centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(ii+jj-1).cdata;
    Centroids_frame=zeros(size(handles.data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata,1),2);
    sizeC=size(handles.data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata,1);
    for kk=1:sizeC
        Centroid_frame(kk,:)= handles.data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata(kk).Centroid ;
    end
    for kk=1:sizeC
        if vector(ii,1:2)==Centroid_frame(kk,:)
            vector(ii,3)=kk;
            break
        end
    end
    try
        popup_seg_ed=get(handles.popup_seg_ed,'Value');
    catch
        popup_seg_ed=2;
    end
    if  popup_seg_ed==1
        for nn=1:size(centy1,1)
            if (centy1(nn,1:2)==vector(ii,1:2))
                break;
            end
        end
        
        
        if  ((centy1(nn,3)-round(centy1(nn,3)))) >0
            vector(ii,3)=nan;
        end
    end
end
%
%
% nan_index=find(isnan(vector(:,3)));
% if length(nan_index)==length(vector(:,3))
%  h = msgbox('The cell trajectories are outdside the selected border','Cancel');
% end
