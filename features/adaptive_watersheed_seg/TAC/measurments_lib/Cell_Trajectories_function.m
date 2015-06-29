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
function Cell_Trajectories_function(handles,n)   %13

start_frame=n*2-1 ;
track_by=get(handles.track_by,'Value') ;
track_what=eval(strcat('get(handles.track_what_',num2str(track_by),',''Value',''' )')) ;
MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;
[vector jj]=create_vector(MATRIX,handles,start_frame) ;
Data_out=Cell_data_function(vector,handles,jj,'Centroid',1);
X=Data_out(:,1) ;  Y=Data_out(:,2) ;
X=X-(X(1)) ;
Y=Y-(Y(1)) ;
scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
figure('color','w','units','pixels','position', scrsz) ;
vector=1:length(X); vector= vector./5;
h_n_plot=plot(X,Y)
hold on
scatter(X,Y , vector ,'filled' ,'facecolor','black' );
hold off
data.Data_out=Data_out;
data.start=jj ;
data.end=jj+length(X)-1 ;
centy1=handles.data_file(4).cdata.Centroids(track_what).cdata(data.end).cdata ;
XY=(Data_out(end,1)-centy1(:,1)).^2+(Data_out(end,2)-centy1(:,2)).^2;
%find closest centroid to the selected point
XY_min_index=find(ismember(XY,(min(XY))))  ;
centy1(XY_min_index,3)-round(centy1(XY_min_index,3));
data.fate=centy1(XY_min_index,3)-round(centy1(XY_min_index,3));

set(gcf,'userdata',  data)
title_str=strcat('Cell trajectories- ',num2str(n))
title(title_str)

if (get(handles.save_Fig_option,'Value') == get(handles.save_Fig_option,'Max'))
    plot_list=get(handles.Raw_listbox,'String');
    pos=plot_list(1);
    pos=char(pos)  ;
    Name='Cell- Trajectories'
    pos=pos(min(findstr(pos,'Pos'))+3:findstr(pos,'_t')-1) ;
    save_Fig_folder=get(handles.save_Fig_folder,'String');
    
    backbone_str=char(strcat('Tby_',handles.data_file(3).cdata(track_what,2),'_Qby_',handles.data_file(3).cdata(track_what,2)));
    newstr=char(strcat(save_Fig_folder,'Cell_Montage_', backbone_str) );
    if isdir(newstr)==0
        mkdir(newstr)
    end
    filename=char(get(handles.edit_axes1,'string')) ;
    filename=filename(1:max(strfind(filename, '_t'))) ;
    newstr2=char(strcat(newstr,'Cell_trajectories_',backbone_str,'_',filename,'div_',num2str(n)))  ;
    pause(1)
    saveas(gcf,newstr2)
    
end


