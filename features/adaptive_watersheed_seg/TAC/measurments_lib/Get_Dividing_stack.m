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
function [Data_out,Stat,start_kk]=Get_Dividing_stack(handles,n,D1,D2,Vs, quantify_by)


if nargin==5
    quantify_by=get(handles.quantify_by,'Value') ;
end
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
popup_spaces=get(handles.popup_spaces,'Value');
Data_out=[]; Stat=[];
MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;
Ignore_Parental_function=get(handles.Ignore_Parental_function,'Value');
% -------------------------------------------------------------------------

% A) cell before division (parental cell)
if Ignore_Parental_function==0 %user option to consider or not consier paerntal
    Data_out =Get_Cell_stack(handles,n,Vs,quantify_by) ; %IMPORTANT: User can input other Vs to rotate the cell differently than the total bounding box
end
if isempty(Data_out)==1
    start_kk=0 ;
else
    start_kk=size(Data_out ,2);
end
% -------------------------------------------------------------------------
% Explnation: in order to have the option to ignore or not to ignore the spaces, kk is used.
% start_kk is where the single start
start_frame=2*D1-1 ; kk=1;

% B) coordinates of D1 and D2
[vector_D1, jj_D1]=create_vector(MATRIX,handles,start_frame) ;
BoundingBox_matrix_D1=Cell_data_function(vector_D1,handles,jj_D1,'BoundingBox',1)  ;
Centroid_matrix_D1= Cell_data_function(vector_D1,handles,jj_D1,'Centroid',1)  ;

start_frame=2*D2-1


[vector_D2, jj_D2]=create_vector(MATRIX,handles,start_frame) ;
BoundingBox_matrix_D2=Cell_data_function(vector_D2,handles,jj_D2,'BoundingBox',1)  ;
Centroid_matrix_D2=Cell_data_function(vector_D2,handles,jj_D2,'Centroid',1)  ;


if size(vector_D1,1)< size(vector_D2,1)
    size_vector_D12=size(vector_D2,1) ;
    size_vector_D21=size(vector_D1,1) ;
else
    size_vector_D12=size(vector_D1,1);
    size_vector_D21=size(vector_D2,1) ;
end
% C)  start loop to get bounding box of D1 and D2 over frame ii+jj_D2-1
% -------------------------------------------------------------------------
h=waitbar(0,'please wait..');
for ii=1:size_vector_D12
    waitbar(ii/size_vector_D12)
    pause(0.05)
    x1_D1=[]; x2_D1=[]; y1_D1=[]; y2_D1=[]; x1_D2=[]; x2_D2=[]; y1_D2=[]; y2_D2=[];
    if (size(vector_D1,1)+1)>ii
        if  isnan(vector_D1(ii,3)) ==0
            pause(0.1)
            D1_stat=1;
            x1_D1= round(BoundingBox_matrix_D1(ii,1))  ;
            x2_D1= floor(BoundingBox_matrix_D1(ii,1))+round(BoundingBox_matrix_D1(ii,3)) ;
            y1_D1= round(BoundingBox_matrix_D1(ii,2) )  ;
            y2_D1= floor(BoundingBox_matrix_D1(ii,2))+round(BoundingBox_matrix_D1(ii,4))  ;
        end
    end
    if (size(vector_D2,1)+1)>ii
        if  isnan(vector_D2(ii,3)) ==0
            x1_D2= round(BoundingBox_matrix_D2(ii,1))  ;
            x2_D2= floor(BoundingBox_matrix_D2(ii,1))+round(BoundingBox_matrix_D2(ii,3)) ;
            y1_D2= round(BoundingBox_matrix_D2(ii,2) )  ;
            y2_D2= floor(BoundingBox_matrix_D2(ii,2))+round(BoundingBox_matrix_D2(ii,4))  ;
            D2_stat=1;
        end
    end
    
    if D1_stat==1 || D2_stat==1
        
        
        filename=box_Raw(ii+jj_D2-1) ;
        %  try
        %   eval(strcat('temp_D12  = handles.stack',num2str(quantify_what),'(',num2str(segmentation_type),').cdata(',num2str((ii+jj_D2-1)),').cdata;'))
        %  catch
        %   temp_D12  =  read_image3(pathname,filename, quantify_what,segmentation_type, Projected_by)  ;
        %  end
        %
        %
        %
        %  if segmentation_type~=3
        %   try
        %  eval(strcat('Segmentation_D12  = handles.stack',num2str(quantify_what),'(',num2str(3),').cdata(',num2str((ii+jj_D2-1)),').cdata;'))
        %  catch
        %    Segmentation_D12  =  read_image3(pathname,filename, quantify_what,3, Projected_by)  ;
        %   end
        %  else
        %      Segmentation_D12  = temp_D12;
        %  end
        if (get( handles.Merge_channels ,'Value') == get(handles.Merge_channels,'Max'))
            temp_D12=Merged_image(ii+jj_D2-1,handles) ;
        else
            try
                eval(strcat('temp_D12  = handles.stack',num2str(quantify_what),'(',num2str(segmentation_type),').cdata(',num2str((ii+jj_D2-1)),').cdata;'))
            catch
                temp_D12  =  read_image3(pathname,filename, quantify_what,segmentation_type, Projected_by)  ;
            end
        end
        
        if segmentation_type~=3 || (get( handles.Merge_channels ,'Value') == get(handles.Merge_channels,'Max'))
            try
                eval(strcat('Segmentation_D12  = handles.stack',num2str(quantify_what),'(',num2str(3),').cdata(',num2str((ii+jj_D2-1)),').cdata;'))
            catch
                Segmentation_D12  =  read_image3(pathname,filename, quantify_what,3, Projected_by)  ;
            end
        else
            Segmentation_D12  = temp;
        end
        
        
        if isempty(findstr('Rotate_by_maximum_pixel',Vs))~=1
            %  rotate by maximum_pixel D1:
            matrix1_D1= temp_D12(y1_D1:y2_D1,x1_D1:x2_D1 );
            matrix2_D1= Segmentation_D12(y1_D1:y2_D1,x1_D1:x2_D1 );
            matrix11_D1=[];matrix22_D1=[]; %second channel
            [matrix1_D1,matrix2_D1,~,matrix22_D1]= Rotate_by_maximum_pixel(matrix1_D1,matrix2_D1,matrix11_D1,matrix22_D1);
            matrix1_D2= temp_D12(y1_D2:y2_D2,x1_D2:x2_D2 );
            matrix2_D2= Segmentation_D12(y1_D2:y2_D2,x1_D2:x2_D2 );
            matrix11_D2=[];matrix22_D2=[]; %second channel
            [matrix1_D2,matrix2_D2,~,matrix22_D2]= Rotate_by_maximum_pixel(matrix1_D2,matrix2_D2,matrix11_D2,matrix22_D2);
            temp_D12=nan(size( temp_D12));
            Segmentation_D12=nan(size( Segmentation_D12));
            if   isempty(matrix1_D1)~=1
                temp_D12(y1_D1:y2_D1,x1_D1:x2_D1 ) =rot90(rot90(imresize( matrix1_D1' , [y2_D1-y1_D1+1 x2_D1-x1_D1+1])));
                Segmentation_D12(y1_D1:y2_D1,x1_D1:x2_D1 )=rot90(rot90(imresize( matrix2_D1' , [y2_D1-y1_D1+1 x2_D1-x1_D1+1])));
            end
            %  rotate by maximum_pixel D2:
            if   isempty(matrix1_D2)~=1
                temp_D12(y1_D2:y2_D2,x1_D2:x2_D2 )=imresize( matrix1_D2', [y2_D2-y1_D2+1 x2_D2-x1_D2+1]);
                Segmentation_D12(y1_D2:y2_D2,x1_D2:x2_D2 )=imresize( matrix2_D2', [y2_D2-y1_D2+1 x2_D2-x1_D2+1]);
            end
        end
        if x1_D1<x1_D2
            x1=x1_D1;
        elseif x1_D1>x1_D2
            x1=x1_D2;
        elseif isempty(x1_D2)
            x1=x1_D1;
        end
        if x1_D1==x1_D2
            x1=x1_D1;
        end
        if y1_D1<y1_D2
            y1=y1_D1 ;
        elseif y1_D1>y1_D2
            y1=y1_D2 ;
        elseif isempty(y1_D2)
            y1=y1_D1;
        end
        if y1_D1==y1_D2
            y1=y1_D1;
        end
        if x2_D1>x2_D2
            x2=x2_D1;
        elseif  x2_D1<x2_D2
            x2=x2_D2;
        elseif isempty(x2_D2)
            x2=x2_D1;
        end
        if x2_D1==x2_D2
            x2=x2_D1;
        end
        if y2_D1>y2_D2
            y2=y2_D1;
        elseif y2_D1<y2_D2
            y2=y2_D2;
        elseif isempty(y2_D2)
            y2=y2_D1;
        end
        if y2_D1==y2_D2
            y2=y2_D1;
        end
        % %  if (get( handles.Merge_channels ,'Value') == get(handles.Merge_channels,'Max'))
        % %   temp_D12=Merged_image(ii+jj_D2-1,handles) ;
        % %  end
        if isempty(findstr('Normal',Vs))~=1
            Data_out(kk+start_kk).cdata= flipdim(temp_D12(y1:y2,x1:x2,:),1)   ;
        end
        
        
        
        if isempty(findstr('X_Rotation',Vs))~=1 %&& (ii<size_vector_D21-1)
            if  ii==1
                if Centroid_matrix_D1(ii,2)>Centroid_matrix_D2(ii,2)
                    Stat='D1 on top' ;
                end
                if Centroid_matrix_D1(ii,2)<Centroid_matrix_D2(ii,2)
                    Stat='D2 on top' ;
                end
            end
            
            if ii<size_vector_D21+1
                if isnan(vector_D2(ii,3)) ~=1 && isnan(vector_D1(ii,3)) ~=1 %%%%%%%%case 1
                    p1=round([Centroid_matrix_D2(ii,1) Centroid_matrix_D2(ii,2)])   ;
                    p2=round([Centroid_matrix_D1(ii,1) Centroid_matrix_D1(ii,2) ]) ;
                    p3=[p2(1)+1 p2(2)];
                    temp_matrix = temp_D12(y1:y2,x1:x2,:);
                    
                    %      figure(1)
                    %      imagesc(temp_D12)
                    %      hold on
                    %
                    %       scatter(p1(1),p1(2),'r')
                    %      scatter(p2(1),p2(2),'g')
                    %       scatter(p3(1),p3(2),'b')
                    %
                    theta= angle_deg_2d_TACWrapper(  p1, p2,p3)-90;
                    Data_out(kk+start_kk).cdata= flipdim( imrotate(temp_matrix,theta+90),1);
                end
            end
        end
        if isempty(findstr('Y_Rotation',Vs))~=1
            if  ii==1
                if Centroid_matrix_D1(ii,2)>Centroid_matrix_D2(ii,2)
                    Stat='D1 on top' ;
                end
                if Centroid_matrix_D1(ii,2)<Centroid_matrix_D2(ii,2)
                    Stat='D2 on top' ;
                end
            end
            if ii<size_vector_D21+1
                if isnan(vector_D2(ii,3)) ~=1 && isnan(vector_D1(ii,3)) ~=1
                    position_in=round([Centroid_matrix_D1(ii,1) Centroid_matrix_D1(ii,2) ; Centroid_matrix_D2(ii,1) Centroid_matrix_D2(ii,2)]) ;
                    x=position_in(1)-position_in(2);
                    y=position_in(3)-position_in(4);
                    theta=asind(y/sqrt(x^2+y^2));
                    if isnan(theta)~=1
                        if x<0
                            if theta>=0 && theta<=90
                                theta=   -theta -90 ;
                            elseif theta<0 && theta>=-90
                                theta=   -theta -90 ;
                            end
                        else  % if x is positive, we are in the left side of y axis and therefore we have to rotate against clockwise (theta must be positive)
                            if theta>=0 && theta<=90
                                theta=   theta +90 ;
                            elseif theta<0 && theta>=-90
                                theta=  theta +90 ;
                            end
                        end
                    end
                    temp_matrix = temp_D12(y1:y2,x1:x2,:);
                    Data_out(kk+start_kk).cdata= flipdim( imrotate(temp_matrix,theta),1);
                else
                    temp_Orientation=[]; order=[];
                    temp_matrix = temp_D12(y1:y2,x1:x2,:);
                    temp_Segmentation=Segmentation_D12(y1:y2,x1:x2,:) ;
                    idx=[];  stats1=[];   order=[];
                    L = bwlabel(temp_Segmentation,4);
                    stats1 = regionprops(L,'Area','Orientation') ;
                    for iii=1:size(stats1,1)
                        idx(iii) =  stats1(iii).Area ;
                    end
                    [idx,order]=sort(idx,'descend');
                    if isempty(order)~=1
                        if order==1
                            temp_Orientation = stats1.Orientation;
                        else
                            temp_Orientation =stats1(order(1)).Orientation  ;
                        end
                        Data_out(kk+start_kk).cdata=  flipdim(imrotate(temp_matrix,-(temp_Orientation)+270),1);
                    end
                end
            end
        end
        if popup_spaces==1 % inside loop
            kk=kk+1;
        end
    end
    if popup_spaces==2 %outside loop
        kk=kk+1;
    end
end

close(h)
% -----------------------------------------------------------

% --------