
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
function Cell_2D_Projection_function(handles,n,Vs) %4
Data=Get_Cell_stack(handles,n,Vs)
maxi=[];
projection=[];

if get(handles.Merge_channels,'value')==get(handles.Merge_channels,'max')
    for ii=1: size(Data,2)
        Data1(ii).cdata=Data(ii).cdata(:,:,1);
        Data2(ii).cdata=Data(ii).cdata(:,:,2);
        Data3(ii).cdata=Data(ii).cdata(:,:,3);
    end
    projection_matrix1 =stack2Yprojection(Data1);
    projection_matrix2 =stack2Yprojection(Data2);
    projection_matrix3 =stack2Yprojection(Data3);
    
    projection_matrix1=uint8((projection_matrix1./(max(max(projection_matrix1))))*255) ;
    projection_matrix2=uint8((projection_matrix2./(max(max(projection_matrix2))))*255);
    projection_matrix3=uint8((projection_matrix3./(max(max(projection_matrix3))))*255);
    
    projection_matrix  = cat(3, projection_matrix1 , projection_matrix2 , projection_matrix3 );
    
else
    projection_matrix=stack2Yprojection(Data);   projection_matrix=   medfilt2 (projection_matrix);
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
%%%%%%
track_what=get(handles.track_by,'Value') ;
track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ;
Div_Cells= Div_Cells_str;
MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata ;
Cell= n;
Cell2=char(Div_Cells(Cell));
Point=findstr(Cell2,'.') ;
if isempty(Point)~=1
    Cell=str2num(Cell2(1:Point-1));
else
    Cell=str2num(Cell2);
end

jj=1;max_Points=0;
for ii=1:size(Div_Cells,1)
    temp_Div_Cells=char(Div_Cells(ii)) ;
    Point=findstr(temp_Div_Cells,'.');
    if max_Points<length(Point)
        max_Points=length(Point);
    end
    if isempty(Point)~=1
        temp_Cell=temp_Div_Cells(1:Point(1)-1);
        if  str2num(temp_Cell)==Cell
            new_Div_Cells(jj,1)=  Div_Cells(ii);
            %%
            cell_index= ii
            V=MATRIX(:,cell_index*2-1);
            V=V(find(V, 1 ):find(V, 1, 'last' )) ;
            
            
            for start_XY=1:size(MATRIX,1)
                if MATRIX(start_XY,cell_index*2 -1)>0
                    break
                end
            end
            V=cumsum(V); Index=find(ismember(V,max(max(V)))); end_XY=Index(1);
            %%
            new_Div_Cells(jj,2)=  {num2str(start_XY)};  new_Div_Cells(jj,3)= { num2str(end_XY+start_XY-1)};
            %%%%must be here
            %              new_Div_Cells(jj,4)=
            temp_vec= MATRIX(end_XY+start_XY-1,cell_index*2-1:cell_index*2) ;
            centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(end_XY+start_XY-1).cdata;
            for kk=1:size(centy1,1)
                if  temp_vec(1)==centy1(kk,1) &&  temp_vec(2)==centy1(kk,2)
                    break
                end
            end
            
            if abs((centy1(kk,3)- (end_XY+start_XY-1)-0.2))<0.001
                new_Div_Cells(jj,4)={num2str(1)};
            else
                new_Div_Cells(jj,4)={num2str(0)};
            end
            jj=jj+1;
        end
    else
        if  str2num(temp_Div_Cells)==Cell
            new_Div_Cells(jj,1)= Div_Cells(ii);
            cell_index= ii
            
            V=MATRIX(:,cell_index*2-1) ;
            V=V(find(V, 1 ):find(V, 1, 'last' )) ;
            
            
            for start_XY=1:size(MATRIX,1)
                if MATRIX(start_XY,cell_index*2 -1)>0
                    break
                end
            end
            
            V=cumsum(V); Index=find(ismember(V,max(max(V)))); end_XY=Index(1);
            %%
            
            new_Div_Cells(jj,2)=  {num2str(start_XY)};  new_Div_Cells(jj,3)= { num2str(end_XY+start_XY-1)};
            
            %%%%must be here
            temp_vec=MATRIX(end_XY+start_XY-1,cell_index*2-1:cell_index*2) ;
            centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(end_XY+start_XY-1).cdata;
            
            for kk=1:size(centy1,1)
                if  temp_vec(1)==centy1(kk,1) &&  temp_vec(2)==centy1(kk,2)
                    break
                end
            end
            
            
            if abs((centy1(kk,3)- (end_XY+start_XY-1)-0.2))<0.001
                new_Div_Cells(jj,4)={num2str(1)};
            else
                new_Div_Cells(jj,4)={num2str(0)};
            end
            jj=jj+1;
            
        end
    end
end


Data=[];
Data.Projection=projection_matrix;
Data.Lineage_data=new_Div_Cells;
set(gcf,'userdata',Data);

Name=char(strcat('Cell- ',Vs,'_Projection'));
set(gcf,'Name',Name)
if (get(handles.save_Fig_option,'Value') == get(handles.save_Fig_option,'Max'))
    track_what=get(handles.track_by,'Value') ;
    track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ;
    quantify_by=get(handles.track_by,'Value') ;
    quantify_by2 =eval(strcat('get(handles.track_what_',num2str(quantify_by),',''Value',''' )')) ;
    plot_list=get(handles.Raw_listbox,'String');
    pos=plot_list(1);
    pos=char(pos)  ;
    pos=pos(min(findstr(pos,'Pos'))+3:findstr(pos,'_t')-1) ;
    save_Fig_folder=get(handles.save_Fig_folder,'String');
    newstr=char(strcat(save_Fig_folder,'Cell_2D_Projection_',handles.data_file(3).cdata(track_what,2),'_',handles.data_file(3).cdata(quantify_by2,2),'_',Vs,'\') );
    if isdir(newstr)==0
        mkdir(newstr)
    end
    filename=char(get(handles.edit_axes1,'string')) ;
    filename=filename(1:max(strfind(filename, '_t'))) ;
    newstr=char(strcat(newstr,'Cell_2D_Projection_',handles.data_file(3).cdata(track_what,2),'_',handles.data_file(3).cdata(quantify_by2,2),'_',Vs,'_',filename,'div_',num2str(n)))
    
    pause(5)
    saveas(gcf,newstr)
end
