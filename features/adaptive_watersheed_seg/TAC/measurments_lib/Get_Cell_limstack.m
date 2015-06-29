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


%      ----------


function [Data_out]=Get_Cell_limstack(handles,n,Vs,TYPE,Length,quantify_by      )   %#ok<INUSD,INUSL>




quantify_by


track_by=get(handles.track_by,'Value') ;
track_what=eval(strcat('get(handles.track_what_',num2str(track_by),',''Value',''' )')) ;
segmentation_type =eval(strcat('get(handles.segmentation_type_',num2str(quantify_by),',''Value',''' )'));
quantify_what=eval(strcat('get(handles.track_what_',num2str(quantify_by),',''Value',''' )')) ;

rotate_by=get(handles.rotate_by,'Value') ;
rotate_what=eval(strcat('get(handles.track_what_',num2str(rotate_by),',''Value',''' )')) ;
Projected_by_Str={'By max',  'By mean', 'z1', 'z2', 'z3', 'z4', 'z5', 'z6', 'z7', 'z7' , 'z9',  'z10'} ;
Projected_by_Value=eval(strcat('get(handles.Projected_by_',num2str(quantify_by),',''Value',''' )'))    ;
Projected_by = (Projected_by_Str(Projected_by_Value)) ;
pathname= handles.data_file(2).cdata ;
box_Raw=get(handles.Raw_listbox,'string') ;

start_frame=2*n-1
MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;
[vector, jj]=create_vector(MATRIX,handles,start_frame) ;
BoundingBox_matrix=Cell_data_function(vector,handles,jj,'BoundingBox',1)  ;
Data_out=[];
if nargin==8
    if isempty(findstr('ascend',TYPE))~=1
        
        ii=1
        while ii<size(vector,1) && ii<Length+1
            if  isnan(vector(ii,3)) ==0
                filename=box_Raw(ii+jj-1) ;
                temp  =  read_image3(pathname,filename, quantify_what,segmentation_type, Projected_by)  ;
                Segmention  =  read_image3(pathname,filename, quantify_what,3, Projected_by)  ;
                
                
                
                x1= round(BoundingBox_matrix(ii,1))  ;
                x2= floor(BoundingBox_matrix(ii,1))+round(BoundingBox_matrix(ii,3)) ;
                y1= round(BoundingBox_matrix(ii,2) )  ;
                y2= floor(BoundingBox_matrix(ii,2))+round(BoundingBox_matrix(ii,4))  ;
                
                Data_out(ii).cdata= flipdim( Segmention(y1:y2,x1:x2,:),1); %   combined_matrix=Merged_image(handles) ;
                
            end
            ii=ii+1 ;
        end
    end
    %
    %
    if isempty(findstr('descend',TYPE))~=1
        ii=size(vector,1)
        if  isnan(vector(ii,3)) ==0
            filename=box_Raw(ii+jj-1) ;
            temp  =  read_image3(pathname,filename, quantify_what,segmentation_type, Projected_by)  ;
            Segmention  =  read_image3(pathname,filename, quantify_what,3, Projected_by)  ;
            
            x1= round(BoundingBox_matrix(ii,1))  ;
            x2= floor(BoundingBox_matrix(ii,1))+round(BoundingBox_matrix(ii,3)) ;
            y1= round(BoundingBox_matrix(ii,2) )  ;
            y2= floor(BoundingBox_matrix(ii,2))+round(BoundingBox_matrix(ii,4))  ;
            %
            Data_out(1).cdata= flipdim( Segmention(y1:y2,x1:x2,:),1); %   combined_matrix=Merged_image(handles) ;
        end
    end
    
else
    if isempty(findstr('ascend',TYPE))~=1
        
        ii=1
        while ii<size(vector,1) && ii<Length+1
            if  isnan(vector(ii,3)) ==0
                filename=box_Raw(ii+jj-1) ;
                temp  =  read_image3(pathname,filename, quantify_what,segmentation_type, Projected_by)  ;
                
                
                
                x1= round(BoundingBox_matrix(ii,1))  ;
                x2= floor(BoundingBox_matrix(ii,1))+round(BoundingBox_matrix(ii,3)) ;
                y1= round(BoundingBox_matrix(ii,2) )  ;
                y2= floor(BoundingBox_matrix(ii,2))+round(BoundingBox_matrix(ii,4))  ;
                
                Data_out(ii).cdata= flipdim( temp(y1:y2,x1:x2,:),1); %   combined_matrix=Merged_image(handles) ;
                
            end
            ii=ii+1 ;
        end
    end
    
    if isempty(findstr('descend',TYPE))~=1
        ii=size(vector,1)
        if  isnan(vector(ii,3)) ==0
            filename=box_Raw(ii+jj-1) ;
            
            pathname
            filename
            quantify_what
            segmentation_type
            Projected_by
            
            
            temp  =  read_image3(pathname,filename, quantify_what,segmentation_type, Projected_by)  ;
            Segmention  =  read_image3(pathname,filename, quantify_what,3, Projected_by)  ;
            x1= round(BoundingBox_matrix(ii,1))  ;
            x2= floor(BoundingBox_matrix(ii,1))+round(BoundingBox_matrix(ii,3)) ;
            y1= round(BoundingBox_matrix(ii,2) )  ;
            y2= floor(BoundingBox_matrix(ii,2))+round(BoundingBox_matrix(ii,4))  ;
            
            Data_out(1).cdata= flipdim( temp(y1:y2,x1:x2,:),1); %   combined_matrix=Merged_image(handles) ;
        end
    end
end