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
function Cell_Montage_function(handles,n,Vs) %3
Montage=Get_Cell_stack(handles,n,Vs) ;
max_x=0;
max_y=0;

for ii=1:size(Montage,2)
    if max_x<size(Montage(ii).cdata,1)
        max_x=size(Montage(ii).cdata,1);
    end
    if max_y<size(Montage(ii).cdata,2)
        max_y=size(Montage(ii).cdata,2);
    end
end

scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
figure('color','w','units','pixels','position', scrsz) ;

if (get( handles.Merge_channels ,'Value') == get(handles.Merge_channels,'Max'))
    if  max(max(max(Montage(ii).cdata)))<256
        D= uint8(zeros(max_x,max_y,3,ii));
    else
        D= uint16(zeros(max_x,max_y,3,ii));
    end
    
    
    for ii=1:size(Montage,2)
        D(end-size(Montage(ii).cdata,1)+1:end, end-size(Montage(ii).cdata,2)+1:end,:,ii)= Montage(ii).cdata ;
    end
else
    D=zeros(max_x,max_y,1,ii);
    for ii=1:size(Montage,2)
        D(end-size(Montage(ii).cdata,1)+1:end, end-size(Montage(ii).cdata,2)+1:end,1,ii)=Montage(ii).cdata(:,:) ;
    end
end
montage(D, 'DisplayRange', []);
set(gcf,'Colormap',jet);
Div_Cells_str=get(handles.Div_Cells,'string');  n_tag= char(Div_Cells_str(n));
str =strcat(Vs, ' Montage of : ', num2str(n));   title(str);
pause(1)
Name=char(strcat('Dividing_Montage_Vs_',Vs) ) ;
set(gcf,'Name',Name)
Data.Montage=Montage;
Data.Div_start_at_frame=nan;
Data.Cell=char(strcat('Cell- ',num2str(n_tag)));

set(gcf,'Userdata',Data);
pause(1)

if (get(handles.save_Fig_option,'Value') == get(handles.save_Fig_option,'Max'))
    track_what=get(handles.track_by,'Value') ;
    track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ;
    quantify_by=get(handles.track_by,'Value') ;
    quantify_by2=eval(strcat('get(handles.track_what_',num2str(quantify_by),',''Value',''' )')) ;
    segmentation_type=eval(strcat('get(handles.segmentation_type_',num2str(quantify_by),',''Value',''' )')) ;
    switch segmentation_type
        case 1
            segmentation='Raw'
        case 2
            segmentation='Filtered'
        case 3
            segmentation='Segmention'
        case 4
            segmentation='F&T'
        case 5
            segmentation='R&T'
    end
    plot_list=get(handles.Raw_listbox,'String');
    pos=plot_list(1);
    pos=char(pos)  ;
    pos=pos(min(findstr(pos,'Pos'))+3:findstr(pos,'_t')-1) ;
    save_Fig_folder=get(handles.save_Fig_folder,'String');
    backbone_str=char(strcat('Tby_',handles.data_file(3).cdata(track_what,2),'_Qby_',handles.data_file(3).cdata(quantify_by2,2),'_Sby_',segmentation));
    newstr=char(strcat(save_Fig_folder,'Cell_Montage_', backbone_str,'_',Vs,'\') );
    if isdir(newstr)==0
        mkdir(newstr)
    end
    filename=char(get(handles.edit_axes1,'string')) ;
    filename=filename(1:max(strfind(filename, '_t'))) ;
    newstr2=char(strcat(newstr,'Cell_Montage_',backbone_str,'_',Vs,'_',filename,'div_',num2str(n)))  ;
    pause(1)
    saveas(gcf,newstr2)
end
pause(3)
return