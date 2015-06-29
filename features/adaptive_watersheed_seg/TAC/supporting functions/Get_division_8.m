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
function [Y_L,Y_R, X_L, X_R,Stat]=Get_division_8(handles,n,D1,D2,str_in) %Y1 is always the top
if get(handles.track_by,'Value')==1
    %This is if we want to track and quantify only in the same channel:
    [Data_temp,~,start_ii]=Get_Dividing_stack(handles,n,D1,D2,'Y_Rotation') ;
    segmentation_type_1=get(handles.segmentation_type_1,'value');
    set(handles.segmentation_type_1,'value',3);
    [Data_Segmention,Stat,start_ii]=Get_Dividing_stack(handles,n,D1,D2,'Y_Rotation') ;
    set(handles.segmentation_type_1,'value',segmentation_type_1);
    
    Y_L=[] ; Y_R=[]; X_L=[] ; X_R=[];
    kk=1;
    for ii=1:start_ii
        
        temp_matrix= double(Data_temp(ii).cdata) ;
        temp_Segmention=double(Data_Segmention(ii).cdata);
        
        if isempty(temp_Segmention)~=1
            % -----------------------------
            %1. Take only the largest particle:
            L = bwlabel(temp_Segmention,4);
            stats = regionprops(L,'Area') ;
            idx=0;
            for iii=1:size(stats,1)
                if idx < stats(iii).Area
                    idx =  stats(iii).Area ;
                    iii_index=iii;
                end
            end
            
            temp_Segmention=ismember(L,iii_index);
            [Y_R(kk),Y_L(kk), X_L(kk), X_R(kk)]=cut2four_monochannel(temp_Segmention,temp_matrix,str_in)  ;
            kk=kk+1;
        end
    end
    
    %%%%%
else
    %This is if we want to track in first channel and quantify in the second channel:
    set(handles.track_by,'Value',1)
    [Data_temp_1,~,start_ii]=Get_Dividing_stack(handles,n,D1,D2,'Y_Rotation') ;
    segmentation_type_1=get(handles.segmentation_type_1,'value');
    set(handles.segmentation_type_1,'value',3);
    [Data_Segmention_1,~,start_ii]=Get_Dividing_stack(handles,n,D1,D2,'Y_Rotation') ;
    set(handles.segmentation_type_1,'value',segmentation_type_1);
    
    set(handles.track_by,'Value',2)
    [Data_temp_2,~,start_ii]=Get_Dividing_stack(handles,n,D1,D2,'Y_Rotation') ;
    segmentation_type_1=get(handles.segmentation_type_1,'value');
    set(handles.segmentation_type_1,'value',3);
    [Data_Segmention_2,Stat,start_ii]=Get_Dividing_stack(handles,n,D1,D2,'Y_Rotation') ;
    set(handles.segmentation_type_1,'value',segmentation_type_1);
    
    
    
    
    
    
    Y_L=[] ; Y_R=[]; X_L=[] ; X_R=[];
    kk=1;
    for ii=1:start_ii
        
        temp_matrix_1= double(Data_temp_1(ii).cdata) ;
        temp_Segmention_1=double(Data_Segmention_1(ii).cdata);
        temp_matrix_2= double(Data_temp_2(ii).cdata) ;
        temp_Segmention_2=double(Data_Segmention_2(ii).cdata);
        
        if isempty(temp_Segmention_1)~=1
            % -----------------------------
            %1. Take only the largest particle:
            L = bwlabel(temp_Segmention_1,4);
            stats = regionprops(L,'Area') ;
            idx=0;
            for iii=1:size(stats,1)
                if idx < stats(iii).Area
                    idx =  stats(iii).Area ;
                    iii_index=iii;
                end
            end
            
            temp_Segmention_1=ismember(L,iii_index);
            [Y_R(kk),Y_L(kk), X_L(kk), X_R(kk)]=cut2four_multichannel(temp_Segmention_1,temp_matrix_1,temp_Segmention_2,temp_matrix_2,str_in)  ;
            kk=kk+1;
        end
    end
    %%%%%
end
