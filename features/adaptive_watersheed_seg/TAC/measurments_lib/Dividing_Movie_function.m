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
function Dividing_Movie_function(handles,n,D1,D2,Vs) %2
[Data,Stat,start_ii]=Get_Dividing_stack(handles,n,D1,D2,Vs) ;

pause(0.2)
scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
h=figure('color','w','units','pixels','position', scrsz) ;
set(h,'colormap',handles.c);

if get(handles.save_Fig_option,'Value' ) == 1
    track_what=get(handles.track_by,'Value') ;
    track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ;
    quantify_by=get(handles.track_by,'Value') ;
    quantify_by2=eval(strcat('get(handles.track_what_',num2str(quantify_by),',''Value',''' )')) ;
    plot_list=get(handles.Raw_listbox,'String');
    pos=plot_list(1);
    pos=char(pos)  ;
    pos=pos(min(findstr(pos,'Pos'))+3:findstr(pos,'_t')-1) ;
    save_Fig_folder=get(handles.save_Fig_folder,'String');
    newstr=char(strcat(save_Fig_folder,'Dividing_2D_Movie_',handles.data_file(3).cdata(track_what,2),'_',handles.data_file(3).cdata(quantify_by2,2),'_',Vs,'\') );
    if isdir(newstr)==0
        mkdir(newstr)
    end
    filename=char(get(handles.edit_axes1,'string')) ;
    filename=filename(1:max(strfind(filename, '_t'))) ;
    newstr=char(strcat(newstr,'Dividing_2D_Movie_',handles.data_file(3).cdata(track_what,2),'_',handles.data_file(3).cdata(quantify_by2,2),'_',Vs,'_',filename,'div_',num2str(n)));
    
    for ii=1:size(Data,2)
        h=imagesc(Data(ii).cdata);
        if isempty(Data(ii).cdata)~=1
            axis equal
            axis tight
            Div_Cells_str=get(handles.Div_Cells,'string');   D1_tag= char(Div_Cells_str(D1)) ;  D2_tag= char(Div_Cells_str(D2));
            if findstr(Stat,'D1 on top')==1
                str_UP=strcat('D1: ',num2str(D1_tag));
                str_DOWN=strcat('D2: ',num2str(D2_tag));
                title(str_UP); xlabel(str_DOWN);
            end
            if findstr(Stat,'D2 on top')==1
                str_UP=strcat('D2: ',num2str(D2_tag));
                str_DOWN=strcat('D1: ',num2str(D1_tag));
                title(str_UP); xlabel(str_DOWN);
            end
            pause(0.15)
            F(ii)= getframe(gcf);
            pause(0.15)
            %   imwrite( temp(1).cdata , newstr,'WriteMode','append');
            %  imwrite( Data(ii).cdata,newstr,'WriteMode','append');
        end
    end
    
    hold off;
    movie2avi(F, newstr ,'compression','None','fps' , 5)
end

if get(handles.save_Fig_option,'Value' ) ~= 1
    for ii=1:size(Data,2)
        h=imagesc(Data(ii).cdata);
        if isempty(Data(ii).cdata)~=1
            axis equal
            axis tight
            Div_Cells_str=get(handles.Div_Cells,'string');   D1_tag= char(Div_Cells_str(D1)) ;  D2_tag= char(Div_Cells_str(D2));
            if findstr(Stat,'D1 on top')==1
                str_UP=strcat('D1: ',num2str(D1_tag));
                str_DOWN=strcat('D2: ',num2str(D2_tag));
                title(str_UP); xlabel(str_DOWN);
            end
            if findstr(Stat,'D2 on top')==1
                str_UP=strcat('D2: ',num2str(D2_tag));
                str_DOWN=strcat('D1: ',num2str(D1_tag));
                title(str_UP); xlabel(str_DOWN);
            end
            pause(0.15)
        end
    end
end
set(h,'userdata',Data');