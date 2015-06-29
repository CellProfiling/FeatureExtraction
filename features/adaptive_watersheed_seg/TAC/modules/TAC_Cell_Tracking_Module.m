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
function varargout = TAC_Cell_Tracking_Module(varargin)

%      TAC_Cell_Tracking_Module, by itself, creates a new TAC_Cell_Tracking_Module or raises the existing
%      singleton*.
%
%      H = TAC_Cell_Tracking_Module returns the handle to a new TAC_Cell_Tracking_Module or the handle to
%      the existing singleton*.
%
%      TAC_Cell_Tracking_Module('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TAC_Cell_Tracking_Module.M with the given input arguments.
%
%      TAC_Cell_Tracking_Module('Property','Value',...) creates a new TAC_Cell_Tracking_Module or raises the
%      existing singleton*.  Starting from the left, property value pairs
%      are
%      applied to the GUI before TAC_Cell_Tracking_Module_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property
%      application
%      stop.  All inputs are passed to TAC_Cell_Tracking_Module_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TAC_Cell_Tracking_Module

% Last Modified by GUIDE v2.5 05-Feb-2013 12:03:28

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TAC_Cell_Tracking_Module_OpeningFcn, ...
    'gui_OutputFcn',  @TAC_Cell_Tracking_Module_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

function TAC_Cell_Tracking_Module_OpeningFcn(hObject, eventdata, handles, varargin)


global h_TAC_Cell_Tracking_Module ;
h_TAC_Cell_Tracking_Module=handles;
handles.flag.axis1=-1;
handles.flag.axis2=-1;
handles.Y1=1;
handles.X1 =1;
handles.Y =512;
handles.X=512;
c=zeros(64,3);
dic=c;
dic(:,1)=0:0.0158:1;
dic(:,2)=0:0.0158:1;
dic(:,3)=0:0.0158:1;
rfp=c;
rfp(:,1)=0:0.0158:1;
gfp=c;
gfp(:,2)=0:0.0158:1;
cfp=c;
cfp(:,3)=0:0.0158:1;
yfp=c;
yfp(:,1)=0:0.0158:1;
yfp(:,2)=0:0.0158:1;
Cherry=c;
Cherry(:,1)=0:0.0158:1;
Cherry(:,2)= linspace(0,0.2,64)';
handles.c1=dic;
handles.c2=cfp;
handles.c3=gfp;
handles.c4=yfp;
handles.c5=Cherry;
handles.c6=rfp;
A=segmentation_file;
for iii=2:6
    eval(strcat('set(handles.T_popup_',num2str(iii),',''String'',   A) '));
end
if nargin ==3
    backgroundImage = importdata('TACTICS_logo2.jpg');  axes(handles.axes2); image(backgroundImage,'Hittest','Off');
    handles.nargin_num=3;
    handles.output = hObject;
    handles.data_file=[];
    guidata(hObject, handles);
end
if nargin==4
    backgroundImage = importdata('TACTICS_logo2.jpg');  axes(handles.axes2); image(backgroundImage,'Hittest','Off');
    handles.data_file=varargin{1};
    handles.output = hObject;
    guidata(hObject, handles);
    
    if isempty( handles.data_file)==1
        handles.nargin_num=3;
        guidata(hObject, handles);
        return
    end
    
    set(handles.figure1,'userdata',handles.data_file);
    set(handles.Current_Exp,'String',handles.data_file(10).cdata);
    handles.nargin_num=4;
    handles.output = hObject;
    set(handles.showcurrentframe,'String',1);
    set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1)) ;
    set(handles.Raw_listbox,'Value', 1 ) ;
    track_what=1;
    str=handles.data_file(3).cdata( track_what,1);
    if char(str)=='1'
        handles.c=handles.c1;
    elseif char(str)=='2'
        handles.c=handles.c2;
    elseif char(str)=='3'
        handles.c=handles.c3;
    elseif char(str)=='4'
        handles.c=handles.c4 ;
    elseif char(str)=='5'
        handles.c=handles.c5 ;
    elseif char(str)=='6'
        handles.c=handles.c6 ;
    end
    set(gcf,'colormap',handles.c);
    track_what1_Callback(hObject, eventdata, handles)
    track_what2_Callback(hObject, eventdata, handles)
    handles.Y1=1;
    handles.X1=1;
    handles.Y=handles.data_file(6).cdata(3);
    handles.X=handles.data_file(6).cdata(4);
    guidata(hObject,handles);
    n=1;  div_cells=[];
    if   findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')==1
        for ii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
            if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata)~=1
                vec_centy = handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata(:,3) -ii ;
                vec_centy= (round(vec_centy*10))/10;
                if find(ismember(vec_centy,0.1))>0
                    div_cells(n)=ii ;
                    n=n+1 ;
                end
            end
        end
    end
    if isempty(div_cells)~=1
        set(handles.Div_frame_index,'String',div_cells)
    end
    if   findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
        
        MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata   ;
        if isempty(MATRIX)~=1
            ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
            size_x=size(MATRIX,2);
            size_y=size(MATRIX,1);
            tot_size_x=size_x+1;
            tot_size_y=size_y+2;
            if  tot_size_x>676
                lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
            elseif  tot_size_x>26   &&  tot_size_x<676
                lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
            elseif  tot_size_x<27
                lastcell= ABC( tot_size_x) ;
            end
            handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
            handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');  set(handles.track_what2,'userdata',handles.C)
            handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
            guidata(hObject,handles)
        end
        nn=1;div_cells=[];
        last_cell =get_last_cell_index(MATRIX);
        for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
            if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
                centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
                for jj=1:size(centy2,1)  % .
                    if str2num(num2str(centy2(jj,3)- iiii))==0.1
                        for cell_index=2:2:(last_cell-2)
                            if  MATRIX(iiii,cell_index-1)==centy2(jj,1) && MATRIX(iiii,cell_index)==centy2(jj,2)
                                break
                            end
                        end
                        div_cells(nn)=cell_index/2 ;
                        nn=nn+1;
                    end
                end
            end
        end
        if isempty( div_cells)~=1
            [all_cells,parental_cells]=TRYME(div_cells,MATRIX) ;
            set(handles.Div_Cells,'value',1);%set(handles.Div_Cells,'min',0)
            if isempty(all_cells)~=1
                set(handles.Div_Cells,'string',all_cells)
            else
                set(handles.Div_Cells,'string','')
            end
            set(handles.parental_num,'value',1);%set(handles.Div_Cells,'min',0)
            if isempty(parental_cells)~=1
                set(handles.parental_num,'string',parental_cells)
                parental_num_Callback(hObject, eventdata, handles)
            else
                set(handles.parental_num,'string','Choose dividing cell:')
                set(handles.Daughter1_edit,'string','')
                set(handles.Daughter2_edit,'string','')
            end
        end
    end
    set(handles.Raw_listbox,  'value',1, 'Enable','on');
    set(handles.axes2,'userdata',[]);
    %  handles = addPlabackControls(hObject, handles);
    guidata(hObject, handles);
    set(handles.sliderframes2, 'Enable','on', 'SliderStep',[1, 0.1]);  % Matlab scrollbar
    set(handles.active_panel1,'visible','on');     set(handles.Raw_listbox,'visible','on')
    set(handles.figure1,'userdata',handles.data_file);update_labelmatrix(handles)
end
if     nargin ==7
    % loading with handles.data_file
    handles.nargin_num=5;
    handles.data_file=varargin{1};
    guidata(hObject, handles);
    if    isempty(handles.data_file)==1
        handles.output = hObject;
        guidata(hObject, handles);
        return
    end
    handles.output = hObject;
    data_file=varargin{1};
    Channel=varargin{3};
    guidata(hObject, handles);
    
    if Channel==1
        Channel= 1;
    end
    if Channel==2
        Channel= 2; end
    if Channel==3
        Channel=3; end
    if Channel==4
        Channel=4; end
    if Channel==5
        Channel=  [1 2]; end
    if Channel==6
        Channel= [1 3]; end
    if Channel==7
        Channel= [1 4]; end
    if Channel==8
        Channel=[2 3]; end
    if Channel==9
        Channel= [2 4]; end
    if Channel==10
        Channel= [3 4]; end
    if Channel==11
        Channel= [1 2 3]; end
    if Channel==12
        Channel= [1 2 4]; end
    if Channel==13
        Channel=  [2 3 4]; end
    if Channel==14
        Channel=  [1 3 4]; end
    if Channel==15
        Channel=  [1 2 3 4]; end
    
    for jjj=1:length(Channel)
        set(handles.track_what1,'Value',Channel(jjj) )
        track_what=Channel(jjj);
        data_file(7).cdata(track_what,2) =cellstr('Y');
        box_Raw=data_file(1).cdata(:,1);
        pathname_Segmentation= data_file(2).cdata(track_what,3) ;
        n=size(box_Raw,1);
        %3. once data waas loaded, Centroids are calulated-
        % execute when button track cells is performed. Basically generate list of
        % trajectoroes of cells from binarised fluorescence images
        h=timebar_TACWrapper('Find centroids. Please wait....');
        set(h,'color','w');
        for ii=1:n  %2 Procced only if the complimantory Segmentation file was found
            centy1=[];
            timebar_TACWrapper(h,ii/n)
            filename_Segmentation=box_Raw(ii) ;
            full_filename_Segmentation= strcat(pathname_Segmentation,filename_Segmentation,'_ch0',num2str(track_what-1),'_Segmented.tif') ;
            full_filename_Segmentation=char(full_filename_Segmentation) ;
            temp_Segmentation=imread( full_filename_Segmentation,1);
            temp_Segmentation=flipdim(temp_Segmentation,1);
            L=bwlabel(temp_Segmentation,4);
            stats=regionprops(L,'Centroid') ;
            for jj=1:length(stats)
                temp_centy=[stats(jj).Centroid ii] ;
                temp_centy=  (round(temp_centy.*100))./100;
                centy1(jj,:)=  temp_centy;
            end
            XY_data(ii).cdata= centy1   ;
            clear centy1;
            pause(0.1);  %let the computer time to cool itself
        end
        close(h)
        data_file(4).cdata.Centroids(track_what).cdata=XY_data;XY_data=[];
        h4=timebar_TACWrapper('Label cells. Please wait....');
        set(h4,'color','w');
        for ii=1:n %2 Procced only if the complimantory Segmentation file was found
            timebar_TACWrapper(h4,ii/n)
            filename_Segmentation=box_Raw(ii) ;
            full_filename_Segmentation= char(strcat(data_file(2).cdata(track_what,3),filename_Segmentation,'_ch0',num2str(track_what-1),'_Segmented.tif')) ;
            full_filename_Segmentation=char(full_filename_Segmentation) ;
            temp_Segmentation=imread( full_filename_Segmentation,1);
            temp_Segmentation=flipdim(temp_Segmentation,1);
            temp_Segmentation2=zeros(size(temp_Segmentation));
            position= data_file(6).cdata ;
            temp_Segmentation2(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1) )  =  temp_Segmentation(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1) );
            L=bwlabel(temp_Segmentation2,4);
            XY_data(ii).cdata= regionprops(L,'Area','BoundingBox','Centroid','PixelList','Orientation','Eccentricity','Perimeter','Extent','Solidity','Majoraxislength','Minoraxislength','EquivDiameter');
            pause(0.1);  %let the computer time to cool itself
        end
        for ii=1:n
            for iii=1:size(XY_data(ii).cdata,1)
                XY_data(ii).cdata(iii).Centroid= round(XY_data(ii).cdata(iii).Centroid*100)/100;
            end
        end
        close(h4)
        data_file(4).cdata.L(track_what).cdata=XY_data ;
        centy1 = data_file(4).cdata.Centroids(track_what).cdata ;
        max_velocity=100;
        h4=waitbar(0,'Hungarian algorithm in action')
        for ii=1:n-1
            waitbar(ii/(n))
            if  isempty(centy1(ii).cdata)~=1 &&  isempty(centy1(ii+1).cdata)~=1
                centy1(ii+1).cdata(:,4)=hungarianlinker_TACWrapper(centy1(ii+1).cdata(:,1:2),centy1(ii).cdata(:,1:2),max_velocity);
            end
            if  isempty(centy1(ii).cdata)==1 ||  isempty(centy1(ii+1).cdata)==1
                centy1(ii+1).cdata(:,1:2)=0;  centy1(ii+1).cdata(:,4)=-1;
            end
            if  isempty(centy1(ii).cdata)~=1 &&  isempty(centy1(ii+1).cdata)==1
                'do nothing'
            end
            if  isempty(centy1(ii).cdata)==1 &&  isempty(centy1(ii+1).cdata)==1
                'do nothing'
            end
        end
        close(h4)
        data_file(4).cdata.Centroids(track_what).cdata= centy1 ;
        min_length=1 ;
        data_file(5).cdata.Tracks(track_what ).cdata= Find_Tracks(centy1,1, n,[], min_length,2) ;
        data_file(7).cdata(track_what,1) =cellstr('Y'); %Now flag for track is Yes
    end
    full_filename=char(varargin{2});
    save (full_filename ,  'data_file')
    handles.output = hObject;
end

%%%%%%%%

if     nargin ==6
    
    handles.nargin_num=5;
    handles.data_file=varargin{1};
    guidata(hObject, handles);
    %             if    isempty(handles.data_file)==1
    %                    handles.output = hObject;
    %                    guidata(hObject, handles);
    %                    return
    %             end
    track_what=1
    data_file=varargin{1}
    
    box_Raw=data_file(1).cdata(:,1);
    n=size(box_Raw,1);
    
    full_filename=char(varargin{2});
    
    
    DATA_file_name=varargin{3}   ;
    temp_segmented=importdata(DATA_file_name);
    temp_segmented=flipdim(temp_segmented,1);
    temp=bwlabel(temp_segmented);
    
    for nn=1:max(max(temp))
        
        temp_sectional.data_file=data_file;
        temp2=bwlabel(temp_segmented);
        temp2(temp2~=nn)=0;
        temp2=temp2./temp2;
        temp2(isnan(temp2))=0;
        
        
        stats=regionprops(temp2,'BoundingBox')  ;
        XY=stats(1).BoundingBox  ;
        XY(3)=XY(1)+XY(3); XY(4)=XY(2)+XY(4) ;
        XY =[XY(1) XY(2); XY(1) XY(4)  ;   XY(3) XY(4);  XY(3) XY(2)]  ;
        ROI=XY ;
        
        centy1 =  data_file(4).cdata.Centroids(track_what).cdata ;
        centy2 =  data_file(4).cdata.L(track_what).cdata ;
        h4=timebar_TACWrapper('Remove centroids. Please wait....');
        set(h4,'color','w');
        for ii=1:n %2 Procced only if the complimantory Segmentation file was found
            try
                kk=1;
                temp_centy=centy1(ii).cdata;
                in=inpolygon( temp_centy(:,1), temp_centy(:,2),ROI(:,1),ROI(:,2));
                centy1(ii).cdata= temp_centy(ismember(in,1),:);
            end
        end
        temp_sectional.data_file(4).cdata.Centroids(track_what).cdata=  centy1 ;
        for ii=1:n %2 Procced only if the complimantory Segmentation file was found
            timebar_TACWrapper(h4,ii/n)
            kk=1;   clear centy3 % imprtant: centry3=[] is not good here!
            kk=1;   clear centy3 % imprtant: centry3=[] is not good here!
            for jj=1:size(centy2(ii).cdata,1);
                temp_centy= centy2(ii).cdata(jj).Centroid  ;
                in=inpolygon( temp_centy(:,1), temp_centy(:,2),ROI(:,1),ROI(:,2))  ;
                if in==1
                    centy3(kk) =centy2(ii).cdata(jj)  ;  kk=kk+1;
                end
            end
            try
                centy2(ii).cdata=centy3';
            catch
                centy2(ii).cdata=[];
            end
            
        end
        temp_sectional.data_file(4).cdata.L(track_what).cdata= new_stack;
        close(h4)
        full_filename2=regexprep(full_filename,'.dat',''); full_filename2=char(strcat( full_filename2,'_Section_',num2str(nn),'.dat'));
        temp_data=temp_sectional.data_file;
        save (full_filename2 ,  'temp_data')
    end
    handles.output = hObject;
end

%%%%%
if nargin ==9
    handles.nargin_num=9;
    handles.data_file=varargin{1};
    handles.output = hObject;
    guidata(hObject, handles);
    if isempty( handles.data_file)==1
        handles.nargin_num=3;
        guidata(hObject, handles);
        return
    end
    set(handles.figure1,'userdata',handles.data_file);
    set(handles.Current_Exp,'String',handles.data_file(10).cdata);
    handles.output = hObject;
    set(handles.track_what1,'Value',varargin{6})
    track_what=varargin{2};
    set(handles.track_what2,'Value',track_what)
    set(handles.Projected_by,'Value',varargin{3})
    guidata(hObject, handles);
    cell_index= varargin{4} ;
    MATRIX=  handles.data_file(5).cdata.Tracks(track_what ).cdata ;
    V=MATRIX(:,cell_index*2-1)./MATRIX(:,cell_index*2-1);
    [~,index]=nanmin(V)
    index=varargin{5}+index -1;
    
    
    
    set(handles.showcurrentframe,'String',num2str(index));
    set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1)) ;
    
    
    str=handles.data_file(3).cdata( varargin{6},1);
    set(handles.Raw_listbox,  'value',index, 'Enable','on');
    
    if char(str)=='1'
        handles.c=handles.c1;
    elseif char(str)=='2'
        handles.c=handles.c2;
    elseif char(str)=='3'
        handles.c=handles.c3;
    elseif char(str)=='4'
        handles.c=handles.c4 ;
    elseif char(str)=='5'
        handles.c=handles.c5 ;
    elseif char(str)=='6'
        handles.c=handles.c6 ;
    end
    set(gcf,'colormap',handles.c);
    track_what1_Callback(hObject, eventdata, handles)
    track_what2_Callback(hObject, eventdata, handles)
    handles.Y1=1;
    handles.X1=1;
    handles.Y=handles.data_file(6).cdata(3);
    handles.X=handles.data_file(6).cdata(4);
    guidata(hObject,handles);
    n=1;  div_cells=[];
    if   findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')==1
        for ii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
            if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata)~=1
                vec_centy = handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata(:,3) -ii ;
                vec_centy= (round(vec_centy*10))/10;
                if find(ismember(vec_centy,0.1))>0
                    div_cells(n)=ii ;
                    n=n+1 ;
                end
            end
        end
    end
    if isempty(div_cells)~=1
        set(handles.Div_frame_index,'String',div_cells)
    end
    if   findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
        
        MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata   ;
        if isempty(MATRIX)~=1
            ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
            size_x=size(MATRIX,2);
            size_y=size(MATRIX,1);
            tot_size_x=size_x+1;
            tot_size_y=size_y+2;
            if  tot_size_x>676
                lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
            elseif  tot_size_x>26   &&  tot_size_x<676
                lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
            elseif  tot_size_x<27
                lastcell= ABC( tot_size_x) ;
            end
            handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
            handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');  set(handles.track_what2,'userdata',handles.C)
            handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
            guidata(hObject,handles)
        end
        nn=1;div_cells=[];
        last_cell =get_last_cell_index(MATRIX);
        for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
            if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
                centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
                for jj=1:size(centy2,1)  % .
                    if str2num(num2str(centy2(jj,3)- iiii))==0.1
                        for cell_index=2:2:(last_cell-2)
                            if  MATRIX(iiii,cell_index-1)==centy2(jj,1) && MATRIX(iiii,cell_index)==centy2(jj,2)
                                break
                            end
                        end
                        div_cells(nn)=cell_index/2 ;
                        nn=nn+1;
                    end
                end
            end
        end
        if isempty( div_cells)~=1
            [all_cells,parental_cells]=TRYME(div_cells,MATRIX) ;
            
            if isempty(all_cells)~=1
                set(handles.Div_Cells,'string',all_cells)
                set(handles.Div_Cells,'value',cell_index)
            else
                set(handles.Div_Cells,'string','')
                set(handles.Div_Cells,'value',1)
            end
            
            set(handles.parental_num,'value',1);%set(handles.Div_Cells,'min',0)
            if isempty(parental_cells)~=1
                set(handles.parental_num,'string',parental_cells)
                parental_num_Callback(hObject, eventdata, handles)
            else
                set(handles.parental_num,'string','Choose dividing cell:')
                set(handles.Daughter1_edit,'string','')
                set(handles.Daughter2_edit,'string','')
            end
        end
        set(handles.Div_Cells,'value',cell_index)
    end
    
    
    
    
    set(handles.axes2,'userdata',[]);
    %  handles = addPlabackControls(hObject, handles);
    guidata(hObject, handles);
    set(handles.sliderframes2, 'Enable','on', 'SliderStep',[1, 0.1]);  % Matlab scrollbar
    set(handles.active_panel1,'visible','on');     set(handles.Raw_listbox,'visible','on')
    set(handles.figure1,'userdata',handles.data_file);update_labelmatrix(handles)
    
    
end


%  handles = addPlabackControls(hObject, handles);
%  set(hObject, 'ResizeFcn',@figResizeFcn, 'DeleteFcn',@figDeleteFcn);
set(handles.sliderframes2, 'Enable','on', 'SliderStep',[1, 0.1]);  % Matlab scrollbar
tic
set(handles.axes2,'userdata',[]);
%  set(hObject, 'ResizeFcn',@figResizeFcn, 'DeleteFcn',@figDeleteFcn);
guidata(hObject, handles);     h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
axis tight
% --------------------------
function varargout = TAC_Cell_Tracking_Module_OutputFcn(hObject, ~, handles)
%  setWindowState(hObject,'maximize','icon.gif');  % Undocumented feature!
pause(0.05); drawnow;
varargout{1} = handles.output;
switch handles.nargin_num
    case 3
        replaceSlider(hObject,handles);
        varargout{1}=  handles.output;
    case 4
        replaceSlider(hObject,handles);
        varargout{1}=  handles.output;
        
    case 5
        wait_pause('Exit',10,0.1)
        close(TAC_Cell_Tracking_Module)
        Close
        clc
end




function replaceSlider(hFig,handles)
sliderPos = getpixelposition(handles.sliderframes);
delete(handles.sliderframes);
handles.sliderframes = javacomponent('javax.swing.JSlider',sliderPos,hFig);
handles.sliderframes.setEnabled(false);

set(handles.sliderframes,'StateChangedCallback',{@sliderframes_Callback,handles});
guidata(hFig, handles);  % update handles struct
if handles.nargin_num==4
    numFiles =size(handles.data_file(1).cdata(:,1),1); set(handles.end_export,'string',num2str(numFiles));
    set(handles.sliderframes, 'Value',1, 'Maximum',numFiles, 'Minimum',1);
    try
        handles.sliderframes.setEnabled(true);  % Java JSlider
    catch
        set(handles.sliderframes, 'Enable','on', 'SliderStep',[1/numFiles, 0.1]);  % Matlab scrollbar
    end
end
function setWindowState(h,state,iconFilename)
if ~usejava('jvm'),  return;  end
drawnow; %need to make sure that the figures have been rendered or Java error can occur

%get the javaframes and desired operations
% is h all figure handles
if ~all(ishandle(h)) || ~isequal(length(h),length(findobj(h,'flat','Type','figure')))
    return;
end %if

%check that the states are all valid
if ~ismember(state,{'maximize','minimize','restore'}),  return;  end

% Get the figure's java frame
warning off MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame
jf = get(h,'javaframe');

%get version so we know which method to call
v = ver('matlab');
switch v.Release
    case {'(R14SP2)','(R14SP3)'}
        awtinvoke(jf,state);
    otherwise
        fp = jf.fFigureClient.getFrameProxy;
        switch state
            case 'maximize'
                awtinvoke(fp,'setMaximized(Z)',true)
            case 'minimize'
                awtinvoke(fp,'setMinimized(Z)',true)
            case 'restore'
                awtinvoke(fp,'setMaximized(Z)',false)
        end %switch
end %switch

% Set the java frame's icon
try
    newIcon = javax.swing.ImageIcon(iconFilename);
    jf.setFigureIcon(newIcon);
catch
    % never mind - filename is probably missing or invalid icon file
end

drawnow;
%end %setWindowState

function figResizeFcn(hFig,varargin)
handles = guidata(hFig);


% ---------------------------------------------------
function Raw_listbox_CreateFcn(~, ~, ~)

function sliderframes_CreateFcn(hObject, ~, handles)
% The folowing is undocumented! - callback for continuous slider movement
hListener = handle.listener(hObject,'ActionEvent',{@sliderframes_Callback,handles});
setappdata(hObject,'listener__',hListener);

%     function figResizeFcn(hFig,varargin)    %#ok
%      handles = guidata(hFig);
%
function showcurrentframe_Callback(hObject, eventdata, handles)
n=get( hObject,'string');
n=round(str2double(n));
set( handles.Raw_listbox,'value',n)
Raw_listbox=get( handles.Raw_listbox,'string');
if n>0
    if n<size(Raw_listbox,1)
        Raw_listbox_Callback(hObject, eventdata, handles)
    end
    
end
function showcurrentframe_CreateFcn(~, ~, ~)
function Show_boundingbox_Callback(hObject, eventdata, handles)
Raw_listbox_Callback(hObject, eventdata, handles)


function Projected_by_CreateFcn(~, ~, ~)
function segmentation_type1_CreateFcn(~, ~, ~)
function track_what1_CreateFcn(~, ~, ~)
function Div_Cells_CreateFcn(~, ~, ~)
function Div_frame_index_CreateFcn(~, ~, ~)
function MA_value_Callback(~, ~, ~)
function MA_value_CreateFcn(~, ~, ~)
function start_export_Callback(~, ~, ~)
function start_export_CreateFcn(~, ~, ~)
function end_export_Callback(~, ~, ~)
function end_export_CreateFcn(~, ~, ~)
function Daughter1_edit_Callback(~, ~, ~)
function Daughter2_edit_Callback(~, ~, ~)
function Daughter2_edit_CreateFcn(~, ~, ~)
function parental_num_CreateFcn(~, ~, ~)
function Daughter1_edit_CreateFcn(~, ~, ~)
function Current_Exp_CreateFcn(~, ~, ~)
function fspecial_type_CreateFcn(~, ~, ~)
function apply_threshold_CreateFcn(~, ~, ~)
function bwmorph_type_CreateFcn(~, ~, ~)
function axes2_CreateFcn(~, ~, ~)
function strel_type_CreateFcn(~, ~, ~)
function select_mode_filtered_CreateFcn(~, ~, ~)
function select_mode_segmentation_CreateFcn(~, ~, ~)
function T_popup_1_CreateFcn(~, ~, ~)
function T_popup_2_CreateFcn(~, ~, ~)
function T_popup_3_CreateFcn(~, ~, ~)
function T_popup_4_CreateFcn(~, ~, ~)
function T_popup_5_CreateFcn(~, ~, ~)
function T_popup_6_CreateFcn(~, ~, ~)
function thresh_level_CreateFcn(~, ~, ~)
function T_Slider_2_CreateFcn(~, ~, ~)
function T_Slider_3_CreateFcn(~, ~, ~)
function T_Slider_4_CreateFcn(~, ~, ~)
function T_Slider_5_CreateFcn(~, ~, ~)
function T_Slider_6_CreateFcn(~, ~, ~)
function T_edit_1_CreateFcn(~, ~, ~)
function T_edit_2_CreateFcn(~, ~, ~)
function T_edit_3_CreateFcn(~, ~, ~)
function T_edit_4_CreateFcn(~, ~, ~)
function T_edit_5_CreateFcn(~, ~, ~)
function T_edit_6_CreateFcn(~, ~, ~)
function MODE_CreateFcn(~, ~, ~)
function start_segmentation_at_CreateFcn(~, ~, ~)
function end_segmentation_at_CreateFcn(~, ~, ~)
% ---------------------------------------------------
function Raw_listbox_Callback(~, ~, handles)
box_Raw=get(handles.Raw_listbox,'string');
if iscell(box_Raw)==0
    return
end
if  toc<0.1
    return
end
tic
n=round(get(handles.Raw_listbox,'Value')) ;
N= str2num(get(handles.showcurrentframe,'String'));
if N<n
    set(handles.forward_button,'Visible','on')
    set(handles.backward_button,'Visible','off')
elseif N>n
    set(handles.forward_button,'Visible','off')
    set(handles.backward_button,'Visible','on')
end
try
    set(handles.sliderframes, 'Minimum',1, 'Maximum',size(box_Raw,1), 'Value',n);
end
set(handles.showcurrentframe,'String',num2str(n));
show_frame( handles,n)  ;
% --------------------------------------------------------------------
% function Load_Callback(hObject, eventdata, handles)
%    set(handles.Div_frame_index,'value',1)
%    set(handles.Div_Cells,'value',1)
%    set(handles.parental_num,'value',1)
%    set(handles.Div_frame_index,'string','Division at frame')
%    set(handles.Div_Cells,'string','Cells list')
%    set(handles.parental_num,'string','Choose dividing cell:')
%    set(handles.Daughter1_edit,'string','')
%    set(handles.Daughter2_edit,'string','')
%    [filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose Raw frames (that have complementary Segmentation frames)'); % handles.directory_name); %pick files to combine
%    if isequal(filename,0)  %$#1
%        h = msgbox('User selected Cancel','Aborted');
%        return;
%    end
%
%    full_filename = strcat(pathname,filename);
%    full_filename = char(full_filename);
%    set(handles.Current_Exp,'String',full_filename);
%    handles.data_file=importdata(full_filename);
%    set(handles.Raw_listbox,'Value',1);
%    set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1));
%    track_what=1;
%    set(handles.track_what1,'Value',1);  set(handles.track_what2,'Value',1);
%    str=[];
%    str=handles.data_file(3).cdata(track_what,1);
%    if str2double(str)<1
%        set(handles.track_what1,'Value',1);set(handles.track_what2,'Value',1);
%        return
%    end
%    guidata(hObject,handles)
%    n=get(handles.Raw_listbox,'Value');
%    c=zeros(64,3);
%    dic=c;
%    dic(:,1)=0:0.0158:1;
%    dic(:,2)=0:0.0158:1;
%    dic(:,3)=0:0.0158:1;
%    rfp=c;
%    rfp(:,1)=0:0.0158:1;
%    gfp=c;
%    gfp(:,2)=0:0.0158:1;
%    cfp=c;
%    cfp(:,3)=0:0.0158:1;
%    yfp=c;
%    yfp(:,1)=0:0.0158:1;
%    yfp(:,2)=0:0.0158:1;
%    Cherry=c;
%    Cherry(:,1)=0:0.0158:1;
%    Cherry(:,2)= linspace(0,0.2,64)';
%
%    handles.c1=dic;
%    handles.c2=cfp;
%    handles.c3=gfp;
%    handles.c4=yfp;
%    handles.c5=Cherry;
%    handles.c6=rfp;
%
%    if char(str)=='1'
%        handles.c=handles.c1;
%    elseif char(str)=='2'
%        handles.c=handles.c2;
%    elseif char(str)=='3'
%        handles.c=handles.c3;
%    elseif char(str)=='4'
%        handles.c=handles.c4;
%    elseif char(str)=='5'
%        handles.c=handles.c5;
%    elseif char(str)=='6'
%        handles.c=handles.c6;
%    end
%    set(gcf,'colormap',handles.c);
%
%    handles.Y1=1;
%    handles.X1=1;
%    handles.Y=handles.data_file(6).cdata(3);
%    handles.X=handles.data_file(6).cdata(4);
%    guidata(hObject,handles);
%
%    n=1;  div_cells=[];
%    if findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')==1
%        for ii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
%            if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata)~=1
%                vec_centy = handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata(:,3) -ii;
%                vec_centy= (round(vec_centy*10))/10;
%                if find(ismember(vec_centy,0.1))>0
%                    div_cells(n)=ii;
%                    n=n+1;
%                end
%            end
%        end
%    end
%    if isempty(div_cells)~=1
%        set(handles.Div_frame_index,'String',div_cells)
%    end
%    if findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
%        MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;
%        if isempty(MATRIX)~=1
%            ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
%            size_x=size(MATRIX,2);
%            size_y=size(MATRIX,1);
%            tot_size_x=size_x+1;
%            tot_size_y=size_y+2;
%            if  tot_size_x>676
%                lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
%            elseif  tot_size_x>26   &&  tot_size_x<676
%                lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
%            elseif  tot_size_x<27
%                lastcell= ABC( tot_size_x);
%            end
%            handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
%           handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');   set(handles.track_what2,'userdata',handles.C)
%            handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
%            guidata(hObject,handles)
%        end
%        nn=1;div_cells=[];
%        last_cell =get_last_cell_index(MATRIX);
%        for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
%            if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
%                centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
%                for jj=1:size(centy2,1)  % .
%                    if str2num(num2str(centy2(jj,3)- iiii))==0.1
%                        for cell_index=2:2:(last_cell-2)
%                            if  MATRIX(iiii,cell_index-1)==centy2(jj,1) && MATRIX(iiii,cell_index)==centy2(jj,2)
%                                break
%                            end
%                        end
%                        div_cells(nn)=cell_index/2;
%                        nn=nn+1;
%                    end
%                end
%            end
%        end
%        if isempty( div_cells)~=1
%            [all_cells,parental_cells]=TRYME(div_cells,MATRIX);
%            set(handles.Div_Cells,'value',1);%set(handles.Div_Cells,'min',0)
%            if  isempty(all_cells)~=1
%                set(handles.Div_Cells,'string',all_cells)
%            else
%                set(handles.Div_Cells,'string','')
%            end
%            set(handles.parental_num,'value',1);%set(handles.Div_Cells,'min',0)
%            if isempty(parental_cells)~=1
%                set(handles.parental_num,'string',parental_cells)
%                parental_num_Callback(hObject, eventdata, handles)
%            else
%                set(handles.parental_num,'string','Choose dividing cell:')
%                set(handles.Daughter1_edit,'string','')
%                set(handles.Daughter2_edit,'string','')
%            end
%        end
%    end
%    %numFiles = size(get(handles.Raw_listbox,'string'),1);
%    numFiles = size(handles.data_file(1).cdata(:,1),1);set(handles.end_export,'string',num2str(numFiles));
%    set(handles.sliderframes, 'Value',1, 'Maximum',numFiles, 'Minimum',1);
%    try
%        handles.sliderframes.setEnabled(true);  % Java JSlider
%    catch
%        set(handles.sliderframes, 'Enable','on', 'SliderStep',[1/numFiles, 0.1]);  % Matlab scrollbar
%
%    end
%    set(handles.Raw_listbox,  'value',1, 'Enable','on');
%    show_frame( handles,1)
%    guidata(hObject, handles); h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);

% ----------------------------------------------------------
function track_what1_Callback(hObject, ~, handles)

track_what =get(handles.track_what1,'Value');
str=handles.data_file(3).cdata(track_what,1);
if str2double(str)<1
    set(handles.track_what1,'Value',1);
    return
end


cla(handles.axes2)



if char(str)=='1'
    handles.c=handles.c1;
    1
elseif char(str)=='2'
    2
    handles.c=handles.c2;
elseif char(str)=='3'
    3;
    handles.c=handles.c3;
elseif char(str)=='4'
    4
    handles.c=handles.c4;
elseif char(str)=='5'
    5
    handles.c=handles.c5;
    
elseif char(str)=='6'
    6
    handles.c=handles.c6;
end
set(gcf,'colormap',handles.c);

guidata(hObject,handles)
n=get(handles.Raw_listbox,'Value');
box_Raw=get(handles.Raw_listbox,'string');
size_boxlist = size(box_Raw,1);

show_frame( handles,n);
show_axes2=get(handles.show_axes2,'value')



if show_axes2<6
    Projected_by_Value=get(handles.Projected_by,'Value')  ;
    Projected_by_Str=get(handles.Projected_by,'String') ;
    Projected_by=char(Projected_by_Str(Projected_by_Value));
    [temp,~,full_filename]= read_image2(handles,n,show_axes2,Projected_by, char(box_Raw(n)),handles.data_file)   ;
    if isempty(temp)==1;
        'cant find the image'
        return;
    end
    axes(handles.axes2); cla
    h_axes2_imagesc=imagesc(temp) ;
    set(h_axes2_imagesc, 'Hittest','Off')   ;
    axis tight
    axis manual
    
end
if    show_axes2==7
    axes(handles.axes1)
    rectangle('Position',[handles.Y1 handles.X1 handles.Y handles.X],'LineWidth',3,'LineStyle','-','EdgeColor','m');
    
    
    
    segmentation_type=get(handles.segmentation_type1,'Value')  ;
    Projected_by_Value=get(handles.Projected_by,'Value')  ;
    Projected_by_Str=get(handles.Projected_by,'String') ;
    Projected_by=char(Projected_by_Str(Projected_by_Value));
    [temp,~,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, char(box_Raw(n)),handles.data_file)   ;
    [   temp_Segmentation,~,full_filename]= read_image2(handles,n,3,Projected_by, char(box_Raw(n)),handles.data_file)   ;
    if isempty( temp_Segmentation)==1
        return
    end
    temp=temp(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1)   ;
    temp_Segmentation=temp_Segmentation(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1) ;
    
    axes(handles.axes2); cla
    h_axes2_imagesc=imagesc(temp) ;
    set(h_axes2_imagesc, 'Hittest','Off')   ;
    bw=im2bw( temp_Segmentation,0)   ;
    [B,L] = bwboundaries(bw ,4,'noholes')   ;
    hold on
    for k = 1:length(B)
        b  = B{k}   ;
        h_axesb_plot=scatter( b(:,2),b(:,1) ,'MarkerFaceColor' ,'m')   ;set(h_axesb_plot, 'Hittest','Off')  ;
    end
    axis tight
    axis manual
end


% ------------------------------------------------------
function Div_frame_index_Callback(hObject, eventdata, handles)
trackdivstr= get(handles.Div_frame_index,'String');
trackdivstr=cellstr(  trackdivstr);
trackdivval= get(handles.Div_frame_index,'Value' );
frame_index=  str2num(char(trackdivstr(trackdivval))); %#ok<ST2NM>
set(handles.Raw_listbox,'Value',frame_index)
Raw_listbox_Callback(hObject, eventdata, handles)
%   ---------------------------------------------------
function Div_Cells_Callback(hObject, eventdata, handles)
cell_index= get(hObject,'Value');
track_what=get(handles.track_what2,'Value');
MATRIX=  handles.data_file(5).cdata.Tracks(track_what ).cdata ;
V=MATRIX(:,cell_index*2-1)./MATRIX(:,cell_index*2-1);
get(handles.Cells_list_option,'value') ;
[~,index]=nanmin(V);
if get(handles.Cells_list_option,'value') == 2
    index=index+nansum(V)-1;
end
set(handles.Raw_listbox,'Value',index)
Raw_listbox_Callback(hObject, eventdata, handles)
%  ------------------------------------------------------
function virtual_stack_mode_Callback(~, ~, ~)

%  -----------------------------------------
function parental_num_Callback(~, ~, handles)
parental_num_str=get(handles.parental_num,'string');
parental_num_val=get(handles.parental_num,'value');
parental_num=parental_num_str(parental_num_val);
div_cells_Vec =get(handles.Div_Cells,'string');
cell_index=find(strcmp(parental_num,  div_cells_Vec ));
trackdivnum=cell_index;
track_what=get(handles.track_what2,'Value');
MATRIX =  handles.data_file(5).cdata.Tracks(track_what).cdata;
if isempty(MATRIX)==1
    'no data at table'
    return
end
V=MATRIX(:,cell_index*2-1);
V=V(find(V, 1 ):find(V, 1, 'last' ));

for start_XY=1:size(MATRIX,1)
    if MATRIX(start_XY,cell_index*2-1)>0
        break
    end
end

end_XY=length(V)+start_XY; % -1
x=MATRIX(end_XY-1,cell_index*2-1);
y=MATRIX(end_XY-1,cell_index*2);
sizee=size(MATRIX,2)/2;
matrix=repmat([1 NaN;NaN 1],1,sizee );
X=matrix(1,:).*MATRIX(end_XY,:);
Y=matrix(2,:).*MATRIX(end_XY,:);
X(isnan(X))=[]; %take off all nans from X vector
Y(isnan(Y))=[]; %take off all nans from X vector
X(X==0)=NaN;
Y(Y==0)=NaN;
XY= (X-x).^2+ (Y-y).^2;%PITAGORAS
XY_min_index=find(ismember(XY,(min(XY))));

if isempty(X(XY_min_index))~=1 || isempty(Y(XY_min_index))~=1
    set(handles.Daughter1_edit,'string',div_cells_Vec(XY_min_index));
end
XY(XY_min_index)=nan;
XY_min_index=find(ismember(XY,(min(XY))));
if isempty(X(XY_min_index))~=1 || isempty(Y(XY_min_index))~=1
    set(handles.Daughter2_edit,'string',div_cells_Vec(XY_min_index));
end
set(handles.Raw_listbox,'Value',end_XY)
show_frame( handles,1)
set(gcf,'colormap',handles.c);
axis tight
% ---------------
function sliderframes_Callback(hObject, ~, handles)

if  toc<0.05
    return
end


tic

C=get(handles.track_what2,'userdata'  );
data_file=get(handles.figure1,'userdata');
n = round(get(hObject,'Value')) ;
axes(handles.axes1);  cla
track_what =get(handles.track_what1,'Value');
segmentation_type=get(handles.segmentation_type1,'Value') ;
Projected_by_Value=get(handles.Projected_by,'Value');
Projected_by_Str=get(handles.Projected_by,'String');
Projected_by=char(Projected_by_Str(Projected_by_Value));
box_list=get(handles.Raw_listbox,'string');
filename=char(box_list(n));
try
    eval(strcat('matrix_out=handles.Ch0',num2str(track_what-1),'_stack(',num2str(n),').cdata;'))
catch
    try
        Projected_by2=str2double(regexprep(Projected_by, 'z', '')) ;
        matrix_out=[];
        if ~isempty(Projected_by2) && ~isnan(Projected_by2)
            switch segmentation_type
                case 1
                    full_filename = [char(data_file(2).cdata(track_what,1)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'.tif'];
                    matrix_out=imread(full_filename ,1);
                case 2
                    full_filename = [char(data_file(2).cdata(track_what,2)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Filtered.tif'];
                    matrix_out=imread(full_filename ,1);
                case 3
                    full_filename = [char(data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    temp=imread(full_filename ,1);
                    matrix_out=flipdim(temp,1);
                case 4
                    full_filename_Filtered = [char(data_file(2).cdata(track_what,2)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Filtered.tif'];
                    temp_Filtered=imread(full_filename_Filtered ,1);
                    temp_Filtered=double(temp_Filtered);
                    full_filename_Segmentation = [char(data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    temp_Segmentation=imread(full_filename_Segmentation ,1);
                    temp_Segmentation=flipdim(temp_Segmentation,1);
                    temp_Segmentation=double(temp_Segmentation);
                    matrix_out=temp_Filtered.* temp_Segmentation;
                case 5
                    full_filename_Raw = [char(data_file(2).cdata(track_what,1)),'z\',filename,'_ch0',num2str(track_what-1),'.tif'] ;
                    temp_Raw=imread(full_filename_Raw ,1);
                    temp_Raw=double(temp_Raw);
                    full_filename_Segmentation = [char(data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    temp_Segmentation=imread(full_filename_Segmentation ,1);
                    temp_Segmentation=flipdim(temp_Segmentation,1);
                    temp_Segmentation=double(temp_Segmentation);
                    matrix_out=temp_Raw.* temp_Segmentation;
            end
        end
        if findstr('Imean',Projected_by)
            switch segmentation_type
                case 1
                    full_filename = [data_file(2).cdata{track_what,1},filename,'_ch0',num2str(track_what-1),'.tif'] ;
                    matrix_out=imread(full_filename);
                case 2
                    full_filename = [data_file(2).cdata{track_what,2},filename,'_ch0',num2str(track_what-1),'_Filtered.tif'];
                    matrix_out = imread(full_filename,'tif',1);
                case 3
                    full_filename = [data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    matrix_out = flipdim(imread(full_filename,'tif',1),1);
                case 4
                    full_filename = [data_file(2).cdata{track_what,2},filename,'_ch0',num2str(track_what-1),'_Filtered.tif'];
                    temp_Filtered = double(imread(full_filename,'tif',1));
                    full_filename = [data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    temp_Segmentation = double(flipdim(imread(full_filename,'tif',1),1));
                    matrix_out = temp_Filtered.* temp_Segmentation;
                case 5
                    full_filename = [data_file(2).cdata{track_what,1},filename,'_ch0',num2str(track_what-1),'.tif'];
                    temp_Raw = double(imread(full_filename,'tif',1));
                    full_filename = [data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    temp_Segmentation = double(flipdim(imread(full_filename,'tif',1),1));
                    matrix_out = temp_Raw.* temp_Segmentation;
            end
        end
        set(handles.edit_axes1,'String',full_filename);
    end
end



%
% set(handles.edit_axes1,'String',full_filename);
imagesc( matrix_out, 'Hittest','Off');
xy_border=data_file(6).cdata;
hold on
centy1 =[];
track_what =get(handles.track_what2,'Value');
if findstr(char(data_file(7).cdata(track_what,2)),'Y')
    if get(handles.Show_boundingbox,'value')==1
        centy1 = data_file(4).cdata.Centroids(track_what).cdata(n).cdata;
        set(handles.nobjects,'string',num2str( size(centy1,1)))
        if isempty(centy1)~=1
            for ii=1:size(data_file(4).cdata.L(track_what).cdata(n).cdata,1)
                if  isempty(data_file(4).cdata.L(track_what).cdata(n).cdata)~=1
                    XY= data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BoundingBox;
                    if XY(1)>xy_border(1) && XY(2)>xy_border(2) && (xy_border(1)+xy_border(3))>(XY(1)+XY(3)) && (xy_border(1)+xy_border(4))>(XY(2)+XY(4))
                        rectangle('Position', XY,'LineWidth',1  ,'EdgeColor','w', 'Hittest','Off'); %keep this one
                        
                        
                        if get(handles.Show_maximum_pixel,'value')==1
                            zz=data_file(4).cdata.L(track_what).cdata(n).cdata(ii)
                            %
                            %                    save zz zz
                            vec1= round(data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_2)  ;
                            plot(centy1(ii,1),centy1(ii,2),'m.',     'MarkerSize',20, 'Hittest','Off');
                            %                       h_axes4_plot=plot(vec1(:,1),vec1(:,2),'m.', 'MarkerSize',30, 'Hittest','Off');
                            centroid=round(data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Centroid) ;
                            vec1= round(data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_2)  ;
                            for jjj=1:size(vec1,1)
                                plot([centroid(jjj,1) vec1(jjj,1)],   [ centroid(jjj,2)  vec1(jjj,2)]    ,'linewidth',2,'color',[1 0 0],      'Hittest','Off');
                            end
                            
                            
                            
                            
                        end
                        
                        
                        if get(handles.Show_proximity_vector,'value')==1
                            vec  = round(data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Proximity_Ch_1)
                            if size(vec,2)>1
                                for jjj=1:size(vec ,1)
                                    startpoint= [vec(jjj,2)  vec(jjj,1)];
                                    x1= [vec(jjj,4) vec(jjj,3)];
                                    v1 =  0.2*(startpoint-x1)  ;
                                    theta = 22.5*pi/180  ;
                                    x2 = x1 + v1* [cos(theta)  -sin(theta) ; sin(theta)  cos(theta)];
                                    x3 = x1 +  v1*[cos(theta)  sin(theta) ; -sin(theta)  cos(theta)] ;
                                    fill([x1(1) x2(1) x3(1)],[x1(2) x2(2) x3(2)],'y',  'Hittest','Off');     % this fills the arrowhead (black)
                                    plot([vec(jjj,4) vec(jjj,2)], [vec(jjj,3)  vec(jjj,1)]        ,'linewidth',2,'color','y', 'Hittest','Off');
                                end
                            end
                        end
                    end
                end
            end
            index_local = (centy1(:,3) == n+0.1) ;
            plot(centy1(index_local,1),centy1(index_local,2),'rx','LineWidth',2,  'MarkerSize',30  ,'Hittest','Off');
            
            index_local2 = (centy1(:,3) == n+0.2)  ;
            plot(centy1(index_local2,1),centy1(index_local2,2),'r+',  'LineWidth',3,  'MarkerSize',40,'Hittest','Off');
        end
    end
    
    
    
    if findstr(char(data_file(7).cdata(track_what,1)),'Y')==1
        if get(handles.show_tracks,'value')==1
            if isempty(centy1)
                centy1 = data_file(4).cdata.Centroids(track_what).cdata(n).cdata;
            end
            track_length_before= round(get(handles.track_length_before,'value')) ;
            if track_length_before==50
                track_length_before=3000;
            end
            track_length_after= round(get(handles.track_length_after,'value')) ;
            if track_length_after==50
                track_length_after=3000;
            end
            MATRIX = data_file(5).cdata.Tracks(track_what ).cdata;
            div_cells_Vec =get(handles.Div_Cells,'string');
            sizee=size(MATRIX,2)/2;
            matrix=repmat([1 NaN;NaN 1],1,sizee );
            X=matrix(1,:).*MATRIX(n,:);
            Y=matrix(2,:).*MATRIX(n,:);
            X(isnan(X))=[];
            Y(isnan(Y))=[];
            STR=data_file(3).cdata{track_what,2};
            x=find((X>0));     xx=x*2-1;       xxx=xx+1;
            for ii=1:length(xx)
                try
                    X2=MATRIX(n-track_length_before:n+track_length_after,xx(ii));  Y2=MATRIX(n-track_length_before:n+track_length_after,xxx(ii));
                catch
                    try
                        X2=MATRIX(1:n+track_length_after,xx(ii));  Y2=MATRIX(1:n+track_length_after,xxx(ii));
                    catch
                        try
                            X2=MATRIX(n-track_length_before:end,xx(ii));  Y2=MATRIX(n-track_length_before:end,xxx(ii));
                        catch
                            try
                                X2=MATRIX(:,xx(ii));  Y2=MATRIX(:,xxx(ii));
                            end
                        end
                    end
                end
                
                X2=X2(X2>0); Y2=Y2(Y2>0);
                
                if length(X2)~=length(Y2)
                    errordlg('X and Y must have the same length. Please check that the coordinates of both X and Y are valid!','Error');
                    return
                end
                
                
                plot(X2,Y2, '.-', 'color',C(x(ii),:), 'Hittest','Off');
            end
            String = repmat({[STR '-']},sizee,1);
            %             if ~isempty(div_cells_Vec)
            try
                %               save  div_cells_Vec div_cells_Vec
                %                 save String
                String = strcat(String,div_cells_Vec);
                %             else
            catch
                String = strcat(String,arrayfun(@num2str,1:sizee,'un',0)');
            end
            text(X(X>0)-10, Y(X>0)+20, String(X>0), 'FontSize',10, 'Color','w', 'Hittest','Off');
        end
    end
end
axis manual;


m=str2num(get(handles.showcurrentframe,'string')) ;
set(handles.Raw_listbox,'Value',n)
if m>n
    set(handles.backward_button,'Visible','on')
    set(handles.forward_button,'Visible','off')
elseif n>m
    set(handles.forward_button,'Visible','on')
    set(handles.backward_button,'Visible','off')
else
    set(handles.forward_button,'Visible','off')
    set(handles.backward_button,'Visible','off')
end
set(handles.showcurrentframe,'String',num2str(n));



%     toc
%          if  toc<0.05
%             return
%          end
%
%
%       tic
%     data_file=get(handles.figure1,'userdata');
%     global h_TAC_Cell_Tracking_Module
%     n = round(get(hObject,'Value')) ;
%     axes(handles.axes1);  cla
%     track_what =get(h_TAC_Cell_Tracking_Module.track_what1,'Value');
%     segmentation_type=get(h_TAC_Cell_Tracking_Module.segmentation_type1,'Value') ;
%     Projected_by_Value=get(h_TAC_Cell_Tracking_Module.Projected_by,'Value');
%     Projected_by_Str=get(h_TAC_Cell_Tracking_Module.Projected_by,'String');
%     Projected_by=char(Projected_by_Str(Projected_by_Value));
%     box_list=get(h_TAC_Cell_Tracking_Module.Raw_listbox,'string');
%     filename=char(box_list(n));
% try
%     eval(strcat('matrix_out=h_TAC_Cell_Tracking_Module.Ch0',num2str(track_what-1),'_stack(',num2str(n),').cdata;'))
% catch
%     try
%     Projected_by2=str2double(regexprep(Projected_by, 'z', '')) ;
%     matrix_out=[];
%     if ~isempty(Projected_by2) && ~isnan(Projected_by2)
%         switch segmentation_type
%             case 1
%                 full_filename = [char(h_TAC_Cell_Tracking_Module.data_file(2).cdata(track_what,1)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'.tif'];
%                 matrix_out=imread(full_filename ,1);
%             case 2
%                 full_filename = [char(h_TAC_Cell_Tracking_Module.data_file(2).cdata(track_what,2)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Filtered.tif'];
%                matrix_out=imread(full_filename ,1);
%             case 3
%                 full_filename = [char(h_TAC_Cell_Tracking_Module.data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
%                  temp=imread(full_filename ,1);
%                  matrix_out=flipdim(temp,1);
%             case 4
%                 full_filename_Filtered = [char(h_TAC_Cell_Tracking_Module.data_file(2).cdata(track_what,2)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Filtered.tif'];
%                    temp_Filtered=imread(full_filename_Filtered ,1);
%                     temp_Filtered=double(temp_Filtered);
%                 full_filename_Segmentation = [char(h_TAC_Cell_Tracking_Module.data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
%                temp_Segmentation=imread(full_filename_Segmentation ,1);
%                     temp_Segmentation=flipdim(temp_Segmentation,1);
%                     temp_Segmentation=double(temp_Segmentation);
%                     matrix_out=temp_Filtered.* temp_Segmentation;
%             case 5
%                 full_filename_Raw = [char(h_TAC_Cell_Tracking_Module.data_file(2).cdata(track_what,1)),'z\',filename,'_ch0',num2str(track_what-1),'.tif'] ;
%                  temp_Raw=imread(full_filename_Raw ,1);
%                     temp_Raw=double(temp_Raw);
%                     full_filename_Segmentation = [char(h_TAC_Cell_Tracking_Module.data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
%                  temp_Segmentation=imread(full_filename_Segmentation ,1);
%                     temp_Segmentation=flipdim(temp_Segmentation,1);
%                     temp_Segmentation=double(temp_Segmentation);
%                     matrix_out=temp_Raw.* temp_Segmentation;
%         end
%     end
%     if findstr('Imean',Projected_by)
%         switch segmentation_type
%             case 1
%                 full_filename = [h_TAC_Cell_Tracking_Module.data_file(2).cdata{track_what,1},filename,'_ch0',num2str(track_what-1),'.tif'] ;
%                matrix_out=imread(full_filename);
%             case 2
%                 full_filename = [h_TAC_Cell_Tracking_Module.data_file(2).cdata{track_what,2},filename,'_ch0',num2str(track_what-1),'_Filtered.tif'];
%                     matrix_out = imread(full_filename,'tif',1);
%             case 3
%                 full_filename = [h_TAC_Cell_Tracking_Module.data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif'];
%                     matrix_out = flipdim(imread(full_filename,'tif',1),1);
%             case 4
%                 full_filename = [h_TAC_Cell_Tracking_Module.data_file(2).cdata{track_what,2},filename,'_ch0',num2str(track_what-1),'_Filtered.tif'];
%                     temp_Filtered = double(imread(full_filename,'tif',1));
%                 full_filename = [h_TAC_Cell_Tracking_Module.data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif'];
%                     temp_Segmentation = double(flipdim(imread(full_filename,'tif',1),1));
%                     matrix_out = temp_Filtered.* temp_Segmentation;
%             case 5
%                 full_filename = [h_TAC_Cell_Tracking_Module.data_file(2).cdata{track_what,1},filename,'_ch0',num2str(track_what-1),'.tif'];
%                     temp_Raw = double(imread(full_filename,'tif',1));
%                 full_filename = [h_TAC_Cell_Tracking_Module.data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif'];
%                 temp_Segmentation = double(flipdim(imread(full_filename,'tif',1),1));
%                    matrix_out = temp_Raw.* temp_Segmentation;
%         end
%     end
%      set(handles.edit_axes1,'String',full_filename);
%     end
% end
%
%
%
% %
% % set(h_TAC_Cell_Tracking_Module.edit_axes1,'String',full_filename);
% imagesc( matrix_out, 'Hittest','Off');
% xy_border=h_TAC_Cell_Tracking_Module.data_file(6).cdata;
% hold on
% centy1 =[];
% track_what =get(h_TAC_Cell_Tracking_Module.track_what2,'Value');
% if findstr(char(h_TAC_Cell_Tracking_Module.data_file(7).cdata(track_what,2)),'Y')
%     if get(h_TAC_Cell_Tracking_Module.Show_boundingbox,'value')==1
%         centy1 = h_TAC_Cell_Tracking_Module.data_file(4).cdata.Centroids(track_what).cdata(n).cdata;
%         if isempty(centy1)~=1
%             for ii=1:size(h_TAC_Cell_Tracking_Module.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
%                 if  isempty(h_TAC_Cell_Tracking_Module.data_file(4).cdata.L(track_what).cdata(n).cdata)~=1
%                     XY= h_TAC_Cell_Tracking_Module.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BoundingBox;
%                     if XY(1)>xy_border(1) && XY(2)>xy_border(2) && (xy_border(1)+xy_border(3))>(XY(1)+XY(3)) && (xy_border(1)+xy_border(4))>(XY(2)+XY(4))
%                            rectangle('Position', XY,'LineWidth',1  ,'EdgeColor','w', 'Hittest','Off'); %keep this one
%
%
%                if get(h_TAC_Cell_Tracking_Module.Show_maximum_pixel,'value')==1
%                       zz=h_TAC_Cell_Tracking_Module.data_file(4).cdata.L(track_what).cdata(n).cdata(ii)
% %
% %                    save zz zz
%                    vec1= round(h_TAC_Cell_Tracking_Module.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_2)  ;
%                     plot(centy1(ii,1),centy1(ii,2),'m.',     'MarkerSize',20, 'Hittest','Off');
% %                       h_axes4_plot=plot(vec1(:,1),vec1(:,2),'m.', 'MarkerSize',30, 'Hittest','Off');
%                      centroid=round(h_TAC_Cell_Tracking_Module.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Centroid) ;
%                       vec1= round(h_TAC_Cell_Tracking_Module.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_2)  ;
%                        for jjj=1:size(vec1,1)
%                                        plot([centroid(jjj,1) vec1(jjj,1)],   [ centroid(jjj,2)  vec1(jjj,2)]    ,'linewidth',2,'color',[1 0 0],      'Hittest','Off');
%                        end
%
%
%
%
%                end
%
%
%                    if get(h_TAC_Cell_Tracking_Module.Show_proximity_vector,'value')==1
%                        vec  = round(h_TAC_Cell_Tracking_Module.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Proximity_Ch_1)
%                        if size(vec,2)>1
%                        for jjj=1:size(vec ,1)
%                                 startpoint= [vec(jjj,2)  vec(jjj,1)];
%                                 x1= [vec(jjj,4) vec(jjj,3)];
%                                v1 =  0.2*(startpoint-x1)  ;
%                                theta = 22.5*pi/180  ;
%                                x2 = x1 + v1* [cos(theta)  -sin(theta) ; sin(theta)  cos(theta)];
%                                x3 = x1 +  v1*[cos(theta)  sin(theta) ; -sin(theta)  cos(theta)] ;
%                                fill([x1(1) x2(1) x3(1)],[x1(2) x2(2) x3(2)],'y',  'Hittest','Off');     % this fills the arrowhead (black)
%                                plot([vec(jjj,4) vec(jjj,2)], [vec(jjj,3)  vec(jjj,1)]        ,'linewidth',2,'color','y', 'Hittest','Off');
%                        end
%                        end
%                    end
%                     end
%                 end
%             end
%              index_local = (centy1(:,3) == n+0.1) ;
%               plot(centy1(index_local,1),centy1(index_local,2),'rx','LineWidth',2,  'MarkerSize',30  ,'Hittest','Off');
%
%              index_local2 = (centy1(:,3) == n+0.2)  ;
%               plot(centy1(index_local2,1),centy1(index_local2,2),'r+',  'LineWidth',3,  'MarkerSize',40,'Hittest','Off');
%         end
%     end
%
%
%
%     if findstr(char(h_TAC_Cell_Tracking_Module.data_file(7).cdata(track_what,1)),'Y')==1
%         if get(h_TAC_Cell_Tracking_Module.show_tracks,'value')==1
%           if isempty(centy1)
%                 centy1 = h_TAC_Cell_Tracking_Module.data_file(4).cdata.Centroids(track_what).cdata(n).cdata;
%           end
%         track_length_before= round(get(h_TAC_Cell_Tracking_Module.track_length_before,'value')) ;
%         if track_length_before==50
%             track_length_before=3000;
%         end
%          track_length_after= round(get(h_TAC_Cell_Tracking_Module.track_length_after,'value')) ;
%         if track_length_after==50
%             track_length_after=3000;
%         end
%             MATRIX = h_TAC_Cell_Tracking_Module.data_file(5).cdata.Tracks(track_what ).cdata;
%             div_cells_Vec =get(h_TAC_Cell_Tracking_Module.Div_Cells,'string');
%             sizee=size(MATRIX,2)/2;
%             matrix=repmat([1 NaN;NaN 1],1,sizee );
%             X=matrix(1,:).*MATRIX(n,:);
%             Y=matrix(2,:).*MATRIX(n,:);
%             X(isnan(X))=[];
%             Y(isnan(Y))=[];
%             STR=h_TAC_Cell_Tracking_Module.data_file(3).cdata{track_what,2};
%             x=find((X>0));     xx=x*2-1;       xxx=xx+1;
%             for ii=1:length(xx)
%                 try
%                   X2=MATRIX(n-track_length_before:n+track_length_after,xx(ii));  Y2=MATRIX(n-track_length_before:n+track_length_after,xxx(ii));
%                 catch
%                        try
%                        X2=MATRIX(1:n+track_length_after,xx(ii));  Y2=MATRIX(1:n+track_length_after,xxx(ii));
%                        catch
%                           try
%                             X2=MATRIX(n-track_length_before:end,xx(ii));  Y2=MATRIX(n-track_length_before:end,xxx(ii));
%                           catch
%                               try
%                                 X2=MATRIX(:,xx(ii));  Y2=MATRIX(:,xxx(ii));
%                               end
%                           end
%                        end
%                 end
%
%                  X2=X2(X2>0); Y2=Y2(Y2>0);
%
%                 if length(X2)~=length(Y2)
%                     errordlg('X and Y must have the same length. Please check that the coordinates of both X and Y are valid!','Error');
%                     return
%                 end
%
%
%            plot(X2,Y2, '.-', 'color',h_TAC_Cell_Tracking_Module.C(x(ii),:), 'Hittest','Off');
%             end
%             String = repmat({[STR '-']},sizee,1);
% %             if ~isempty(div_cells_Vec)
%                 try
% %               save  div_cells_Vec div_cells_Vec
% %                 save String
%                 String = strcat(String,div_cells_Vec);
% %             else
%                 catch
%                 String = strcat(String,arrayfun(@num2str,1:sizee,'un',0)');
%                 end
%               text(X(X>0)-10, Y(X>0)+20, String(X>0), 'FontSize',10, 'Color','w', 'Hittest','Off');
%         end
%     end
% end
%  axis manual;
%
%
% m=str2num(get(h_TAC_Cell_Tracking_Module.showcurrentframe,'string')) ;
% set(h_TAC_Cell_Tracking_Module.Raw_listbox,'Value',n)
% if m>n
%     set(h_TAC_Cell_Tracking_Module.backward_button,'Visible','on')
%     set(h_TAC_Cell_Tracking_Module.forward_button,'Visible','off')
% elseif n>m
%       set(h_TAC_Cell_Tracking_Module.forward_button,'Visible','on')
%       set(h_TAC_Cell_Tracking_Module.backward_button,'Visible','off')
% else
%     set(handles.forward_button,'Visible','off')
%       set(handles.backward_button,'Visible','off')
% end
%  set(h_TAC_Cell_Tracking_Module.showcurrentframe,'String',num2str(n));
%
%
%


%    setappdata(hObject,'inCallback',[]);

% ===========================================
% ======  FUNCTIONS =========================
% ===========================================
% ========================================
function show_frame(handles,n,MODE)


track_what =get(handles.track_what1,'Value');
segmentation_type=get(handles.segmentation_type1,'Value') ;
Projected_by_Value=get(handles.Projected_by,'Value');
Projected_by_Str=get(handles.Projected_by,'String');
Projected_by=char(Projected_by_Str(Projected_by_Value));
box_list=get(handles.Raw_listbox,'string');
filename=char(box_list(n));
try
    eval(strcat('matrix_out=handles.Ch0',num2str(track_what-1),'_stack(',num2str(n),').cdata;'))
catch
    try
        Projected_by2=str2double(regexprep(Projected_by, 'z', '')) ;
        matrix_out=[];
        if ~isempty(Projected_by2) && ~isnan(Projected_by2)
            switch segmentation_type
                case 1
                    full_filename = [char(handles.data_file(2).cdata(track_what,1)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'.tif'];
                    matrix_out=imread(full_filename ,1);
                case 2
                    full_filename = [char(handles.data_file(2).cdata(track_what,2)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Filtered.tif'];
                    matrix_out=imread(full_filename ,1);
                case 3
                    full_filename = [char(handles.data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    temp=imread(full_filename ,1);
                    matrix_out=flipdim(temp,1);
                case 4
                    full_filename_Filtered = [char(handles.data_file(2).cdata(track_what,2)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Filtered.tif'];
                    temp_Filtered=imread(full_filename_Filtered ,1);
                    temp_Filtered=double(temp_Filtered);
                    full_filename_Segmentation = [char(handles.data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    temp_Segmentation=imread(full_filename_Segmentation ,1);
                    temp_Segmentation=flipdim(temp_Segmentation,1);
                    temp_Segmentation=double(temp_Segmentation);
                    matrix_out=temp_Filtered.* temp_Segmentation;
                case 5
                    full_filename_Raw = [char(handles.data_file(2).cdata(track_what,1)),'z\',filename,'_ch0',num2str(track_what-1),'.tif'] ;
                    temp_Raw=imread(full_filename_Raw ,1);
                    temp_Raw=double(temp_Raw);
                    full_filename_Segmentation = [char(handles.data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    temp_Segmentation=imread(full_filename_Segmentation ,1);
                    temp_Segmentation=flipdim(temp_Segmentation,1);
                    temp_Segmentation=double(temp_Segmentation);
                    matrix_out=temp_Raw.* temp_Segmentation;
            end
        end
        if findstr('Imean',Projected_by)
            switch segmentation_type
                case 1
                    full_filename = [handles.data_file(2).cdata{track_what,1},filename,'_ch0',num2str(track_what-1),'.tif'] ;
                    matrix_out=imread(full_filename,'tif',1);
                case 2
                    full_filename = [handles.data_file(2).cdata{track_what,2},filename,'_ch0',num2str(track_what-1),'_Filtered.tif'];
                    matrix_out = imread(full_filename,'tif',1);
                case 3
                    full_filename = [handles.data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    matrix_out = flipdim(imread(full_filename,'tif',1),1);
                case 4
                    full_filename = [handles.data_file(2).cdata{track_what,2},filename,'_ch0',num2str(track_what-1),'_Filtered.tif'];
                    temp_Filtered = double(imread(full_filename,'tif',1));
                    full_filename = [handles.data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    temp_Segmentation = double(flipdim(imread(full_filename,'tif',1),1));
                    matrix_out = temp_Filtered.* temp_Segmentation;
                case 5
                    full_filename = [handles.data_file(2).cdata{track_what,1},filename,'_ch0',num2str(track_what-1),'.tif'];
                    temp_Raw = double(imread(full_filename,'tif',1));
                    full_filename = [handles.data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif'];
                    temp_Segmentation = double(flipdim(imread(full_filename,'tif',1),1));
                    matrix_out = temp_Raw.* temp_Segmentation;
            end
        end
        set(handles.edit_axes1,'String',full_filename);
    end
end

try
    MODE
    framePos = get(0,'screensize')%getpixelposition(handles.axes1) ;
    framePos=[1  (framePos(4)-(  framePos(3) /2))  framePos(3) /2  (framePos(3)/2)-((framePos(4)-(framePos(3)/2)))/2]
    h=figure('color','w','units','pixels','position',  framePos,'numbertitle','off', 'name',char(filename),'colormap',handles.c) ;
    imagesc( matrix_out, 'Hittest','Off');set(h,'userdata', matrix_out)
    xlabel('X','FontSize',12,'Color',[0 0 0]);
    ylabel('Y','FontSize',12,'Color',[0 0 0]);
    filename=char(filename);
    title(filename) ;
    %  axis tight; axis manual;
    index=1
    YLim=get(handles.axes1,'YLim')
    set(get(h,'children'),'ylim',YLim);
    XLim=get(handles.axes1,'XLim')
    set(get(h,'children'),'xlim',XLim);
    % set(h,'YLim',YLim);
    %  --------------------------------------------------
catch
    axes(handles.axes1); cla
    h=imagesc( matrix_out, 'Hittest','Off');
end

xy_border=handles.data_file(6).cdata;
hold on
track_what =get(handles.track_what2,'Value');


if findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')
    if get(handles.Show_boundingbox,'value')==1
        try
            centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata;
            set(handles.nobjects,'string',num2str( size(centy1,1)))
            for ii=1:size(handles.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
                if  isempty(handles.data_file(4).cdata.L(track_what).cdata(n).cdata)~=1
                    XY= handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BoundingBox;
                    if XY(1)>xy_border(1) && XY(2)>xy_border(2) && (xy_border(1)+xy_border(3))>(XY(1)+XY(3)) && (xy_border(1)+xy_border(4))>(XY(2)+XY(4))
                        rectangle('Position', XY,'LineWidth',1  ,'EdgeColor','w', 'Hittest','Off');
                        if get(handles.Show_maximum_pixel,'value')==1
                            zz=handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii)
                            vec1= round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_2)  ;
                            plot(centy1(ii,1),centy1(ii,2),'m.',     'MarkerSize',20, 'Hittest','Off');
                            centroid=round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Centroid) ;
                            vec1= round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_2)  ;
                            for jjj=1:size(vec1,1)
                                plot([centroid(jjj,1) vec1(jjj,1)],   [ centroid(jjj,2)  vec1(jjj,2)]    ,'linewidth',2,'color',[1 0 0],      'Hittest','Off');
                            end
                        end
                        if get(handles.Show_proximity_vector,'value')==1
                            vec  = round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Proximity_Ch_1)
                            if size(vec,2)>1
                                for jjj=1:size(vec ,1)
                                    startpoint= [vec(jjj,2)  vec(jjj,1)];
                                    x1= [vec(jjj,4) vec(jjj,3)];
                                    v1 =  0.2*(startpoint-x1)  ;
                                    theta = 22.5*pi/180  ;
                                    x2 = x1 + v1* [cos(theta)  -sin(theta) ; sin(theta)  cos(theta)];
                                    x3 = x1 +  v1*[cos(theta)  sin(theta) ; -sin(theta)  cos(theta)] ;
                                    fill([x1(1) x2(1) x3(1)],[x1(2) x2(2) x3(2)],'y',  'Hittest','Off');     % this fills the arrowhead (black)
                                    plot([vec(jjj,4) vec(jjj,2)], [vec(jjj,3)  vec(jjj,1)]        ,'linewidth',2,'color','y', 'Hittest','Off');
                                end
                            end
                        end
                    end
                end
            end
            index_local = (centy1(:,3) == n+0.1);  % faster: use bwlabel indexing
            plot(centy1(index_local,1),centy1(index_local,2),'rx','LineWidth',2,  'MarkerSize',30  ,'Hittest','Off');
            index_local2 = (centy1(:,3) == n+0.2);  % faster: use bwlabel indexing
            plot(centy1(index_local2,1),centy1(index_local2,2),'r+',  'LineWidth',3,  'MarkerSize',40,'Hittest','Off');
        end
    end
    try
        if findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
            if get(handles.show_tracks,'value')==1
                
                track_length_before= round(get(handles.track_length_before,'value')) ;
                if track_length_before==50
                    track_length_before=3000;
                end
                track_length_after= round(get(handles.track_length_after,'value')) ;
                if track_length_after==50
                    track_length_after=3000;
                end
                MATRIX = handles.data_file(5).cdata.Tracks(track_what ).cdata;
                div_cells_Vec =get(handles.Div_Cells,'string');
                sizee=size(MATRIX,2)/2;
                matrix=repmat([1 NaN;NaN 1],1,sizee );
                X=matrix(1,:).*MATRIX(n,:);
                Y=matrix(2,:).*MATRIX(n,:);
                X(isnan(X))=[];
                Y(isnan(Y))=[];
                STR=handles.data_file(3).cdata{track_what,2};
                x=find((X>0));     xx=x*2-1;       xxx=xx+1;
                for ii=1:length(xx)
                    try
                        X2=MATRIX(n-track_length_before:n+track_length_after,xx(ii));  Y2=MATRIX(n-track_length_before:n+track_length_after,xxx(ii));
                    catch
                        try
                            X2=MATRIX(1:n+track_length_after,xx(ii));  Y2=MATRIX(1:n+track_length_after,xxx(ii));
                        catch
                            try
                                X2=MATRIX(n-track_length_before:end,xx(ii));  Y2=MATRIX(n-track_length_before:end,xxx(ii));
                            catch
                                try
                                    X2=MATRIX(:,xx(ii));  Y2=MATRIX(:,xxx(ii));
                                end
                            end
                        end
                    end
                    X2=X2(X2>0); Y2=Y2(Y2>0);
                    plot(X2,Y2, '.-', 'color',handles.C(x(ii),:), 'Hittest','Off');
                end
                
                String = repmat({[STR '-']},sizee,1);
                try
                    String = strcat(String,div_cells_Vec);
                catch
                    String = strcat(String,arrayfun(@num2str,1:sizee,'un',0)');
                end
                text(X(X>0)-10, Y(X>0)+20, String(X>0), 'FontSize',10, 'Color','w', 'Hittest','Off');
            end
        end
    end
end
axis manual;

% ---------------------------------------------------------------
function[matrix_out,centy1] = Moving_Average(moving_avg_value,current_image,total_frame_number,handles)
matrix_out = [];
start_MA_frame = current_image - round(moving_avg_value/2);
extra = 0;
if start_MA_frame<1
    extra = -start_MA_frame;
    start_MA_frame=1;
end
end_MA_frame=current_image+moving_avg_value-round(moving_avg_value/2)+extra;
if end_MA_frame<1
    return
end
if end_MA_frame > total_frame_number
    end_MA_frame = total_frame_number;
end
segmentation_type=get(handles.segmentation_type1,'Value');
[temp,centy1] = read_image_visualization(handles,current_image,segmentation_type);
if isempty(temp)
    'cant find the image'
    return
    
end
if moving_avg_value > 1
    jj = 1;
    avg = zeros(size(temp));
    for ii = start_MA_frame : end_MA_frame
        [temp,centy1] = read_image_visualization(handles,ii,segmentation_type);
        if isempty(temp)
            'cant find the image'
            return;
        end
        avg = ((avg*(jj-1)+double(temp)))/jj;
        jj = jj+1;
    end
    [temp,centy1] = read_image_visualization(handles,current_image,segmentation_type);
    %           matrix_out= wfusimg(avg,temp,'db2',5,'mean','mean');  % if you dont have the Wavelet Toolbox
end
matrix_out = temp;

%   -----------------------------------------------------------------------
function [matrix_out,centy1]= read_image(handles,n,segmentation_type,track_what)
if nargin==3
    track_what= get(handles.track_what1,'Value') ;
end
try
    Projected_by_Value=get(handles.Projected_by,'Value');
    Projected_by_Str=get(handles.Projected_by,'String');
    Projected_by=char(Projected_by_Str(Projected_by_Value));
    box_list=get(handles.Raw_listbox,'string');
    filename=char(box_list(n));
    [matrix_out,centy1,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, filename,handles.data_file,track_what);
    set(handles.edit_axes1,'String',full_filename);
    
catch
    centy1 = handles.data_file(4).cdata.Centroids(track_what1).cdata(n).cdata;
    matrix_out= handles.stack(n).cdata;
    %     if isempty(matrix_out)==1
    %         [ 'Stack does not contain frame  ' num2str(n) '. Please load this frame to stack and try again!']
    %        return; end;
end
% -------------------------------------------------
function [matrix_out,centy1]= read_image_visualization(handles,n,segmentation_type,track_what)


if nargin==3
    track_what= get(handles.track_what1,'Value') ;
end
% virtual_stack_mode=get(handles.virtual_stack_mode,'value')


if get(handles.virtual_stack_mode,'value')~=1
    Projected_by_Value=get(handles.Projected_by,'Value');
    Projected_by_Str=get(handles.Projected_by,'String');
    Projected_by=char(Projected_by_Str(Projected_by_Value));
    box_list=get(handles.Raw_listbox,'string');
    filename=char(box_list(n));
    [matrix_out,centy1,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, filename,handles.data_file,track_what);
    set(handles.edit_axes1,'String',full_filename);
    
else
    
    centy1=[];
    if   findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')==1
        centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata;
    end
    try
        eval(strcat('matrix_out=handles.Ch0',num2str(track_what-1),'_stack(',num2str(n),').cdata;'))
        Projected_by_Value=get(handles.Projected_by,'Value');
        Projected_by_Str=get(handles.Projected_by,'String');
        Projected_by=char(Projected_by_Str(Projected_by_Value));
        box_list=get(handles.Raw_listbox,'string');
        filename=char(box_list(n));
        segmentation_type=get(handles.segmentation_type1,'value');
        [matrix_out,centy1,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, filename,handles.data_file,track_what);
        set(handles.edit_axes1,'String',full_filename);
        
    catch
        %       if isempty(matrix_out)==1
        [ 'Stack does not contain frame  ' num2str(n) '. Load this frame from virtual stack!']
        Projected_by_Value=get(handles.Projected_by,'Value');
        Projected_by_Str=get(handles.Projected_by,'String');
        Projected_by=char(Projected_by_Str(Projected_by_Value));
        box_list=get(handles.Raw_listbox,'string');
        filename=char(box_list(n));
        segmentation_type=get(handles.segmentation_type1,'value');
        [matrix_out,centy1,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, filename,handles.data_file,track_what);
        set(handles.edit_axes1,'String',full_filename);
    end
    
    
end
% ----------------------------
function [matrix_out,centy1,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, filename,data_file,track_what , track_what2 )

if nargin==7
    track_what2= get(handles.track_what2,'Value');
end
if nargin<7
    track_what= get(handles.track_what1,'Value'); track_what2= get(handles.track_what2,'Value');
end
Projected_by2=str2double(regexprep(Projected_by, 'z', '')) ;
matrix_out=[];  centy1=[];


if findstr(char(data_file(7).cdata(track_what2,2)),'Y')==1
    centy1 = data_file(4).cdata.Centroids(track_what2).cdata(n).cdata;
end
if ~isempty(Projected_by2) && ~isnan(Projected_by2)
    switch segmentation_type
        case 1
            
            full_filename = [char(data_file(2).cdata(track_what,1)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'.tif'];
            a=dir(full_filename );
            if size(a,1)~=0
                matrix_out=imread(full_filename ,1);
            end
            
        case 2
            
            full_filename = [char(data_file(2).cdata(track_what,2)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Filtered.tif'];
            a=dir(full_filename );
            if size(a,1)~=0
                matrix_out=imread(full_filename ,1);
            end
            
        case 3
            full_filename = [char(data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
            a=dir(full_filename );
            if size(a,1)~=0
                temp=imread(full_filename ,1);
                matrix_out=flipdim(temp,1);
            end
            
        case 4
            full_filename_Filtered = [char(data_file(2).cdata(track_what,2)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Filtered.tif'];
            a=dir(full_filename_Filtered);
            if size(a,1)~=0
                temp_Filtered=imread(full_filename_Filtered ,1);
                temp_Filtered=double(temp_Filtered);
            end
            
            full_filename_Segmentation = [char(data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
            b=dir(full_filename_Segmentation);
            if size(a,1)~=0 && size(b,1)~=0
                temp_Segmentation=imread(full_filename_Segmentation ,1);
                temp_Segmentation=flipdim(temp_Segmentation,1);
                temp_Segmentation=double(temp_Segmentation);
                matrix_out=temp_Filtered.* temp_Segmentation;
            end
            
        case 5
            
            full_filename_Raw = [char(data_file(2).cdata(track_what,1)),'z\',filename,'_ch0',num2str(track_what-1),'.tif'] ;
            a=dir(full_filename_Raw);
            if size(a,1)~=0
                temp_Raw=imread(full_filename_Raw ,1);
                temp_Raw=double(temp_Raw);
            end
            
            full_filename_Segmentation = [char(data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'];
            
            b=dir(full_filename_Segmentation);
            if size(a,1)~=0 && size(b,1)~=0
                temp_Segmentation=imread(full_filename_Segmentation ,1);
                temp_Segmentation=flipdim(temp_Segmentation,1);
                temp_Segmentation=double(temp_Segmentation);
                matrix_out=temp_Raw.* temp_Segmentation;
            end
    end
end

if findstr('Imean',Projected_by)
    switch segmentation_type
        case 1
            full_filename = [data_file(2).cdata{track_what,1},filename,'_ch0',num2str(track_what-1),'.tif'] ;
            if ~isempty(dir(full_filename))
                matrix_out=imread(full_filename,'tif',1);
            end
            
        case 2
            full_filename = [data_file(2).cdata{track_what,2},filename,'_ch0',num2str(track_what-1),'_Filtered.tif'];
            if ~isempty(dir(full_filename))
                matrix_out = imread(full_filename,'tif',1);
            end
            
        case 3
            full_filename = [data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif']
            if ~isempty(dir(full_filename))
                matrix_out = flipdim(imread(full_filename,'tif',1),1)  ;
            end
            
        case 4
            full_filename = [data_file(2).cdata{track_what,2},filename,'_ch0',num2str(track_what-1),'_Filtered.tif'];
            a = dir(full_filename);
            if ~isempty(a)
                temp_Filtered = double(imread(full_filename,'tif',1));
            end
            
            full_filename = [data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif'];
            b = dir(full_filename);
            if ~isempty(a) && ~isempty(b)
                temp_Segmentation = double(flipdim(imread(full_filename,'tif',1),1));
                matrix_out = temp_Filtered.* temp_Segmentation;
            end
            
        case 5
            full_filename = [data_file(2).cdata{track_what,1},filename,'_ch0',num2str(track_what-1),'.tif'];
            a = dir(full_filename);
            if ~isempty(a)
                temp_Raw = double(imread(full_filename,'tif',1));
            end
            
            full_filename = [data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Segmented.tif'];
            b = dir(full_filename );
            if ~isempty(a) && ~isempty(b)
                temp_Segmentation = double(flipdim(imread(full_filename,'tif',1),1));
                matrix_out = temp_Raw.* temp_Segmentation;
            end
    end
end

%  save all
%  return
%-------------------------------------------------------------------------
function [last_cell]=get_last_cell_index(MATRIX)
for  last_cell=2:2: size(MATRIX,2)
    X=MATRIX(:,last_cell);
    X(X==0)=[];
    if isempty(X)==1
        break
    end
end


% ----------------------------
function [vector, jj]=create_vector(MATRIX,handles,start_frame)
%  [vector  jj]
% vector is the trajectories of cell number start_frame in the
% MATRIX (the table). jj is the first frame that this cell appears.
%takes the matrix from table and the first frame where the cell appears as an inputs
if start_frame>size(MATRIX,2)
    Y=wavread('Error');
    h = errordlg('Input has to be smaller than the number of cells tracked.','Error');
    sound(Y,22000);
    return
end

vector=MATRIX(:,start_frame);
for ii=1:length(vector);
    if  vector(ii)>0
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
track_what=get(handles.track_what2,'Value');
% the   location is from the coresponding Centroids data
for ii=1:n
    centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(ii+jj-1).cdata;
    Centroids_frame=zeros(size(handles. data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata,1),2);
    sizeC=size(handles. data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata,1);
    for kk=1:sizeC
        Centroid_frame(kk,:)= handles. data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata(kk).Centroid;
    end
    for kk=1:sizeC
        if vector(ii,1:2)==Centroid_frame(kk,:)
            vector(ii,3)=kk;
            break
        end
    end
end
% -------------------------------------------------------------------------

function Open_Experiment_Callback(hObject, eventdata, handles)

set(handles.Div_frame_index,'value',1)
set(handles.Div_Cells,'value',1)
set(handles.parental_num,'value',1)
set(handles.Div_frame_index,'string','Division at frame')
set(handles.Div_Cells,'string','Cells list')
set(handles.parental_num,'string','Choose dividing cell:')
set(handles.Daughter1_edit,'string','')
set(handles.Daughter2_edit,'string','')
Current_Exp=get(handles.Current_Exp,'String');


try
    [filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please load experiment',Current_Exp);  % handles.directory_name); %pick files to combine
catch
    [filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please load experiment'  );  % handles.directory_name); %pick files to combine
end

if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
h=waitbar(0,'delete current stack file from memory ....');
set(h,'color','w');

handles.Ch00_stack=[];
handles.Ch01_stack=[];
handles.Ch02_stack=[];
handles.Ch03_stack=[];
handles.Ch04_stack=[];

close(h)


%%


full_filename = strcat(pathname,filename);
full_filename = char(full_filename);
set(handles.Current_Exp,'String',full_filename);
handles.data_file=importdata(full_filename);
set(handles.Raw_listbox,'Value',1);

set(handles.show_axes2,'Value',6);
cla(handles.axes2)
set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1));
track_what=1;
set(handles.track_what1,'Value',1);      set(handles.track_what2,'Value',1);
str=[];
str=handles.data_file(3).cdata(track_what,1);
if str2double(str)<1
    set(handles.track_what1,'Value',1);   set(handles.track_what2,'Value',1);
    return
end

n=get(handles.Raw_listbox,'Value');
c=zeros(64,3);
dic=c;
dic(:,1)=0:0.0158:1;
dic(:,2)=0:0.0158:1;
dic(:,3)=0:0.0158:1;
rfp=c;
rfp(:,1)=0:0.0158:1;
gfp=c;
gfp(:,2)=0:0.0158:1;
cfp=c;
cfp(:,3)=0:0.0158:1;
yfp=c;
yfp(:,1)=0:0.0158:1;
yfp(:,2)=0:0.0158:1;
Cherry=c;
Cherry(:,1)=0:0.0158:1;
Cherry(:,2)= linspace(0,0.2,64)';

handles.c1=dic;
handles.c2=cfp;
handles.c3=gfp;
handles.c4=yfp;
handles.c5=Cherry;
handles.c6=rfp;

if char(str)=='1'
    handles.c=handles.c1;
elseif char(str)=='2'
    handles.c=handles.c2;
elseif char(str)=='3'
    handles.c=handles.c3;
elseif char(str)=='4'
    handles.c=handles.c4;
elseif char(str)=='5'
    handles.c=handles.c5;
elseif char(str)=='6'
    handles.c=handles.c6;
end
set(gcf,'colormap',handles.c);

handles.Y1=1;
handles.X1=1;
handles.Y=handles.data_file(6).cdata(3);
handles.X=handles.data_file(6).cdata(4);
guidata(hObject,handles);

n=1;  div_cells=[];
if findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')==1
    for ii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
        if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata)~=1
            vec_centy = handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata(:,3) -ii;
            vec_centy= (round(vec_centy*10))/10;
            if find(ismember(vec_centy,0.1))>0
                div_cells(n)=ii;
                n=n+1;
            end
        end
    end
end
if isempty(div_cells)~=1
    set(handles.Div_frame_index,'String',div_cells)
end
if findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
    MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;
    if isempty(MATRIX)~=1
        ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
        size_x=size(MATRIX,2);
        size_y=size(MATRIX,1);
        tot_size_x=size_x+1;
        tot_size_y=size_y+2;
        if  tot_size_x>676
            lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
        elseif  tot_size_x>26   &&  tot_size_x<676
            lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
        elseif  tot_size_x<27
            lastcell= ABC( tot_size_x);
        end
        handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
        handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');  set(handles.track_what2,'userdata',handles.C)
        handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
        guidata(hObject,handles)
    end
    nn=1;div_cells=[];
    last_cell =get_last_cell_index(MATRIX);
    for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
        if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
            centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
            for jj=1:size(centy2,1)  % .
                if str2num(num2str(centy2(jj,3)- iiii))==0.1
                    for cell_index=2:2:(last_cell-2)
                        if  MATRIX(iiii,cell_index-1)==centy2(jj,1) && MATRIX(iiii,cell_index)==centy2(jj,2)
                            break
                        end
                    end
                    div_cells(nn)=cell_index/2;
                    nn=nn+1;
                end
            end
        end
    end
    if isempty( div_cells)~=1
        [all_cells,parental_cells]=TRYME(div_cells,MATRIX);
        set(handles.Div_Cells,'value',1);%set(handles.Div_Cells,'min',0)
        if  isempty(all_cells)~=1
            set(handles.Div_Cells,'string',all_cells)
        else
            set(handles.Div_Cells,'string','')
        end
        set(handles.parental_num,'value',1);%set(handles.Div_Cells,'min',0)
        if isempty(parental_cells)~=1
            set(handles.parental_num,'string',parental_cells)
            parental_num_Callback(hObject, eventdata, handles)
        else
            set(handles.parental_num,'string','Choose dividing cell:')
            set(handles.Daughter1_edit,'string','')
            set(handles.Daughter2_edit,'string','')
        end
    end
end
%numFiles = size(get(handles.Raw_listbox,'string'),1);
numFiles = size(handles.data_file(1).cdata(:,1),1);set(handles.end_export,'string',num2str(numFiles));
set(handles.sliderframes, 'Value',1, 'Maximum',numFiles, 'Minimum',1);

try
    handles.sliderframes.setEnabled(true);  % Java JSlider
    
catch
    set(handles.sliderframes, 'Enable','on', 'SliderStep',[1/numFiles, 0.1]);  % Matlab scrollbar
    
end
set(handles.Raw_listbox,  'value',1, 'Enable','on');


guidata(hObject,handles) ;global h_TAC_Cell_Tracking_Module;  h_TAC_Cell_Tracking_Module=handles;
set(handles.active_panel1,'visible','on');set(handles.Raw_listbox,'visible','on')
%  Raw_listbox_Callback(hObject, eventdata, handles)
set(handles.figure1,'userdata',handles.data_file);
track_what2_Callback(hObject, eventdata, handles)

axis tight
set(handles.figure1,'userdata',handles.data_file);update_labelmatrix(handles)
% --------------------------------------------------------------------
function Save_Experiment_Callback(hObject, ~, handles)

Current_Exp=get(handles.Current_Exp,'String');
[filename, pathname, filterindex] = uiputfile({  '*.dat','Dat-files (*.dat)';}, 'save  session to a data file',Current_Exp);

if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
filename=regexprep(filename, 'TACTICS_EXP_','');
full_filename= strcat(pathname,'TACTICS_EXP_',filename) ;
full_filename=char(full_filename);

Raw_listbox=get(handles.Raw_listbox,'String') ;
if iscell(Raw_listbox)~=0
    handles.data_file(1).cdata=cell(length(Raw_listbox),1) ;
    handles.data_file(1).cdata(:,1)=Raw_listbox;
end
handles.data_file(10).cdata=full_filename;
guidata(hObject, handles);
temp=handles.data_file;
save(full_filename ,  'temp')
pause(1)
msgbox('Experiment file was saved. Press OK to continue','Saved')

function Relabel_the_cells_Callback(hObject, ~, handles)
box_list=get(handles.Raw_listbox,'string');
end_frame=size(box_list,1);
n=get(handles.Raw_listbox,'Value') ;
track_what=get(handles.track_what2,'Value') ;
centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;

% if   findstr(char(handles.data_file(7).cdata(track_what,2)),'N')==1     %Must be labeled before running the tracking algorithm
%             h = msgbox('Please allocate the Centroids and label the cells before running tracking algorithm.','Aborted');
%             return
% end
str=eval(strcat('handles.data_file(3).cdata(',num2str(track_what),',1)'))
str=str2double(str);
if str==0
    return
end

prompt = {'Enter frame to start:','Enter frae to end:'};
dlg_title = 'Input';
num_lines = 1;
def = {num2str(n),num2str(end_frame)};
answer = inputdlg(prompt,dlg_title,num_lines,def);
start_track =str2num(char(answer(1)));
end_track =str2num(char(answer(2)));
box_list=get(handles.Raw_listbox,'string');
str_parameter=select_label_parameter;

if str>0
    handles.data_file(4).cdata.Centroids(track_what).cdata=Find_Centroids(handles,track_what,box_list,start_track,end_track) ;
    handles.data_file(4).cdata.L(track_what).cdata=Find_L(handles,track_what,box_list,start_track,end_track,str_parameter) ;
end


handles.data_file(7).cdata(track_what,2) =cellstr('Y');
guidata(hObject,handles);
global h_TAC_Cell_Tracking_Module;h_TAC_Cell_Tracking_Module=handles;


show_frame( handles,n);
set(handles.figure1,'userdata',handles.data_file);update_labelmatrix(handles)

% --------------------------------------------------------------------
function Untitled_32_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
    run('TACTICS',handles.data_file) ;
else
    run('TACTICS') ;
end
% --------------------------------------------------------------------
function Untitled_33_Callback(~, ~, ~)
function Untitled_24_Callback(hObject, eventdata, handles)
track_what=get(handles.track_what2,'Value') ;
MATRIX=  handles.data_file(5).cdata.Tracks(track_what ).cdata;       %1. Getting the tracked trajectories

save all
return






n=1;
for  last_cell=2:2: size(MATRIX,2)
    X=MATRIX(:,last_cell) ;
    X=X(X~=0)
    if isempty(X)==1
        break
    end
end
h=waitbar(0,'please wait')
for ii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
    if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata)~=1
        waitbar(ii/size(handles.data_file(4).cdata.Centroids(track_what).cdata,2))
        centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata;   %2. Getting all the centroids for the frame after the division
        for jj=1:size(centy1,1)  %3. Loop for breaking the tracks as marked by the user
            temp_centy1=centy1(jj,3)-ii;
            if   (round(temp_centy1*10))/10 ==0.1
                for cell_index=2:2:(last_cell-2)
                    if  MATRIX(ii,cell_index-1)==centy1(jj,1) && MATRIX(ii,cell_index)==centy1(jj,2)
                        break
                    end
                end
                cell_index=cell_index/2;
                MATRIX=break_track(MATRIX,ii,cell_index,n,last_cell)     ;
                n=n+1; %n rows wefe alreadey added to MATRIX
            end
        end
    end
end
close(h)
%   4. Set the MATRIX back to table
if isempty(MATRIX)~=1
    ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
    size_x=size(MATRIX,2);
    size_y=size(MATRIX,1);
    tot_size_x=size_x+1;
    tot_size_y=size_y+2;
    if  tot_size_x>676
        lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
    elseif  tot_size_x>26   &&  tot_size_x<676
        lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
    elseif  tot_size_x<27
        lastcell= ABC( tot_size_x) ;
    end
    handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
    handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
    handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k')    ;
    guidata(hObject,handles)
end
handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
guidata(hObject,handles);
nn=1;div_cells=[];
last_cell =get_last_cell_index(MATRIX );
for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
    if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
        centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
        for jj=1:size(centy2,1)  % .
            if str2num(num2str(centy2(jj,3)- iiii))==0.1
                for cell_index=2:2:(last_cell-2)
                    if  MATRIX(iiii,cell_index-1)==centy2(jj,1) && MATRIX(iiii,cell_index)==centy2(jj,2)
                        break
                    end
                end
                div_cells(nn)=cell_index/2 ;
                nn=nn+1;
            end
        end
    end
end
[all_cells,parental_cells]=TRYME(div_cells,MATRIX) ;
set(handles.Div_Cells,'value',1);%set(handles.Div_Cells,'min',0)
if isempty(all_cells)~=1
    set(handles.Div_Cells,'string',all_cells)
else
    set(handles.Div_Cells,'string','')
end
set(handles.parental_num,'value',1);%set(handles.Div_Cells,'min',0)
if isempty(parental_cells)~=1
    set(handles.parental_num,'string',parental_cells)
    parental_num_Callback(hObject, eventdata, handles)
else
    set(handles.parental_num,'string','Choose dividing cell:')
    set(handles.Daughter1_edit,'string','')
    set(handles.Daughter2_edit,'string','')
end
n=get(handles.Raw_listbox,'Value') ;
show_frame( handles,n) ;


% --------------------------------------------------------------------
function Untitled_15_Callback(~, ~, handles)
% hObject    handle to Load_optimal_settings (see GCBO)
[filename, pathname, filterindex] = uigetfile({  '*.dat','DAT-files (*.dat)';}, 'Please Choose optimal setting file')% handles.directory_name); %pick files to combine
if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end


full_filename= strcat(pathname,filename);
full_filename=char(full_filename);
DATA=importdata(full_filename)  ;
set_DATA(handles,DATA);


% --------------------------------------------------------------------
function Untitled_16_Callback(~, ~, handles)

track_what=get(handles.track_what1,'Value');
n_Raw=get(handles.Raw_listbox,'Value');

DATA=handles.data_file(8).cdata(track_what).Frame(n_Raw).DATA  ;



if  DATA(1).vector(11)~=0
    set(handles.T_popup_2,'Value',DATA(1).vector(11));   end
if  DATA(1).vector(12)~=0
    set(handles.T_popup_3,'Value',DATA(1).vector(12));  end
if  DATA(1).vector(13)~=0
    set(handles.T_popup_4,'Value',DATA(1).vector(13));  end
if  DATA(1).vector(14)~=0
    set(handles.T_popup_5,'Value',DATA(1).vector(14));  end
if  DATA(1).vector(15)~=0
    set(handles.T_popup_6,'Value',DATA(1).vector(15));  end


for ii=2:5
    T_popup_function(ii,handles);
end


set(handles.thresh_level,'Value',DATA(1).vector(16));
set(handles.T_Slider_2,'Value',DATA(1).vector(17));
set(handles.T_Slider_3,'Value',DATA(1).vector(18));
set(handles.T_Slider_4,'Value',DATA(1).vector(19));
set(handles.T_Slider_5,'Value',DATA(1).vector(20));
set(handles.T_Slider_6,'Value',DATA(1).vector(21));
if DATA(1).vector(22)==0
    DATA(1).vector(22)= 1;
end
%   if DATA(1).vector(23)==0
%      DATA(1).vector(23)= 1;
%   end
if DATA(1).vector(24)==0
    DATA(1).vector(24)= 1;
end
set(handles.strel_type,'Value',DATA(1).vector(22));
%  set(handles.fspecial_type,'Value',DATA(1).vector(23));
set(handles.bwmorph_type,'Value',DATA(1).vector(24));

%  if isnan(DATA(2).vector(1))~=1
%      set(handles.F_edit_1,'String',DATA(2).vector(1)); end
%   if isnan(DATA(2).vector(2))~=1
%       set(handles.F_edit_2,'String',DATA(2).vector(2)); end
%    if isnan(DATA(2).vector(3))~=1
%        set(handles.F_edit_3,'String',DATA(2).vector(3)); end
%     if isnan(DATA(2).vector(4))~=1
%         set(handles.F_edit_4,'String',DATA(2).vector(4)); end
%      if isnan(DATA(2).vector(5))~=1
%          set(handles.F_edit_5,'String',DATA(2).vector(5)); end
%
try
    if isnan(DATA(2).vector(6))~=1
        set(handles.T_edit_1,'String',DATA(2).vector(6)); end
    if isnan(DATA(2).vector(7))~=1
        set(handles.T_edit_2,'String',DATA(2).vector(7)); end
    if isnan(DATA(2).vector(8))~=1
        set(handles.T_edit_3,'String',DATA(2).vector(8)); end
    if isnan(DATA(2).vector(9))~=1
        set(handles.T_edit_4,'String',DATA(2).vector(9)); end
    if isnan(DATA(2).vector(10))~=1
        set(handles.T_edit_5,'String',DATA(2).vector(10)); end
    if isnan(DATA(2).vector(11))~=1
        set(handles.T_edit_6,'String',DATA(2).vector(11)); end
end
% --------------------------------------------------------------------
function Untitled_20_Callback(hObject, ~, handles)
global h_TAC_Cell_Tracking_Module;
MATRIX=  handles.data_file(5).cdata.Tracks(track_what ).cdata;
if  isempty(MATRIX)==1
    return
end
n=get(handles.Raw_listbox,'Value') ;
prompt = {'Please input cell to be eliminated:'};
dlg_title = 'Delete Cell';
num_lines = 1;
def = {' ' };
answer = inputdlg(prompt,dlg_title,num_lines,def)
answer=str2double(answer);
MATRIX(:, answer*2-1:answer*2)=[];
ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
size_x=size(MATRIX,2);
size_y=size(MATRIX,1);
tot_size_x=size_x+1;
tot_size_y=size_y+2;
if  tot_size_x>676
    lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
elseif  tot_size_x>26   &&  tot_size_x<676
    lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
elseif  tot_size_x<27
    lastcell= ABC( tot_size_x) ;
end
handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
guidata(hObject,handles) ; h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
show_frame( handles,n)  ;


% --------------------------------------------------------------------
function Untitled_21_Callback(hObject, ~, handles)
global h_TAC_Cell_Tracking_Module;
n=get(handles.Raw_listbox,'Value') ;
prompt = {'Please input the SHORTER track to be cuttoff:'};
dlg_title = 'Delete';
num_lines = 1;
def = {' ' };
answer = inputdlg(prompt,dlg_title,num_lines,def) ;
min_track_length=str2double(answer);
track_what=get(handles.track_what2,'Value');
MATRIX=  handles.data_file(5).cdata.Tracks(track_what ).cdata;
for ii=1:size(MATRIX,2)
    X=MATRIX(:, ii);
    X=X(X~=0);
    track_length=length(X);
    if  track_length<min_track_length
        list_of_delete(ii)=ii;
    end
end
list_of_delete= list_of_delete( list_of_delete~=0)
MATRIX(:,list_of_delete)=[];
ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
size_x=size(MATRIX,2);
size_y=size(MATRIX,1);
tot_size_x=size_x+1;
tot_size_y=size_y+2;
if  tot_size_x>676
    lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
elseif  tot_size_x>26   &&  tot_size_x<676
    lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
elseif  tot_size_x<27
    lastcell= ABC( tot_size_x) ;
end
handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
guidata(hObject,handles)
show_frame( handles,n)  ;
h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);

% --------------------------------------------------------------------
function Untitled_22_Callback(hObject, ~, handles)
global h_TAC_Cell_Tracking_Module;
track_what=get(handles.track_what2,'Value');
n=get(handles.Raw_listbox,'Value') ;
prompt = {'Please input the LONGER track to be cuttoff:'};
dlg_title = 'Delete';
num_lines = 1;
def = {' ' };
answer = inputdlg(prompt,dlg_title,num_lines,def) ;
max_track_length=str2double(answer);
MATRIX=  handles.data_file(5).cdata.Tracks(track_what ).cdata;
for ii=1:size(MATRIX,2)
    X=MATRIX(:, ii);
    X=X(X~=0);
    track_length=length(X);
    if  track_length>max_track_length
        list_of_delete(ii)=ii;
    end
end
list_of_delete=list_of_delete(list_of_delete~=0)
MATRIX(:,list_of_delete)=[];
ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
size_x=size(MATRIX,2);
size_y=size(MATRIX,1);
tot_size_x=size_x+1;
tot_size_y=size_y+2;
if  tot_size_x>676
    lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
elseif  tot_size_x>26   &&  tot_size_x<676
    lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
elseif  tot_size_x<27
    lastcell= ABC( tot_size_x) ;
end

handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
guidata(hObject,handles)
show_frame( handles,n)  ;
h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);


% --------------------------------------------------------------------
function Untitled_23_Callback(hObject, ~, handles)
global h_TAC_Cell_Tracking_Module;
track_what=get(handles.track_what2,'Value') ;
n=get(handles.Raw_listbox,'Value') ;
MATRIX=  handles.data_file(5).cdata.Tracks(track_what ).cdata;
if  isempty(MATRIX)==1
    return
end
prompt = {'Please input first cell-track:','Please input second cell-track:'};
dlg_title = 'Merging..';
num_lines = 1;
def = {'',''};
answer  = inputdlg(prompt,dlg_title,num_lines,def);
answer=str2double(answer);
answer_1    = answer(1);
answer_2    = answer(2);
MATRIX(:, answer_1*2-1:answer_1*2)=MATRIX(:, answer_1*2-1:answer_1*2)+MATRIX(:, answer_2*2-1:answer_2*2) ;
MATRIX(:, answer_2*2-1:answer_2*2)=[];
ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
size_x=size(MATRIX,2);
size_y=size(MATRIX,1);
tot_size_x=size_x+1;
tot_size_y=size_y+2;
if  tot_size_x>676
    lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
elseif  tot_size_x>26   &&  tot_size_x<676
    lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
elseif  tot_size_x<27
    lastcell= ABC( tot_size_x) ;
end
handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
guidata(hObject,handles)
show_frame( handles,n)  ;
h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);

% -------------------------------------------------------------------------

function T_popup_1_Callback(~, ~, handles)
T_popup_function(1,handles);
function T_popup_2_Callback(~, ~, handles)
T_popup_function(2,handles);
function T_popup_3_Callback(~, ~, handles)
T_popup_function(3,handles);
function T_popup_4_Callback(~, ~, handles)
T_popup_function(4,handles);
function T_popup_5_Callback(~, ~, handles)
T_popup_function(5,handles);
function T_popup_6_Callback(~, ~, handles)
T_popup_function(6,handles);
% ---------------------------------------------------------------
function axes1_ButtonDownFcn(hObject, eventdata, handles)
global h_TAC_Cell_Tracking_Module;
segmentation_type=get(handles.segmentation_type1,'value');
track_what1=get(handles.track_what1,'Value') ;
track_what=get(handles.track_what2,'Value') ;
n=get(handles.Raw_listbox,'value');
Projected_by_Value=get(handles.Projected_by,'Value');
Projected_by_Str=get(handles.Projected_by,'String');
Projected_by=char(Projected_by_Str(Projected_by_Value));
box_list=get(handles.Raw_listbox,'string');
filename=char(box_list(n));
[temp,centy1,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, filename,handles.data_file,track_what1,track_what);
set(handles.edit_axes1,'String',full_filename);

n= get(handles.Raw_listbox,'value');
point1 = get(hObject,'CurrentPoint')  ;
sel_typ = get(gcbf,'SelectionType')
if strcmp(sel_typ,'extend')==1
    
    % ========================
    % ========================
    
    
    
    if  strfind(num2str(get(handles.mode_1,'foregroundcolor')),'1  1  0')
        if isempty(centy1)==1
            return
        end
        centy1_from_L= handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata  ;
        XY= (centy1_from_L(:,1)-point1(1,1)).^2+ (centy1_from_L(:,2)-point1(1,2)).^2;   %find closest centroid to the selected point
        XY_min_index=find(ismember(XY,(min(XY))))  ;
        xy= handles.data_file(4).cdata.L(track_what).cdata(n).cdata(XY_min_index).BoundingBox  ;
        if xy(1)<point1(1,1) && xy(2)<point1(1,2) && point1(1,1)<(xy(1)+xy(3)) && point1(1,2)<(xy(2)+xy(4))
            for ii=1:size(centy1,1)
                if centy1(ii,1:2) ==centy1_from_L(XY_min_index,1:2)
                    centy1(ii,:)=[]  ;
                    handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata =centy1   ;
                    handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii)=[]  ;
                    break
                end
            end
        else
            return
        end
        guidata(hObject,handles);     h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
        set(handles.Div_frame_index,'Value',1)
        set(handles.Div_frame_index,'Max',1)
        set(handles.Div_frame_index,'String',[])
        
        N=1;  div_cells=[];
        if   findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')==1
            for ii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
                if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata)~=1
                    vec_centy = handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata(:,3) -ii ;
                    vec_centy= (round(vec_centy*10))/10   ;
                    if find(ismember(vec_centy,0.1))>0
                        div_cells(N)=ii ;
                        N=N+1 ;
                    end
                end
            end
        end
        if isempty(div_cells)~=1
            set(handles.Div_frame_index,'String', div_cells )
        end
        show_frame( handles,n)   ;
        return
    end
    % ========================
    % ========================
    if  strfind(num2str(get(handles.mode_2,'foregroundcolor')),'1  1  0')
        box_Raw=get(handles.Raw_listbox,'string')   ;
        n=round(get(handles.Raw_listbox,'Value'));
        track_what=get(handles.track_what2,'Value') ;
        filename_Raw=char(box_Raw(n))  ;
        
        if isempty(centy1)==1
            return
        end
        XY= (centy1(:,1)-point1(1,1)).^2+ (centy1(:,2)-point1(1,2)).^2;   %find closest centroid to the selected point
        XY_min_index=find(ismember(XY,(min(XY))))  ;
        for ii=1:size(handles.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
            ii
            xy= handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BoundingBox ;
            % find coresponding  bounding box to the closet centroid.
            % If the point is inside the bounding box eliminate the centroid
            if centy1(XY_min_index,1:2)== handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Centroid
                if xy(1)<point1(1,1) && xy(2)<point1(1,2) && point1(1,1)<(xy(1)+xy(3)) && point1(1,2)<(xy(2)+xy(4))
                    if centy1(XY_min_index,3)-round(centy1(XY_min_index,3))==0
                        centy1(XY_min_index,3)=centy1(XY_min_index,3)+0.1;
                    else
                        centy1(XY_min_index,3)=round(centy1(XY_min_index,3));
                    end
                    handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata=centy1 ;
                    guidata(hObject,handles);   h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
                end
            end
        end
        index_local=find(ismember(centy1(:,3),n+0.1));
        %     h_axes2_plot=plot(centy1(index_local,1),centy1(index_local,2),  'rx','MarkerSize',30)  ;
        %     set(h_axes2_plot, 'Hittest','Off')  ;
        set(handles.Div_frame_index,'Value',1)
        set(handles.Div_frame_index,'Max',1)
        set(handles.Div_frame_index,'String',[])
        N=1;  div_cells=[];
        if   findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')==1
            for ii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
                if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata)~=1
                    vec_centy = handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata(:,3) -ii ;
                    vec_centy= (round(vec_centy*10))/10   ;
                    if find(ismember(vec_centy,0.1))>0
                        div_cells(N)=ii ;
                        N=N+1 ;
                    end
                end
            end
        end
        if isempty(div_cells)~=1
            set(handles.Div_frame_index,'String',div_cells)
        end
        show_frame( handles,n)  ;
        return
    end
    % ========================
    % ========================
    if  strfind(num2str(get(handles.mode_3,'foregroundcolor')),'1  1  0')
        
        MATRIX=handles.data_file(5).cdata.Tracks(track_what ).cdata   ;
        if isempty(MATRIX)==1
            return
        end
        stat=0;
        point1 = get(hObject,'CurrentPoint')  ;
        fig = gcf;
        sel_typ = get(gcbf,'SelectionType')
        n= get(handles.Raw_listbox,'value');
        
        if isempty(temp)==1
            'cant find the image'
            return;
        end
        if isempty(temp)==1
            return
        end
        %find closest trajectory  from (n-1)to the selected point:
        for  last_cell=2:2: size(MATRIX,2)
            X=MATRIX(:,last_cell) ;
            X=X(X~=0);
            if isempty(X)==1
                break
            end
        end
        
        closest_track=[];
        if n>1
            MATRIX=  handles.data_file(5).cdata.Tracks(track_what ).cdata;
            sizee=size(MATRIX,2)/2;
            matrix=repmat([1 NaN;NaN 1],1,sizee );
            X=matrix(1,:).*MATRIX(n-1,:);
            Y=matrix(2,:).*MATRIX(n-1,:);
            X(isnan(X))=[];
            Y(isnan(Y))=[];
            XY= (X-point1(1,1)).^2+ (Y-point1(1,2)).^2     ;
            closest_track=find(ismember(XY,(min(XY))));
        end
        if isempty(closest_track)==1
            closest_track=1;
        end
        
        
        
        %find closest centroid to the selected point:
        XY= (centy1(:,1)-point1(1,1)).^2+ (centy1(:,2)-point1(1,2)).^2;
        XY_min_index=find(ismember(XY,(min(XY))))  ;
        for ii=1:size(handles.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
            xy= handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BoundingBox ;
            % find coresponding  bounding box to the closet centroid.
            % If the point is inside the bounding box eliminate the centroid
            if centy1(XY_min_index,1:2)== handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Centroid
                if xy(1)<point1(1,1) && xy(2)<point1(1,2) && point1(1,1)<(xy(1)+xy(3)) && point1(1,2)<(xy(2)+xy(4))
                    stat=1;
                    break
                end
            end
        end
        
        if     stat==0
            return
        end
        
        %  =====================
        div_cells_Vec =get(handles.Div_Cells,'string') ;
        [MATRIX,centy1,selection]=Tracking_option_GUI(closest_track,n,XY_min_index,XY,MATRIX,handles.data_file(4).cdata.Centroids(track_what).cdata, div_cells_Vec);
        
        if selection<10
            
            handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
            guidata(hObject,handles)
            
            if findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
                MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;
                if isempty(MATRIX)~=1
                    ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
                    size_x=size(MATRIX,2);
                    size_y=size(MATRIX,1);
                    tot_size_x=size_x+1;
                    tot_size_y=size_y+2;
                    if  tot_size_x>676
                        lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
                    elseif  tot_size_x>26   &&  tot_size_x<676
                        lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
                    elseif  tot_size_x<27
                        lastcell= ABC( tot_size_x);
                    end
                    handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
                    handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');  set(handles.track_what2,'userdata',handles.C)
                    handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
                    guidata(hObject,handles)
                end
                nn=1;div_cells=[];
                last_cell =get_last_cell_index(MATRIX);
                for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
                    if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
                        centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
                        for jj=1:size(centy2,1)  % .
                            if str2num(num2str(centy2(jj,3)- iiii))==0.1
                                for cell_index=2:2:(last_cell-2)
                                    if  MATRIX(iiii,cell_index-1)==centy2(jj,1) && MATRIX(iiii,cell_index)==centy2(jj,2)
                                        break
                                    end
                                end
                                div_cells(nn)=cell_index/2;
                                nn=nn+1;
                            end
                        end
                    end
                end
                if isempty( div_cells)~=1
                    [all_cells,parental_cells]=TRYME(div_cells,MATRIX);
                    set(handles.Div_Cells,'value',1);%set(handles.Div_Cells,'min',0)
                    if  isempty(all_cells)~=1
                        set(handles.Div_Cells,'string',all_cells)
                    else
                        set(handles.Div_Cells,'string','')
                    end
                    set(handles.parental_num,'value',1);%set(handles.Div_Cells,'min',0)
                    if isempty(parental_cells)~=1
                        set(handles.parental_num,'string',parental_cells)
                        parental_num_Callback(hObject, eventdata, handles)
                    else
                        set(handles.parental_num,'string','Choose dividing cell:')
                        set(handles.Daughter1_edit,'string','')
                        set(handles.Daughter2_edit,'string','')
                    end
                end
            end
            show_frame( handles,n)  ;
            
            
        elseif selection>10
            handles.data_file(4).cdata.Centroids(track_what).cdata =centy1  ;
            guidata(hObject,handles)
            Untitled_25_Callback(hObject, eventdata, handles)
        end
        
        
        h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
        
        
        
        try
            cell_tracks_window('Untitled_1_Callback', h_cell_tracks_window.Untitled_1,[],h_cell_tracks_window)
        end
        % ****************************************************************8
    end
    
    % ========================
    if  strfind(num2str(get(handles.mode_4,'foregroundcolor')),'1  1  0')
        if   findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
            MATRIX  =  handles.data_file(5).cdata.Tracks(track_what ).cdata;
            sizee=size(MATRIX,2)/2;
            matrix=repmat([1 NaN;NaN 1],1,sizee );
            X=matrix(1,:).*MATRIX(n,:);
            Y=matrix(2,:).*MATRIX(n,:);
            X(isnan(X))=[]; %take off all nans from X vector
            Y(isnan(Y))=[]; %take off all nans from Y vector
            X2=X;
            Y2=Y;
            X2(X2==0)=[];
            Y2(Y2==0)=[];
            x=find((X>0)) ;
            xx=x*2-1;
            xxx=xx+1;
            min_XY=1000 ; % largest predicted image size
            for ii=1:length(xx)
                X2=MATRIX(:,xx(ii)); Y2=MATRIX(:,xxx(ii));
                XY= sqrt((X2-point1(1,1)).^2+ (Y2-point1(1,2)).^2)  ;
                if   min(XY) < min_XY
                    [min_XY,Frame_index]=min(XY);
                end
            end
            set(handles.Raw_listbox,'value',Frame_index);
            show_frame( handles,Frame_index)  ;
        end
    end
    
    % ========================
    
    
    if  strfind(num2str(get(handles.mode_6,'foregroundcolor')),'1  1  0')
        box_Raw=get(handles.Raw_listbox,'string')   ;
        n=round(get(handles.Raw_listbox,'Value'));
        filename_Raw=char(box_Raw(n))  ;
        if isempty(centy1)==1
            return
        end
        XY= (centy1(:,1)-point1(1,1)).^2+ (centy1(:,2)-point1(1,2)).^2;   %find closest centroid to the selected point
        XY_min_index=find(ismember(XY,(min(XY))))  ;
        for ii=1:size(handles.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
            xy= handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BoundingBox ;
            % find coresponding  bounding box to the closet centroid.
            % If the point is inside the bounding box eliminate the centroid
            if centy1(XY_min_index,1:2)== handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Centroid
                if xy(1)<point1(1,1) && xy(2)<point1(1,2) && point1(1,1)<(xy(1)+xy(3)) && point1(1,2)<(xy(2)+xy(4))
                    if centy1(XY_min_index,3)-round(centy1(XY_min_index,3))==0
                        centy1(XY_min_index,3)=centy1(XY_min_index,3)+0.2;
                    else
                        centy1(XY_min_index,3)=round(centy1(XY_min_index,3));
                    end
                    handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata=centy1 ;
                    guidata(hObject,handles);
                    h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
                end
            end
        end
        show_frame( handles,n)  ;
        return
    end
    
    if  strfind(num2str(get(handles.mode_7,'foregroundcolor')),'1  1  0')
        
        temp_Segmentation = read_image(handles,n,3)  ;
        
        
        
        
        
        point1=ceil(point1) ;
        temp_Segmentation2=bwlabel(temp_Segmentation);
        Val=temp_Segmentation2( point1(3), point1(1));
        temp_Segmentation(temp_Segmentation2==Val)=0;
        
        
        
        
        full_filename_Segmentation= char(strcat(handles.data_file(2).cdata(track_what1,3),filename,'_ch0',num2str(track_what1-1),'_Segmented.tif')) ;
        temp_Segmentation=flipdim(temp_Segmentation,1);
        imwrite(temp_Segmentation, full_filename_Segmentation);  %save file to hard drive
        pushbutton27_Callback(hObject, eventdata, handles)
        
        
    end
    
    
    
    
end
% ========================
if strcmp(sel_typ,'normal')==1
    
    
    if isempty(centy1)==1
        return
    end
    centy1_from_L= handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata  ;
    XY= (centy1_from_L(:,1)-point1(1,1)).^2+ (centy1_from_L(:,2)-point1(1,2)).^2;   %find closest centroid to the selected point
    XY_min_index= ismember(XY,(min(XY)))  ;
    xy= handles.data_file(4).cdata.L(track_what).cdata(n).cdata(XY_min_index).BoundingBox  ;
    if xy(1)<point1(1,1) && xy(2)<point1(1,2) && point1(1,1)<(xy(1)+xy(3)) && point1(1,2)<(xy(2)+xy(4))
        h=waitbar(0,'splitting object using watershed ....');
        temp_Segmentation = read_image(handles,n,3)  ;
        if (xy(1)+xy(3))>512
            xy(1)=floor(xy(1));
        end
        if (xy(2)+xy(4))>512
            xy(2)=floor(xy(2));
        end
        X1=round(xy(2)) ;
        Y1=round(xy(1));
        X2=round(xy(2)+xy(4));
        Y2=round(xy(1)+xy(3));
        
        matrix_bw=double(temp_Segmentation(X1:X2,Y1:Y2));
        try
            temp_Segmentation(X1:X2,Y1:Y2)=watershed_split(matrix_bw)  ;
            full_filename_Segmentation= char(strcat(handles.data_file(2).cdata(track_what1,3),filename,'_ch0',num2str(track_what1-1),'_Segmented.tif')) ;
            temp_Segmentation=flipdim(temp_Segmentation,1);
            imwrite(temp_Segmentation, full_filename_Segmentation);  %save file to hard drive
            pushbutton27_Callback(hObject, eventdata, handles)
        end
        
    end
    try
        close(h)
    end
end

if strcmp(sel_typ,'alt')==1
    
    if isempty(centy1)==1
        return
    end
    centy1_from_L= handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata  ;
    XY= (centy1_from_L(:,1)-point1(1,1)).^2+ (centy1_from_L(:,2)-point1(1,2)).^2;   %find closest centroid to the selected point
    XY_min_index= ismember(XY,(min(XY)))  ;
    xy= handles.data_file(4).cdata.L(track_what).cdata(n).cdata(XY_min_index).BoundingBox  ;
    if xy(1)<point1(1,1) && xy(2)<point1(1,2) && point1(1,1)<(xy(1)+xy(3)) && point1(1,2)<(xy(2)+xy(4))
        h=waitbar(0,'splitting object using intensity-shell ....');
        temp_Segmentation = read_image(handles,n,3)  ;
        temp_Raw = read_image(handles,n,1)  ;
        if (xy(1)+xy(3))>512
            xy(1)=floor(xy(1));
        end
        if (xy(2)+xy(4))>512
            xy(2)=floor(xy(2));
        end
        X1=round(xy(2)) ;
        Y1=round(xy(1));
        X2=round(xy(2)+xy(4));
        Y2=round(xy(1)+xy(3));
        try
            matrix_bw=double(temp_Segmentation(X1:X2,Y1:Y2));
            matrix_raw=double(temp_Raw(X1:X2,Y1:Y2));
            ROI= I_split_Xaxis(matrix_bw, matrix_raw) ;
            ROI =bwareaopen(ROI,20);
            ROI=bwlabel_max(ROI,2)*255;
            temp_Segmentation(X1:X2,Y1:Y2)=ROI;
            full_filename_Segmentation= char(strcat(handles.data_file(2).cdata(track_what1,3),filename,'_ch0',num2str(track_what1-1),'_Segmented.tif')) ;
            temp_Segmentation=flipdim(temp_Segmentation,1);
            imwrite(temp_Segmentation, full_filename_Segmentation);  %save file to hard drive
            pushbutton27_Callback(hObject, eventdata, handles)
        end
    end
    try
        close(h)
    end
end
set(handles.figure1,'userdata',handles.data_file);update_labelmatrix(handles)
% ---------------------------------------------------------------
function select_mode_segmentation_Callback(hObject, ~, handles)
select_mode_segmentation=get(hObject,'Value');
if select_mode_segmentation==3
    Raw_listbox=get(handles.Raw_listbox,'string')  ;
    n=get(handles.Raw_listbox,'Value') ;
    if isempty(n)==1
        n=1;
    end
    if isempty(  Raw_listbox)==1
        return
    end
    
    set(handles.start_segmentation_at,'String',num2str(n));
    set(handles.end_segmentation_at,'String',num2str(size(Raw_listbox,1)));
    
    
    set(handles.start_segmentation_at,'Visible','on');
    set(handles.end_segmentation_at,'Visible','on');
else
    set(handles.start_segmentation_at,'Visible','off')
    set(handles.end_segmentation_at,'Visible','off')
end

% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, ~, handles)

Current_Exp=get(handles.Current_Exp,'String');
[filename, pathname, filterindex] = uiputfile({  '*.dat','Dat-files (*.dat)';}, 'save  session to a data file',Current_Exp);

if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
filename=regexprep(filename, 'TACTICS_EXP_','');
full_filename= strcat(pathname,'TACTICS_EXP_',filename) ;
full_filename=char(full_filename);

Raw_listbox=get(handles.Raw_listbox,'String')
if iscell(Raw_listbox)~=0
    handles.data_file(1).cdata=cell(length(Raw_listbox),1) ;
    handles.data_file(1).cdata(:,1)=Raw_listbox;
end



handles.data_file(10).cdata=full_filename;
guidata(hObject, handles);
temp=handles.data_file;
save(full_filename ,  'temp')



%   -------------------------------------------------------------
function popupmenu7_Callback(hObject, ~, handles)
popup_apply_filters=get(hObject,'Value') ;


switch popup_apply_filters
    case 1
        str=handles.data_file(1).cdata(2,3)
    case 2
        str=handles.data_file(1).cdata(3,3)
    case 3
        str=handles.data_file(1).cdata(4,3)
    case 4
        str=handles.data_file(1).cdata(5,3)
end
if char(str)=='1'
    handles.c=handles.c1
elseif char(str)=='2'
    handles.c=handles.c2
elseif char(str)=='3'
    handles.c=handles.c3
elseif char(str)=='4'
    handles.c=handles.c4
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.


% -------------------------------------------------------------------------

function pushbutton10_Callback(~, ~, ~)
uiwait
% --------------------------------------------------------------------
function segmentation_type1_Callback(~, ~, handles)
n=get(handles.Raw_listbox,'value')   ;
show_frame( handles,n) ;

curent_index=[];





if get(handles.show_axes2,'value')==7
    axes(handles.axes1)
    h_rectangle=rectangle('Position',[handles.Y1 handles.X1 handles.Y handles.X],'LineWidth',3,'LineStyle','-','EdgeColor','m','Hittest','Off');
    segmentation_type=get(handles.segmentation_type2,'Value');
    box_Raw= get(handles.Raw_listbox,'String') ;
    filename=char(box_Raw(n));
    Projected_by_Value=get(handles.Projected_by,'Value')  ;
    Projected_by_Str=get(handles.Projected_by,'String') ;
    Projected_by=char(Projected_by_Str(Projected_by_Value));
    track_what=get(handles.track_what2,'Value') ;
    
    [temp,~,~]= read_image2(handles,n,segmentation_type,Projected_by, filename,handles.data_file,track_what,track_what) ;
    [temp_Segmentation,~,~]= read_image2(handles,n,3,Projected_by, filename,handles.data_file,track_what,track_what)     ;
    temp=temp(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1);
    axes(handles.axes2); cla
    temp_Segmentation2=temp_Segmentation(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1);
    h_axes2_imagesc=imagesc(temp, 'Hittest','Off') ; axis tight                                        ;
    axes2(1).cdata=   temp_Segmentation2;axes2(2).cdata=temp;
    set(handles.axes2,'userdata',axes2);
    bw=im2bw( temp_Segmentation2,0)   ;
    [B,L] = bwboundaries(bw ,4,'noholes')   ;
    hold on
    if size( temp_Segmentation2,1)>200 || size( temp_Segmentation2,2)>200
        for k = 1:length(B)
            b  = B{k}   ;
            h_axesb_plot=scatter( b(:,2),b(:,1) ,'MarkerFaceColor' ,'m', 'Marker','.'  )   ;set(h_axesb_plot, 'Hittest','Off')  ;
        end
    else
        for k = 1:length(B)
            b  = B{k}   ;
            h_axesb_plot=scatter( b(:,2),b(:,1) ,'MarkerFaceColor' ,'m')   ;set(h_axesb_plot, 'Hittest','Off')  ;
        end
    end
    
    axis tight
    axis manual
end



%   -----------------------------------------------------------------------
function axes2_ButtonDownFcn(hObject, ~, handles)
global h_TAC_Cell_Tracking_Module;
centy1=[] ;
axes2=get(handles.axes2,'userdata')
matrix=axes2(1).cdata ;  temp=axes2(2).cdata  ;
xy=   round(get(hObject,'CurrentPoint')  );
xy=round(xy);
y=xy(1,1) ;
x=xy(1,2) ;
fig = gcf;
sel_typ = get(gcbf,'SelectionType');
switch sel_typ
    case 'normal'
        
        h = imline(gca,[y x ;y+1 x+1]);
        setColor(h,[1 1 1]);
        get(h)
        
        Line_Children=get(h,'Children')
        set(Line_Children(1),'LineWidth',8,'Color','y','Marker','o')
        set(Line_Children(2),'LineWidth',8,'Color','y','Marker','o')
        set(Line_Children(3),'LineWidth',5,'Color',[0.2824 0.5333 0.9725])
        
        position_in = wait(h) ;
        myline=[]; X=[];Y=[];
        if isempty(position_in)==1
            return
        end
        
        if sum(position_in)==0
            return
        end
        tic
        Index= ~matrix;
        temp=uint8(255*( double(temp)./max(max(double(temp)))));
        temp(Index)=255;
        %%%% splitting starts from left to right always
        x = round(position_in(:,1)) ;
        y = round(position_in(:,2)) ;
        [matrix2,kk]=intensity_split_function(x,y,matrix,temp);
        if isempty(matrix2)==1
            axes(handles.axes2);   cla
            h_axes1_imagesc=imagesc(double(matrix).*double(temp)) ;
            set(h_axes1_imagesc, 'Hittest','Off')   ;
            [B,L] = bwboundaries(matrix ,4,'noholes')   ;
            hold on
            for k = 1:length(B)
                b  = B{k}   ;
                h_axesb_plot=scatter( b(:,2),b(:,1) ,'MarkerFaceColor' ,'m')   ;set(h_axesb_plot, 'Hittest','Off')  ;
            end
            axis manual
        end
        if isempty(matrix2)~=1
            axes(handles.axes2);
            cla
            axes2(1).cdata=matrix2;
            set(handles.axes2,'userdata',axes2);
            h_axes1_imagesc=imagesc(double(matrix2).*double(temp)) ;
            set(h_axes1_imagesc, 'Hittest','Off')   ;
            [B,L] = bwboundaries(matrix2 ,4,'noholes')   ;
            hold on
            for k = 1:length(B)
                b  = B{k}   ;
                h_axesb_plot=scatter( b(:,2),b(:,1) ,'MarkerFaceColor' ,'m')   ;set(h_axesb_plot, 'Hittest','Off')  ;
            end
            axis manual
            
        end
    case 'extend'
        box_Raw=get(handles.Raw_listbox,'string') ;
        if iscell(box_Raw)==0
            Y=wavread('Error');
            h = errordlg('No files in Raw Frame listbox','Error');
            return
        end
        n=get(handles.Raw_listbox,'value')   ;
        filename=char(box_Raw(n))  ;
        track_what=get(handles.track_what2,'Value') ;
        pathname_Segmentation=handles.data_file(2).cdata(track_what,3) ;
        full_filename_Segmentation= char(strcat(handles.data_file(2).cdata(track_what,3),filename,'_ch0',num2str(track_what-1),'_Segmented.tif')) ;
        
        full_filename_Segmentation=char(full_filename_Segmentation );
        temp_Segmentation=imread(full_filename_Segmentation,1);
        temp_Segmentation=flipdim(temp_Segmentation,1);
        temp_Segmentation( handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1  )=  matrix   ;
        temp_Segmentation=flipdim(temp_Segmentation,1);
        imwrite(temp_Segmentation, full_filename_Segmentation);  %save file to hard drive
        temp_Segmentation=flipdim(temp_Segmentation,1);
        L=bwlabel(temp_Segmentation,4);
        stats=regionprops(L,'Centroid') ;
        for jj=1:length(stats)
            temp_centy=[stats(jj).Centroid n] ;
            temp_centy=  (round(temp_centy.*100))./100;
            centy1(jj,:)=  temp_centy;
        end
        handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata  =centy1   ;
        temp_Segmentation2=zeros(size(temp_Segmentation));
        position= handles.data_file(6).cdata ;
        temp_Segmentation2(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1))  =  temp_Segmentation(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1));
        L=bwlabel(temp_Segmentation2,4);
        handles.data_file(4).cdata.L(track_what).cdata(n).cdata= regionprops(L,'Area','BoundingBox','Centroid','PixelList','Orientation','Eccentricity','Perimeter','Extent','Solidity','Majoraxislength','Minoraxislength','EquivDiameter');
        
        
        for iii=1:size(handles.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
            handles.data_file(4).cdata.L(track_what).cdata(n).cdata(iii).Centroid= round( handles.data_file(4).cdata.L(track_what).cdata(n).cdata(iii).Centroid*100)/100 ;
        end
        try %relabel n
            centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
            try
                centy1(n).cdata(:,4)=hungarianlinker_TACWrapper(centy1(n ).cdata(:,1:2),centy1(n-1).cdata(:,1:2),100);  %100 is dafult velocity
            catch
                centy1(n).cdata(:,4)=-1;
            end
            handles.data_file(4).cdata.Centroids(track_what).cdata= centy1 ;
            guidata(hObject,handles);
        end
        try %relabel n+1
            centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
            try
                centy1(n+1).cdata(:,4)=hungarianlinker_TACWrapper(centy1(n+1 ).cdata(:,1:2),centy1(n).cdata(:,1:2),100);  %100 is dafult velocity
            catch
                centy1(n+1).cdata(:,4)=-1;
            end
            handles.data_file(4).cdata.Centroids(track_what).cdata= centy1 ;
            
        end
        guidata(hObject,handles);
        eventdata.VerticalScrollCount=0;
        figure1_WindowScrollWheelFcn([], eventdata, handles)
    case 'alt'
        if matrix(x,y)==max(max(matrix))
            matrix(x,y)=0;
        elseif matrix(x,y)==0
            matrix(x,y)=max(max(matrix)) ;
        end
        
        axes(handles.axes2);
        cla
        axes2(1).cdata=matrix;
        set(handles.axes2,'userdata',axes2);
        
        segmentation_type=get(handles.segmentation_type1,'Value');
        if   segmentation_type==3
            h_axes1_imagesc=imagesc(matrix) ;
        else
            h_axes1_imagesc=imagesc(double(matrix).*double(temp)) ;
        end
        set(h_axes1_imagesc, 'Hittest','Off')   ;
end
h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
set(handles.figure1,'userdata',handles.data_file);update_labelmatrix(handles)
% -------------------------------------------------------------------------
function pushbutton27_Callback(hObject, ~, handles)

global h_TAC_Cell_Tracking_Module;
centy1=[];
box_Raw=get(handles.Raw_listbox,'string') ;
if iscell(box_Raw)==0
    Y=wavread('Error');
    h = errordlg('No files in Raw Frame listbox','Error');
    return
end
n=get(handles.Raw_listbox,'value')   ;
filename=char(box_Raw(n))  ;
track_what=get(handles.track_what2,'Value') ;
pathname_Segmentation=handles.data_file(2).cdata(track_what,3) ;


full_filename_Segmentation= char(strcat(handles.data_file(2).cdata(track_what,3),filename,'_ch0',num2str(track_what-1),'_Segmented.tif')) ;

full_filename_Segmentation=char(full_filename_Segmentation );
temp_Segmentation=imread(full_filename_Segmentation,1);
temp_Segmentation=flipdim(temp_Segmentation,1);



L=bwlabel(temp_Segmentation,4);
stats=regionprops(L,'Centroid') ;
for jj=1:length(stats)
    temp_centy=[stats(jj).Centroid n] ;
    temp_centy=  (round(temp_centy.*100))./100;
    centy1(jj,:)=  temp_centy;
end

handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata  =centy1  ;
temp_Segmentation2=zeros(size(temp_Segmentation));
position= handles.data_file(6).cdata ;
temp_Segmentation2(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1))  =  temp_Segmentation(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1));
L=bwlabel(temp_Segmentation2,4);
handles.data_file(4).cdata.L(track_what).cdata(n).cdata= regionprops(L,'Area','BoundingBox','Centroid','PixelList','Orientation','Eccentricity','Perimeter','Extent','Solidity','Majoraxislength','Minoraxislength','EquivDiameter');

for iii=1:size(handles.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
    handles.data_file(4).cdata.L(track_what).cdata(n).cdata(iii).Centroid= round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(iii).Centroid*100)/100 ;
end
guidata(hObject,handles);
try %relabel n
    centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
    try
        centy1(n).cdata(:,4)=hungarianlinker_TACWrapper(centy1(n ).cdata(:,1:2),centy1(n-1).cdata(:,1:2),100);  %100 is dafult velocity
    catch
        centy1(n).cdata(:,4)=-1;
    end
    handles.data_file(4).cdata.Centroids(track_what).cdata= centy1 ;
    guidata(hObject,handles);
end
try %relabel n+1
    centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
    try
        centy1(n+1).cdata(:,4)=hungarianlinker_TACWrapper(centy1(n+1 ).cdata(:,1:2),centy1(n).cdata(:,1:2),100);  %100 is dafult velocity
    catch
        centy1(n+1).cdata(:,4)=-1;
    end
    handles.data_file(4).cdata.Centroids(track_what).cdata= centy1 ;
    guidata(hObject,handles);
end









show_frame( handles,n);
h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);

% -------------------------------------






%-------------------------------------------------------------------------
function pushbutton31_Callback(~, ~, ~)


% ----------------------
function T_popup_function(ii,handles)   %#ok<INUSD>
%VMatlab user can easily  add more segmentation and binary operations options upon demand. Instructions are as the following:
% Open segmentation_file.m located in supporting functions library with Matlab editor.
%  Add indexed case. For instance, if there are 10 cases, add case 11.
% For this case add the next format:
% case 11
%  if nargin==0
%                  matrix(11)={  ‘user given name for the operation'}
%         else
%             matrix=operation added by the user
%          end
% %Example:
% %case 7
%         %    if nargin==0
%         %         matrix(7)={   'imfill holes'}
%         %    else
%         %             matrix=imfill(matrix,'holes');
%         %    end
%
% Whereas nargin==0 is used to give the function name,
% matrix is the input and returned output  image
% 7  is the case index
% imfill is the function used on input matrix
% matrix can be only in 2-D format
% 4. Save and exit the segmentation_file.m .
% 5. Open TAC_Segmentation_Module.m with Matlab editor.
% 6. Add to the indexed case under  T_popup_function slider setting. This settings are depended on the  maximum  input value. i.e.:
%             eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
%              eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',0)'));
%              eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
%              eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Max''', ',1)'));
%              eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Min''', ',0)'));
%              eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Value''', ',0)'));
%              eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Sliderstep''', ',[0.005 0.05])'))
% 7. Save and exit TAC_Segmentation_Module.m .

X=eval( strcat ('get(handles.T_popup_',num2str(ii), ',','''Value''', ')'));
switch X
    case 1
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''off''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''off''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',[])'));
    case 2
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''off''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''off''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',[])'));
        
    case 3
        
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Max''', ',2000)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Min''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Value''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Sliderstep''', ',[0.01 0.1])'));
    case 4
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Max''', ',10000)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Min''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Value''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Sliderstep''', ',[0.01 0.1])'));
    case 5
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Max''', ',100)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Min''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Value''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Sliderstep''', ',[0.01 0.05])'));
        
    case 6
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Max''', ',8)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Min''', ',4)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Value''', ',4)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Sliderstep''', ',[1 1])'));
    case 7
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''off''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''off''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',[])'));
    case 8
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Max''', ',1)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Min''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Value''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Sliderstep''', ',[0.005 0.05])'));
    case 9
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Max''', ',1)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Min''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Value''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Sliderstep''', ',[0.005 0.05])'));
    case 10
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Max''', ',1)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Min''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Value''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Sliderstep''', ',[0.005 0.05])'));
    case 11
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Max''', ',20)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Min''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Value''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Sliderstep''', ',[0.01 0.05])'));
    case 12
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Max''', ',20)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Min''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Value''', ',0)'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Sliderstep''', ',[0.01 0.05])'));
    case 13
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''off''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''off''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',[])'));
    case 14
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''off''', ')'));
        eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''off''', ')'));
        eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',[])'));
        
end

% =========================================================================
% -------------------------
%  function T_popup_1_Callback(hObject, eventdata, handles)
% T_popup_function(1,handles);
%  function T_popup_2_Callback(hObject, eventdata, handles)
% T_popup_function(2,handles);
%  function T_popup_3_Callback(hObject, eventdata, handles)
% T_popup_function(3,handles);
%  function T_popup_4_Callback(hObject, eventdata, handles)
% T_popup_function(4,handles);
%  function T_popup_5_Callback(hObject, eventdata, handles)
% T_popup_function(5,handles);
%  function T_popup_6_Callback(hObject, eventdata, handles)
% T_popup_function(6,handles);
% % END SECTION 5 - MAIN FUNCTIONS
% ------------------------------
function thresh_level_Callback(hObject, eventdata, handles)
S=get(hObject,'Value');
set(handles.T_edit_1,'String', S);
apply_segmentation_function(hObject, eventdata, handles,'empty')    ;
% -----------
function T_Slider_2_Callback(hObject, eventdata, handles)
S=get(hObject,'Value');
V=get(handles.T_popup_2,'Value');
if V<8
    S=round(S);
end
set(handles.T_edit_2,'String', S);
apply_segmentation_function(hObject, eventdata, handles,'empty')    ;
% ---------------------------------------------------------------------
function T_Slider_3_Callback(hObject, eventdata, handles)
S=get(hObject,'Value');
V=get(handles.T_popup_3,'Value');
if V<8
    S=round(S);
end
set(handles.T_edit_3,'String', S);
apply_segmentation_function(hObject, eventdata, handles,'empty')    ;
% ---------------------------------------------------------------------
function T_Slider_4_Callback(hObject, eventdata, handles)
S=get(hObject,'Value');
V=get(handles.T_popup_4,'Value');
if V<8
    S=round(S);
end
set(handles.T_edit_4,'String', S);
apply_segmentation_function(hObject, eventdata, handles,'empty')    ;
% ---------------------------------------------------------------------
function T_Slider_5_Callback(hObject, eventdata, handles)
S=get(hObject,'Value') ;
V=get(handles.T_popup_5,'Value');
if V<8
    S=round(S);
end
set(handles.T_edit_5,'String', S);
apply_segmentation_function(hObject, eventdata, handles,'empty')    ;
% ---------------------------------------------------------------------
function T_Slider_6_Callback(hObject, eventdata, handles)
S=get(hObject,'Value') ;
V=get(handles.T_popup_6,'Value');
if V<8
    S=round(S);
end
set(handles.T_edit_6,'String', S);
apply_segmentation_function(hObject, eventdata, handles,'empty')    ;



% --------------------------------------------------------------
function [STAT]= autothreshold_critiria(matrix_bw,ROI)

bwareaopen_value=80;
%Critiria: 0. minimum size of segment larger than critical area 1. must
%be only one segment. 2. Circularity higher than 0.45
%3. Less than 0.4 percatet of border line is filled. 4. new threshold is at least 0.6 percent from the original matrix_bw!
STAT=0;

if mean(mean(matrix_bw))>50 && size(matrix_bw,1)*size(matrix_bw,2)>100
    
    L=bwlabel(ROI) ;
    
    if max(max(L))==1
        stats=regionprops(L,'Perimeter','Area');
        circularity=4*pi*stats.Area/(stats.Perimeter^2)
        if circularity>0.5
            if mean(ROI(:,1))<0.4 || mean(ROI(:,end))<0.4 || mean(ROI(:,1))<0.4 || mean(ROI(:,end))<0.4
                a=sum(sum(matrix_bw)); b=sum(sum(ROI));
                if a/b>0.62
                    STAT=1;
                end
            end
        end
    end
end
%  ----------
% --------------------------------------------------------------
function [STAT]= autothreshold_critiria2(matrix_bw,ROI) %for 2 cells
bwareaopen_value=80;
%Critiria: 0. minimum size of segment larger than critical area 1. must
%be only one segment. 2. Circularity higher than 0.45
%3. Less than 0.4 percatet of border line is filled. 4. new threshold is at least 0.6 percent from the original matrix_bw!
STAT=0;
if mean(mean(matrix_bw))>50 && size(matrix_bw,1)*size(matrix_bw,2)>100
    L=bwlabel(ROI) ;
    if max(max(L))==1
        stats=regionprops(L,'Perimeter','Area');
        circularity=4*pi*stats.Area/(stats.Perimeter^2)
        if circularity>0.45
            if mean(ROI(:,1))<0.4 || mean(ROI(:,end))<0.4 || mean(ROI(:,1))<0.4 || mean(ROI(:,end))<0.4
                %                              a=sum(sum(ROI)); b=sum(sum(ROI));v
                %                               if b/a>0.6
                STAT=1;
                %                               end
            end
        end
    end
end
%  ----------



% --------------------------------------------------------------------
function Optima_settings_Callback(~, ~, ~)
% hObject    handle to Optima_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Load_optimal_settings_Callback(~, ~, handles)
% hObject    handle to Load_optimal_settings (see GCBO)
[filename, pathname, filterindex] = uigetfile({  '*.dat','DAT-files (*.dat)';}, 'Please Choose optimal setting file')% handles.directory_name); %pick files to combine
if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end


full_filename= strcat(pathname,filename);
full_filename=char(full_filename);
DATA=importdata(full_filename)  ;
set_DATA(handles,DATA);
% --------------------------------------------------------------------
function Setting_for_selected_frame_Callback(~, ~, handles)

track_what=get(handles.track_what1,'Value');
n_Raw=get(handles.Raw_listbox,'Value');

DATA=handles.data_file(8).cdata(track_what).Frame(n_Raw).DATA  ;

%  if  DATA(1).vector(1)~=0
%      set(handles.F_popup_1,'Value',DATA(1).vector(1)); end
%  if  DATA(1).vector(2)~=0
%      set(handles.F_popup_2,'Value',DATA(1).vector(2)); end
%  if  DATA(1).vector(3)~=0
%      set(handles.F_popup_3,'Value',DATA(1).vector(3)); end
%  if  DATA(1).vector(4)~=0
%      set(handles.F_popup_4,'Value',DATA(1).vector(4)); end
%  if  DATA(1).vector(5)~=0
%      set(handles.F_popup_5,'Value',DATA(1).vector(5)); end

% for ii=1:5
% F_popup_function(ii,handles);
% end
%
% set(handles.F_Slider_1,'Value',DATA(1).vector(6));
% set(handles.F_Slider_2,'Value',DATA(1).vector(7));
% set(handles.F_Slider_3,'Value',DATA(1).vector(8));
% set(handles.F_Slider_4,'Value',DATA(1).vector(9));
% set(handles.F_Slider_5,'Value',DATA(1).vector(10));
%


if  DATA(1).vector(11)~=0
    set(handles.T_popup_2,'Value',DATA(1).vector(11));   end
if  DATA(1).vector(12)~=0
    set(handles.T_popup_3,'Value',DATA(1).vector(12));  end
if  DATA(1).vector(13)~=0
    set(handles.T_popup_4,'Value',DATA(1).vector(13));  end
if  DATA(1).vector(14)~=0
    set(handles.T_popup_5,'Value',DATA(1).vector(14));  end
if  DATA(1).vector(15)~=0
    set(handles.T_popup_6,'Value',DATA(1).vector(15));  end


for ii=2:5
    T_popup_function(ii,handles);
end


set(handles.thresh_level,'Value',DATA(1).vector(16));
set(handles.T_Slider_2,'Value',DATA(1).vector(17));
set(handles.T_Slider_3,'Value',DATA(1).vector(18));
set(handles.T_Slider_4,'Value',DATA(1).vector(19));
set(handles.T_Slider_5,'Value',DATA(1).vector(20));
set(handles.T_Slider_6,'Value',DATA(1).vector(21));
if DATA(1).vector(22)==0
    DATA(1).vector(22)= 1;
end
%   if DATA(1).vector(23)==0
%      DATA(1).vector(23)= 1;
%   end
if DATA(1).vector(24)==0
    DATA(1).vector(24)= 1;
end
set(handles.strel_type,'Value',DATA(1).vector(22));
%  set(handles.fspecial_type,'Value',DATA(1).vector(23));
set(handles.bwmorph_type,'Value',DATA(1).vector(24));

%  if isnan(DATA(2).vector(1))~=1
%      set(handles.F_edit_1,'String',DATA(2).vector(1)); end
%   if isnan(DATA(2).vector(2))~=1
%       set(handles.F_edit_2,'String',DATA(2).vector(2)); end
%    if isnan(DATA(2).vector(3))~=1
%        set(handles.F_edit_3,'String',DATA(2).vector(3)); end
%     if isnan(DATA(2).vector(4))~=1
%         set(handles.F_edit_4,'String',DATA(2).vector(4)); end
%      if isnan(DATA(2).vector(5))~=1
%          set(handles.F_edit_5,'String',DATA(2).vector(5)); end
%

if isnan(DATA(2).vector(6))~=1
    set(handles.T_edit_1,'String',DATA(2).vector(6)); end
if isnan(DATA(2).vector(7))~=1
    set(handles.T_edit_2,'String',DATA(2).vector(7)); end
if isnan(DATA(2).vector(8))~=1
    set(handles.T_edit_3,'String',DATA(2).vector(8)); end
if isnan(DATA(2).vector(9))~=1
    set(handles.T_edit_4,'String',DATA(2).vector(9)); end
if isnan(DATA(2).vector(10))~=1
    set(handles.T_edit_5,'String',DATA(2).vector(10)); end
if isnan(DATA(2).vector(11))~=1
    set(handles.T_edit_6,'String',DATA(2).vector(11)); end




%  ---------------------
function set_DATA(handles,DATA)

% if DATA(1).vector(1)~=0
%     set(handles.F_popup_1,'Value',DATA(1).vector(1)) ;   end
% if DATA(1).vector(2)~=0
%     set(handles.F_popup_2,'Value',DATA(1).vector(2));    end
% if DATA(1).vector(3)~=0
%     set(handles.F_popup_3,'Value',DATA(1).vector(3));    end
% if DATA(1).vector(4)~=0
%     set(handles.F_popup_4,'Value',DATA(1).vector(4));    end
% if DATA(1).vector(5)~=0
%     set(handles.F_popup_5,'Value',DATA(1).vector(5));    end

% for ii=1:5
% F_popup_function(ii,handles);
% end

% set(handles.F_Slider_1,'Value',DATA(1).vector(6));
% set(handles.F_Slider_2,'Value',DATA(1).vector(7));
% set(handles.F_Slider_3,'Value',DATA(1).vector(8));
% set(handles.F_Slider_4,'Value',DATA(1).vector(9));
% set(handles.F_Slider_5,'Value',DATA(1).vector(10));
%
if DATA(1).vector(11)~=0
    set(handles.T_popup_2,'Value',DATA(1).vector(11));  end
if DATA(1).vector(12)~=0
    set(handles.T_popup_3,'Value',DATA(1).vector(12));  end
if DATA(1).vector(13)~=0
    set(handles.T_popup_4,'Value',DATA(1).vector(13));  end
if DATA(1).vector(14)~=0
    set(handles.T_popup_5,'Value',DATA(1).vector(14));  end
if DATA(1).vector(15)~=0
    set(handles.T_popup_6,'Value',DATA(1).vector(15));  end
for ii=2:5
    T_popup_function(ii,handles);
end
set(handles.thresh_level,'Value',DATA(1).vector(16));
set(handles.T_Slider_2,'Value',DATA(1).vector(17));
set(handles.T_Slider_3,'Value',DATA(1).vector(18));
set(handles.T_Slider_4,'Value',DATA(1).vector(19));
set(handles.T_Slider_5,'Value',DATA(1).vector(20));
set(handles.T_Slider_6,'Value',DATA(1).vector(21));
set(handles.strel_type,'Value',DATA(1).vector(22));
% set(handles.fspecial_type,'Value',DATA(1).vector(23));
set(handles.bwmorph_type,'Value',DATA(1).vector(24));
% set(handles.F_edit_1,'String',DATA(2).vector(1));
% set(handles.F_edit_2,'String',DATA(2).vector(2));
% set(handles.F_edit_3,'String',DATA(2).vector(3));
% set(handles.F_edit_4,'String',DATA(2).vector(4));
% set(handles.F_edit_5,'String',DATA(2).vector(5));
set(handles.T_edit_1,'String',DATA(2).vector(6));
set(handles.T_edit_2,'String',DATA(2).vector(7));
set(handles.T_edit_3,'String',DATA(2).vector(8));
set(handles.T_edit_4,'String',DATA(2).vector(9));
set(handles.T_edit_5,'String',DATA(2).vector(10));
set(handles.T_edit_6,'String',DATA(2).vector(11));
% set(handles.Filtered_panel,'Visible','on');
% set(handles.Threshold_panel,'Visible','on');




% ----------------------------------------------------------------------------------------------------------------
function [output]= Cell_data_function(vector,handles,~,str,~)
track_what=get(handles.track_what1,'Value')  ;
output=[];

for ii=1:size(vector,1)
    if isnan(vector(ii,3))~=1
        full_command=strcat('handles. data_file(4).cdata.L(',num2str(track_what) ,').cdata(ii+jj-1).cdata(vector(ii,3)).',str) ;
        output(ii,:)= eval(full_command) ;
    end
end

%      kk=1;
%               for ii=1:size(vector,1)
%                           if isnan(vector(ii,3))~=1
%                               full_command=strcat('handles. data_file(4).cdata.L(',num2str(track_what1) ,').cdata(ii+jj-1).cdata(vector(ii,3)).',str);
%                               output(kk,:)= eval(full_command) ; kk=kk+1;
%                           end
%               end


%  ------------------------------------------
function show_tracks_Callback(hObject, eventdata, handles)
Raw_listbox_Callback(hObject, eventdata, handles)
% -----------------------------------------


% --------------------------------------------------------------------
function Untitled_36_Callback(~, ~, ~)
% hObject    handle to Untitled_36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_35_Callback(hObject, ~, handles)
h=timebar_TACWrapper('Processing second segmentation. Please  wait....');set(h,'color','w');
track_what=get(handles.track_what1,'value')
[Channel,Projected_by]=select_channel;
fff=1; z=1
box_Raw=get(handles.Raw_listbox,'string') ;
n=  get(handles.Raw_listbox,'value') ;
temp_matrix=zeros(512,512);
for ii=1:size(box_Raw,1)
    timebar_TACWrapper(h,ii/size(box_Raw,1))
    filename=char(box_Raw(ii)) ;
    [matrix2,~,full_filename_Segmentation]= read_image2(handles,ii,3,Projected_by, filename,handles.data_file,Channel)   ;
    
    
    [temp,~,full_filename_Raw]= read_image2(handles,ii,3,'Imean', filename,handles.data_file , track_what)   ;
    
    
    
    
    
    % % % % % % %         for kk=1:5 %if useing 5 sections
    % % % % % % %           Z=char(strcat('z',num2str(kk)));
    % % % % % % %           [temp_Raw(:,:,kk),centy1,full_filename]= read_image2(handles,ii,1,Z, filename, handles.data_file)   ;
    % % % % % % %         end
    for jj=1:size(handles.data_file(4).cdata.L(track_what).cdata(ii).cdata,1)
        if  isempty(handles.data_file(4).cdata.L(track_what).cdata(ii).cdata)~=1
            XY=  double(handles.data_file(4).cdata.L(track_what).cdata(ii).cdata(jj).BoundingBox);
            STAT=0;
            if (XY(1)+XY(3))>512
                XY(1)=floor(XY(1));
            end
            if (XY(2)+XY(4))>512
                XY(2)=floor(XY(2));
            end
            X1=round(XY(2))  ;
            Y1=round(XY(1))  ;
            X2=round(XY(2)+XY(4)) ;
            Y2=round(XY(1)+XY(3)) ;
            
            
            matrix1= temp_matrix;
            matrix1(X1:X2,Y1:Y2)=temp(X1:X2,Y1:Y2)./(max(max(temp(X1:X2,Y1:Y2))));
            matrix2=  matrix2./max(max(matrix2));
            
            intersec=double(matrix1).*double(matrix2);
            
            
            
            if         max(max(matrix2))==0
                'no object in the  second channel'
                V=0;
                eval(strcat('handles.data_file(4).cdata.L(',num2str(track_what),').cdata(',num2str(ii),').cdata(',num2str(jj),').Proximity_Ch_',num2str(Channel-1),'=V ;'))
            else
                if max(max(intersec))>0
                    'cell-object contact'
                    V=1;
                    eval(strcat('handles.data_file(4).cdata.L(',num2str(track_what),').cdata(',num2str(ii),').cdata(',num2str(jj),').Proximity_Ch_',num2str(Channel-1),'=V ;'))
                else
                    
                    
                    
                    
                    %                       pause
                    
                    
                    
                    matrix11=bwdist(matrix1,'euclidean');
                    matrix22=  bwdist(matrix2,'euclidean');
                    
                    matrix111= double(matrix1).*double(matrix22);  matrix111(~ matrix111)=nan;
                    matrix222= double(matrix11).*double(matrix2);matrix222(~ matrix222)=nan;
                    
                    v1=find(ismember(matrix111,min(min(matrix111))))  ;
                    v2=find(ismember(matrix222,min(min(matrix222))))  ;
                    v1=v1(1); v2=v2(1);% if more than one pixel is selected as the closest point. better model is required!
                    [V(1),V(2)]=ind2sub(size(matrix111),v1);  [V(3),V(4)]=ind2sub(size(matrix111),v2);
                    eval(strcat('handles.data_file(4).cdata.L(',num2str(track_what),').cdata(',num2str(ii),').cdata(',num2str(jj),').Proximity_Ch_',num2str(Channel-1),'=V ;'))
                end
            end
            clear V
        end
    end
end


guidata(hObject,handles);

close(h)

% hObject    handle to Untitled_35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ==============================================
% ========     SEGMENTATION MODE  ===============
%+=============================================
function apply_segmentation_function(hObject, eventdata, handles,Batch)
curent_index=[];
Projected_by_Value=get(handles.Projected_by,'Value') ;
Projected_by_Str=get(handles.Projected_by,'String')  ;
track_what=get(handles.track_what2,'Value')  ;
popup_select_mode_segmentation=get(handles.select_mode_segmentation,'Value') ;
imfo= handles.data_file(9).cdata;
n=round(get(handles.Raw_listbox,'value'));
box_Raw= get(handles.Raw_listbox,'String') ;
segmentation_type=get(handles.segmentation_type1,'Value');



filename=char(box_Raw(n));
Projected_by_Value=get(handles.Projected_by,'Value')  ;
Projected_by_Str=get(handles.Projected_by,'String') ;
Projected_by=char(Projected_by_Str(Projected_by_Value));
pathname_Raw=handles.data_file(2).cdata(track_what,1) ;
pathname_Filtered=handles.data_file(2).cdata(track_what,2) ;
pathname_Segmentation=handles.data_file(2).cdata(track_what,3) ;
if iscell( box_Raw)==0
    Y=wavread('Error');
    h = errordlg('No files in Filtered Frame listbox','Error');
    return
end
switch popup_select_mode_segmentation
    case 1
        [temp_Filtered,~,full_filename]= read_image2(handles,n,2,Projected_by,  char(box_Raw(n)),handles.data_file)   ;
        
        %        info=imfinfo(full_filename);  Num_bit=info.BitDepth;
        
        
        if handles.data_file(9).cdata==8
            temp_Filtered(1)=255 ;
            temp_Filtered=uint8(temp_Filtered);
        elseif handles.data_file(9).cdata==16
            %                 '16'
            if max(max(temp_Filtered))<256
                temp_Filtered(1)=  255;
                temp_Filtered=uint8(temp_Filtered);
            else
                temp_Filtered(1)=  65535;
                temp_Filtered=uint8(temp_Filtered);
            end
        elseif handles.data_file(9).cdata==32
            'think about a new solution here!!!!'
            temp_Filtered=uint32(temp_Filtered);
            return
        end
        if    get(handles.Auto_threshold_on,'value')==1
            thresh_level = graythresh(temp_Filtered);
            thresh_level =thresh_level * 0.5 ; %
            set(handles.thresh_level,'value', thresh_level );
            set(handles.T_edit_1 ,'string', num2str(thresh_level ));
        end
        temp_Segmentation=segment_frame(temp_Filtered,handles,imfo) ;  %relabel the frame
        axes(handles.axes1)
        cla
        h_axes2_imagesc=imagesc(temp_Segmentation) ;
        set(h_axes2_imagesc, 'Hittest','Off')   ;
        h_rectangle=rectangle('Position',[handles.Y1 handles.X1 handles.Y handles.X],'LineWidth',3,'LineStyle','-','EdgeColor','m');  set(h_rectangle, 'Hittest','Off')   ;
    case 2
        [temp_Filtered,~,full_filename]= read_image2(handles,n,2,Projected_by, char(box_Raw(n)),handles.data_file,track_what,track_what)   ;
        if handles.data_file(9).cdata==8
            temp_Filtered(1)=255 ;
            temp_Filtered=uint8(temp_Filtered);
        elseif handles.data_file(9).cdata==16
            if max(max(temp_Filtered))<256
                temp_Filtered(1)=  255;
                temp_Filtered=uint8(temp_Filtered);
            else
                temp_Filtered(1)=  65535;
                temp_Filtered=uint8(temp_Filtered);
                
            end
        elseif handles.data_file(9).cdata==32
            temp_Filtered=uint32(temp_Filtered);
            return
        end
        if     get(handles.Auto_threshold_on,'value')==1
            thresh_level = graythresh(temp_Filtered);
            thresh_level =thresh_level * 0.5 ; %
            set(handles.thresh_level,'value', thresh_level );
            set(handles.T_edit_1 ,'string', num2str(thresh_level ));
            a6=thresh_level;
            a13=thresh_level;
        else
            a6=get(handles.thresh_level,'Value');
            a13=str2double(get(handles.T_edit_1,'String')) ;
        end
        a1=get(handles.T_popup_2,'Value') ;
        a2=get(handles.T_popup_3,'Value') ;
        a3=get(handles.T_popup_4,'Value')  ;
        a4=get(handles.T_popup_5,'Value') ;
        a5=get(handles.T_popup_6,'Value');
        %   a6=get(handles.thresh_level,'Value');
        a7=get(handles.T_Slider_2,'Value');
        a8=get(handles.T_Slider_3,'Value');
        a9=get(handles.T_Slider_4,'Value');
        a10=get(handles.T_Slider_5,'Value');
        a11=get(handles.T_Slider_6,'Value');
        a12=get(handles.bwmorph_type,'Value');
        %    a13=str2double(get(handles.T_edit_1,'String')) ;
        a14=str2double(get(handles.T_edit_2,'String'));
        a15=str2double(get(handles.T_edit_3,'String'));
        a16=str2double(get(handles.T_edit_4,'String'));
        a17=str2double(get(handles.T_edit_5,'String'));
        a18=str2double(get(handles.T_edit_6,'String'))
        temp_Segmentation=segment_frame(temp_Filtered,handles,imfo); % the temp image as defined by segment_frame function
        if get(handles.show_axes2,'value')<6
            axes(handles.axes2); cla
            h_axes2_imagesc=imagesc(temp_Segmentation) ; set(h_axes2_imagesc, 'Hittest','Off')   ;
            axis tight
            axis manual
        end
        pathname_Segmentation=handles.data_file(2).cdata(track_what,3)      ;
        [full_filename_Segmentation,filename_Segmentation]=set_new_filename( char(box_Raw(n)),  Projected_by_Str,Projected_by_Value,track_what,3, pathname_Segmentation )  ;
        temp_Segmentation=flipdim(temp_Segmentation,1);
        imwrite(temp_Segmentation, full_filename_Segmentation);  %save file to hard drive
        iii=n; %stright from raw_listbox
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(11)=a1  ;
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(12)=a2  ;
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(13)=a3  ;
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(14)=a4  ;
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(15)=a5  ;
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(16)=a6  ;
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(17)=a7  ;
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(18)=a8  ;
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(19)=a9  ;
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(20)=a10  ;
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(21)=a11;
        handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(24)=a12  ;
        if isnan(a13)~=1
            handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(6)=a13  ;  end
        if isnan(a14)~=1
            handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(7)=a14  ;  end
        if isnan(a15)~=1
            handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(8)=a15  ;  end
        if isnan(a16)~=1
            handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(9)=a16  ;  end
        if isnan(a17)~=1
            handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(10)=a17  ;  end
        if isnan(a18)~=1
            handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(11)=a18   ; end
        guidata(hObject,handles);
        pushbutton27_Callback(hObject, eventdata, handles)  %relabel
        axes(handles.axes1)
        h_rectangle=rectangle('Position',[handles.Y1 handles.X1 handles.Y handles.X],'LineWidth',3,'LineStyle','-','EdgeColor','m');  set(h_rectangle, 'Hittest','Off')   ;
        if get(handles.show_axes2,'value')==7
            
            [temp,~,~]= read_image2(handles,n,segmentation_type,Projected_by, filename,handles.data_file,track_what,track_what) ;
            [temp_Segmentation,~,~]= read_image2(handles,n,3,Projected_by, filename,handles.data_file,track_what,track_what)     ;
            temp=temp(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1);
            axes(handles.axes2); cla
            
            temp_Segmentation2=temp_Segmentation(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1);
            axes(handles.axes2); cla
            h_axes2_imagesc=imagesc(temp, 'Hittest','Off') ; axis tight                                        ;
            axes2(1).cdata=   temp_Segmentation2;axes2(2).cdata=temp;
            set(handles.axes2,'userdata',axes2);
            
            bw=im2bw( temp_Segmentation2,0)   ;
            [B,L] = bwboundaries(bw ,4,'noholes')   ;
            hold on
            if size( temp_Segmentation2,1)>200 || size( temp_Segmentation2,2)>200
                for k = 1:length(B)
                    b  = B{k}   ;
                    h_axesb_plot=scatter( b(:,2),b(:,1) ,'MarkerFaceColor' ,'m', 'Marker','.'  )   ;set(h_axesb_plot, 'Hittest','Off')  ;
                end
            else
                for k = 1:length(B)
                    b  = B{k}   ;
                    h_axesb_plot=scatter( b(:,2),b(:,1) ,'MarkerFaceColor' ,'m')   ;set(h_axesb_plot, 'Hittest','Off')  ;
                end
            end
            
            axis tight
            axis manual
        end
    case 3
        if strcmp(Batch,'Batch')==1
            start_segmentation_at=str2double(get(handles.start_segmentation_at,'String'));
            end_segmentation_at=str2double(get(handles.end_segmentation_at,'String'));
            if floor((end_segmentation_at-start_segmentation_at)/20) <1
                h = msgbox('Minimal files for Batch is 20','Aborted');
                return
            end
            h=waitbar(0,'Batch thresholding for the selected frames....');
            set(h,'color','w');
            
            a1=get(handles.T_popup_2,'Value');
            a2=get(handles.T_popup_3,'Value');
            a3=get(handles.T_popup_4,'Value');
            a4=get(handles.T_popup_5,'Value');
            a5=get(handles.T_popup_6,'Value');
            a6=get(handles.thresh_level,'Value');
            a7=get(handles.T_Slider_2,'Value');
            a8=get(handles.T_Slider_3,'Value');
            a9=get(handles.T_Slider_4,'Value');
            a10=get(handles.T_Slider_5,'Value');
            a11=get(handles.T_Slider_6,'Value');
            a12=get(handles.bwmorph_type,'Value');
            a13=str2double(get(handles.T_edit_1,'String'));
            a14=str2double(get(handles.T_edit_2,'String'));
            a15=str2double(get(handles.T_edit_3,'String'));
            a16=str2double(get(handles.T_edit_4,'String'));
            a17=str2double(get(handles.T_edit_5,'String'));
            a18=str2double(get(handles.T_edit_6,'String'));
            for iii=start_segmentation_at:end_segmentation_at
                waitbar(start_segmentation_at/end_segmentation_at)
                
                if isnan(a1)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(11)=a1  ;  end
                if isnan(a2)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(12)=a2  ;  end
                if isnan(a3)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(13)=a3  ;  end
                if isnan(a4)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(14)=a4  ;  end
                if isnan(a5)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(15)=a5  ;  end
                if isnan(a6)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(16)=a6  ;  end
                if isnan(a7)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(17)=a7  ;  end
                if isnan(a8)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(18)=a8  ;  end
                if isnan(a9)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(19)=a9  ;  end
                if isnan(a10)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(20)=a10  ;  end
                if isnan(a11)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(21)=a11  ;  end
                if isnan(a12)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(1).vector(24)=a12  ;  end
                if isnan(a13)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(6)=a13  ;  end
                if isnan(a14)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(7)=a14  ;  end
                if isnan(a15)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(8)=a15  ;  end
                if isnan(a16)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(9)=a16  ;  end
                if isnan(a17)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(10)=a17  ;  end
                if isnan(a18)~=1
                    handles.data_file(8).cdata(track_what).Frame(iii).DATA(2).vector(11)=a18   ; end
            end
            %      guidata(hObject,handles);
            for ii=1:floor((end_segmentation_at-start_segmentation_at)/20)  %e,.x 80/20=8
                for jj=1:20
                    curent_index=(ii-1)*20+jj+start_segmentation_at -1  ;
                    waitbar((curent_index/(floor((end_segmentation_at-start_segmentation_at)/20)))/20)
                    [temp_Filtered,~,full_filename]= read_image2(handles,curent_index,2,Projected_by, char(box_Raw(curent_index)),handles.data_file) ;
                    if handles.data_file(9).cdata==8
                        temp_Filtered(1)=255 ;
                        temp_Filtered=uint8(temp_Filtered);
                    elseif handles.data_file(9).cdata==16
                        if max(max(temp_Filtered))<256
                            temp_Filtered(1)=  255;
                            temp_Filtered=uint8(temp_Filtered);
                        else
                            temp_Filtered(1)=  65535;
                            temp_Filtered=uint8(temp_Filtered);
                        end
                        
                    elseif handles.data_file(9).cdata==32
                        temp_Filtered=uint32(temp_Filtered);
                        return
                    end
                    if get(handles.Auto_threshold_on,'value')==1
                        thresh_level = graythresh(temp_Filtered);
                        thresh_level =thresh_level * 0.5 ; %
                        set(handles.thresh_level,'value', thresh_level );
                        set(handles.T_edit_1 ,'string', num2str(thresh_level ));
                        a6=thresh_level;
                        a13=thresh_level;
                        if isnan(a6)~=1
                            handles.data_file(8).cdata(track_what).Frame(curent_index).DATA(1).vector(16)=a6  ;
                        end
                        if isnan(a13)~=1
                            handles.data_file(8).cdata(track_what).Frame(curent_index).DATA(2).vector(6)=a13  ;
                        end
                    end
                    temp_matrix=segment_frame(temp_Filtered,handles,imfo); % the temp image as defined by filer_Frame function
                    temp_matrix=flipdim(temp_matrix,1);
                    [full_filename_Segmentation,filename_Segmentation]=set_new_filename( char(box_Raw(curent_index)),  Projected_by_Str,Projected_by_Value,track_what,3, pathname_Segmentation )  ;
                    box_threshold((ii-1)*20+jj)=cellstr(filename_Segmentation) ;
                    imwrite(temp_matrix, full_filename_Segmentation);  %save file to hard drive
                    pause(0.1) %give the computer time to cool itself a bit
                end
            end
            curent_index=curent_index+1;
            while  end_segmentation_at-curent_index+1~=0   %the residual:
                waitbar((curent_index/floor((end_segmentation_at-start_segmentation_at)/20))/20)
                [temp_Filtered,~,full_filename]= read_image2(handles,curent_index,2,Projected_by, char(box_Raw(curent_index)),handles.data_file)   ;
                if handles.data_file(9).cdata==8
                    temp_Filtered(1)=255 ;
                    temp_Filtered=uint8(temp_Filtered);
                elseif handles.data_file(9).cdata==16
                    if max(max(temp_Filtered))<256
                        temp_Filtered(1)=  255;
                        temp_Filtered=uint8(temp_Filtered);
                    else
                        temp_Filtered(1)=  65535;
                        temp_Filtered=uint8(temp_Filtered);
                    end
                elseif handles.data_file(9).cdata==32
                    temp_Filtered=uint32(temp_Filtered);
                    return
                end
                if get(handles.Auto_threshold_on,'value')==1
                    thresh_level = graythresh(temp_Filtered);
                    thresh_level =thresh_level * 0.5 ; %
                    set(handles.thresh_level,'value', thresh_level );
                    set(handles.T_edit_1 ,'string', num2str(thresh_level ));
                    a6=thresh_level ;
                    a13=thresh_level ;
                    if isnan(a6)~=1
                        handles.data_file(8).cdata(track_what).Frame(curent_index).DATA(1).vector(16)=a6  ;
                    end
                    if isnan(a13)~=1
                        handles.data_file(8).cdata(track_what).Frame(curent_index).DATA(2).vector(6)=a13  ;
                    end
                end
                temp_matrix=segment_frame(temp_Filtered,handles,imfo); % the temp image as defined by filer_Frame function
                temp_matrix=flipdim(temp_matrix,1);
                [full_filename_Segmentation,filename_Segmentation]=set_new_filename( char(box_Raw(curent_index)),  Projected_by_Str,Projected_by_Value,track_what,3, pathname_Segmentation )  ;
                box_threshold(end+1)=cellstr(filename_Segmentation) ;
                imwrite(temp_matrix, full_filename_Segmentation);  %save file to hard drive
                curent_index=curent_index+1  ;
                pause(0.1)
            end
            for ii=start_segmentation_at:end_segmentation_at
                waitbar(ii/end_segmentation_at)
                centy1=[];
                filename=box_Raw(ii)  ;
                full_filename_Segmentation= char(strcat(handles.data_file(2).cdata(track_what,3),filename,'_ch0',num2str(track_what-1),'_Segmented.tif')) ;
                temp_Segmentation=imread(full_filename_Segmentation,1);
                temp_Segmentation=flipdim(temp_Segmentation,1);
                L=bwlabel(temp_Segmentation,4);
                stats=regionprops(L,'Centroid') ;
                for jj=1:length(stats)
                    temp_centy=[stats(jj).Centroid ii] ;
                    temp_centy=  (round(temp_centy.*100))./100;
                    centy1(jj,:)=  temp_centy;
                end
                handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata  =centy1  ;
                temp_Segmentation2=zeros(size(temp_Segmentation));
                position= handles.data_file(6).cdata ;
                temp_Segmentation2(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1))  =  temp_Segmentation(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1));
                L=bwlabel(temp_Segmentation2,4);
                handles.data_file(4).cdata.L(track_what).cdata(ii).cdata= regionprops(L,'Area','BoundingBox','Centroid','PixelList','Orientation','Eccentricity','Perimeter','Extent','Solidity','Majoraxislength','Minoraxislength','EquivDiameter');
                for iii=1:size(handles.data_file(4).cdata.L(track_what).cdata(ii).cdata,1)
                    handles.data_file(4).cdata.L(track_what).cdata(ii).cdata(iii).Centroid= round(handles.data_file(4).cdata.L(track_what).cdata(ii).cdata(iii).Centroid*100)/100 ;
                end
            end
            guidata(hObject,handles);
            try %relabel
                centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
                try
                    hungarianlinker_TACWrapper(centy1(n).cdata(:,1:2),centy1(n-1).cdata(:,1:2),100)
                    centy1(n).cdata(:,4)=hungarianlinker_TACWrapper(centy1(n ).cdata(:,1:2),centy1(n-1).cdata(:,1:2),100);  %100 is dafult velocity
                catch
                    centy1(n).cdata(:,4)=-1;
                end
                handles.data_file(4).cdata.Centroids(track_what).cdata= centy1 ;
                guidata(hObject,handles);
            end
            h_TAC_Cell_Tracking_Module=handles;
            
            Raw_listbox_Callback(hObject, eventdata, handles)
            close(h)
        end
        set(handles.select_mode_segmentation,'value',1)
        set(handles.start_segmentation_at,'Visible','off')
        set(handles.end_segmentation_at,'Visible','off')
end



% -----------------------------------
function [full_filename,filename]=set_new_filename(  filename,Projected_by_Str,Projected_by_Value,track_what,segmentation_type, pathname )

Projected_by=char(Projected_by_Str(Projected_by_Value));
Projected_by=regexprep(Projected_by, 'z', '') ;
Projected_by=str2double(Projected_by) ;
if segmentation_type==2
    if isempty(Projected_by)~=1&& isnan(Projected_by)~=1
        filename = char(strcat(filename,'_z0',num2str(Projected_by),'_ch0',num2str(track_what-1),'_Filtered.tif'))  ;
        mkdir(char(strcat(pathname ,  'z\'))) ;
        full_filename =  char(strcat(pathname ,  'z\',filename));
    end
    Projected_by=char(Projected_by_Str(Projected_by_Value));
    if findstr('Imean',Projected_by)
        filename=regexprep(filename, '.tif', '') ;
        filename= char(strcat(filename,'_ch0',num2str(track_what-1),'_Filtered.tif')) ;
        full_filename = char(strcat(pathname  ,filename));
    end
end
if segmentation_type==3
    if isempty(Projected_by)~=1&& isnan(Projected_by)~=1
        str_takeoff= char(strcat('_z0',num2str(Projected_by),'_ch0',num2str(track_what-1),'_Filtered.tif'))   ;
        filename =regexprep(filename ,str_takeoff, '')  ;
        filename =char(strcat( filename ,'_z0',num2str(Projected_by),'_ch0',num2str(track_what-1),'_Segmented.tif'));
        mkdir(char(strcat(pathname ,  'z\')))
        full_filename  =  char(strcat(pathname ,  'z\',  filename ));
    end
    
    Projected_by=char(Projected_by_Str(Projected_by_Value));
    if findstr('Imean',Projected_by)
        str_takeoff= char(strcat('_ch0',num2str(track_what-1),'_Filtered.tif'))  ;
        filename =regexprep(filename ,str_takeoff, '') ;
        filename =char(strcat( filename ,'_ch0',num2str(track_what-1),'_Segmented.tif')) ;
        full_filename  =  char(strcat(pathname ,  filename ));
    end
    
end
%   -------------------
function[matrix]=segment_frame(matrix,handles,imfo)   %seperated filters for Frame and DIC, option for future changes
thresh_level=(get(handles.T_edit_1,'String'))  ;
thresh_level=str2double(thresh_level) ;
if imfo==8
    matrix(1)=255 ;
    matrix=uint8(matrix);
elseif imfo==16
    if max(max(matrix))<256
        matrix(1)=  255;
        matrix=uint8(matrix);
    end
elseif imfo==32
    'think about a new solution here!!!!'
    matrix=uint32(matrix);
    return
end
matrix=im2bw(matrix,thresh_level);
matrix=Thresold_function(matrix,2,handles);
matrix=Thresold_function(matrix,3,handles);
matrix=Thresold_function(matrix,4,handles);
matrix=Thresold_function(matrix,5,handles);
matrix=Thresold_function(matrix,6,handles);
% -------------------------------------------------------------------------
function [matrix]=Thresold_function(matrix,ii,handles)
%     matrix=-matrix;
X=  eval( strcat ('get(handles.T_popup_',num2str(ii), ',','''Value''', ')'))  ;
switch X
    case 2
        bwmorph_selected=get(handles.bwmorph_type,'Value')
        switch bwmorph_selected
            case 1
                matrix  = bwmorph(matrix,'bothat');
            case 2
                matrix  = bwmorph(matrix,'bridge')
            case 3
                matrix  = bwmorph(matrix,'close');
            case 4
                matrix  = bwmorph(matrix,'diag')
            case 5
                matrix  = bwmorph(matrix,'dilate');
            case 6
                matrix  = bwmorph(matrix,'erode');
            case 7
                matrix  = bwmorph(matrix, 'fill');
            case 8
                matrix  = bwmorph(matrix, 'hbreak');
            case 9
                matrix  = bwmorph(matrix, 'majority');
            case 10
                matrix  = bwmorph(matrix,'open' );
            case 11
                matrix  = bwmorph(matrix,'remove');
            case 12
                matrix  = bwmorph(matrix, 'shrink');
            case 13
                matrix  = bwmorph(matrix,'skel');
            case 14
                matrix  = bwmorph(matrix,'spur');
            case 15
                matrix  = bwmorph(matrix,'thicken');
            case 16
                matrix  = bwmorph(matrix, 'thin' );
            case 17
                matrix  = bwmorph(matrix, 'tophat' );
        end
        
    case 3
        bwareaopen_value=eval(strcat ('get(handles.T_edit_',num2str(ii), ',','''String''', ')'));
        bwareaopen_value=str2double(bwareaopen_value)   ;
        matrix=bwareaopen(matrix,bwareaopen_value,4);
    case 4
        bwareaopen_value=eval(strcat ('get(handles.T_edit_',num2str(ii), ',','''String''', ')'));
        bwareaopen_value=str2double(bwareaopen_value)   ;
        L = bwlabel(matrix,4) ;
        stats = regionprops(L,'Area');
        idx = find([stats.Area] < bwareaopen_value);
        matrix = ismember(L,idx);
    case 5
        
        strel_value=eval(strcat ('get(handles.T_edit_',num2str(ii), ',','''String''', ')'));
        strel_value=str2double(strel_value)       ;
        strel_selected=get(handles.strel_type,'Value');
        strel_type=get(handles.strel_type,'String');
        strel_type=strel_type(strel_selected);
        strel_type=char(strel_type);
        SE = strel(strel_type,strel_value) ;
        matrix = imclose(matrix,SE) ;
        
        
    case 6
        imclearborder_value=eval(strcat ('get(handles.T_edit_',num2str(ii), ',','''String''', ')'));
        imclearborder_value=str2double(imclearborder_value)   ;
        matrix=imclearborder(matrix,imclearborder_value);
    case 7
        %         matrix=matrix;
        matrix=imfill(matrix,'holes');
    case 8
        bwareaopen_value=eval(strcat ('get(handles.T_edit_',num2str(ii), ',','''String''', ')'));
        circularity=[];
        bwareaopen_value=str2double(bwareaopen_value)  ;
        [B,L]=bwboundaries(matrix,4,'noholes');
        stats=regionprops(L,'all');
        for jj=1:length(stats)
            boundary = B{jj};
            % compute a simple estimate of the object'Current_Exp perimeter
            delta_sq = diff(boundary).^2;
            area(jj)=stats(jj).Area;
            perimeter = sum(sqrt(sum(delta_sq,2)));
            circumference(jj)=perimeter;
            circularity(jj)=4*pi*area(jj)/perimeter^2;
        end
        if isempty( circularity)~=1
            idx = find( circularity  >bwareaopen_value) ;
            if isempty(idx)==1
                matrix=zeros(size(matrix));
            else
                matrix = ismember(L,idx) ;
            end
        end
    case 9
        bwareaopen_value=eval(strcat ('get(handles.T_edit_',num2str(ii), ',','''String''', ')'));
        bwareaopen_value=str2double(bwareaopen_value)  ;
        [B,L]=bwboundaries(matrix,4,'noholes');
        stats=regionprops(L,'all');
        for jj=1:length(stats)
            boundary = B{jj};
            % compute a simple estimate of the object'Current_Exp perimeter
            delta_sq = diff(boundary).^2;
            area(jj)=stats(jj).Area;
            perimeter = sum(sqrt(sum(delta_sq,2)));
            circumference(jj)=perimeter;
            circularity(jj)=4*pi*area(jj)/perimeter^2;
        end
        idx = find( circularity  <bwareaopen_value);
        if isempty(idx)==1
            matrix=zeros(size(matrix));
        else
            matrix = ismember(L,idx) ;
        end
    case  10
        bwareaopen_value=eval(strcat ('get(handles.T_edit_',num2str(ii), ',','''String''', ')'));
        bwareaopen_value=str2double(bwareaopen_value)  ;
        matrix=make2round(matrix,bwareaopen_value)   ;
    case 11
        
        
        
        
        
end
matrix=abs(matrix);
% -------------------------------------------------------------------------
function [matrix]= make2round(matrix,bwareaopen_value)
timer=1;
STATUS=1;

while STATUS==1
    data(timer).cdata=matrix  ;
    clear L
    clear B
    clear area
    circularity=[]
    [B,L]=bwboundaries(matrix,4,'noholes');
    stats=regionprops(L,'all');
    
    for jj=1:length(stats)
        boundary = B{jj};
        % compute a simple estimate of the object'Current_Exp perimeter
        delta_sq = diff(boundary).^2;
        area(jj)=stats(jj).Area;
        perimeter = sum(sqrt(sum(delta_sq,2)));
        circumference(jj)=perimeter;
        circularity(jj)=4*pi*area(jj)/perimeter^2;
    end
    
    if isempty(circularity)==1
        return
    end
    idx = find( circularity  <bwareaopen_value) ;
    if isempty(idx)==1
        STATUS=0;
    else
        matrix = ismember(L,idx) ;
        timer=timer+1;
        if timer>5
            matrix=zeros(size(matrix));
            for ii=1:size(data,2)
                matrix=data(ii).cdata+matrix;
            end
            matrix=matrix./matrix;
            matrix(isnan(matrix))=0;
            matrix=imfill(matrix,'holes');
            return
        end
    end
    
    
    
    SE = strel('disk',2)  ;
    matrix = imclose(matrix,SE) ;
    matrix=imfill(matrix,'holes');
    matrix=wiener2(matrix,2);
    
end
matrix=zeros(size(matrix));
for ii=1:size(data,2)
    matrix=data(ii).cdata+matrix;
end
matrix=matrix./matrix;
matrix(isnan(matrix))=0;
matrix=imfill(matrix,'holes');

% ---------------------------------------------------------------------


% --- Executes on button press in Apply_Segmentation.
function Apply_Segmentation_Callback(hObject, eventdata, handles)
apply_segmentation_function(hObject, eventdata, handles,'Batch')
set(handles.figure1,'userdata',handles.data_file);update_labelmatrix(handles)



% --- Executes on button press in Auto_threshold_on.
function Auto_threshold_on_Callback(hObject, eventdata, handles)
if get(handles.select_mode_segmentation,'value')~=3
    apply_segmentation_function(hObject, eventdata, handles,'Batch')
end


% --- Executes on selection change in show_axes2.
function show_axes2_Callback(hObject, eventdata, handles)
get(hObject,'value')
if get(hObject,'value')==8
    set(handles.m_edit,'Visible','on')
else
    set(handles.m_edit,'Visible','off')
end
if get(hObject,'value')==9
    n=get(handles.Div_Cells,'value');
    Vs=select_parameter  ;
    
    
    track_what=get(handles.track_what2,'Value') ;
    start_frame=n*2-1;
    MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;
    [vector, jj]=create_vector(MATRIX,handles,start_frame)
    box_Raw=get(handles.Raw_listbox,'string');
    
    
    if strfind(Vs,'Intensity')
        try
            X=nan(1,size( box_Raw,1)) ;
            for ii=1:size(vector,1)
                if isnan(vector(ii,3))~=1
                    X(ii+jj-1)=handles.data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata(vector(ii,3)).Intensity;
                end
            end
        catch
            Data_out=Get_Cell_Intensity(handles,n,Vs) ;X=nan(1,size( box_Raw,1)) ;
            X(jj:jj+size(vector,1)-1)=Data_out;
        end
        Vs_X='Intensity';
    end
    
    
    if strfind(Vs,'Area')
        X=nan(1,size( box_Raw,1)) ;
        for ii=1:size(vector,1)
            if isnan(vector(ii,3))~=1
                X(ii+jj-1)=handles.data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata(vector(ii,3)).Area;
            end
        end
        Vs_X='Area';
    end
    
    if   strfind(Vs,'Velocity')
        X=vector(:,1) ;  Y=vector(:,2) ;
        X=(diff(X)).^2;  Y=(diff(Y)).^2;
        Data_out=(X+Y).^0.5;
        X=nan(1,size( box_Raw,1)) ;
        X(jj+1:jj+size(vector,1)-1)=Data_out';
        Vs_X='Velocity';
    end
    
    if strfind(Vs,'Eccentricity')
        X=nan(1,size( box_Raw,1)) ;
        for ii=1:size(vector,1)
            if isnan(vector(ii,3))~=1
                X(ii+jj-1)=handles.data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata(vector(ii,3)).Eccentricity;
            end
        end
        Vs_X='Eccentricity';
    end
    if strfind(Vs,'EquivDiameter')
        X=nan(1,size( box_Raw,1)) ;
        for ii=1:size(vector,1)
            if isnan(vector(ii,3))~=1
                X(ii+jj-1)=handles.data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata(vector(ii,3)).EquivDiameter;
            end
        end
        Vs_X='EquivDiameter';
    end
    if strfind(Vs,'Solidity')
        X=nan(1,size( box_Raw,1)) ;
        for ii=1:size(vector,1)
            if isnan(vector(ii,3))~=1
                X(ii+jj-1)=handles.data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata(vector(ii,3)).Solidity;
            end
        end
        Vs_X='Solidity';
    end
    if strfind(Vs,'Extent')
        X=nan(1,size( box_Raw,1)) ;
        for ii=1:size(vector,1)
            if isnan(vector(ii,3))~=1
                X(ii+jj-1)=handles.data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata(vector(ii,3)).Extent;
            end
        end
        Vs_X='Extent';
    end
    if strfind(Vs,'Perimeter')
        X=nan(1,size( box_Raw,1)) ;
        for ii=1:size(vector,1)
            if isnan(vector(ii,3))~=1
                X(ii+jj-1)=handles.data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata(vector(ii,3)).Perimeter;
            end
        end
        Vs_X='Perimeter';
    end
    
    
    if strfind(Vs,'Orientation')
        X=nan(1,size( box_Raw,1)) ;
        for ii=1:size(vector,1)
            if isnan(vector(ii,3))~=1
                X(ii+jj-1)=handles.data_file(4).cdata.L(track_what).cdata(ii+jj-1).cdata(vector(ii,3)).Orientation;
            end
        end
        Vs_X='Orientation';
    end
    
    
    data(1).cdata=X;
    data(2).cdata=Vs_X ;
    data(3).cdata=jj;
    set(handles.show_axes2,'userdata',data)
    set(handles.axes2,'Visible','on');
end



eventdata.VerticalScrollCount=0;
figure1_WindowScrollWheelFcn([], eventdata, handles)
axes(handles.axes2)
axis auto





%   ----------------------------
function figure1_WindowScrollWheelFcn(~, eventdata, handles)



if  toc<0.05
    return
end
tic
box_Raw=get(handles.Raw_listbox,'string') ;
n=round(get(handles.Raw_listbox,'Value')) ;
N=n+eventdata.VerticalScrollCount;
if N<1 ||  N>size(box_Raw,1)
    return
end



point  = get(gcf,'CurrentPoint')   ;
xy1  =get(handles.Raw_listbox, 'Position');   %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
if (xy1(1)<point(1,1) && xy1(2)<point(1,2) && point(1,1)<(xy1(1)+xy1(3)) && point(1,2)<(xy1(2)+xy1(4)))
    return
end
set(handles.Raw_listbox,'value',N);
if eventdata.VerticalScrollCount==1
    set(handles.forward_button,'Visible','on')
    set(handles.backward_button,'Visible','off')
elseif eventdata.VerticalScrollCount==-1
    set(handles.forward_button,'Visible','off')
    set(handles.backward_button,'Visible','on')
end


%  set(handles.sliderframes, 'Minimum',1, 'Maximum',size(box_Raw,1), 'Value',N);
set(handles.showcurrentframe,'String',num2str(N));
show_frame( handles,N)


Projected_by_Value=get(handles.Projected_by,'Value')  ;
Projected_by_Str=get(handles.Projected_by,'String') ;
Projected_by=char(Projected_by_Str(Projected_by_Value));
segmentation_type=get(handles.segmentation_type2,'Value')   ;
track_what2=get(handles.track_what2,'Value') ;
axes2_ch=get(handles.axes2_ch,'Value') ;




show_axes2=get(handles.show_axes2,'value');
if   show_axes2<6
    axes(handles.axes2);cla
    [temp,~,full_filename]= read_image2(handles,N ,segmentation_type,Projected_by, char(box_Raw(N)),handles.data_file,  axes2_ch,axes2_ch);
    imagesc(temp)
end
if  show_axes2==7
    axes(handles.axes1)
    rectangle('Position',[handles.Y1 handles.X1 handles.Y handles.X],'LineWidth',3,'LineStyle','-','EdgeColor','m');
    show_axes2=get(handles.show_axes2,'value');
    
    [temp,~,full_filename]= read_image2(handles,N ,segmentation_type,Projected_by, char(box_Raw(N)),handles.data_file, axes2_ch,axes2_ch);
    temp=temp(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1)   ;
    
    axes(handles.axes2) ;cla
    
    h_axes1_imagesc=imagesc(temp , 'Hittest','Off')   ;
    
    try
        [matrix,~,full_filename]= read_image2(handles,N ,3,Projected_by, char(box_Raw(N)),handles.data_file,track_what2,track_what2);
        matrix=matrix(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1);
        axes2(1).cdata=matrix;axes2(2).cdata=temp;
        set(handles.axes2,'userdata',axes2);
        bw=im2bw( matrix,0)   ;
        [B,L] = bwboundaries(bw ,4,'noholes')   ;
        hold on
        for k = 1:length(B)
            b  = B{k}   ;
            h_axesb_plot=scatter( b(:,2),b(:,1) ,'MarkerFaceColor' ,'m')   ;set(h_axesb_plot, 'Hittest','Off')  ;
        end
    end
    
    
end
if   show_axes2==8
    axes(handles.axes2);cla
    n=N; N=N-str2num(get(handles.m_edit,'string')) ;
    if N<1 ||  N>size(box_Raw,1)
        return
    end
    [temp,~,full_filename]= read_image2(handles,N ,segmentation_type,Projected_by, char(box_Raw(N)),handles.data_file,  axes2_ch,axes2_ch);
    imagesc(temp,'Hittest','Off');
    
    
    hold on
    track_what =get(handles.track_what2,'Value');
    
    
    xy_border=handles.data_file(6).cdata;
    
    if findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')
        if get(handles.Show_boundingbox,'value')==1
            centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata;
            if isempty(centy1)~=1
                for ii=1:size(handles.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
                    if  isempty(handles.data_file(4).cdata.L(track_what).cdata(n).cdata)~=1
                        XY= handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BoundingBox;
                        if XY(1)>xy_border(1) && XY(2)>xy_border(2) && (xy_border(1)+xy_border(3))>(XY(1)+XY(3)) && (xy_border(1)+xy_border(4))>(XY(2)+XY(4))
                            rectangle('Position', XY,'LineWidth',1  ,'EdgeColor','w', 'Hittest','Off');
                            if get(handles.Show_maximum_pixel,'value')==1
                                zz=handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii)
                                vec1= round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_2)  ;
                                plot(centy1(ii,1),centy1(ii,2),'m.',     'MarkerSize',20, 'Hittest','Off');
                                centroid=round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Centroid) ;
                                vec1= round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_2)  ;
                                for jjj=1:size(vec1,1)
                                    plot([centroid(jjj,1) vec1(jjj,1)],   [ centroid(jjj,2)  vec1(jjj,2)]    ,'linewidth',2,'color',[1 0 0],      'Hittest','Off');
                                end
                            end
                            if get(handles.Show_proximity_vector,'value')==1
                                vec  = round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Proximity_Ch_1)
                                if size(vec,2)>1
                                    for jjj=1:size(vec ,1)
                                        startpoint= [vec(jjj,2)  vec(jjj,1)];
                                        x1= [vec(jjj,4) vec(jjj,3)];
                                        v1 =  0.2*(startpoint-x1)  ;
                                        theta = 22.5*pi/180  ;
                                        x2 = x1 + v1* [cos(theta)  -sin(theta) ; sin(theta)  cos(theta)];
                                        x3 = x1 +  v1*[cos(theta)  sin(theta) ; -sin(theta)  cos(theta)] ;
                                        fill([x1(1) x2(1) x3(1)],[x1(2) x2(2) x3(2)],'y',  'Hittest','Off');     % this fills the arrowhead (black)
                                        plot([vec(jjj,4) vec(jjj,2)], [vec(jjj,3)  vec(jjj,1)]        ,'linewidth',2,'color','y', 'Hittest','Off');
                                    end
                                end
                            end
                        end
                    end
                end
                index_local = (centy1(:,3) == n+0.1);  % faster: use bwlabel indexing
                plot(centy1(index_local,1),centy1(index_local,2),'rx','LineWidth',2,  'MarkerSize',30  ,'Hittest','Off');
                index_local2 = (centy1(:,3) == n+0.2);  % faster: use bwlabel indexing
                plot(centy1(index_local2,1),centy1(index_local2,2),'r+',  'LineWidth',3,  'MarkerSize',40,'Hittest','Off');
            end
        end
        try
            if findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
                if get(handles.show_tracks,'value')==1
                    
                    track_length_before= round(get(handles.track_length_before,'value')) ;
                    if track_length_before==50
                        track_length_before=3000;
                    end
                    track_length_after= round(get(handles.track_length_after,'value')) ;
                    if track_length_after==50
                        track_length_after=3000;
                    end
                    MATRIX = handles.data_file(5).cdata.Tracks(track_what ).cdata;
                    div_cells_Vec =get(handles.Div_Cells,'string');
                    sizee=size(MATRIX,2)/2;
                    matrix=repmat([1 NaN;NaN 1],1,sizee );
                    X=matrix(1,:).*MATRIX(n,:);
                    Y=matrix(2,:).*MATRIX(n,:);
                    X(isnan(X))=[];
                    Y(isnan(Y))=[];
                    STR=handles.data_file(3).cdata{track_what,2};
                    x=find((X>0));     xx=x*2-1;       xxx=xx+1;
                    for ii=1:length(xx)
                        try
                            X2=MATRIX(n-track_length_before:n+track_length_after,xx(ii));  Y2=MATRIX(n-track_length_before:n+track_length_after,xxx(ii));
                        catch
                            try
                                X2=MATRIX(1:n+track_length_after,xx(ii));  Y2=MATRIX(1:n+track_length_after,xxx(ii));
                            catch
                                try
                                    X2=MATRIX(n-track_length_before:end,xx(ii));  Y2=MATRIX(n-track_length_before:end,xxx(ii));
                                catch
                                    try
                                        X2=MATRIX(:,xx(ii));  Y2=MATRIX(:,xxx(ii));
                                    end
                                end
                            end
                        end
                        X2=X2(X2>0); Y2=Y2(Y2>0);
                        plot(X2,Y2, '.-', 'color',handles.C(x(ii),:), 'Hittest','Off');
                    end
                    String = repmat({[STR '-']},sizee,1);
                    try
                        String = strcat(String,div_cells_Vec);
                    catch
                        String = strcat(String,arrayfun(@num2str,1:sizee,'un',0)');
                    end
                    text(X(X>0)-10, Y(X>0)+20, String(X>0), 'FontSize',10, 'Color','w', 'Hittest','Off');
                end
            end
        end
    end
    
    
    
    axis manual
end
if  show_axes2==9
    data=get(handles.show_axes2,'userdata')
    X=data(1).cdata ;Vs_X=data(2).cdata   ;  jj= data(3).cdata;
    axes(handles.axes2) ;cla
    h_axes2_plot =plot(X ,'w.', 'Hittest','Off')   ;
    ylabel(Vs_X,'color','y')  ;xlabel('time point','color','y')
    set(handles.axes2,'Xcolor','y'); set(handles.axes2,'Ycolor','y')
    try
        h_axes2_scatter=plot(N,X(N) ,'m+','MarkerSize',20, 'Hittest','Off')   ;
        %              scatter(N-jj,X(N-jj)  )
    end
else
    set(handles.axes1,'Xcolor','k'); set(handles.axes1,'Ycolor','k')
end




function min_var_for_consideration_CreateFcn(~, ~, ~)

function show_axes2_CreateFcn(~, ~, ~)




% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(~, ~, handles)
point  = get(gcf,'CurrentPoint')    ;
xy1 =get(handles.axes1, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
xy2 =get(handles.axes2, 'Position') ;
if xy1(1)<point(1,1) && xy1(2)<point(1,2) && point(1,1)<(xy1(1)+xy1(3)) && point(1,2)<(xy1(2)+xy1(4))
    set(gcf,'Pointer','hand')
elseif xy2(1)<point(1,1) && xy2(2)<point(1,2) && point(1,1)<(xy2(1)+xy2(3)) && point(1,2)<(xy2(2)+xy2(4))
    set(gcf,'Pointer','crosshair')
else
    set(gcf,'Pointer','arrow')
end


% --- Executes during object creation, after setting all properties.
function edit_axes1_CreateFcn(~, ~, ~)
function figure1_KeyPressFcn(~, ~, ~)



% --------------------------------------------------------------------
function Untitled_34_Callback(hObject, ~, handles)
% hObject    handle to Untitled_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=timebar_TACWrapper('Label brightest pixel. Please  wait....');set(h,'color','w');
track_what=get(handles.track_what1,'value')
[Channel,Projected_by]=select_channel;
box_Raw=get(handles.Raw_listbox,'string') ;
n=  get(handles.Raw_listbox,'value') ;
temp_matrix=zeros(512,512);
for ii=1:size(box_Raw,1)
    timebar_TACWrapper(h,ii/size(box_Raw,1))
    filename=char(box_Raw(ii)) ;
    [temp_Segmentation,~,full_filename_Segmentation]= read_image2(handles,ii,3,'Imean', filename,handles.data_file, track_what)   ;
    [temp,~,full_filename_Raw]= read_image2(handles,ii,1,Projected_by, filename,handles.data_file,Channel)   ;
    
    
    
    
    
    % % % % % % %         for kk=1:5 %if useing 5 sections
    % % % % % % %           Z=char(strcat('z',num2str(kk)));
    % % % % % % %           [temp_Raw(:,:,kk),centy1,full_filename]= read_image2(handles,ii,1,Z, filename, handles.data_file)   ;
    % % % % % % %         end
    for jj=1:size(handles.data_file(4).cdata.L(track_what).cdata(ii).cdata,1)
        if  isempty(handles.data_file(4).cdata.L(track_what).cdata(ii).cdata)~=1
            XY=  double(handles.data_file(4).cdata.L(track_what).cdata(ii).cdata(jj).BoundingBox);
            STAT=0;
            if (XY(1)+XY(3))>512
                XY(1)=floor(XY(1));
            end
            if (XY(2)+XY(4))>512
                XY(2)=floor(XY(2));
            end
            X1=round(XY(2))  ;
            Y1=round(XY(1))  ;
            X2=round(XY(2)+XY(4)) ;
            Y2=round(XY(1)+XY(3)) ;
            
            
            matrix= temp_matrix;
            matrix(X1:X2,Y1:Y2)=temp_Segmentation(X1:X2,Y1:Y2);
            matrix=smoothn_TACWrapper(double(matrix).*double(temp),3);
            [~, x]=find(ismember(matrix,max(max(matrix)))) ;
            
            eval(strcat('handles.data_file(4).cdata.L(',num2str(track_what),').cdata(',num2str(ii),').cdata(',num2str(jj),').BrightestP_Ch_',num2str(Channel),'=[x y] ;'))
            
        end
    end
end


guidata(hObject,handles);
close(h)
% --- Executes on selection change in vector1.
function vector1_Callback(~, ~, ~)
% hObject    handle to vector1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns vector1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from vector1


% --- Executes during object creation, after setting all properties.
function vector1_CreateFcn(hObject, ~, ~)
% hObject    handle to vector1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function zoom_in(~, index,point1)
if nargin==2
    eval(strcat('point1 =get(handles.axes',num2str(index),',''CurrentPoint'');'));
end
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
eval(strcat('curr_lim2=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))





range_data1 = abs(diff(curr_lim1)) ;
range_data2 = abs(diff(curr_lim2)) ;
range_data1 = round(range_data1+range_data1*0.4);
range_data2 = round(range_data2+range_data2*0.4) ;
Xlim=[point1(1)-range_data1/2  point1(1)+range_data1/2];
Ylim=[point1(4)-range_data2/2  point1(4)+range_data2/2];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Xlim);'))
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],Ylim);'))
%  --------------------------------------------------
function zoom_out(~, index,point1)
if nargin==2
    eval(strcat('point1 =get(handles.axes',num2str(index),',''CurrentPoint'');'));
end
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
eval(strcat('curr_lim2=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))




range_data1 = abs(diff(curr_lim1)) ;
range_data2 = abs(diff(curr_lim2))  ;
range_data1 = round(range_data1-range_data1*0.4) ;
range_data2 = round(range_data2-range_data2*0.4)  ;

Xlim=[point1(1)-range_data1/2  point1(1)+range_data1/2];
Ylim=[point1(4)-range_data2/2  point1(4)+range_data2/2];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Xlim);'))
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],Ylim);'))




% --- Executes on slider movement.
function sliderframes2_Callback(hObject, eventdata, ~)




try
    if isnumeric(hObject), return;  end  % only process handle.listener events
    handles = guidata(hObject);
    inCallback = getappdata(hObject,'inCallback');
    if isempty(inCallback)
        setappdata(hObject,'inCallback',1);
    else
        return;  % prevent re-entry...
    end
    
    %box_Raw=get(handles.Raw_listbox,'string');
    n=round(get(hObject,'value')) ;
    if (n~=1 && n<8)
        set(handles.Projected_by,'min',1,'max',10,'value',n)
        Raw_listbox_Callback(hObject, eventdata, handles)
    end
    
    % set(handles.sliderframes,'Max',size( box_Raw,1));
    % set(handles.Raw_listbox,'Min',1);
    % set(handles.Raw_listbox,'Value',n);
    % show_frame( handles,n);
catch
    % never mind
    a=1;  %debug point
end

setappdata(hObject,'inCallback',[]);
function sliderframes2_CreateFcn(hObject, ~, handles)
hListener = handle.listener(hObject,'ActionEvent',{@sliderframes2_Callback,handles});
setappdata(hObject,'listener__',hListener);
function Show_maximum_pixel_Callback(hObject, eventdata, handles)
Raw_listbox_Callback(hObject, eventdata, handles)
function Show_proximity_vector_Callback(hObject, eventdata, handles)
Raw_listbox_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, ~, handles)
propertyeditor('off')
track_what=get(handles.track_what1,'value');
set(hObject,'Value',0)
h=waitbar(0,'reading stack file to memory ....');
%     speaker_TACWrapper('reading stack file to memory ....');
set(h,'color','w');
segmentation_type=get(handles.segmentation_type1,'Value')  ;
start_export=str2double(get(handles.start_export,'string'));
end_export=str2double(get(handles.end_export,'string'));
n=end_export-start_export;
box_Raw=get(handles.Raw_listbox,'string');
for ii=1:size(box_Raw,1)
    waitbar(ii/size(box_Raw,1))
    if (ii>start_export-1) && (ii-1<end_export)
        temp = read_image(handles,ii,segmentation_type);
        eval(strcat('handles.Ch0',num2str(track_what-1),'_stack(',num2str(ii),').cdata=uint8(255*(double(temp)./max(max(double(temp)))));'))
        
        
        pause(0.05)
    else
        
        eval(strcat('handles.Ch0',num2str(track_what-1),'_stack(',num2str(ii),').cdata=[];'))
    end
end
guidata(hObject, handles);
close(h)


global h_TAC_Cell_Tracking_Module
h_TAC_Cell_Tracking_Module=handles;
speaker_TACWrapper(' stack was loaded ....');
% --------------------------------------------------------------------
function uitoggletool2_ClickedCallback(hObject, ~, handles)
axes(handles.axes1)
h = imrect(gca, [handles.Y1 handles.X1 handles.Y handles.X]);
setColor(h,[1 0 1]);
xy = wait(h)
xy=round(xy);
handles.Y1=xy(1)
handles.X1=xy(2)
handles.Y=xy(3)
handles.X=xy(4)
guidata(hObject,handles)
y=xy(1,1)
x=xy(1,2)
segmentation_type=get(handles.segmentation_type1,'Value') ;
box_Raw=get(handles.Raw_listbox,'string') ;
if iscell(box_Raw)==0
    Y=wavread('Error');
    h = errordlg('No files in Raw Frame listbox','Error');
    return
end
n=round(get(handles.Raw_listbox,'Value')) ;
show_frame( handles,n)  ;
show_axes2=get(handles.show_axes2,'value');
if   show_axes2<6
    Projected_by_Value=get(handles.Projected_by,'Value')  ;
    Projected_by_Str=get(handles.Projected_by,'String') ;
    Projected_by=char(Projected_by_Str(Projected_by_Value));
    [temp,~,full_filename]= read_image2(handles,n ,show_axes2,Projected_by, char(box_Raw(n)),handles.data_file)   ;
    if isempty(temp)==1
        'cant find the image'
        return;
    end
    axes(handles.axes2)
    cla
    imagesc(temp)
end
if    get(handles.show_axes2,'value')==7
    box_Raw=get(handles.Raw_listbox,'string')   ;
    filename_Raw=char(box_Raw(n))  ;
    track_what=get(handles.track_what2,'Value') ;
    [temp,centy1]=read_image(handles,n,segmentation_type);
    if isempty(temp)==1
        'cant find the image'
        return
    end
    pathname_Segmentation=handles.data_file(2).cdata(track_what,3) ;
    full_filename_Segmentation= char(strcat(handles.data_file(2).cdata(track_what,3),filename_Raw,'_ch0',num2str(track_what-1),'_Segmented.tif')) ;
    full_filename_Segmentation=char(full_filename_Segmentation );
    matrix=imread(full_filename_Segmentation,1);
    matrix=flipdim(matrix,1);
    temp=temp(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1);
    rectangle('Position',[handles.Y1 handles.X1 handles.Y handles.X],'LineWidth',3,'LineStyle','-','EdgeColor','m');
    matrix=matrix(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1);
    axes(handles.axes2)
    cla
    h_axes1_imagesc=imagesc(temp) ;
    set(h_axes1_imagesc, 'Hittest','Off')   ;
    axes2(1).cdata=matrix;axes2(2).cdata=temp;
    set(handles.axes2,'userdata',axes2);
    bw=im2bw( matrix,0)   ;
    [B,L] = bwboundaries(bw ,4,'noholes')   ;
    hold on
    for k = 1:length(B)
        b  = B{k}   ;
        h_axesb_plot=scatter( b(:,2),b(:,1) ,'MarkerFaceColor' ,'m')   ;set(h_axesb_plot, 'Hittest','Off')  ;
    end
    axis tight
    axis manual
end
function uitoggletool4_ClickedCallback(hObject, ~, handles)
n=get(handles.Raw_listbox,'value')
Close %close all open windows
show_frame(handles,n,[])

axis tight; axis manual;     axis off
set(gca,'Ydir','reverse' )
xlabel('X cordinates','FontSize',12,'Color',[0 0 0]);
ylabel('Y cordinates','FontSize',12,'Color',[0 0 0]);
set(gcf,'Color','w');
set(gcf,'Toolbar','none');
title('Select ROI with the mouse, control the box size with arrows-','Color','blue','fontsize',13 ,'fontname' ,'it ' ) ;
xy_border=handles.data_file(6).cdata;
h_rectangle=rectangle('Position', xy_border,'LineWidth',5,'LineStyle','--','EdgeColor','m');
set(h_rectangle, 'Hittest','Off')   ;
hold on
axis on;
axis tight
val=[1 1];
save val val %(important- do not delete)
magnify_TACWrapper(figure(gcf),'m');
h=figure(gcf);
uiwait(h);

load a2axistoset;
XX1=a2axistoset(3);
XX2=a2axistoset(4);
YY1=a2axistoset(1);
YY2=a2axistoset(2);
XX1=round(XX1);
XX2=round(XX2);
YY1=round(YY1);
YY2=round(YY2);
XX=XX2-XX1;
YY=YY2-YY1;



if XX1<1
    XX1=1;
end
if YY1<1
    YY1=1;
end

handles.Y1=YY1;
handles.X1=XX1;
handles.Y=YY;
handles.X=XX;
show_frame( handles,n)  ;
set(handles.show_axes2,'value',7)
guidata(hObject,handles)

track_what=get(handles.track_what2,'Value') ;
[matrix,~]=read_image(handles,n,3,track_what);
[temp,~]=read_image(handles,n,2,track_what);

%             figure(1); imagesc(matrix)
%             figure(2); imagesc(temp)

temp=temp(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1);
matrix=matrix(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1);
axes(handles.axes2)
cla
axes2(1).cdata=matrix;axes2(2).cdata=temp;
set(handles.axes2,'userdata',axes2);
h_axes1_imagesc=imagesc(temp) ;
set(h_axes1_imagesc, 'Hittest','Off')   ;
set(handles.axes2,'userdata',axes2);
bw=im2bw(matrix,0)   ;
[B,L] = bwboundaries(bw ,4,'noholes')   ;
hold on
for k = 1:length(B)
    b  = B{k}   ;
    h_axesb_plot=scatter( b(:,2),b(:,1) ,'MarkerFaceColor' ,'m')   ;set(h_axesb_plot, 'Hittest','Off')  ;
end
axis tight
axis manual
% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
Open_Experiment_Callback(hObject, eventdata, handles)
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
Save_Experiment_Callback(hObject, eventdata, handles)
function uipushtool3_ClickedCallback(~, ~, ~)
disp('under development')

% --------------------------------------------------------------------
function uitoggletool6_ClickedCallback(~, ~, handles)
n=get(handles.Raw_listbox,'value')   ;
show_frame(handles,n,[])
% --------------------------------------------------------------------
function uitoggletool7_ClickedCallback(~, ~, handles)
% hObject    handle to uitoggletool7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
framePos = getpixelposition(handles.axes2)
framePos(2)= framePos(2)*1.09;
framePos(4)= framePos(4)/1.15;







box_Raw=get(handles.Raw_listbox,'string')   ;
n=get(handles.Raw_listbox,'value')   ;
filename=char(box_Raw(n))  ;
track_what=get(handles.track_what1,'Value') ;
axes2=get(handles.axes2,'userdata')
matrix=axes2(1).cdata ;  temp=axes2(2).cdata  ;
if isempty(matrix)~=1
    h=figure('color','w','units','pixels','position',  framePos,'numbertitle','off', 'name',char(filename),'colormap',handles.c)
    
    hold on
    imagesc(double(matrix).*double(temp)) ;
    set(gcf,'colormap',handles.c);
    set(gcf,'UserData',temp) ;
    xlabel('X','FontSize',12,'Color',[0 0 0]);
    ylabel('Y','FontSize',12,'Color',[0 0 0]);
    data(1).cdata=flipdim(temp,1);
    data(2).cdata=flipdim(matrix,1);
    set(gcf,'UserData',data) ;
    title(filename) ;
    filename=char(filename);
    set(gcf,'Name', filename);
    hold on
    axis tight
    axis manual
end

% --------------------------------------------------------------------
function uitoggletool12_ClickedCallback(hObject, eventdata, handles)
Untitled_25_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function uipushtool5_ClickedCallback(hObject, eventdata, handles)
Label_the_cells_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------





% --------------------------------------------------------------------
function uipushtool6_ClickedCallback(~, ~, ~)
% hObject    handle to uipushtool6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------


% --------------------------------------------------------------------
function Untitled_26_Callback(hObject, ~, handles)
uiwait(msg_box_1)
h = imrect;
position = wait(h)
handles.data_file(6).cdata=  [ceil(position(1)) ceil(position(2)) round(position(3))  round(position(4))]  ;
guidata(hObject,handles);
n=get(handles.Raw_listbox,'Value') ;
box_Raw=get(handles.Raw_listbox,'string') ;
filename=char(box_Raw(n)) ;
show_frame( handles,n);
% --------------------------------------------------------------------



% --------------------------------------------------------------------
function Untitled_39_Callback(~, ~, ~)
cell_lineage_window
global h_cell_lineage_window
cell_lineage_window('Untitled_1_Callback', h_cell_lineage_window.Untitled_1,[],h_cell_lineage_window)


function T_edit_1_Callback(hObject, eventdata, handles)
Apply_Threshold_Callback(hObject, eventdata, handles)
function track_length_before_Callback(hObject, eventdata, handles)
n=get( hObject,'value')
Raw_listbox_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function Untitled_41_Callback(~, ~, handles)


track_what=get(handles.track_what1,'value')
h=timebar_TACWrapper('Processing second segmentation. Please wait....');set(h,'color','w');
fff=1; z=1
box_Raw=get(handles.Raw_listbox,'string') ;

n=  get(handles.Raw_listbox,'value') ;
for ii=1:size(box_Raw,1)
    
    timebar_TACWrapper(h,ii/size(box_Raw,1))
    filename=box_Raw(ii) ;
    [temp_Segmentation,~,full_filename_Segmentation]= read_image2(handles,ii,3,'Imean', filename,handles.data_file)   ;
    [temp,~,full_filename_Raw]= read_image2(handles,ii,1,'Imean', filename,handles.data_file)   ;
    for kk=1:5 %if useing 5 sections
        Z=char(strcat('z',num2str(kk)));
        [temp_Raw(:,:,kk),~,full_filename]= read_image2(handles,ii,1,Z, filename, handles.data_file)   ;
    end
    for jj=1:size(handles.data_file(4).cdata.L(track_what).cdata(ii).cdata,1)
        if  isempty(handles.data_file(4).cdata.L(track_what).cdata(ii).cdata)~=1
            XY=  double(handles.data_file(4).cdata.L(track_what).cdata(ii).cdata(jj).BoundingBox);
            STAT=0;
            if (XY(1)+XY(3))>512
                XY(1)=floor(XY(1));
            end
            if (XY(2)+XY(4))>512
                XY(2)=floor(XY(2));
            end
            X1=round(XY(2)) ;
            Y1=round(XY(1));
            X2=round(XY(2)+XY(4));
            Y2=round(XY(1)+XY(3));
            
            
            matrix_intensity=double(temp(X1:X2,Y1:Y2));
            matrix_bw=double(temp_Segmentation(X1:X2,Y1:Y2));
            matrix_bw=matrix_bw./max(max(matrix_bw))  ;
            matrix_intensity=matrix_intensity.*matrix_bw;
            matrix_bw_size=sum(sum(matrix_bw));
            thresh_intensity=matrix_intensity(:) ;
            thresh_intensity=sort(thresh_intensity) ;
            thresh_intensity=unique(thresh_intensity) ;
            Orientation_varriable= handles.data_file(4).cdata.L(track_what).cdata(ii).cdata(jj).Orientation;
            if   Orientation_varriable<0
                Orientation_varriable=Orientation_varriable+180  ;
            end
            matrix_bw=   flipdim( imrotate( matrix_bw,-Orientation_varriable),1);
            matrix_intensity2=   flipdim( imrotate( matrix_intensity,-Orientation_varriable),1);
            Movie1(fff).cdata= matrix_bw;   Movie2(fff).cdata=matrix_intensity2;
            fff=fff+1;
            
            
        end
    end
end
Movie3=Movie1;Movie4=Movie2;
save  Movie3  Movie3;save  Movie4  Movie4



% --------------------------------------------------------------------
function Untitled_42_Callback(~, ~, ~)
cell_tracks_window
global h_cell_tracks_window
cell_tracks_window('Untitled_1_Callback', h_cell_tracks_window.Untitled_1,[],h_cell_tracks_window)




function axes1_DeleteFcn(~, ~, ~)
function mode_1_Callback(~, ~, handles)
maxes_mode(handles,1)
function mode_2_Callback(~, ~, handles)
maxes_mode(handles,2)
function mode_3_Callback(~, ~, handles)
maxes_mode(handles,3)
function mode_4_Callback(~, ~, handles)
maxes_mode(handles,4)
function mode_5_Callback(~, ~, handles)
maxes_mode(handles,5)

n=get(handles.Raw_listbox,'value')  +1 ;
track_what=get(handles.track_what2,'Value') ;
centy1 =handles.data_file(4).cdata.Centroids(track_what).cdata   ;

axes(handles.axes2)



for ii=1: size(centy1(n).cdata,1)
    eval(['global h_imline_' num2str(ii)])
    
    
    
    %    cell1=find(ismember(XY,(min(XY)))) ;
    
    
    %     XY= (( centy1(n).cdata(:,1)-cell2(1)).^2+ (centy1(n).cdata(:,2)-cell2(2)).^2).^2     ;
    %    cell2=find(ismember(XY,(min(XY)))) ;
    %
    %    temp_val=centy1(n).cdata(cell1,4);
    %    centy1(n).cdata(cell1,4)= centy1(n).cdata(cell2,4) ;
    %    centy1(n).cdata(cell2,4)= temp_val
    %
    index=centy1(n).cdata(ii,4)
    if index==-1
        
        vec=[  centy1(n).cdata(ii,1)   centy1(n).cdata(ii,2)     centy1(n).cdata(ii,1)   centy1(n).cdata(ii,2) ]
        
        %  ['h_imline_' num2str(ii) '=imline(gca,[' num2str(vec(1)) ' ' num2str(vec(2)) '],[' num2str(vec(3)) ' ' num2str(vec(4)) '])']
        eval( ['h_imline_' num2str(ii) '=imline(gca,[' num2str(vec(1)) ' ' num2str(vec(2)) ' ;' num2str(vec(3)) ' ' num2str(vec(4)) '])']     )
        eval( ['setColor(h_imline_' num2str(ii)   ',[1 0 1])'])
        
        eval( ['Line_Children=get(h_imline_' num2str(ii) ','  '''Children'')'])
        eval(['set(Line_Children(1),''LineWidth''' ',0.2,'  '''Color'',''m'',''Marker'',''*'')' ])
        eval(['set(Line_Children(2),''LineWidth''' ',5,'  '''Color'',''b'',''Marker'',''o'')' ])
        eval(['set(Line_Children(3),''LineWidth''' ',3,'  '''Color'',''m''' ')'])
        
        
    else
        vec=[  centy1(n).cdata(ii,1)   centy1(n).cdata(ii,2)  centy1(n-1).cdata(index,1)   centy1(n-1).cdata(index,2) ]
        
        %  ['h_imline_' num2str(ii) '=imline(gca,[' num2str(vec(1)) ' ' num2str(vec(2)) '],[' num2str(vec(3)) ' ' num2str(vec(4)) '])']
        eval( ['h_imline_' num2str(ii) '=imline(gca,[' num2str(vec(1)) ' ' num2str(vec(2)) ' ;' num2str(vec(3)) ' ' num2str(vec(4)) '])']     )
        eval( ['setColor(h_imline_' num2str(ii)   ',[1 0 1])'])
        
        eval( ['Line_Children=get(h_imline_' num2str(ii) ','  '''Children'')'])
        eval(['set(Line_Children(1),''LineWidth''' ',0.2,'  '''Color'',''m'',''Marker'',''*'')' ])
        eval(['set(Line_Children(2),''LineWidth''' ',7,'  '''Color'',''r'',''Marker'',''o'')' ])
        eval(['set(Line_Children(3),''LineWidth''' ',3,'  '''Color'',''m''' ')'])
        text(vec(1), vec(2),num2str(ii),'fontsize',12,'VerticalAlignment','middle','color','y')
        
    end
    
    
    
end



function mode_6_Callback(~, ~, handles)
maxes_mode(handles,6)

function mode_7_Callback(~, ~, handles)

maxes_mode(handles,7)

function maxes_mode(handles,n)


axis manual;

for ii=1:7
    if ii==n
        eval(strcat('set(handles.mode_',num2str(ii),' ,''foregroundcolor''',',''','y'')') )
    else
        eval(strcat('set(handles.mode_',num2str(ii),' ,''foregroundcolor''',',''','w'')') )
        
    end
end

if n == 1
    set(handles.Segmentation_panel,'Visible','on')
    set(handles.Raw_listbox,'Visible','off')
    set(handles.control_panel,'Visible','off')
else
    set(handles.Segmentation_panel,'Visible','off')
    set(handles.Raw_listbox,'Visible','on')
    set(handles.control_panel,'Visible','on')
end


function track_what2_Callback(hObject, ~, handles)
set(handles.virtual_stack_mode,'value',0)
cla(handles.axes2)
track_what =get(handles.track_what2,'Value');
if   findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
    MATRIX=handles.data_file(5).cdata.Tracks(track_what).cdata;
    ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
    size_x=size(MATRIX,2);
    size_y=size(MATRIX,1);
    tot_size_x=size_x+1;
    tot_size_y=size_y+2;
    if  tot_size_x>676
        lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
    elseif  tot_size_x>26   &&  tot_size_x<676
        lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
    elseif  tot_size_x<27
        lastcell= ABC( tot_size_x);
    end
    handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
    handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
    handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');  set(handles.track_what2,'userdata',handles.C)
    guidata(hObject,handles)
    
    
end



n=get(handles.Raw_listbox,'Value');
box_Raw=get(handles.Raw_listbox,'string');
size_boxlist = size(box_Raw,1);

set(handles.Div_frame_index,'value',1)
set(handles.Div_Cells,'value',1)
set(handles.parental_num,'value',1)
set(handles.Div_frame_index,'string','Division at frame')
set(handles.Div_Cells,'string','Cells list')
set(handles.parental_num,'string','Choose dividing cell:')
set(handles.Daughter1_edit,'string','')
set(handles.Daughter2_edit,'string','')

jjj=1;  div_cells=[];
if findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')==1
    for ii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
        if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata)~=1
            vec_centy = handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata(:,3) -ii;
            vec_centy= (round(vec_centy*10))/10;
            if find(ismember(vec_centy,0.1))>0
                div_cells(jjj)=ii;
                jjj=jjj+1;
            end
        end
    end
end


if isempty(div_cells)~=1
    set(handles.Div_frame_index,'String',div_cells)
end
if findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
    MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;
    if isempty(MATRIX)~=1
        ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
        size_x=size(MATRIX,2);
        size_y=size(MATRIX,1);
        tot_size_x=size_x+1;
        tot_size_y=size_y+2;
        if  tot_size_x>676
            lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
        elseif  tot_size_x>26   &&  tot_size_x<676
            lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
        elseif  tot_size_x<27
            lastcell= ABC( tot_size_x);
        end
        handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
        handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');  set(handles.track_what2,'userdata',handles.C)
        handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
        guidata(hObject,handles)
    end
    nn=1;div_cells=[];
    last_cell =get_last_cell_index(MATRIX);
    for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
        if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
            centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
            for jj=1:size(centy2,1)  % .
                if str2num(num2str(centy2(jj,3)- iiii))==0.1
                    for cell_index=2:2:(last_cell-2)
                        if  MATRIX(iiii,cell_index-1)==centy2(jj,1) && MATRIX(iiii,cell_index)==centy2(jj,2)
                            break
                        end
                    end
                    div_cells(nn)=cell_index/2;
                    nn=nn+1;
                end
            end
        end
    end
    
    
    
    
    
    try
        [all_cells,parental_cells]=TRYME(div_cells,MATRIX) ;
    catch
        if iscell(box_Raw)==0
            Y=wavread('Error');
            h = errordlg('No files in Raw Frame listbox','Error');
            return
        end
        
        
        show_frame( handles,n);
        show_axes2=get(handles.show_axes2,'value')
        return
    end
    if isempty( div_cells)~=1
        set(handles.parental_num,'value',1);%set(handles.Div_Cells,'min',0)
        if isempty(parental_cells)~=1
            set(handles.parental_num,'string',parental_cells)
        else
            set(handles.parental_num,'string','Choose dividing cell:')
            set(handles.Daughter1_edit,'string','')
            set(handles.Daughter2_edit,'string','')
        end
    end
    set(handles.Div_Cells,'value',1);%set(handles.Div_Cells,'min',0)
    if  isempty(all_cells)~=1
        set(handles.Div_Cells,'string',all_cells)
    else
        set(handles.Div_Cells,'string','')
    end
end

if iscell(box_Raw)==0
    Y=wavread('Error');
    h = errordlg('No files in Raw Frame listbox','Error');
    return
end

show_frame( handles,n);
show_axes2=get(handles.show_axes2,'value');
if show_axes2<6
    Projected_by_Value=get(handles.Projected_by,'Value')  ;
    Projected_by_Str=get(handles.Projected_by,'String') ;
    Projected_by=char(Projected_by_Str(Projected_by_Value));
    [temp,~,full_filename]= read_image2(handles,n,show_axes2,Projected_by, char(box_Raw(n)),handles.data_file)   ;
    if isempty(temp)==1;
        'cant find the image'
        return;
    end
    axes(handles.axes2); cla
    h_axes2_imagesc=imagesc(temp) ;
    set(h_axes2_imagesc, 'Hittest','Off')   ;
    axis tight
    axis manual
    
end
if    show_axes2==7
    axes(handles.axes1)
    rectangle('Position',[handles.Y1 handles.X1 handles.Y handles.X],'LineWidth',3,'LineStyle','-','EdgeColor','m');
    
    
    
    segmentation_type=get(handles.segmentation_type1,'Value')  ;
    Projected_by_Value=get(handles.Projected_by,'Value')  ;
    Projected_by_Str=get(handles.Projected_by,'String') ;
    Projected_by=char(Projected_by_Str(Projected_by_Value));
    [temp,~,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, char(box_Raw(n)),handles.data_file)   ;
    [   temp_Segmentation,~,full_filename]= read_image2(handles,n,3,Projected_by, char(box_Raw(n)),handles.data_file)   ;
    if isempty( temp_Segmentation)==1
        return
    end
    temp=temp(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1)   ;
    temp_Segmentation=temp_Segmentation(handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1) ;
    
    axes(handles.axes2); cla
    h_axes2_imagesc=imagesc(temp) ;
    set(h_axes2_imagesc, 'Hittest','Off')   ;
    bw=im2bw( temp_Segmentation,0)   ;
    [B,L] = bwboundaries(bw ,4,'noholes')   ;
    hold on
    for k = 1:length(B)
        b  = B{k}   ;
        h_axesb_plot=scatter( b(:,2),b(:,1) ,'MarkerFaceColor' ,'m')   ;set(h_axesb_plot, 'Hittest','Off')  ;
    end
    axis tight
    axis manual
end
function track_what2_CreateFcn(~, ~, ~)
function track_length_after_Callback(hObject, eventdata, handles)
n=get( hObject,'value')
Raw_listbox_Callback(hObject, eventdata, handles)
function track_length_after_CreateFcn(~, ~, ~)

function track_length_before_CreateFcn(~, ~, ~)
function axes1_CreateFcn(~, ~, ~)
function uipushtool25_ClickedCallback(hObject, eventdata, handles)
Open_Experiment_Callback(hObject, eventdata, handles)
function uitoggletool20_ClickedCallback(~, ~, handles)
axes(handles.axes1); axis tight;axes(handles.axes2); axis tight
function Untitled_1_Callback(~, ~, ~)
function Untitled_4_Callback(~, ~, ~)
function Untitled_17_Callback(~, ~, ~)



% --------------------------------------------------------------------
function Untitled_38_Callback(~, ~, ~)

function Cells_list_option_Callback(~, ~, handles)
parental_num_Callback([], [], handles)


% --- Executes on selection change in segmentation_type2.
function segmentation_type2_Callback(~, eventdata, handles)
% hObject    handle to segmentation_type2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eventdata.VerticalScrollCount=0;
figure1_WindowScrollWheelFcn([], eventdata, handles)


% Hints: contents = cellstr(get(hObject,'String')) returns segmentation_type2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from segmentation_type2


% --- Executes during object creation, after setting all properties.
function segmentation_type2_CreateFcn(hObject, ~, ~)
% hObject    handle to segmentation_type2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in axes2_ch.
function axes2_ch_Callback(~, eventdata, handles)
eventdata.VerticalScrollCount=0;
figure1_WindowScrollWheelFcn([], eventdata, handles)



% --- Executes during object creation, after setting all properties.
function axes2_ch_CreateFcn(hObject, ~, ~)
% hObject    handle to axes2_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function figure1_WindowKeyPressFcn(~, ~, ~)


% --------------------------------------------------------------------
function Untitled_14_Callback(~, ~, ~)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_19_Callback(~, ~, ~)
% hObject    handle to Untitled_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_40_Callback(~, ~, ~)
% hObject    handle to Untitled_40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_44_Callback(hObject, ~, handles)
global h_TAC_Cell_Tracking_Module;

n=get(handles.Raw_listbox,'Value') ;
track_what=get(handles.track_what2,'Value') ;

centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;




if   findstr(char(handles.data_file(7).cdata(track_what,2)),'N')==1     %Must be labeled before running the tracking algorithm
    h = msgbox('Please allocate the Centroids and label the cells before running tracking algorithm.','Aborted');
    return
end
str=eval(strcat('handles.data_file(3).cdata(',num2str(track_what),',1)'))
str=str2double(str);
if str==0
    return
end






jj=0;
for ii=1:size(centy1,2)
    jj=jj+size(centy1(ii).cdata,1);
end
maxi=jj*2;
MATRIX2=zeros(size(centy1,2) ,maxi);
jjj=1;
for ii=1:size(centy1,2)
    for jj=1:size(centy1(ii).cdata,1)
        MATRIX2(ii,jjj:jjj+1)  =centy1(ii).cdata(jj,1:2) ;
        jjj=jjj+2;
    end
end
MATRIX=      MATRIX2 ;
handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
handles.data_file(7).cdata(track_what,1) =cellstr('Y'); %Now flag for track is Yes
guidata(hObject,handles);
%  track_what2_Callback(hObject, eventdata, handles)
Raw_listbox_Callback([], [], handles)

h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
try
    global h_cell_tracks_window
    cell_tracks_window('Untitled_1_Callback', h_cell_tracks_window.Untitled_1,[],h_cell_tracks_window)
end








% --------------------------------------------------------------------
function Untitled_45_Callback(hObject, ~, handles)
n=get(handles.Raw_listbox,'Value') ;
track_what=get(handles.track_what2,'Value') ;
centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;

if   findstr(char(handles.data_file(7).cdata(track_what,2)),'N')==1     %Must be labeled before running the tracking algorithm
    h = msgbox('Please allocate the Centroids and label the cells before running tracking algorithm.','Aborted');
    return
end
str=eval(strcat('handles.data_file(3).cdata(',num2str(track_what),',1)'))
str=str2double(str);
if str==0
    return
end

prompt = {'max_velocity (pixels/frame): ','Enter frame to start:','Enter frae to end:'};
dlg_title = 'Input';
num_lines = 1;
def = {'100 ',num2str(n),num2str(size(centy1,2) )};
answer = inputdlg(prompt,dlg_title,num_lines,def);
max_velocity =str2double(char(answer(1)));
start_track =str2num(char(answer(2)));
end_track =str2num(char(answer(3))) ;
h=waitbar(0,'Hungarian algorithm in action')
for ii=start_track:end_track -1
    waitbar(ii/(end_track+1-start_track))
    if  isempty(centy1(ii).cdata)~=1 &&  isempty(centy1(ii+1).cdata)~=1
        centy1(ii+1).cdata(:,4)=hungarianlinker_TACWrapper(centy1(ii+1).cdata(:,1:2),centy1(ii).cdata(:,1:2),max_velocity);
    end
    if  isempty(centy1(ii).cdata)==1 ||  isempty(centy1(ii+1).cdata)==1
        centy1(ii+1).cdata(:,1:2)=0;  centy1(ii+1).cdata(:,4)=-1;
    end
    if  isempty(centy1(ii).cdata)~=1 &&  isempty(centy1(ii+1).cdata)==1
        'do nothing'
    end
    if  isempty(centy1(ii).cdata)==1 &&  isempty(centy1(ii+1).cdata)==1
        'do nothing'
    end
end

handles.data_file(4).cdata.Centroids(track_what).cdata= centy1 ;
guidata(hObject,handles) ;global h_TAC_Cell_Tracking_Module;  h_TAC_Cell_Tracking_Module=handles;
close(h)
set(handles.figure1,'userdata',handles.data_file);update_labelmatrix(handles)
% --------------------------------------------------------------------
function Untitled_25_Callback(hObject, eventdata, handles)
track_what=get(handles.track_what2,'Value') ;
if   findstr(char(handles.data_file(7).cdata(track_what,2)),'N')==1     %Must be labeled before running the tracking algorithm
    h = msgbox('Please allocate the Centroids and label the cells before running tracking algorithm.','Aborted');
    return
end
str=eval(strcat('handles.data_file(3).cdata(',num2str(track_what),',1)'))
str=str2double(str);
if str==0
    return
end
track_what=get(handles.track_what2,'Value') ;
centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
start_track=get(handles.Raw_listbox,'value');
end_track=size(centy1,2) ;
[mindisp,start_track,end_track,MODE]=set_track_params(start_track,end_track);
original_MATRIX = handles.data_file(5).cdata.Tracks(track_what ).cdata ;
MATRIX= Find_Tracks(centy1,start_track, end_track,original_MATRIX,mindisp,MODE) ;
M=MATRIX./MATRIX;[a,start_XY]=nanmin(M);Index= isnan(a); MATRIX(:,Index)=[];
handles.data_file(5).cdata.Tracks(track_what ).cdata= MATRIX;

handles.data_file(7).cdata(track_what,1) =cellstr('Y'); %Now flag for track is Yes
guidata(hObject,handles)


track_what2_Callback(hObject, eventdata, handles)



h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
try
    global h_cell_tracks_window
    cell_tracks_window('Untitled_1_Callback', h_cell_tracks_window.Untitled_1,[],h_cell_tracks_window)
end
%
choice = questdlg('Do you want to runthe splitter?', ...
    'Hello User', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        Untitled_46_Callback(hObject, eventdata, handles)
        
        
end



% --------------------------------------------------------------------
function Untitled_46_Callback(hObject, eventdata, handles)
global h_TAC_Cell_Tracking_Module;
track_what=get(handles.track_what2,'Value') ;
MATRIX=handles.data_file(5).cdata.Tracks(track_what ).cdata  ;
M=MATRIX./MATRIX; [a,start_XY]=nanmin(M');  M=nansum(a);  %#ok<UDIM>
n=1;
for  last_cell=2:2: size(MATRIX,2)
    X=MATRIX(:,last_cell) ;
    X=X(X~=0);
    if isempty(X)==1
        break
    end
end
h=waitbar(0,'splitting tracks of dividing cells')
for ii=1:M
    waitbar(ii/M)
    if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata)~=1
        centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata;   %2. Getting all the centroids for the frame after the division
        for jj=1:size(centy1,1)  %3. Loop for breaking the tracks as marked by the user
            temp_centy1=centy1(jj,3)-ii;
            
            if   (round(temp_centy1*10))/10 ==0.1
                try
                    for cell_index=2:2:(last_cell-2)
                        if  MATRIX(ii,cell_index-1)==centy1(jj,1) && MATRIX(ii,cell_index)==centy1(jj,2)
                            break
                        end
                    end
                    cell_index=cell_index/2;
                    MATRIX=break_track(MATRIX,ii,cell_index,n,last_cell) ;
                    n=n+1; %n rows wefe alreadey added to MATRIX2
                end
            end
        end
    end
end
close(h)


M=MATRIX./MATRIX;[a,start_XY]=nanmin(M);Index= isnan(a); MATRIX(:,Index)=[];

%   4. Set the MATRIX back to table

if isempty(MATRIX)~=1
    ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
    size_x=size(MATRIX,2);
    size_y=size(MATRIX,1);
    tot_size_x=size_x+1;
    tot_size_y=size_y+2;
    if  tot_size_x>676
        lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
    elseif  tot_size_x>26   &&  tot_size_x<676
        lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
    elseif  tot_size_x<27
        lastcell= ABC( tot_size_x) ;
    end
    handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
    handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
    try
        handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k')    ;
    catch
        'you cant readily distinguish that many colors'
        handles.C=rand(size(handles.data_file(5).cdata.Tracks(track_what).cdata ,2),3) ;
    end
    guidata(hObject,handles)
end
handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
handles.data_file(7).cdata(track_what,1) =cellstr('Y'); %Now flag for track is Yes
guidata(hObject,handles);
nn=1;div_cells=[];
last_cell =get_last_cell_index(MATRIX );
for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
    if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
        centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
        for jj=1:size(centy2,1)  % .
            if str2num(num2str(centy2(jj,3)- iiii))==0.1
                for cell_index=2:2:(last_cell-2)
                    if  MATRIX(iiii,cell_index-1)==centy2(jj,1) && MATRIX(iiii,cell_index)==centy2(jj,2)
                        break
                    end
                end
                div_cells(nn)=cell_index/2 ;
                nn=nn+1;
            end
        end
    end
end
[all_cells,parental_cells]=TRYME(div_cells,MATRIX) ;
set(handles.Div_Cells,'value',1);%set(handles.Div_Cells,'min',0)
if isempty(all_cells)~=1
    set(handles.Div_Cells,'string',all_cells)
else
    set(handles.Div_Cells,'string','')
end
%       set(handles.parental_num,'value',1);%set(handles.Div_Cells,'min',0)
%           if isempty(parental_cells)~=1
%             set(handles.parental_num,'string',parental_cells)
%                track_what2_Callback(hObject, eventdata, handles)
%           else
%               set(handles.parental_num,'string','Choose dividing cell:')
%               set(handles.Daughter1_edit,'string','')
%               set(handles.Daughter2_edit,'string','')
%               track_what2_Callback(hObject, eventdata, handles)
%           end
set(handles.parental_num,'value',1);%set(handles.Div_Cells,'min',0)
if isempty(parental_cells)~=1
    set(handles.parental_num,'string',parental_cells)
    %                parental_num_Callback(hObject, eventdata, handles)
else
    set(handles.parental_num,'string','Choose dividing cell:')
    set(handles.Daughter1_edit,'string','')
    set(handles.Daughter2_edit,'string','')
end
% set(handles.Raw_listbox,'Value',nnn) ;
%  Raw_listbox_Callback(hObject, eventdata, handles)
track_what2_Callback(hObject, eventdata, handles)
% set(handles.Raw_listbox,'Value',nnn) ;

h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
try
    global h_cell_tracks_window
    cell_tracks_window('Untitled_1_Callback', h_cell_tracks_window.Untitled_1,[],h_cell_tracks_window)
end
function m_edit_CreateFcn(~, ~, ~)
% --------------------------------------------------------------------
function Untitled_47_Callback(hObject, ~, handles)
point1 =get(handles.axes1,'Position');
point1=point1./2;
axes(handles.axes1);
h_rectangle = impoly(gca);
setColor(h_rectangle,[0 0.2 0.2]);
ROI= wait(h_rectangle) ;
prompt = {'Please input frame to start:','Please input frame to end:'};
dlg_title = 'Merging..';
num_lines = 1;
def = {'',''};
answer  = inputdlg(prompt,dlg_title,num_lines,def);
answer=str2double(answer);
m    = answer(1);
n    = answer(2);
h=timebar_TACWrapper('Remove centroids. Please wait....');
set(h,'color','w');
track_what=get(handles.track_what2,'value')
centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata;
for ii=m:n %2 Procced only if the complimantory Segmentation file was found
    timebar_TACWrapper(h,ii/n)
    try
        temp_centy=centy1(ii).cdata;
        in=inpolygon( temp_centy(:,1), temp_centy(:,2),ROI(:,1),ROI(:,2));
        centy1(ii).cdata= temp_centy(ismember(in,0),:);
    end
end
handles.data_file(4).cdata.Centroids(track_what).cdata=  centy1 ;
guidata(hObject,handles);
global h_TAC_Cell_Tracking_Module
h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file); close(h)
% --------------------------------------------------------------------
function Untitled_48_Callback(hObject, ~, handles)
point1 =get(handles.axes1,'Position');
point1=point1./2;
axes(handles.axes1);
h_rectangle = impoly(gca);
%  setColor(h_rectangle,[0 0.2 0.2]);
ROI= wait(h_rectangle) ;
prompt = {'Please input frame to start:','Please input frame to end:'};
dlg_title = 'Merging..';
num_lines = 1;


n=get(handles.Raw_listbox,'Value') ;
track_what=get(handles.track_what2,'Value') ;
centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
centy2 = handles.data_file(4).cdata.L(track_what).cdata ;

def = {num2str(n),num2str(size(centy1,2) )};



answer  = inputdlg(prompt,dlg_title,num_lines,def);
answer=str2double(answer);
m    = answer(1);
n    = answer(2);
h=timebar_TACWrapper('Remove objects outside region. Please wait....');
set(h,'color','w');
track_what=get(handles.track_what2,'value')

for ii=m:n %2 Procced only if the complimantory Segmentation file was found
    try
        temp_centy=centy1(ii).cdata;
        in=inpolygon( temp_centy(:,1), temp_centy(:,2),ROI(:,1),ROI(:,2));
        centy1(ii).cdata= temp_centy(ismember(in,1),:);
    end
end
handles.data_file(4).cdata.Centroids(track_what).cdata=  centy1 ;
clc
for ii=m:n %2 Procced only if the complimantory Segmentation file was found
    timebar_TACWrapper(h,ii/n)
    
    kk=1;   clear centy3 % imprtant: centry3=[] is not good here!
    for jj=1:size(centy2(ii).cdata,1);
        temp_centy= centy2(ii).cdata(jj).Centroid  ;
        in=inpolygon( temp_centy(:,1), temp_centy(:,2),ROI(:,1),ROI(:,2))  ;
        if in==1
            centy3(kk) =centy2(ii).cdata(jj)  ;  kk=kk+1;
        end
    end
    try
        centy2(ii).cdata=centy3';
    catch
        centy2(ii).cdata=[];
    end
    
end
close(h)

handles.data_file(4).cdata.L(track_what).cdata=  centy2  ;





guidata(hObject,handles);
global h_TAC_Cell_Tracking_Module
h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
% --------------------------------------------------------------------
function accept_label_changes_Callback(hObject, ~, handles)
h=waitbar(0,'PLEASE WAIT ....');
try
    global h_TAC_Cell_Tracking_Module;
    centy1=[]
    axes2=get(handles.axes2,'userdata')
    matrix=axes2(1).cdata ;  temp=axes2(2).cdata  ;
    
    box_Raw=get(handles.Raw_listbox,'string') ;
    if iscell(box_Raw)==0
        Y=wavread('Error');
        h = errordlg('No files in Raw Frame listbox','Error');
        return
    end
    n=get(handles.Raw_listbox,'value')   ;
    filename=char(box_Raw(n))  ;
    track_what=get(handles.track_what2,'Value') ;
    pathname_Segmentation=handles.data_file(2).cdata(track_what,3) ;
    full_filename_Segmentation= char(strcat(handles.data_file(2).cdata(track_what,3),filename,'_ch0',num2str(track_what-1),'_Segmented.tif')) ;
    
    full_filename_Segmentation=char(full_filename_Segmentation );
    temp_Segmentation=imread(full_filename_Segmentation,1);
    temp_Segmentation=flipdim(temp_Segmentation,1);
    temp_Segmentation( handles.X1:handles.X1+handles.X-1,handles.Y1:handles.Y1+handles.Y-1  )=  matrix   ;
    temp_Segmentation=flipdim(temp_Segmentation,1);
    imwrite(temp_Segmentation, full_filename_Segmentation);  %save file to hard drive
    temp_Segmentation=flipdim(temp_Segmentation,1);
    L=bwlabel(temp_Segmentation,4);
    stats=regionprops(L,'Centroid') ;
    for jj=1:length(stats)
        temp_centy=[stats(jj).Centroid n] ;
        temp_centy=  (round(temp_centy.*100))./100;
        centy1(jj,:)=  temp_centy;
    end
    handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata  =centy1   ;
    temp_Segmentation2=zeros(size(temp_Segmentation));
    position= handles.data_file(6).cdata ;
    temp_Segmentation2(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1))  =  temp_Segmentation(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1));
    L=bwlabel(temp_Segmentation2,4);
    handles.data_file(4).cdata.L(track_what).cdata(n).cdata= regionprops(L,'Area','BoundingBox','Centroid','PixelList','Orientation','Eccentricity','Perimeter','Extent','Solidity','Majoraxislength','Minoraxislength','EquivDiameter');
    for iii=1:size(handles.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
        handles.data_file(4).cdata.L(track_what).cdata(n).cdata(iii).Centroid= round( handles.data_file(4).cdata.L(track_what).cdata(n).cdata(iii).Centroid*100)/100 ;
    end
    guidata(hObject,handles);
    try %relabel n
        centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
        try
            hungarianlinker_TACWrapper(centy1(n).cdata(:,1:2),centy1(n-1).cdata(:,1:2),100)
            centy1(n).cdata(:,4)=hungarianlinker_TACWrapper(centy1(n ).cdata(:,1:2),centy1(n-1).cdata(:,1:2),100);  %100 is dafult velocity
        catch
            centy1(n).cdata(:,4)=-1;
        end
        handles.data_file(4).cdata.Centroids(track_what).cdata= centy1 ;
        guidata(hObject,handles);
    end
    try %relabel n+1
        centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
        try
            centy1(n+1).cdata(:,4)=hungarianlinker_TACWrapper(centy1(n+1 ).cdata(:,1:2),centy1(n).cdata(:,1:2),100);  %100 is dafult velocity
        catch
            centy1(n+1).cdata(:,4)=-1;
        end
        handles.data_file(4).cdata.Centroids(track_what).cdata= centy1 ;
        guidata(hObject,handles);
    end
end
close(h)
show_frame( handles,n);
set(handles.figure1,'userdata',handles.data_file);update_labelmatrix(handles)
% --------------------------------------------------------------------
function Untitled_50_Callback(hObject, eventdata, handles)
choice = questdlg('Are you sure you want to erase existing labeling?', ...
    'Hello User', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        answer = 1;
    case 'No'
        answer = 0;
end

if answer
    track_what=get(handles.track_what2,'Value') ;
    str=eval(strcat('handles.data_file(3).cdata(',num2str(track_what),',1)'))
    str=str2double(str);
    if str==0
        return
    end
    h=timebar_TACWrapper('Format labelling. Please wait....');
    set(h,'color','w');
    
    box_Raw=get(handles.Raw_listbox,'string') ;
    
    n=size(box_Raw,1);
    for ii=1:n %2 Procced only if the complimantory Segmentation file was found
        timebar_TACWrapper(h,ii/n)
        handles.data_file(4).cdata.L(track_what).cdata(ii).cdata=[];
        handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata=[];
    end
    
    handles.data_file(7).cdata(track_what,2) =cellstr('N');
    guidata(hObject,handles);
    close(h)
    set(handles.figure1,'userdata',handles.data_file);update_labelmatrix(handles)
end
Untitled_51_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Untitled_51_Callback(hObject, eventdata, handles)
choice = questdlg('Are you sure you want to erase existing trajectories MATRIX?', ...
    'Hello User', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        answer = 0;
    case 'No'
        answer = 1;
end

if answer
    return
end
h=timebar_TACWrapper('Format trajectories mstrix. Please wait....');

box_Raw=get(handles.Raw_listbox,'string');
track_what=get(handles.track_what2,'Value') ;
handles.data_file(5).cdata.Tracks(track_what ).cdata =[];

handles.data_file(7).cdata(track_what,1) =cellstr('N'); %Now flag for track is No
guidata(hObject,handles);
global h_TAC_Cell_Tracking_Module
h_TAC_Cell_Tracking_Module=handles;
close(h)
track_what2_Callback(hObject, eventdata, handles)
set(handles.figure1,'userdata',handles.data_file);update_labelmatrix(handles)
% --------------------------------------------------------------------
function uipushtool54_ClickedCallback(~, ~, handles)
maxes_mode(handles,2)
% --------------------------------------------------------------------
function uipushtool53_ClickedCallback(~, ~, handles)
maxes_mode(handles,6)
% --------------------------------------------------------------------
function uipushtool56_ClickedCallback(~, ~, ~)
Untitled_39_Callback
% --------------------------------------------------------------------
function uipushtool55_ClickedCallback(~, ~, ~)
% --------------------------------------------------------------------
function uipushtool52_ClickedCallback(hObject, eventdata, handles)
Untitled_46_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function Untitled_52_Callback(~, ~, handles)

n=get(handles.Raw_listbox,'value')   ;
track_what=get(handles.track_what2,'Value') ;
centy1 =handles.data_file(4).cdata.Centroids(track_what).cdata   ;
try
    n_m1=centy1(n-1).cdata; n_m1
end
n_0=centy1(n).cdata; n_0
try
    n_p1=centy1(n+1).cdata; n_p1
end


% --------------------------------------------------------------------
function Untitled_53_Callback(~, ~, ~)

% --------------------------------------------------------------------
function Untitled_55_Callback(~, ~, handles)
track_what=get(handles.track_what2,'Value') ;
centy1 =handles.data_file(4).cdata.Centroids(track_what).cdata
vec=ones(1,size(centy1,2));
for ii=1:size(centy1,2)
    try
        centy1(ii).cdata(:,4);
    catch
        vec(ii)= 0;
    end
end
figure
plot(vec, 'Marker','*',  'LineStyle','none', 'Color',[0 0 1]);
ylim([-1 2])
% --------------------------------------------------------------------
function Untitled_54_Callback(~, ~, handles)
track_what=get(handles.track_what2,'Value') ;
MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata   ;
figure
imagesc(MATRIX)
% --------------------------------------------------------------------
function uipushtool58_ClickedCallback(hObject, eventdata, handles)
h=timebar_TACWrapper('Update trajectories, Please wait....');
n=get(handles.Raw_listbox,'value')   ;
track_what=get(handles.track_what2,'Value') ;
centy1 =handles.data_file(4).cdata.Centroids(track_what).cdata   ;
clc
for ii=1: size(centy1(n+1).cdata,1)
    eval(['global h_imline_' num2str(ii)]);
    pos_1234= eval([' h_imline_' num2str(ii) '.getPosition']);%get position of each line
    pos_12=[pos_1234(1) pos_1234(3)];
    XY= (( centy1(n+1).cdata(:,1)-pos_12(1)).^2+ (centy1(n+1).cdata(:,2)-pos_12(2)).^2).^2    ;
    Cell1(ii) =find(ismember(XY,(min(XY)))) ;
    pos_34(1:2,ii)=  [pos_1234(2) pos_1234(4)];
end
for ii=1: size(centy1(n).cdata,1)
    %for each cell labeled with centy1 in n-1 (Centy its shortcut name), search for the closest star-ended line
    %location
    ii
    Centy=[centy1(n).cdata(ii,1) centy1(n).cdata(ii,2)]
    XY= ((Centy(1)- pos_34(1,:)).^2+ (Centy(2)-pos_34(2,:)).^2).^2
    Cell2(ii) =find(ismember(XY,(min(XY)))) ;
end
centy1(n+1).cdata(:,4)=-1
for ii=1: size(centy1(n).cdata,1)
    centy1(n+1).cdata(Cell2(ii),4)=Cell1(ii);
end

handles.data_file(4).cdata.Centroids(track_what).cdata  =   centy1;
guidata(hObject,handles);
global h_TAC_Cell_Tracking_Module
h_TAC_Cell_Tracking_Module=handles;
close(h)
Untitled_25_Callback(hObject, eventdata, handles)
eventdata.VerticalScrollCount=0;
figure1_WindowScrollWheelFcn([], eventdata, handles)

% --- Executes on key release with focus on figure1 or any of its controls.
function figure1_WindowKeyReleaseFcn(~, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)
%  eventdata.Character
% eventdata.Key
eventdata.Key

if strfind(eventdata.Key, 'downarrow')
    'downarrow'
    event.VerticalScrollCount=-1;
    figure1_WindowScrollWheelFcn([], event, handles)
    
    
end
if strfind(eventdata.Key ,'uparrow')
    'uparrow'
    event.VerticalScrollCount=+1;
    figure1_WindowScrollWheelFcn([], event, handles)
    
    
end

if strfind(eventdata.Key ,'s')
    's'
    Split_segment(handles)
    
end


function Split_segment(~)
disp('under development')
% --------------------------------------------------------------------
function Untitled_56_Callback(~, ~, ~)
centy_window
global h_centy_window
centy_window('Untitled_1_Callback', h_centy_window.Untitled_1,[],h_centy_window)
% --------------------------------------------------------------------
function Untitled_57_Callback(hObject, eventdata, handles)

n=get(handles.Raw_listbox,'Value') ;
track_what=get(handles.track_what2,'Value') ;
centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
dlg_title = 'Format';
prompt = {'Please input frame to start:','Please input frame to end:'};
def = {num2str(n),num2str(size(centy1,2) )};
answer  = inputdlg(prompt,dlg_title,1,def);
answer=str2double(answer);
m    = answer(1);
n    = answer(2);
h=timebar_TACWrapper('Remove centroids. Please wait....');
set(h,'color','w');
for ii=m:n %2 Procced only if the complimantory Segmentation file was found
    handles.data_file(4).cdata.L(track_what).cdata(ii).cdata=[];
    handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata=[];
    timebar_TACWrapper(h,ii/n)
end

guidata(hObject,handles);
global h_TAC_Cell_Tracking_Module
h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);  close(h)
Untitled_51_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function Untitled_58_Callback(hObject, eventdata, handles)
global h_TAC_Cell_Tracking_Module;
n=get(handles.Raw_listbox,'Value') ;
dlg_title = 'Format';
def = {num2str(n)};
prompt = {'Please input last frame in trajectories MATRIX:'};
dlg_title = 'Delete';
num_lines = 1;
def = {' ' };
answer = inputdlg(prompt,dlg_title,num_lines,def)
answer=str2double(answer);
h=timebar_TACWrapper(['Remove trajectories from frame' num2str(answer)  '. Please wait....']);
set(h,'color','w');
track_what=get(handles.track_what2,'Value') ;
MATRIX=  handles.data_file(5).cdata.Tracks(track_what ).cdata;
MATRIX(:, answer*2-1:end)=[];
ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
size_x=size(MATRIX,2);
size_y=size(MATRIX,1);
tot_size_x=size_x+1;
tot_size_y=size_y+2;
if  tot_size_x>676
    lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
elseif  tot_size_x>26   &&  tot_size_x<676
    lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
elseif  tot_size_x<27
    lastcell= ABC( tot_size_x) ;
end

handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
guidata(hObject,handles)
track_what2_Callback(hObject, eventdata, handles)
h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);
function pushbutton30_Callback(~, ~, ~)
% --------------------------------------------------------------------
function uipushtool59_ClickedCallback(~, ~, handles)
axes(handles.axes2)
axis auto
axes(handles.axes1)
axis auto
% --------------------------------------------------------------------
function Level_set_evaluation_Callback(~, ~, handles)
axes2=get(handles.axes2,'userdata')
matrix_bw=double(axes2(1).cdata) ;matrix_intensity=double(axes2(2).cdata)  ;
matrix_bw=matrix_bw./max(max(matrix_bw))  ;
matrix_intensity=matrix_intensity.*matrix_bw;
ROI= drlse_edge_TACWrapper(matrix_intensity,80,handles )     ;
axes2(1).cdata=255*ROI;
set(handles.axes2,'userdata',axes2);
function start_segmentation_at_Callback(~, ~, ~)
function end_segmentation_at_Callback(~, ~, ~)


% --------------------------------------------------------------------
function Untitled_59_Callback(~, ~, ~)
% hObject    handle to Untitled_59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_60_Callback(hObject, eventdata, handles)



nnn=get(handles.Raw_listbox,'Value') ;

track_what=get(handles.track_what1,'Value') ;
if   findstr(char(handles.data_file(7).cdata(track_what,2)),'N')==1     %Must be labeled before running the tracking algorithm
    h = msgbox('Please allocate the Centroids and label the cells before running tracking algorithm.','Aborted');
    return
end
str=eval(strcat('handles.data_file(3).cdata(',num2str(track_what),',1)'))
str=str2double(str);
if str==0
    return
end

[maxdisp,param.dim,param.good,param.mem]=Crocker_params ;clc

maxi=0;
centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
MATRIX = Find_Tracks_Crocker(maxdisp,param,centy1)    ;

box_Raw=get(handles.Raw_listbox,'string') ;
sizey=size(box_Raw,1);
if size(MATRIX,2)< sizey
    MATRIX(end+1:sizey,:)=0
end
% take 0 from MATRIX side:
n=size(MATRIX,2);
vector=1:n;
for jj=1:n
    vec=MATRIX(:,jj)./MATRIX(:,jj) ;
    if isnan(max(vec))==1
        h = msgbox('Wrong input settings to tracking algorithm','Aborted');
        return
    end
    
    vector(jj)=find(ismember(vec,1), 1 ) ;
end
[~,b]=sort(vector);
MATRIX2=zeros(size(MATRIX));
for jj=1:n
    MATRIX2(:,jj)=MATRIX(:,b(jj));
end
if maxi<size(MATRIX2,2)
    maxi=size(MATRIX2,2);
end

cla
if char(str)=='1'
    handles.c=handles.c1;
    1
elseif char(str)=='2'
    2
    handles.c=handles.c2;
elseif char(str)=='3'
    3
    handles.c=handles.c3;
elseif char(str)=='4'
    4
    handles.c=handles.c4 ;
elseif char(str)=='5'
    5
    handles.c=handles.c5 ;
end
if str2double(str)<1
    set(handles.track_what,'Value',1)
    return
end
guidata(hObject,handles)
n=1;
for  last_cell=2:2: size(MATRIX2,2)
    X=MATRIX2(:,last_cell) ;
    X=X(X~=0);
    if isempty(X)==1
        break
    end
end
h=waitbar(0,'please wait')
for ii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
    if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata)~=1
        waitbar(ii/size(handles.data_file(4).cdata.Centroids(track_what).cdata,2))
        centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata;   %2. Getting all the centroids for the frame after the division
        for jj=1:size(centy1,1)  %3. Loop for breaking the tracks as marked by the user
            temp_centy1=centy1(jj,3)-ii;
            if   (round(temp_centy1*10))/10 ==0.1
                for cell_index=2:2:(last_cell-2)
                    if  MATRIX2(ii,cell_index-1)==centy1(jj,1) && MATRIX2(ii,cell_index)==centy1(jj,2)
                        break
                    end
                end
                cell_index=cell_index/2;
                MATRIX2=break_track(MATRIX2,ii,cell_index,n,last_cell)     ;
                n=n+1; %n rows wefe alreadey added to MATRIX2
            end
        end
    end
end
close(h)




%   4. Set the MATRIX back to table

if isempty(MATRIX2)~=1
    ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
    size_x=size(MATRIX2,2);
    size_y=size(MATRIX2,1);
    tot_size_x=size_x+1;
    tot_size_y=size_y+2;
    if  tot_size_x>676
        lastcell=strcat(ABC(floor( tot_size_x/676)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
    elseif  tot_size_x>26   &&  tot_size_x<676
        lastcell=strcat(ABC(floor( tot_size_x/26)),ABC(round(26*( tot_size_x/26-floor( tot_size_x/26)))));
    elseif  tot_size_x<27
        lastcell= ABC( tot_size_x) ;
    end
    handles.Table_last_cell=strcat(lastcell,num2str(tot_size_y));
    handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX2;
    
    handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k')    ;
    guidata(hObject,handles)
end
handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX2;
handles.data_file(7).cdata(track_what,1) =cellstr('Y'); %Now flag for track is Yes
guidata(hObject,handles);
nn=1;div_cells=[];
last_cell =get_last_cell_index(MATRIX2 );
for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
    if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
        centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
        for jj=1:size(centy2,1)  % .
            if str2num(num2str(centy2(jj,3)- iiii))==0.1
                for cell_index=2:2:(last_cell-2)
                    if  MATRIX2(iiii,cell_index-1)==centy2(jj,1) && MATRIX2(iiii,cell_index)==centy2(jj,2)
                        break
                    end
                end
                div_cells(nn)=cell_index/2 ;
                nn=nn+1;
            end
        end
    end
end
[all_cells,parental_cells]=TRYME(div_cells,MATRIX2) ;
set(handles.Div_Cells,'value',1);%set(handles.Div_Cells,'min',0)
if isempty(all_cells)~=1
    set(handles.Div_Cells,'string',all_cells)
else
    set(handles.Div_Cells,'string','')
end
set(handles.parental_num,'value',1);%set(handles.Div_Cells,'min',0)
if isempty(parental_cells)~=1
    set(handles.parental_num,'string',parental_cells)
    parental_num_Callback(hObject, eventdata, handles)
else
    set(handles.parental_num,'string','Choose dividing cell:')
    set(handles.Daughter1_edit,'string','')
    set(handles.Daughter2_edit,'string','')
end
set(handles.Raw_listbox,'Value',nnn) ;
Raw_listbox_Callback(hObject, eventdata, handles)




% --------------------------------------------------------------------
function Untitled_61_Callback(~, ~, ~)
% hObject    handle to Untitled_61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function New_Experiment_Callback(~, ~, ~)
run('Experiment_Generator') ;





% --------------------------------------------------------------------
function Untitled_62_Callback(hObject, eventdata, handles)
axes2=get(handles.axes2,'userdata')
matrix_bw=double(axes2(1).cdata) ;matrix_intensity=double(axes2(2).cdata)  ;
matrix_bw=matrix_bw./max(max(matrix_bw))  ;
matrix_bw2= bwlabel_max(matrix_bw,1);
se = strel('disk',1);
erodedBW = imerode(matrix_bw2,se);
jj=1
while max(max(bwlabel(erodedBW)))==1 && jj<10
    erodedBW = imerode(erodedBW,se);
    jj=jj+1;
end
if jj==10 || max(max(erodedBW ))==0
    return
end

mask_em = bwlabel_max(erodedBW,2);  % select 2 largest segments
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(matrix_bw2), hy, 'replicate');
Ix = imfilter(double(matrix_bw2), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);

gradmag2 = imimposemin(gradmag,   mask_em);
L = watershed(gradmag2);
matrix_bw(L==0 & matrix_bw2==1)=0;
axes2(1).cdata=255*matrix_bw ;
set(handles.axes2,'userdata',axes2);
accept_label_changes_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function Untitled_63_Callback(~, ~, ~)
% hObject    handle to Untitled_63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_70_Callback(~, ~, ~)
% hObject    handle to Untitled_70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function run_Change_LUT_Callback(hObject, eventdata, handles)
handles.c=change_LUT ;
guidata(hObject,handles);
set(gcf,'colormap',handles.c);

% --------------------------------------------------------------------
function Untitled_72_Callback(~, ~, ~)
% hObject    handle to Untitled_72 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_75_Callback(hObject, eventdata, handles)
axes(handles.axes1)
start_row = 1478;
end_row = 2246;
answer = inputdlg('Please input pixel size (in um)');
answer=str2double(char(answer));
um_per_pixel = answer;
rows = [start_row um_per_pixel end_row];
start_col = 349;
end_col = 1117;
cols = [start_col um_per_pixel end_col];
hline = imdistline(gca,[50 00],[100 150]);
api = iptgetapi(hline);
api.setLabelTextFormatter('%02.0f um');
api = iptgetapi(hline);
wait(hline)  ;
api.delete()

function Segmentation_module_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
    run('TAC_Segmentation_Module',handles.data_file) ;
else
    run('TAC_Segmentation_Module') ;
end
% --------------------------------------------------------------------
function Tracking_module_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
    run('TAC_Cell_Tracking_Module',handles.data_file) ;
else
    run('TAC_Cell_Tracking_Module') ;
end

% --------------------------------------------------------------------
function Measurments_module_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
    run('TAC_Measurments_Module',handles.data_file) ;
else
    run('TAC_Measurments_Module') ;
end
% --------------------------------------------------------------------
function Robut_Module_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
    run('TAC_Robust_Module',handles.data_file) ;
else
    run('TAC_Robust_Module') ;
end

% --------------------------------------------------------------------
function Analysis_module_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
    run('TAC_Analysis_Module',handles.data_file) ;
else
    run('TAC_Analysis_Module') ;
end


% --------------------------------------------------------------------
function Polarization_module_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
    run('TAC_Polarization_Module',handles.data_file) ;
else
    run('TAC_Polarization_Module') ;
end



% --------------------------------------------------------------------
function Untitled_73_Callback(hObject, eventdata, handles)
if   handles.flag.axis2==-1
    axes(handles.axes2)
    colorbar
    set(handles.axes2,'Xcolor','y'); set(handles.axes2,'Ycolor','y')
else
    axes(handles.axes2)
    colorbar('off')
    set(handles.axes2,'Xcolor','k'); set(handles.axes2,'Ycolor','k')
end
handles.flag.axis2=handles.flag.axis2*(-1);
guidata(hObject, handles);



% --------------------------------------------------------------------
function Untitled_74_Callback(hObject, eventdata, handles)

if   handles.flag.axis1==-1
    axes(handles.axes1)
    colorbar
else
    axes(handles.axes1)
    colorbar('off')
end
handles.flag.axis1=handles.flag.axis1*(-1);
guidata(hObject, handles);


% --------------------------------------------------------------------
function Untitled_76_Callback(hObject, eventdata, handles)

track_what=get(handles.track_what2,'Value')  ;
MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata  ;
save MATRIX MATRIX

if isempty(MATRIX)==1
    Y=wavread('Error');
    h = errordlg('You have to track the cell first!!','Error');
    sound(Y,22000);
    return
end


ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];



if size(MATRIX,2)>26
    lastcell=strcat(ABC(floor(size(MATRIX,2)/26)),ABC(round(26*(size(MATRIX,2)/26-floor(size(MATRIX,2)/26)))));
else
    lastcell= ABC(size(MATRIX,2)) ;
end
lastcell=strcat(lastcell,num2str(size(MATRIX,1)))  ;
Excel = actxserver('Excel.Application');
set(Excel, 'Visible', 1);
Workbooks = Excel.Workbooks;
Workbook = invoke(Workbooks, 'Add');
Activesheet = Excel.Activesheet;
ActivesheetRange = get(Activesheet,'Range','A1',lastcell);

set(ActivesheetRange, 'Value',MATRIX);
ActivesheetRange.Font.Bold = 'True';
ActivesheetRange.Font.Size = 10;
ActivesheetRange.ColumnWidth = 11;
ActivesheetRange.Borders.LineStyle = 1;
ActivesheetRange.Borders.Weight = 2


% --------------------------------------------------------------------
function Untitled_77_Callback(hObject, eventdata, handles)
colormapeditor
handles.c=  get(gcf,'colormap')
guidata(hObject,handles)


% --------------------------------------------------------------------
function Untitled_78_Callback(hObject, eventdata, handles)
axes(handles.axes1)
imcontrast(gca)


% --------------------------------------------------------------------
function Untitled_79_Callback(hObject, eventdata, handles)
axes(handles.axes1)
impixelregion(gca)


% --------------------------------------------------------------------
function Untitled_80_Callback(hObject, eventdata, handles)
axes(handles.axes1)
imtool(gca)


% --------------------------------------------------------------------
function Untitled_81_Callback(hObject, eventdata, handles)
axes1_cord=get(handles.axes1, 'Position');
axes2_cord=get(handles.axes2, 'Position');

set(handles.axes1, 'Position',axes2_cord) ;
set(handles.axes2, 'Position',axes1_cord) ;

axes(handles.axes2)
axis auto


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(~, ~, ~)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
function update_labelmatrix(handles)
n=get(handles.Raw_listbox,'value')   ;
track_what=get(handles.track_what2,'Value') ;
centy1 =handles.data_file(4).cdata.Centroids(track_what).cdata   ;
box_Raw=get(handles.Raw_listbox,'string') ;
sizey=size(box_Raw,1);

green= uint8(zeros(2,sizey))  ;
red= green  ;
blue= green  ;



for ii=1:sizey
    try
        if isempty(centy1(ii).cdata)~=1
            green(1,ii)=255;
            try
                centy1(ii).cdata(:,4);
                red(2,ii)=255;
            end
        end
    end
end




RGB=cat(3,green,red,blue);
axes(handles.axes3); cla ; imagesc(RGB);  axis tight



axes(handles.axes1);


% --- Executes during object creation, after setting all properties.
function nobjects_CreateFcn(~, ~, ~)
% hObject    handle to nobjects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




function m_edit_Callback(~, ~, ~)
% hObject    handle to m_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m_edit as text
%        str2double(get(hObject,'String')) returns contents of m_edit as a double


% --------------------------------------------------------------------
function Untitled_82_Callback(hObject, eventdata, handles)
n=get(handles.Raw_listbox,'Value') ;
track_what=get(handles.track_what2,'Value') ;
centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
centy2 = handles.data_file(4).cdata.L(track_what).cdata ;

dlg_title = 'Format';
prompt = {'Please input frame to start:','Please input frame to end:','Please input minimum size:'};
def = {num2str(n),num2str(size(centy1,2) ),'user input critiria'};
answer  = inputdlg(prompt,dlg_title,1,def);
answer=str2double(answer);
m    = answer(1);
n    = answer(2);
Critiria    = answer(3)
h=timebar_TACWrapper('Remove centroids. Please wait....');
set(h,'color','w');
for ii=m:n %2 Procced only if the complimantory Segmentation file was found
    timebar_TACWrapper(h,ii/n)
    try
        
        X=centy1(ii).cdata.centy11(:,1);  Y=centy1(ii).cdata.centy11(:,2);
        centy22 = centy2(ii).cdata
        for jj=1:size(centy22,1)
            if  centy22(jj).Area<Critiria
                jj
                XY=centy22(jj).Centroid
                centy1(ii).cdata(ismember((abs(X-XY(1))+abs(Y-XY(2))),0),:)=[];
            end
        end
        
        
    end
end
handles.data_file(4).cdata.Centroids(track_what).cdata=  centy1 ;
guidata(hObject,handles);
global h_TAC_Cell_Tracking_Module
h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);  close(h)


% --------------------------------------------------------------------
function Untitled_83_Callback(hObject, eventdata, handles)


track_what=get(handles.track_what2,'Value') ;
MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata   ;


nn=1;div_cells=[];
last_cell =get_last_cell_index(MATRIX)
for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
    if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
        % centy2: to find the mark in centroids, centy2 is the centy
        % for all tracked frames
        centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata
        
        for jj=1:size(centy2,1)  % .
            if str2num(num2str(centy2(jj,3)- iiii))==0.1
                for cell_index=2:2:(last_cell-2)
                    if  MATRIX(iiii,cell_index-1)==centy2(jj,1) && MATRIX(iiii,cell_index)==centy2(jj,2)
                        break
                    end
                end
                div_cells(nn)=cell_index/2;
                nn=nn+1;
            end
        end
    end
end


%        div_cells is the list of location of all dividing cells (parental) in MATRIX of trajectories


save div_cells div_cells
save MATRIX MATRIX

all_cells=cell(size(MATRIX,2)/2,1);
for ii=1:size(MATRIX,2)/2
    all_cells(ii) =cellstr(num2str(ii));
end


for zzz=1:length(div_cells)
    cell_index=div_cells(zzz);
    PD1D2_matrix(zzz,1)=cell_index;
    trackdivnum=cell_index;
    V=MATRIX(:,cell_index*2-1);
    V=V(find(V, 1 ):find(V, 1, 'last' ));
    for start_XY=1:size(MATRIX,1)
        if MATRIX(start_XY,cell_index*2-1)>0
            break
        end
    end
    end_XY=length(V)+start_XY;
    x=MATRIX(end_XY-1,cell_index*2-1);
    y=MATRIX(end_XY-1,cell_index*2);
    sizee=size(MATRIX,2)/2;
    matrix=repmat([1 NaN;NaN 1],1,sizee );
    X=matrix(1,:).*MATRIX(end_XY,:);
    Y=matrix(2,:).*MATRIX(end_XY,:);
    X(isnan(X))=[]; %take off all nans from X vector
    Y(isnan(Y))=[]; %take off all nans from X vector
    X(X==0)=NaN;
    Y(Y==0)=NaN;
    XY= (X-x).^2+ (Y-y).^2;%PITAGORAS
    XY_min_index=find(ismember(XY,(min(XY))));
    if isempty(X(XY_min_index))~=1 || isempty(Y(XY_min_index))~=1
        PD1D2_matrix(zzz,2)=XY_min_index;
    end
    XY(XY_min_index)=nan;
    XY_min_index=find(ismember(XY,(min(XY))));
    if isempty(X(XY_min_index))~=1 || isempty(Y(XY_min_index))~=1
        PD1D2_matrix(zzz,3)=XY_min_index;
    end
end
PD1D2_matrix


% --------------------------------------------------------------------
function Untitled_84_Callback(~, ~, ~)
% hObject    handle to Untitled_84 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_85_Callback(hObject, eventdata, handles)

msgbox('please confirm that there is segmented grid in the selected channel')

box_list=get(handles.Raw_listbox,'string');
n=get(handles.Raw_listbox,'Value') ;
track_what=get(handles.track_what1,'Value') ;
pathname_Segmentation=handles.data_file(2).cdata(track_what,3) ;
filename_Segmentation=box_list(n)  ;
full_filename_Segmentation=char(strcat(pathname_Segmentation,    filename_Segmentation,'_ch0',num2str(track_what-1),'_Segmented.tif'));
temp_Segmentation=imread( full_filename_Segmentation,1);
temp =flipdim(temp_Segmentation,1);



temp2=bwlabel(temp);
temp2(temp2~=5)=0;
temp2=temp2./temp2;
temp2(isnan(temp2))=0;

stats=regionprops(temp2,'BoundingBox')




XY=stats(1).BoundingBox
XY(3)=XY(1)+XY(3); XY(4)=XY(2)+XY(4)
XY =[XY(1) XY(2); XY(1) XY(4)  ;   XY(3) XY(4);  XY(3) XY(2)]

ROI=XY


prompt = {'Please input frame to start:','Please input frame to end:'};
dlg_title = 'Merging..';
num_lines = 1;


n=get(handles.Raw_listbox,'Value') ;
track_what=get(handles.track_what2,'Value') ;
centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata ;
centy2 = handles.data_file(4).cdata.L(track_what).cdata ;

def = {num2str(n),num2str(size(centy1,2) )};



answer  = inputdlg(prompt,dlg_title,num_lines,def);
answer=str2double(answer);
m    = answer(1);
n    = answer(2);
h=timebar_TACWrapper('Remove objects outside region. Please wait....');
set(h,'color','w');
track_what=get(handles.track_what2,'value')

for ii=m:n %2 Procced only if the complimantory Segmentation file was found
    try
        temp_centy=centy1(ii).cdata;
        in=inpolygon( temp_centy(:,1), temp_centy(:,2),ROI(:,1),ROI(:,2));
        centy1(ii).cdata= temp_centy(ismember(in,1),:);
    end
end
handles.data_file(4).cdata.Centroids(track_what).cdata=  centy1 ;
for ii=m:n %2 Procced only if the complimantory Segmentation file was found
    timebar_TACWrapper(h,ii/n)
    
    kk=1;   clear centy3 % imprtant: centry3=[] is not good here!
    for jj=1:size(centy2(ii).cdata,1);
        temp_centy= centy2(ii).cdata(jj).Centroid  ;
        in=inpolygon( temp_centy(:,1), temp_centy(:,2),ROI(:,1),ROI(:,2))  ;
        if in==1
            centy3(kk) =centy2(ii).cdata(jj)  ;  kk=kk+1;
        end
    end
    try
        centy2(ii).cdata=centy3';
    catch
        centy2(ii).cdata=[];
    end
    
end
close(h)

handles.data_file(4).cdata.L(track_what).cdata=  centy2  ;





guidata(hObject,handles);
global h_TAC_Cell_Tracking_Module
h_TAC_Cell_Tracking_Module=handles; set(handles.figure1,'userdata',handles.data_file);


% --- Executes on button press in mode_7.


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in mode_1.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to mode_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
