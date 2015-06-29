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
function Population_plot_function(handles,str_in,Vs,x) %%4-7
scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
figure('color','w','units','pixels','position', scrsz) ;

track_what=get(handles.track_by,'Value') ;
track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ;
MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;

for ii=1:size(MATRIX,2)
    X=MATRIX(:, ii);
    X(X==0)=[];
    if isempty(X)==1
        break;
    end
end
n=ii/2-1;



X=[];
Y_matrix=zeros(n,x);
if isempty(Vs)==1
    for jj=1:n
        
        Y=eval(strcat('Get_Cell_',str_in,'(handles,jj,Vs)') )'  ;
        if strcmp(str_in,'Intensity')==1 || strcmp(str_in,'I_per_A')==1
            Y=Y';
        end
        if isempty(Y)~=1
            Y=imresize(Y,[1 x])
            Y_matrix(jj,:)= Y ;
        end
        
        Y_data(jj).cdata=Y;
    end
    if get(handles.subplot_on,'value')==1
        x_size_plot_vector=[1 2 2 2 3 3 3 3 3 4 4 4 4 4 4 5];
        y_size_plot_vector=[1 1 2 2 2 3 3 3 3 3 4 4 4 4 4 4];
        subplot( x_size_plot_vector( handles.size_plot) ,y_size_plot_vector(handles.size_plot),handles.current_plot);
        hold on
    end
    boxplot(Y_matrix,'plotstyle','compact')
    xlabel('Frames');  str_y=strcat(str_in, ' of Cell from population');  ylabel(str_y) ;
    axis tight
    set(gcf,'userdata',Y_data);
    return
end

%  p 003 add vs option (for type 2 only)
for jj=1:n %a. All data functions about the cells:
    Y=eval(strcat('Get_Cell_',str_in,'(handles,jj,Vs)') );
    if findstr(Vs,'Time')
        X=1:length(Y) ;
    end
    if strfind(Vs,'Intensity')
        X=Get_Cell_Intensity(handles,n,Vs) ;
        Vs_X='Intensity';
    end
    if strfind(Vs,'Area')
        X=Get_Cell_Area(handles,n,Vs) ;
        Vs_X='Area';
    end
    if  strfind(Vs,'Eccentricity')
        X=Get_Cell_Eccentricity(handles,n,Vs) ;
        Vs_X='Eccentricity';
    end
    if strfind(Vs,'Orientation')
        X=Get_Cell_Orientation(handles,n,Vs) ;
        Vs_X='Orientation';
    end
    if   strfind(Vs,'Velocity')
        X=Get_Cell_Velocity(handles,n,Vs) ;
        Vs_X='Velocity';
    end
    if strfind(Vs,'Polarisation')
        X=Get_Cell_Polarisation(handles,n,Vs) ;
        Vs_X='Polarisation';
    end
    if strfind(Vs,'EquivDiameter')
        X=Get_Cell_EquivDiameter(handles,n,Vs) ;
        Vs_X='EquivDiameter' ;
    end
    if strfind(Vs,'Ellipticity')
        X=Get_Cell_Ellipticity(handles,n,Vs) ;
        Vs_X='Ellipticity' ;
    end
    
    if findstr(Vs,'Circularity')
        X=Get_Cell_Circularity(handles,n,Vs) ;
        Vs_X= 'Circularity';
    end
    if findstr(Vs,'Extent')
        X=Get_Cell_Extent(handles,n,Vs) ;
        Vs_X= 'Extent';
    end
    
    if findstr(Vs,'Perimeter')
        X=Get_Cell_Perimeter(handles,n,Vs) ;
        Vs_X= 'Perimeter';
    end
    if findstr(Vs,'Solidity')
        X=Get_Cell_Solidity(handles,n,Vs) ;
        Vs_X= 'Solidity';
    end
    if findstr(Vs,'graycoprops_Contrast')
        X=Get_Cell_graycoprops_Contrast(handles,n,Vs) ;
        Vs_X= 'graycoprops_Contrast';
    end
    if findstr(Vs,'graycoprops_Correlation')
        X=Get_Cell_graycoprops_Correlation(handles,n,Vs) ;
        Vs_X= 'graycoprops_Correlation';
    end
    if findstr(Vs,'graycoprops_Energy')
        X=Get_Cell_graycoprops_Energy(handles,n,Vs) ;
        Vs_X= 'graycoprops_Energy';
    end
    if findstr(Vs,'graycoprops_Homogeneity')
        X=Get_Cell_graycoprops_Homogeneity(handles,n,Vs) ;
        Vs_X= 'graycoprops_Homogeneity';
    end
    if findstr(Vs,'std2')
        X=Get_Cell_std2(handles,n,Vs) ;
        Vs_X= 'std2';
    end
    if findstr(Vs,'number_of_peaks_X')
        X=Get_Cell_number_of_peaks_X(handles,n,Vs) ;
        Vs_X= 'number_of_peaks_X';
    end
    if findstr(Vs,'number_of_peaks_Y')
        X=Get_Cell_number_of_peaks_Y(handles,n,Vs) ;
        Vs_X= 'number_of_peaks_Y';
    end
    if findstr(Vs,'number_of_disks')
        X=Get_Cell_number_of_disks(handles,n,Vs) ;
        Vs_X= 'number_of_disks';
    end
    
    
    
    if length(X)>length(Y)
        X=X(1:length(Y));
    elseif length(Y)>length(X)
        Y=Y(1:length(X));
    end
    X_data(jj).cdata=X;
    Y_data(jj).cdata=Y;
end
C=jet(n);
if get(handles.subplot_on,'value')==1
    x_size_plot_vector=[1 2 2 2 3 3 3 3 3 4 4 4 4 4 4 5];
    y_size_plot_vector=[1 1 2 2 2 3 3 3 3 3 4 4 4 4 4 4];
    subplot( x_size_plot_vector( handles.size_plot) ,y_size_plot_vector(handles.size_plot),handles.current_plot,'Parent',gcf,'ZColor',[1 1 1],'YColor',[1 1 1], 'XColor',[1 1 1], 'Color',[0 0 0]);
else
    showaxes('black')
    set(gcf, 'Color',[1 1 1]);
end
hold on
for ii=1:n
    plot(X_data(ii).cdata,Y_data(ii).cdata, 'MarkerFaceColor',C(ii,:),'MarkerEdgeColor',C(ii,:), 'Marker','square', 'LineStyle','none');
    Data.X_data(ii).cdata=X ;
    Data.Y_data(ii).cdata=Y ;
end
xlabel(Vs)
ylabel(str_in)
title('Data for popuation')
axis tight
Div_Cells=get(handles.Div_Cells,'string');
legend(Div_Cells );
set(legend,'Color',[1 1 1])
set(gcf,'userdata',Data);
Name=char(strcat('Population_',str_in,'_Vs_',Vs) ) ;
set(gcf,'Name',Name)
if (get(handles.save_Fig_option,'Value') == get(handles.save_Fig_option,'Max'))
    %   track_by=get(handles.track_by,'Value') ;
    %   track_by=eval(strcat('get(handles.track_what_',num2str(track_by),',''Value',''' )')) ;
    quantify_by=get(handles.track_by,'Value') ;
    quantify_by2=eval(strcat('get(handles.track_what_',num2str(quantify_by),',''Value',''' )')) ;
    plot_list=get(handles.Raw_listbox,'String');
    pos=plot_list(1);
    pos=char(pos)  ;
    pos=pos(min(findstr(pos,'Pos'))+3:findstr(pos,'_t')-1) ;
    save_Fig_folder=get(handles.save_Fig_folder,'String');
    newstr=char(strcat(save_Fig_folder, Name, '_',handles.data_file(3).cdata(track_what,2),'_',handles.data_file(3).cdata(quantify_by2,2),'\') );
    if isdir(newstr)==0
        mkdir(newstr)
    end
    filename=char(get(handles.edit_axes1,'string')) ;
    filename=filename(1:max(strfind(filename, '_t'))) ;
    newstr=char(strcat(newstr, Name, '_',handles.data_file(3).cdata(track_what,2),'_',handles.data_file(3).cdata(quantify_by2,2),'_',filename));
    pause(5)
    saveas(gcf,newstr)
end
