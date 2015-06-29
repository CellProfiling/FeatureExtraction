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
function [Data_out]=Get_Cell_stack(handles,n,Vs, quantify_by)
try
    if nargin==3
        quantify_by=get(handles.quantify_by,'Value') ;
    end
end
try
    track_by=get(handles.track_by,'Value') ;
    track_what=eval(strcat('get(handles.track_what_',num2str(track_by),',''Value',''' )')) ;
    segmentation_type =eval(strcat('get(handles.segmentation_type_',num2str(quantify_by),',''Value',''' )'));
    quantify_what=eval(strcat('get(handles.track_what_',num2str(quantify_by),',''Value',''' )')) ;
    rotate_by=get(handles.rotate_by,'Value') ;
    rotate_what=eval(strcat('get(handles.track_what_',num2str(rotate_by),',''Value',''' )')) ;
    Projected_by_Value=eval(strcat('get(handles.Projected_by_',num2str(quantify_by),',''Value',''' )'))    ;
    popup_spaces=get(handles.popup_spaces,'Value');
    NETO_option=get(handles.NETO_option,'value');
    Merge_channels=get( handles.Merge_channels ,'Value');
catch
    track_what=get(handles.track_what2,'value');
    segmentation_type=get(handles.segmentation_type2,'value');
    quantify_what=get(handles.axes2_ch,'value');
    Projected_by_Value=get(handles.Projected_by,'value');
    popup_spaces=1;NETO_option=2;Merge_channels=0;
end

Projected_by_Str={'By max',  'By mean', 'z1', 'z2', 'z3', 'z4', 'z5', 'z6', 'z7', 'z7' , 'z9',  'z10'} ;

Projected_by = (Projected_by_Str(Projected_by_Value)) ;
pathname= handles.data_file(2).cdata ;
box_Raw=get(handles.Raw_listbox,'string') ;
Data_out=[];
start_frame=2*n-1
MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;
[vector, jj]=create_vector(MATRIX,handles,start_frame) ;
BoundingBox_matrix=Cell_data_function(vector,handles,jj,'BoundingBox',1)  ;
if isempty(findstr('Rotation',Vs))~=1
    Orientation_vector=Cell_data_function(vector,handles,jj,'Orientation',1);
end


if   NETO_option==1
    if popup_spaces==1
        for ii=1:size(vector,1);
            if  isnan(vector(ii,3)) ==0
                filename=box_Raw(ii+jj-1) ;
                
                if Merge_channels == 1
                    temp=Merged_image(ii+jj-1,handles) ;
                else
                    try
                        eval(strcat('temp  = handles.stack',num2str(quantify_what),'(',num2str(segmentation_type),').cdata(',num2str((ii+jj-1)),').cdata;'))
                    catch
                        temp  =  read_image3(pathname,filename, quantify_what,segmentation_type, Projected_by)  ;
                    end
                end
                
                if segmentation_type~=3 || Merge_channels == 1
                    try
                        eval(strcat('Segmentation  = handles.stack',num2str(quantify_what),'(',num2str(3),').cdata(',num2str((ii+jj-1)),').cdata;'))
                    catch
                        Segmentation  =  read_image3(pathname,filename, quantify_what,3, Projected_by)  ;
                    end
                else
                    Segmentation  = temp;
                end
                
                
                x1= round(BoundingBox_matrix(ii,1))  ;
                x2= floor(BoundingBox_matrix(ii,1))+round(BoundingBox_matrix(ii,3)) ;
                y1= round(BoundingBox_matrix(ii,2) )  ;
                y2= floor(BoundingBox_matrix(ii,2))+round(BoundingBox_matrix(ii,4))  ;
                if ( isempty(findstr('X_Rotation',Vs))==1) && (isempty(findstr('Y_Rotation',Vs))==1)
                    Data_out(ii).cdata=  temp(y1:y2,x1:x2,:) ; %
                    pause
                end
                if isempty(findstr('X_Rotation',Vs))~=1
                    Orientation_varriable=Orientation_vector(ii);
                    if  Orientation_varriable<0
                        Orientation_varriable=Orientation_varriable+180 ;
                    end
                    Data_out(ii).cdata=  flipdim( imrotate(temp(y1:y2,x1:x2,:),-Orientation_varriable),1);
                end
                if isempty(findstr('Y_Rotation',Vs))~=1
                    Orientation_varriable=Orientation_vector(ii)+90;
                    if  Orientation_varriable<0
                        Orientation_varriable=Orientation_varriable+270 ;
                    end
                    Data_out(ii).cdata=  flipdim( imrotate(temp(y1:y2,x1:x2,:),-Orientation_varriable),1);
                end
                if isempty(findstr('Rotate_by_maximum_pixel',Vs))~=1
                    matrix11= temp(y1:y2,x1:x2,:);
                    matrix22= Segmentation(y1:y2,x1:x2,:);
                    filename=box_Raw(ii+jj-1) ;
                    try
                        eval(strcat('temp2  = handles.stack',num2str(rotate_by),'(',num2str(segmentation_type),').cdata(',num2str((ii+jj-1)),').cdata;'))
                    catch
                        temp2  =  read_image3(pathname,filename,rotate_by,segmentation_type, Projected_by)  ;
                    end
                    if segmentation_type~=3
                        try
                            eval(strcat('Segmentation2  = handles.stack',num2str(rotate_by),'(',num2str(3),').cdata(',num2str((ii+jj-1)),').cdata;'))
                        catch
                            Segmentation2  =  read_image3(pathname,filename, rotate_by,3, Projected_by)  ;
                        end
                    else
                        Segmentation2  = temp2;
                    end
                    matrix1 = temp(y1:y2,x1:x2,:);
                    matrix2 = Segmentation(y1:y2,x1:x2,:);
                    [matrix1,~,~ ,matrix22 ]= Rotate_by_maximum_pixel(matrix1,matrix2,matrix11,matrix22);
                    Data_out(ii).cdata=matrix1;
                end
            end
        end
    elseif popup_spaces==2
        kk=1;
        for ii=1:size(vector,1);
            if  isnan(vector(ii,3)) ==0
                filename=box_Raw(ii+jj-1) ;
                if Merge_channels == 1
                    temp=Merged_image(ii+jj-1,handles) ;
                else
                    try
                        eval(strcat('temp  = handles.stack',num2str(quantify_what),'(',num2str(segmentation_type),').cdata(',num2str((ii+jj-1)),').cdata;'))
                    catch
                        temp  =  read_image3(pathname,filename, quantify_what,segmentation_type, Projected_by)  ;
                    end
                end
                
                if segmentation_type~=3 ||   Merge_channels == 1
                    try
                        eval(strcat('Segmentation  = handles.stack',num2str(quantify_what),'(',num2str(3),').cdata(',num2str((ii+jj-1)),').cdata;'))
                    catch
                        Segmentation  =  read_image3(pathname,filename, quantify_what,3, Projected_by)  ;
                    end
                else
                    Segmentation  = temp;
                end
                
                
                x1= round(BoundingBox_matrix(kk,1))  ;
                x2= floor(BoundingBox_matrix(kk,1))+round(BoundingBox_matrix(kk,3)) ;
                y1= round(BoundingBox_matrix(kk,2) )  ;
                y2= floor(BoundingBox_matrix(kk,2))+round(BoundingBox_matrix(kk,4))  ;
                if ( isempty(findstr('X_Rotation',Vs))==1) && (isempty(findstr('Y_Rotation',Vs))==1)
                    Data_out(kk).cdata=  temp(y1:y2,x1:x2,:)  ;
                end
                if isempty(findstr('X_Rotation',Vs))~=1
                    Orientation_varriable=Orientation_vector(kk);
                    if  Orientation_varriable<0
                        Orientation_varriable=Orientation_varriable+180 ;
                    end
                    Data_out(kk).cdata=  flipdim( imrotate(temp(y1:y2,x1:x2,:),-Orientation_varriable),1);
                end
                if isempty(findstr('Y_Rotation',Vs))~=1
                    Orientation_varriable=Orientation_vector(kk)+90;
                    if  Orientation_varriable<0
                        Orientation_varriable=Orientation_varriable+270 ;
                    end
                    Data_out(kk).cdata=  flipdim( imrotate(temp(y1:y2,x1:x2,:),-Orientation_varriable),1);
                end
                if isempty(findstr('Rotate by maximum pixe',Vs))~=1
                    matrix1= temp(y1:y2,x1:x2,:);
                    matrix2= Segmentation(y1:y2,x1:x2,:);
                    matrix11=[];matrix22=[]; %second channel
                    [matrix1,~,~,matrix22]= Rotate_by_maximum_pixel(matrix1,matrix2,matrix11,matrix22);
                    Data_out(kk).cdata=matrix1;
                end
                kk=kk+1;
            end
        end
    end
else
    if popup_spaces==1
        for ii=1:size(vector,1)
            if isnan(vector(ii,3))~=1
                full_command=strcat('handles.data_file(4).cdata.L(',num2str(track_what) ,').cdata(ii+jj-1).cdata(vector(ii,3)).PixelList') ;
                output(ii).cdata= eval(full_command)  ;
            end
        end
    elseif popup_spaces==2
        kk=1;
        for ii=1:size(vector,1)
            if isnan(vector(ii,3))~=1
                full_command=strcat('handles.data_file(4).cdata.L(',num2str(track_what) ,').cdata(ii+jj-1).cdata(vector(ii,3)).PixelList');
                output(kk).cdata= eval(full_command)  ;
                kk=kk+1;
            end
        end
    end
    if popup_spaces==1
        for ii=1:size(vector,1);
            if  isnan(vector(ii,3)) ==0
                filename=box_Raw(ii+jj-1) ;
                if  Merge_channels  == 1
                    temp=Merged_image(ii+jj-1,handles) ;
                else
                    try
                        eval(strcat('temp  = handles.stack',num2str(quantify_what),'(',num2str(segmentation_type),').cdata(',num2str((ii+jj-1)),').cdata;'))
                    catch
                        temp  =  read_image3(pathname,filename, quantify_what,segmentation_type, Projected_by)  ;
                    end
                end
                
                if segmentation_type~=3 ||  Merge_channels   == 1
                    try
                        eval(strcat('Segmentation  = handles.stack',num2str(quantify_what),'(',num2str(3),').cdata(',num2str((ii+jj-1)),').cdata;'))
                    catch
                        Segmentation  =  read_image3(pathname,filename, quantify_what,3, Projected_by)  ;
                    end
                else
                    Segmentation  = temp;
                end
                
                if   Merge_channels ~= 1
                    PixelList= output(ii).cdata;
                    PixelList = sub2ind([handles.data_file(6).cdata(4) handles.data_file(6).cdata(3)], PixelList(:,2),PixelList(:,1)) ;
                    PixelList= setdiff(1:handles.data_file(6).cdata(4)*handles.data_file(6).cdata(3),PixelList);
                    temp(PixelList)=0;
                end
                x1= round(BoundingBox_matrix(ii,1))  ;
                x2= floor(BoundingBox_matrix(ii,1))+round(BoundingBox_matrix(ii,3)) ;
                y1= round(BoundingBox_matrix(ii,2) )  ;
                y2= floor(BoundingBox_matrix(ii,2))+round(BoundingBox_matrix(ii,4))  ;
                
                if ( isempty(findstr('X_Rotation',Vs))==1) && (isempty(findstr('Y_Rotation',Vs))==1)
                    Data_out(ii).cdata=   temp(y1:y2,x1:x2,:) ;%no rotation
                end
                if isempty(findstr('X_Rotation',Vs))~=1%x rotation
                    Orientation_varriable=Orientation_vector(ii);
                    if  Orientation_varriable<0
                        Orientation_varriable=Orientation_varriable+180 ;
                    end
                    Data_out(ii).cdata=  flipdim( imrotate(temp(y1:y2,x1:x2,:),-Orientation_varriable),1);
                end
                if isempty(findstr('Y_Rotation',Vs))~=1
                    Orientation_varriable=Orientation_vector(ii)+90;
                    if  Orientation_varriable<0
                        Orientation_varriable=Orientation_varriable+270 ;
                    end
                    Data_out(ii).cdata=  flipdim( imrotate(temp(y1:y2,x1:x2,:),-Orientation_varriable),1);
                end
                if isempty(findstr('Rotate_by_maximum_pixel',Vs))~=1
                    matrix11= temp(y1:y2,x1:x2,:);
                    matrix22= Segmentation(y1:y2,x1:x2,:);
                    filename=box_Raw(ii+jj-1) ;
                    try
                        eval(strcat('temp2  = handles.stack',num2str(rotate_by),'(',num2str(segmentation_type),').cdata(',num2str((ii+jj-1)),').cdata;'))
                    catch
                        temp2  =  read_image3(pathname,filename, rotate_by,segmentation_type, Projected_by)  ;
                    end
                    if segmentation_type~=3
                        try
                            eval(strcat('Segmentation2  = handles.stack',num2str(rotate_by),'(',num2str(3),').cdata(',num2str((ii+jj-1)),').cdata;'))
                        catch
                            Segmentation2  =  read_image3(pathname,filename, rotate_by,3, Projected_by)  ;
                        end
                    else
                        Segmentation2  = temp2;
                    end
                    matrix1 = temp2(y1:y2,x1:x2,:);
                    matrix2 = Segmentation2(y1:y2,x1:x2,:);
                    [matrix1,~,~ ,matrix22 ]= Rotate_by_maximum_pixel(matrix1,matrix2,matrix11,matrix22);
                    Data_out(ii).cdata=matrix1;
                end
            end
        end
    elseif popup_spaces==2
        kk=1;
        for ii=1:size(vector,1);
            if  isnan(vector(ii,3)) ==0
                filename=box_Raw(ii+jj-1) ;
                if Merge_channels == 1
                    temp=Merged_image(ii+jj-1,handles) ;
                else
                    try
                        eval(strcat('temp  = handles.stack',num2str(quantify_what),'(',num2str(segmentation_type),').cdata(',num2str((ii+jj-1)),').cdata;'))
                    catch
                        temp  =  read_image3(pathname,filename, quantify_what,segmentation_type, Projected_by)  ;
                    end
                end
                
                if segmentation_type~=3 || Merge_channels == 1
                    try
                        eval(strcat('Segmentation  = handles.stack',num2str(quantify_what),'(',num2str(3),').cdata(',num2str((ii+jj-1)),').cdata;'))
                    catch
                        Segmentation  =  read_image3(pathname,filename, quantify_what,3, Projected_by)  ;
                    end
                else
                    Segmentation  = temp;
                end
                
                if  (get( handles.Merge_channels ,'Value') ~= get(handles.Merge_channels,'Max'))
                    PixelList= output(kk).cdata;
                    PixelList = sub2ind([handles.data_file(6).cdata(4) handles.data_file(6).cdata(3)], PixelList(:,2),PixelList(:,1)) ;
                    PixelList= setdiff(1:handles.data_file(6).cdata(4)*handles.data_file(6).cdata(3),PixelList);
                    temp(PixelList)=0;
                end
                x1= round(BoundingBox_matrix(kk,1))  ;
                x2= floor(BoundingBox_matrix(kk,1))+round(BoundingBox_matrix(kk,3)) ;
                y1= round(BoundingBox_matrix(kk,2) )  ;
                y2= floor(BoundingBox_matrix(kk,2))+round(BoundingBox_matrix(kk,4))  ;
                if ( isempty(findstr('X_Rotation',Vs))==1) && (isempty(findstr('Y_Rotation',Vs))==1)
                    Data_out(kk).cdata=  temp(y1:y2,x1:x2,:)  ;
                end
                if isempty(findstr('X_Rotation',Vs))~=1
                    Orientation_varriable=Orientation_vector(kk);
                    if  Orientation_varriable<0
                        Orientation_varriable=Orientation_varriable+180 ;
                    end
                    Data_out(kk).cdata=  flipdim( imrotate(temp(y1:y2,x1:x2,:),-Orientation_varriable),1);
                end
                if isempty(findstr('Y_Rotation',Vs))~=1
                    Orientation_varriable=Orientation_vector(kk)+90;
                    if  Orientation_varriable<0
                        Orientation_varriable=Orientation_varriable+270 ;
                    end
                    Data_out(kk).cdata=  flipdim( imrotate(temp(y1:y2,x1:x2,:),-Orientation_varriable),1);
                end
                if isempty(findstr('Rotate by maximum pixe',Vs))~=1
                    matrix1= temp(y1:y2,x1:x2,:);
                    matrix2= Segmentation(y1:y2,x1:x2,:);
                    matrix11=[];matrix22=[]; %second channel
                    [matrix1,~,~,matrix22]= Rotate_by_maximum_pixel(matrix1,matrix2,matrix11,matrix22);
                    Data_out(kk).cdata=matrix1;
                end
                kk=kk+1;
            end
        end
    end
end