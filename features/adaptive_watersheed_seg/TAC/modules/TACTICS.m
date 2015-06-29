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
function varargout = TACTICS(varargin)
%_________________________________________________________________________

% TACTICS M-file for TACTICS.fig
%      TACTICS, by itself, creates a new TACTICS or raises the existing
%      singleton*.
%
%      H = TACTICS returns the handle to a new TACTICS or the handle to
%      the existing singleton*.
%
%      TACTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TACTICS.M with the given input arguments.
%
%      TACTICS('Property','Value',...) creates a new TACTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs
%      are
%      applied to the GUI before TACTICS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property
%      application
%      stop.  All inputs are passed to TACTICS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TACTICS

% Last Modified by GUIDE v2.5 17-Nov-2012 10:59:25

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TACTICS_OpeningFcn, ...
    'gui_OutputFcn',  @TACTICS_OutputFcn, ...
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

function TACTICS_OpeningFcn(hObject, eventdata, handles, varargin)







backgroundImage = importdata('TACTICS_logo2.jpg');
%select the axes
axes(handles.axes4);
%place image onto the axes
image(backgroundImage);
%remove the axis tick marks
axis off










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



if nargin ==3
    backgroundImage = importdata('TACTICS_logo2.jpg');  axes(handles.axes1); image(backgroundImage);
    handles.nargin_num=3;
    handles.output = hObject;
    handles.data_file=[];
    guidata(hObject, handles);
    
    % try
    %  speaker('WELCOME to TaCtikcs . Totally Automated Cell Tracking In Confinement Systems')
    %   end
    
    
elseif nargin==4
    
    handles.data_file=varargin{1};
    handles.output = hObject;
    guidata(hObject, handles);
    
    
    if isempty( handles.data_file)==1
        handles.nargin_num=3;
        guidata(hObject, handles);
        return
    end
    
    set(handles.Current_Exp,'String',handles.data_file(10).cdata);
    handles.nargin_num=4;
    handles.output = hObject;
    set(handles.showcurrentframe,'String',1);
    set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1)) ;
    set(handles.Raw_listbox,'Value', 1 ) ;
    
    
    %        set(handles.sliderframes,'Max',length(handles.data_file(1).cdata(:,1)));
    %        set(handles.sliderframes,'Min',1);        set(handles.sliderframes,'value',1);
    
    
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
    track_what_Callback(hObject, eventdata, handles)
    
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
        
        MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata
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
            handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k') ;
            handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
            guidata(hObject,handles)
        end
        nn=1;div_cells=[];
        last_cell =get_last_cell_index(MATRIX);
        for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
            if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
                centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
                for jj=1:size(centy2,1)  % .
                    if centy2(jj,3)/iiii>1
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
    
    guidata(hObject, handles);
    
    
    handles = addPlabackControls(hObject, handles);
    %  set(hObject, 'ResizeFcn',@figResizeFcn, 'DeleteFcn',@figDeleteFcn);
    guidata(hObject, handles);
    
    % clc
    %     % Choose default command line output for TACTICS
    %     handles.output = hObject;
    
    
    % UIWAIT makes TACTICS wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
    
    % Update handles structure
    
    set(handles.sliderframes2, 'Enable','on', 'SliderStep',[1, 0.1]);  % Matlab scrollbar
    set(handles.active_panel1,'visible','on');     set(handles.Raw_listbox,'visible','on')
    
    guidata(hObject, handles);
    
    
    
end






handles = addPlabackControls(hObject, handles);
%  set(hObject, 'ResizeFcn',@figResizeFcn, 'DeleteFcn',@figDeleteFcn);

set(handles.sliderframes2, 'Enable','on', 'SliderStep',[1, 0.1]);  % Matlab scrollbar


tic


%  set(hObject, 'ResizeFcn',@figResizeFcn, 'DeleteFcn',@figDeleteFcn);
guidata(hObject, handles);
axis tight
clc




% --- Outputs from this function are returned to the command line.
function varargout = TACTICS_OutputFcn(hObject, eventdata, handles)
%  setWindowState(hObject,'maximize','icon.gif');  % Undocumented feature!
pause(0.05); drawnow;


varargout{1} = handles.output;
switch handles.nargin_num
    case 3
        try
            replaceSlider(hObject,handles);
        end
        try
            varargout{1}=  handles.output;
        end
    case 4
        replaceSlider(hObject,handles);
        varargout{1}=  handles.output;
        
    case 5
        wait_pause=waitbar(0,'exit....');
        for cc=1:5
            waitbar(cc/5)
            pause(1)
        end
        
        close( wait_pause)
        close(TAC_Cell_Tracking_Module)
        Close
end

function handles = addPlabackControls(hObject, handles)
icons = load(fullfile(fileparts(mfilename), 'animatorIcons.mat'));
function replaceSlider(hFig,handles)    %#ok
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

function figResizeFcn(hFig,varargin)    %#ok
handles = guidata(hFig);
%     %set(hFig, 'Units', 'pixels');
%     %figPos   = get(hFig, 'Position');
%     framePos = getpixelposition(handles.showcurrentframe);
%     panelPos = framePos + [100,0,0,0];
%     %set(handles.PlaybackAxes, 'units','Pixel', 'Position', panelPos+[0,15,0,-10]);
%     set(handles.slowerAxes  , 'units','Pixel', 'Position', [panelPos(1),                 panelPos(2)+panelPos(4)/2-5 16 16]);
%     set(handles.fasterAxes  , 'units','Pixel', 'Position', [panelPos(1)+panelPos(3)-16   panelPos(2)+panelPos(4)/2-5 16 16]);
%     set(handles.pauseAxes   , 'units','Pixel', 'Position', [panelPos(1)+panelPos(3)/2-8  panelPos(2)+panelPos(4)/2-5 16 16]);

% Called when figure is closed
% function figDeleteFcn(varargin)    %#ok
%     % stop and delete timer object
%     stop(timerfindall('tag','animationTimer'));
%     delete(timerfindall('tag','animationTimer'));

% Called when the control buttons are pressed
% function speedBtnFcn(varargin)
%     handles = guidata(varargin{1});
%     hTimer = handles.hTimer;
%     isRunning = strcmpi(hTimer.Running,'on');
%
%     switch get(varargin{1}, 'Tag')
%       case 'slowerImage'
%           stop(hTimer);
%           hTimer.Period = hTimer.Period + 0.1;
%           if isRunning
%               n = get(handles.Raw_listbox,'value');
%               set(handles.Raw_listbox,'value',max(1,n-1));
%               start(hTimer);
%           end
%
%       case 'fasterImage'
%           stop(hTimer);
%           hTimer.Period = max(0.1, hTimer.Period - 0.1);
%           if isRunning
%               n = get(handles.Raw_listbox,'value');
%               set(handles.Raw_listbox,'value',max(1,n-1));
%               start(hTimer);
%           end
%
%       case 'pauseImage'
%           if isRunning
%               stop(hTimer);
%           else
%               start(hTimer);
%           end
%     end
%
% function startTimer(hTimer, eventData, varargin)
%     try
%         handles = guidata(hTimer.UserData);
%         set(handles.pauseImage, 'CData', handles.icons.pauseCData, 'alphadata', handles.icons.pauseAlpha);
%     catch
%         a=1;
%     end
%
% function stopTimer(hTimer, eventData, varargin)
%     try
%         handles = guidata(hTimer.UserData);
%         set(handles.pauseImage, 'CData', handles.icons.playCData, 'alphadata', handles.icons.playAlpha);
%     catch
%         a=1;
%     end
%
% function updateTimer(hTimer, eventData, varargin)
%     try
%         handles = guidata(hTimer.UserData);
%         n = get(handles.Raw_listbox,'value');
%         s = get(handles.Raw_listbox,'string');
%         if iscell(s)
%             maxN = length(s);
%         else
%             maxN = 1;
%         end
%         set(handles.Raw_listbox,'value',min(maxN,n+1));
%         Raw_listbox_Callback(handles.Raw_listbox, [], handles);
%     catch
%         a=1;
%     end

% ---------------------------------------------------
function Raw_listbox_CreateFcn(hObject, eventdata, handles)

function sliderframes_CreateFcn(hObject, eventdata, handles)
% The folowing is undocumented! - callback for continuous slider movement
hListener = handle.listener(hObject,'ActionEvent',{@sliderframes_Callback,handles});
setappdata(hObject,'listener__',hListener);



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
function showcurrentframe_CreateFcn(hObject, eventdata, handles)
function Show_boundingbox_Callback(hObject, eventdata, handles)
Raw_listbox_Callback(hObject, eventdata, handles)


function Projected_by_CreateFcn(hObject, eventdata, handles)
function segmentation_type_CreateFcn(hObject, eventdata, handles)
function track_what_CreateFcn(hObject, eventdata, handles)
function Div_Cells_CreateFcn(hObject, eventdata, handles)
function Div_frame_index_CreateFcn(hObject, eventdata, handles)
function MA_value_Callback(hObject, eventdata, handles)
function MA_value_CreateFcn(hObject, eventdata, handles)
function start_export_Callback(hObject, eventdata, handles)
function start_export_CreateFcn(hObject, eventdata, handles)
function end_export_Callback(hObject, eventdata, handles)
function end_export_CreateFcn(hObject, eventdata, handles)
function Daughter1_edit_Callback(hObject, eventdata, handles)
function Daughter2_edit_Callback(hObject, eventdata, handles)
function Daughter2_edit_CreateFcn(hObject, eventdata, handles)
function parental_num_CreateFcn(hObject, eventdata, handles)
function Daughter1_edit_CreateFcn(hObject, eventdata, handles)
function Current_Exp_CreateFcn(hObject, eventdata, handles)
function fspecial_type_CreateFcn(hObject, eventdata, handles)
function apply_threshold_CreateFcn(hObject, eventdata, handles)
function bwmorph_type_CreateFcn(hObject, eventdata, handles)

function strel_type_CreateFcn(hObject, eventdata, handles)
function select_mode_filtered_CreateFcn(hObject, eventdata, handles)
function select_mode_threshold_CreateFcn(hObject, eventdata, handles)
function T_popup_1_CreateFcn(hObject, eventdata, handles)
function T_popup_2_CreateFcn(hObject, eventdata, handles)
function T_popup_3_CreateFcn(hObject, eventdata, handles)
function T_popup_4_CreateFcn(hObject, eventdata, handles)
function T_popup_5_CreateFcn(hObject, eventdata, handles)
function T_popup_6_CreateFcn(hObject, eventdata, handles)
function thresh_level_CreateFcn(hObject, eventdata, handles)
function T_Slider_2_CreateFcn(hObject, eventdata, handles)
function T_Slider_3_CreateFcn(hObject, eventdata, handles)
function T_Slider_4_CreateFcn(hObject, eventdata, handles)
function T_Slider_5_CreateFcn(hObject, eventdata, handles)
function T_Slider_6_CreateFcn(hObject, eventdata, handles)
function T_edit_1_CreateFcn(hObject, eventdata, handles)
function T_edit_2_CreateFcn(hObject, eventdata, handles)
function T_edit_3_CreateFcn(hObject, eventdata, handles)
function T_edit_4_CreateFcn(hObject, eventdata, handles)
function T_edit_5_CreateFcn(hObject, eventdata, handles)
function T_edit_6_CreateFcn(hObject, eventdata, handles)
function MODE_CreateFcn(hObject, eventdata, handles)
function start_threshold_at_CreateFcn(hObject, eventdata, handles)
function end_threshold_at_CreateFcn(hObject, eventdata, handles)
% ---------------------------------------------------
function Raw_listbox_Callback(hObject, eventdata, handles)
box_Raw=get(handles.Raw_listbox,'string');
% if iscell(box_Raw)==0
%     Y=wavread('Error');
%     h = errordlg('No files in Raw Frame listbox','Error');
%     return
% end
n=round(get(handles.Raw_listbox,'Value'));
size_boxlist = size(box_Raw,1);
try
    set(handles.sliderframes, 'Minimum',1, 'Maximum',size_boxlist, 'Value',n);
end
show_frame(hObject, eventdata, handles,n);





%   set(handles.sliderframes, 'Minimum',1, 'Maximum',size_boxlist,
%   'Value',n);





% --------------------------------------------------------------------
function Load_Callback(hObject, eventdata, handles)
set(handles.Div_frame_index,'value',1)
set(handles.Div_Cells,'value',1)
set(handles.parental_num,'value',1)
set(handles.Div_frame_index,'string','Division at frame')
set(handles.Div_Cells,'string','Cells list')
set(handles.parental_num,'string','Choose dividing cell:')
set(handles.Daughter1_edit,'string','')
set(handles.Daughter2_edit,'string','')
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose Raw frames (that have complementary Thresholded frames)'); % handles.directory_name); %pick files to combine
if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end

full_filename = strcat(pathname,filename);
full_filename = char(full_filename);
set(handles.Current_Exp,'String',full_filename);
handles.data_file=importdata(full_filename);
set(handles.Raw_listbox,'Value',1);
set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1));
track_what=1;
set(handles.track_what,'Value',1);
str=[];
str=handles.data_file(3).cdata(track_what,1);
if str2double(str)<1
    set(handles.track_what,'Value',1)
    return
end
guidata(hObject,handles)
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
        handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');
        handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
        guidata(hObject,handles)
    end
    nn=1;div_cells=[];
    last_cell =get_last_cell_index(MATRIX);
    for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
        if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
            centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
            for jj=1:size(centy2,1)  % .
                if centy2(jj,3)/iiii>1
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
show_frame(hObject, eventdata, handles,1)
guidata(hObject, handles);

% ----------------------------------------------------------
function track_what_Callback(hObject, eventdata, handles)

track_what=get(handles.track_what,'Value');
str=handles.data_file(3).cdata(track_what,1);
if str2double(str)<1
    set(handles.track_what,'Value',1)
    return
end


set(handles.virtual_stack_mode,'value',0)






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
    handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');
    guidata(hObject,handles)
    
    
end
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


set(handles.Div_frame_index,'value',1)
set(handles.Div_Cells,'value',1)
set(handles.parental_num,'value',1)
set(handles.Div_frame_index,'string','Division at frame')
set(handles.Div_Cells,'string','Cells list')
set(handles.parental_num,'string','Choose dividing cell:')
set(handles.Daughter1_edit,'string','')
set(handles.Daughter2_edit,'string','')

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
        handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');
        handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
        guidata(hObject,handles)
    end
    nn=1;div_cells=[];
    last_cell =get_last_cell_index(MATRIX);
    for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
        if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
            centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
            for jj=1:size(centy2,1)  % .
                if centy2(jj,3)/iiii>1
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
    
    
    
    
    
    [all_cells,parental_cells]=TRYME(div_cells,MATRIX) ;
    
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

%           cla(handles.axes1)
%              parental_num_Callback(hObject, eventdata, handles)
box_Raw=get(handles.Raw_listbox,'string');
if iscell(box_Raw)==0
    Y=wavread('Error');
    h = errordlg('No files in Raw Frame listbox','Error');
    return
end
n=round(get(handles.Raw_listbox,'Value'));
size_boxlist = size(box_Raw,1);

Raw_listbox_Callback(hObject, eventdata, handles)
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
cell_index= get(hObject,'Value')
track_what=get(handles.track_what,'Value');
MATRIX=  handles.data_file(5).cdata.Tracks(track_what ).cdata;
V=MATRIX(:,cell_index*2-1);
V=V(find(V, 1 ):find(V, 1, 'last' ));

for start_XY=1:size(MATRIX,1)
    if MATRIX(start_XY,cell_index*2 -1)>0
        break
    end
end

set(handles.Raw_listbox,'Value',+start_XY)
Raw_listbox_Callback(hObject, eventdata, handles)
%  ------------------------------------------------------
function virtual_stack_mode_Callback(hObject, eventdata, handles)

%  -----------------------------------------
function parental_num_Callback(hObject, eventdata, handles)
parental_num_str=get(handles.parental_num,'string');
parental_num_val=get(handles.parental_num,'value');
parental_num=parental_num_str(parental_num_val);
div_cells_Vec =get(handles.Div_Cells,'string');
cell_index=find(strcmp(parental_num,  div_cells_Vec ));
trackdivnum=cell_index;
track_what=get(handles.track_what,'Value');
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
show_frame(hObject, eventdata, handles,1)
set(gcf,'colormap',handles.c);
axis tight
% ---------------
function sliderframes_Callback(hObject, eventdata, handles)
if  toc<0.05
    return
end
try
    if isnumeric(hObject), return;  end  % only process handle.listener events
    inCallback = getappdata(hObject,'inCallback');
    if isempty(inCallback)
        setappdata(hObject,'inCallback',1);
    else
        return
    end
    handles = guidata(handles.figure1);
    
    n = round(get(hObject,'Value'));
    set(handles.Raw_listbox,'value',n);
    set(handles.showcurrentframe,'String',num2str(n));
    tic
    
    show_frame(hObject, eventdata, handles,n);
    
    
    
catch
    % never mind
    a=1;  %debug point
end
setappdata(hObject,'inCallback',[]);

% ===========================================
% ======  FUNCTIONS =========================
% ===========================================
% ========================================
function show_frame(hObject, eventdata, handles,n)
box_Raw=get(handles.Raw_listbox,'string');

%filename=box_Raw(n);
track_what=get(handles.track_what,'Value');
moving_avg_value=str2double(get(handles.MA_value,'String'));
[temp,centy1] = Moving_Average(moving_avg_value,n,size(box_Raw,1),handles);
% if isempty(temp)
%      'cant find the image'
%     return;
% end
axes(handles.axes1);
cla(handles.axes1);
imagesc(temp, 'Hittest','Off');
% set(h_axes1_imagesc, 'Hittest','Off');
%set(gcf,'colormap',handles.c);
xy_border=handles.data_file(6).cdata;
%rectangle('Position', xy_border,'LineWidth',5,'LineStyle','--','EdgeColor','m');
%axis tight; axis manual;
hold on

if findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')
    if get(handles.Show_boundingbox,'value')==1
        if isempty(centy1)~=1
            for ii=1:size(handles.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
                if  isempty(handles.data_file(4).cdata.L(track_what).cdata(n).cdata)~=1
                    XY= handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BoundingBox;
                    if XY(1)>xy_border(1) && XY(2)>xy_border(2) && (xy_border(1)+xy_border(3))>(XY(1)+XY(3)) && (xy_border(1)+xy_border(4))>(XY(2)+XY(4))
                        rectangle('Position', XY,'LineWidth',1  ,'EdgeColor','w', 'Hittest','Off'); %keep this one
                        
                        
                        if get(handles.Show_maximum_pixel,'value')==1
                            vec1= round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_3)  ;
                            plot(centy1(ii,1),centy1(ii,2),'m.',     'MarkerSize',20, 'Hittest','Off');
                            %                       h_axes4_plot=plot(vec1(:,1),vec1(:,2),'m.', 'MarkerSize',30, 'Hittest','Off');
                            centroid=round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Centroid) ;
                            vec1= round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_3)  ;
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
            index_local = (centy1(:,3) == n+0.1);  % faster: use logical indexing
            plot(centy1(index_local,1),centy1(index_local,2),'rx',  'MarkerSize',30,'Hittest','Off');
            
            
        end
    end
    
    
    
    
    if findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
        if get(handles.show_tracks,'value')==1
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
                X2=MATRIX(:,xx(ii));  Y2=MATRIX(:,xxx(ii));
                X2=X2(X2>0); Y2=Y2(Y2>0);
                if length(X2)~=length(Y2)
                    errordlg('X and Y must have the same length. Please check that the coordinates of both X and Y are valid!','Error');
                    return
                end
                
                
                plot(X2,Y2, '.-', 'color',handles.C(x(ii),:), 'Hittest','Off');
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
segmentation_type=get(handles.segmentation_type,'Value');
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
    track_what= get(handles.track_what,'Value') ;
end

% if get(handles.virtual_stack_mode,'value')~=1
Projected_by_Value=get(handles.Projected_by,'Value');
Projected_by_Str=get(handles.Projected_by,'String');
Projected_by=char(Projected_by_Str(Projected_by_Value));
box_list=get(handles.Raw_listbox,'string');
filename=char(box_list(n));
segmentation_type=get(handles.segmentation_type,'value');
[matrix_out,centy1,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, filename,handles.data_file,track_what);
set(handles.edit_axes1,'String',full_filename);

% else


%     if   findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')==1
%         centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata;
%     end
%     matrix_out= handles.stack(n).cdata;
%     if isempty(matrix_out)==1
%         [ 'Stack does not contain frame  ' num2str(n) '. Please load this frame to stack and try again!']
%        return; end;
%

% end
% -------------------------------------------------
function [matrix_out,centy1]= read_image_visualization(handles,n,segmentation_type,track_what)


if nargin==3
    track_what= get(handles.track_what,'Value') ;
end
% virtual_stack_mode=get(handles.virtual_stack_mode,'value')


if get(handles.virtual_stack_mode,'value')~=1
    Projected_by_Value=get(handles.Projected_by,'Value');
    Projected_by_Str=get(handles.Projected_by,'String');
    Projected_by=char(Projected_by_Str(Projected_by_Value));
    box_list=get(handles.Raw_listbox,'string');
    filename=char(box_list(n));
    segmentation_type=get(handles.segmentation_type,'value');
    [matrix_out,centy1,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, filename,handles.data_file,track_what);
    set(handles.edit_axes1,'String',full_filename);
    
else
    
    centy1=[];
    if   findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')==1
        centy1 = handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata;
    end
    try
        eval(strcat('matrix_out=handles.Ch0',num2str(track_what-1),'_stack(',num2str(n),').cdata;'))
        if isempty(matrix_out)==1
            [ 'Stack does not contain frame  ' num2str(n) '. Load this frame from virtual stack!']
            Projected_by_Value=get(handles.Projected_by,'Value');
            Projected_by_Str=get(handles.Projected_by,'String');
            Projected_by=char(Projected_by_Str(Projected_by_Value));
            box_list=get(handles.Raw_listbox,'string');
            filename=char(box_list(n));
            segmentation_type=get(handles.segmentation_type,'value');
            [matrix_out,centy1,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, filename,handles.data_file,track_what);
            set(handles.edit_axes1,'String',full_filename);
        end
    catch
        %       if isempty(matrix_out)==1
        [ 'Stack does not contain frame  ' num2str(n) '. Load this frame from virtual stack!']
        Projected_by_Value=get(handles.Projected_by,'Value');
        Projected_by_Str=get(handles.Projected_by,'String');
        Projected_by=char(Projected_by_Str(Projected_by_Value));
        box_list=get(handles.Raw_listbox,'string');
        filename=char(box_list(n));
        segmentation_type=get(handles.segmentation_type,'value');
        [matrix_out,centy1,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, filename,handles.data_file,track_what);
        set(handles.edit_axes1,'String',full_filename);
    end
    
    
end
% ----------------------------
function [matrix_out,centy1,full_filename]= read_image2(handles,n,segmentation_type,Projected_by, filename,data_file,track_what)
if nargin==6
    track_what= get(handles.track_what,'Value');
end

Projected_by2=str2double(regexprep(Projected_by, 'z', '')) ;
matrix_out=[];  centy1=[];


if findstr(char(data_file(7).cdata(track_what,2)),'Y')==1
    centy1 = data_file(4).cdata.Centroids(track_what).cdata(n).cdata;
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
            full_filename = [char(data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Threshold.tif'];
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
            
            full_filename_Threshold = [char(data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Threshold.tif'];
            b=dir(full_filename_Threshold);
            if size(a,1)~=0 && size(b,1)~=0
                temp_Threshold=imread(full_filename_Threshold ,1);
                temp_Threshold=flipdim(temp_Threshold,1);
                temp_Threshold=double(temp_Threshold);
                matrix_out=temp_Filtered.* temp_Threshold;
            end
            
        case 5
            
            full_filename_Raw = [char(data_file(2).cdata(track_what,1)),'z\',filename,'_ch0',num2str(track_what-1),'.tif'];
            a=dir(full_filename_Raw);
            if size(a,1)~=0
                temp_Raw=imread(full_filename_Raw ,1);
                temp_Raw=double(temp_Raw);
            end
            
            full_filename_Threshold = [char(data_file(2).cdata(track_what,3)),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Threshold.tif'];
            
            b=dir(full_filename_Threshold);
            if size(a,1)~=0 && size(b,1)~=0
                temp_Threshold=imread(full_filename_Threshold ,1);
                temp_Threshold=flipdim(temp_Threshold,1);
                temp_Threshold=double(temp_Threshold);
                matrix_out=temp_Raw.* temp_Threshold;
            end
    end
end

if findstr('By mean',Projected_by)
    switch segmentation_type
        case 1
            full_filename = [data_file(2).cdata{track_what,1},filename,'_ch0',num2str(track_what-1),'.tif'];
            if ~isempty(dir(full_filename))
                matrix_out=imread(full_filename,'tif',1);
            end
            
        case 2
            full_filename = [data_file(2).cdata{track_what,2},filename,'_ch0',num2str(track_what-1),'_Filtered.tif'];
            if ~isempty(dir(full_filename))
                matrix_out = imread(full_filename,'tif',1);
            end
            
        case 3
            full_filename = [data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Threshold.tif'];
            if ~isempty(dir(full_filename))
                matrix_out = flipdim(imread(full_filename,'tif',1),1);
            end
            
        case 4
            full_filename = [data_file(2).cdata{track_what,2},filename,'_ch0',num2str(track_what-1),'_Filtered.tif'];
            a = dir(full_filename);
            if ~isempty(a)
                temp_Filtered = double(imread(full_filename,'tif',1));
            end
            
            full_filename = [data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Threshold.tif'];
            b = dir(full_filename);
            if ~isempty(a) && ~isempty(b)
                temp_Threshold = double(flipdim(imread(full_filename,'tif',1),1));
                matrix_out = temp_Filtered.* temp_Threshold;
            end
            
        case 5
            full_filename = [data_file(2).cdata{track_what,1},filename,'_ch0',num2str(track_what-1),'.tif'];
            a = dir(full_filename);
            if ~isempty(a)
                temp_Raw = double(imread(full_filename,'tif',1));
            end
            
            full_filename = [data_file(2).cdata{track_what,3},filename,'_ch0',num2str(track_what-1),'_Threshold.tif'];
            b = dir(full_filename );
            if ~isempty(a) && ~isempty(b)
                temp_Threshold = double(flipdim(imread(full_filename,'tif',1),1));
                matrix_out = temp_Raw.* temp_Threshold;
            end
    end
end
if isempty(matrix_out)
    'could not find the file!!'
    cla(handles.axes1)
end

%-------------------------------------------------------------------------
function [last_cell]=get_last_cell_index(MATRIX)
for  last_cell=2:2: size(MATRIX,2)
    X=MATRIX(:,last_cell);
    X(X==0)=[];
    if isempty(X)==1
        break
    end
end

% ----------------------
function [all_cells,parental_cells]=TRYME(div_cells,MATRIX)
all_cells=cell(size(MATRIX,2)/2,1);
for ii=1:size(MATRIX,2)/2
    all_cells(ii) =cellstr(num2str(ii));
end
if isempty(div_cells)~=1
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
    for zzz=1:size(PD1D2_matrix,1)
        if  isempty(find(ismember(PD1D2_matrix(:,2:3),PD1D2_matrix(zzz,1)), 1))==1
            all_cells(PD1D2_matrix(zzz,1)) =cellstr(num2str(PD1D2_matrix(zzz,1)));
        end
        all_cells(PD1D2_matrix(zzz,2)) =cellstr(strcat(all_cells(PD1D2_matrix(zzz,1)) ,'.1'));
        all_cells(PD1D2_matrix(zzz,3)) =cellstr(strcat(all_cells(PD1D2_matrix(zzz,1)) ,'.2'));
    end
end
parental_cells=cell(size(div_cells,2),1);
for ii=1:size(div_cells,2)
    parental_cells(ii)=all_cells(div_cells(ii));
end
% ----------------------------
function [vector jj]=create_vector(MATRIX,handles,start_frame)
% vector is the trajectories of cell number start_frame in the
% MATRIX (the table). jj is the first frame that this cell appears.

%one of the most important functions!
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
track_what=get(handles.track_what,'Value');
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
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please load experiment'); % handles.directory_name); %pick files to combine
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


full_filename = strcat(pathname,filename);
full_filename = char(full_filename);
set(handles.Current_Exp,'String',full_filename);
handles.data_file=importdata(full_filename);
set(handles.Raw_listbox,'Value',1);


set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1));
track_what=1;
set(handles.track_what,'Value',1);
str=[];
str=handles.data_file(3).cdata(track_what,1);
if str2double(str)<1
    set(handles.track_what,'Value',1)
    return
end
guidata(hObject,handles)
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
        handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');
        handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
        guidata(hObject,handles)
    end
    nn=1;div_cells=[];
    last_cell =get_last_cell_index(MATRIX);
    for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
        if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
            centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
            for jj=1:size(centy2,1)  % .
                if centy2(jj,3)/iiii>1
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
try
    set(handles.sliderframes, 'Value',1, 'Maximum',numFiles, 'Minimum',1);
end
try
    handles.sliderframes.setEnabled(true);  % Java JSlider
    
catch
    set(handles.sliderframes, 'Enable','on', 'SliderStep',[1/numFiles, 0.1]);  % Matlab scrollbar
    
end
set(handles.Raw_listbox,  'value',1, 'Enable','on');


guidata(hObject, handles);
set(handles.active_panel1,'visible','on');set(handles.Raw_listbox,'visible','on')
Raw_listbox_Callback(hObject, eventdata, handles)
axis tight

track_what_Callback(hObject, eventdata, handles)
%  mem=memory;
%  [temp_Threshold,centy1,full_filename ]= read_image2(handles,1,1,'By mean', char(handles.data_file(1).cdata(1,1)),handles.data_file)   ;
%  imfo=imfinfo(full_filename);
% if mem.MaxPossibleArrayBytes> imfo.FileSize*numFiles
%     set(handles.end_export,'string',num2str(numFiles))
%   pushbutton16_Callback(hObject, eventdata, handles)
% else
%       h = msgbox('Not enough RAM Memory to load all stack','Aborted');
% end


% --------------------------------------------------------------------
function Save_Experiment_Callback(hObject, eventdata, handles)

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



% --------------------------------------------------------------------
function Untitled_28_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function axes1_ButtonDownFcn(hObject, eventdata, handles)
segmentation_type=get(handles.segmentation_type,'value');

sel_typ = get(gcbf,'SelectionType')
if strcmp(sel_typ,'extend')==1
    track_what=get(handles.track_what,'Value') ;
    n= get(handles.Raw_listbox,'value');
    point1 = get(hObject,'CurrentPoint')  ;
    % ========================
    % ========================
    if get(handles.MODE,'value')==1
        box_Raw=get(handles.Raw_listbox,'string')   ;
        n=round(get(handles.Raw_listbox,'Value'));
        track_what=get(handles.track_what,'Value') ;
        filename_Raw=char(box_Raw(n))  ;
        moving_avg_value=str2double(get(handles.MA_value,'String'))   ;
        [temp,centy1]=Moving_Average(moving_avg_value,n,length(box_Raw),handles);
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
        guidata(hObject,handles);
        set(handles.Div_frame_index,'Value',1)
        set(handles.Div_frame_index,'Max',1)
        set(handles.Div_frame_index,'String',[])
        
        N=1;  div_cells=[];
        if   findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')==1
            for ii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
                if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata)~=1
                    vec_centy = handles.data_file(4).cdata.Centroids(track_what).cdata(ii).cdata(:,3) -ii ;
                    vec_centy= (round(vec_centy*10))/10
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
        show_frame(hObject, eventdata, handles,n)   ;
        return
    end
    % ========================
    % ========================
    if get(handles.MODE,'value')==2
        box_Raw=get(handles.Raw_listbox,'string')   ;
        n=round(get(handles.Raw_listbox,'Value'));
        track_what=get(handles.track_what,'Value') ;
        filename_Raw=char(box_Raw(n))  ;
        moving_avg_value=str2double(get(handles.MA_value,'String'))   ;
        [temp,centy1]=Moving_Average(moving_avg_value,n,length(box_Raw),handles);
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
                        centy1(XY_min_index,3)=centy1(XY_min_index,3)+0.1;
                    else
                        centy1(XY_min_index,3)=round(centy1(XY_min_index,3));
                    end
                    handles.data_file(4).cdata.Centroids(track_what).cdata(n).cdata=centy1 ;
                    guidata(hObject,handles);
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
                    vec_centy= (round(vec_centy*10))/10
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
        show_frame(hObject, eventdata, handles,n)  ;
        return
    end
    % ========================
    % ========================
    
    if get(handles.MODE,'value')==3
        
        
        track_what=get(handles.track_what,'Value') ;
        MATRIX=handles.data_file(5).cdata.Tracks(track_what ).cdata   ;
        if isempty(MATRIX)==1
            return
        end
        stat=0;
        point1 = get(hObject,'CurrentPoint')  ;
        fig = gcf;
        sel_typ = get(gcbf,'SelectionType')
        n= get(handles.Raw_listbox,'value');
        [temp,centy1] = read_image_visualization(handles,n,segmentation_type);
        if isempty(temp)==1
            'cant find the image'
            return; end;
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
        
        
        
        
        [Tracking_options,new_cell_num]=Tracking_option_GUI(closest_track);
        %  =====================
        switch  Tracking_options
            case 1  %      Use an exist  track path, and put the current point as its 'n' track point
                cell_index=2*new_cell_num; % location of new cell num chosen by the user in MATRIX
                MATRIX(n,   cell_index-1)=centy1(XY_min_index,1);
                MATRIX(n,   cell_index)=centy1(XY_min_index,2);
            case 2   %  Create new cell track, and put the current point as its first track point
                for  last_cell=2:2: size(MATRIX,2)
                    X=MATRIX(:,last_cell) ;
                    X=X(X~=0)
                    if isempty(X)==1
                        break
                    end
                end
                
                frame_index=n;
                for ii=2:2:(last_cell-2)  %find the place where to put the new track (ii)
                    X=MATRIX(:,ii-1) ;
                    X2=X;
                    X=X(X~=0)
                    start_X=find(ismember(X2,X(1))) ; start_X=start_X(1);
                    if frame_index<start_X
                        break
                    end
                end
                cell_index=ii/2 ;
                MATRIX_out=zeros(size(MATRIX,1),size(MATRIX,2)+2);
                MATRIX_out(:,1:(cell_index*2-2))=MATRIX(:,1:(cell_index*2-2));
                MATRIX_out( n,cell_index*2-1:cell_index*2)=centy1(XY_min_index,1:2)
                MATRIX_out(:,cell_index*2+1:end)=MATRIX(:,cell_index*2-1:end);
                MATRIX=MATRIX_out;
            case 3 % Delete this point
                cell_index=2*new_cell_num; % location of new cell num chosen by the user in MATRIX
                MATRIX(n,   cell_index-1)=0 ;
                MATRIX(n,   cell_index)=0;
            case 4 % Delete all the next track points from image 'n' further
                MATRIX(n:end, new_cell_num*2-1:new_cell_num*2)=0;
            case 5 % Delete path  ('input ')
                MATRIX(:, new_cell_num*2-1:new_cell_num*2)=[];
            case 6% If two cells flipped-Transform track path ('input 1')  to track path ('input 2') from images 'n'
                track_what=get(handles.track_what,'Value') ;
                prompt = {'Please input first cell-track:','Please input second cell-track:'};
                dlg_title = 'Merging..';
                num_lines = 1;
                def = {num2str(new_cell_num),''};
                answer  = inputdlg(prompt,dlg_title,num_lines,def);
                answer=str2double(answer);
                answer_2    = answer(1);
                answer_1    = answer(2);
                backup_vec=MATRIX(n, answer_1*2-1:answer_1*2);
                MATRIX(n, answer_1*2-1:answer_1*2)=MATRIX(n, answer_2*2-1:answer_2*2);
                MATRIX(n, answer_2*2-1:answer_2*2)= backup_vec;
            case 7
                track_what=get(handles.track_what,'Value') ;
                prompt = {'Please input first cell-track:','Please input second cell-track:'};
                dlg_title = 'Merging..';
                num_lines = 1;
                def = {num2str(new_cell_num),''};
                answer  = inputdlg(prompt,dlg_title,num_lines,def);
                answer=str2double(answer);
                answer_2    = answer(1);
                answer_1    = answer(2);
                backup_track=MATRIX(n:end, answer_1*2-1:answer_1*2);
                MATRIX(n:end, answer_1*2-1:answer_1*2)=MATRIX(n:end, answer_2*2-1:answer_2*2);
                MATRIX(n:end, answer_2*2-1:answer_2*2)=backup_track;
            case 8 % merge trajectories
                track_what=get(handles.track_what,'Value') ;
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
        end
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
                handles.C=distinguishable_colors_TACWrapper(size(MATRIX,2),'k');
                handles.data_file(5).cdata.Tracks(track_what ).cdata=MATRIX;
                guidata(hObject,handles)
            end
            nn=1;div_cells=[];
            last_cell =get_last_cell_index(MATRIX);
            for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2)
                if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1
                    centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;   % . Find the mark in centroids
                    for jj=1:size(centy2,1)  % .
                        if centy2(jj,3)/iiii>1
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
        
        
        
        
        
        
        
        
        
        
        
        
        show_frame(hObject, eventdata, handles,n)  ;
        % ****************************************************************8
    end
    % ========================
    if get(handles.MODE,'value')==4
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
            show_frame(hObject, eventdata, handles,Frame_index)  ;
        end
    end
    
    
    
end
% =======================
% =======================
if strcmp(sel_typ,'alt')==1
    segmentation_type=get(handles.segmentation_type,'Value') ;
    point1 = get(hObject,'CurrentPoint')  ;
    fig = gcf;
    box_Raw=get(handles.Raw_listbox,'string') ;
    if iscell(box_Raw)==0
        Y=wavread('Error');
        h = errordlg('No files in Raw Frame listbox','Error');
        return
    end
    n=round(get(handles.Raw_listbox,'Value'));
    if n>1
        set(handles.Raw_listbox,'value',n-1);      set(handles.sliderframes, 'Minimum',1, 'Maximum',size(box_Raw,1), 'Value',n-1);        set(handles.showcurrentframe,'String',num2str(n-1));
        
        show_frame(hObject, eventdata, handles,n-1)  ;
        
    end
    
end
% ========================
if strcmp(sel_typ,'normal')==1
    segmentation_type=get(handles.segmentation_type,'Value') ;
    point1 = get(hObject,'CurrentPoint')  ;
    fig = gcf;
    box_Raw=get(handles.Raw_listbox,'string') ;
    if iscell(box_Raw)==0
        Y=wavread('Error');
        h = errordlg('No files in Raw Frame listbox','Error');
        return
    end
    n=round(get(handles.Raw_listbox,'Value')) ;
    if n<size(box_Raw,1)
        set(handles.Raw_listbox,'value',n+1);      set(handles.sliderframes, 'Minimum',1, 'Maximum',size(box_Raw,1), 'Value',n+1);        set(handles.showcurrentframe,'String',num2str(n+1));
        show_frame(hObject, eventdata, handles,n+1)  ;
        
    end
end
% ---------------------------------------------------------------
function select_mode_threshold_Callback(hObject, eventdata, handles)
select_mode_threshold=get(hObject,'Value');
if select_mode_threshold==3
    Raw_listbox=get(handles.Raw_listbox,'string')  ;
    n=get(handles.Raw_listbox,'Value') ;
    if isempty(n)==1
        n=1;
    end
    if isempty(  Raw_listbox)==1
        return
    end
    
    set(handles.start_threshold_at,'String',num2str(n));
    set(handles.end_threshold_at,'String',num2str(size(Raw_listbox,1)));
    
    
    set(handles.start_threshold_at,'Visible','on');
    set(handles.end_threshold_at,'Visible','on');
else
    set(handles.start_threshold_at,'Visible','off')
    set(handles.end_threshold_at,'Visible','off')
end

% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
close
Z_projector


% --------------------------------------------------------------------
function [XY_data]= Find_Centroids(hObject, eventdata, handles,track_what)
box_Raw=get(handles.Raw_listbox,'string') ;
pathname_Raw=handles.data_file(2).cdata(track_what,1) ;
pathname_Threshold=handles.data_file(2).cdata(track_what,3) ;


n=size(box_Raw,1) ;
for ii=1:n %2 Procced only if the complimantory thresholded file was found
    filename_Threshold=box_Raw(ii)  ;
    full_filename_Threshold=strcat(pathname_Threshold,    filename_Threshold,'_ch0',num2str(track_what-1),'_Threshold.tif');
    
    full_filename_Threshold=char(full_filename_Threshold) ;
    a=dir(full_filename_Threshold);
    if size(a,1)==0
        error_text=strcat(full_filename_Threshold ,' could not been found. Input have to be both Raw and Thresholded images');
        h = msgbox(error_text ,'Aborted');
        set(handles.Raw_listbox,'value',1) ;
        set(handles.Raw_listbox,'string','Images list') ;
        return;
    end
end




%3. once data waas loaded, Centroids are calulated-
% execute when button track cells is performed. Basically generate list of
% trajectoroes of cells from binarised fluorescence images
h=timebar('Find centroids. Please wait....');
set(h,'color','w');

for ii=1:n %2 Procced only if the complimantory thresholded file was found
    centy1=[];
    timebar(h,ii/n)
    filename_Threshold=box_Raw(ii) ;
    full_filename_Threshold=strcat(pathname_Threshold,    filename_Threshold,'_ch0',num2str(track_what-1),'_Threshold.tif');
    
    full_filename_Threshold=char(full_filename_Threshold) ;
    temp_Threshold=imread( full_filename_Threshold,1);
    temp_Threshold=flipdim(temp_Threshold,1);
    L=bwlabel(temp_Threshold,4);
    stats=regionprops(L,'Centroid') ;
    for jj=1:length(stats)
        temp_centy=[stats(jj).Centroid ii] ;
        temp_centy=  (round(temp_centy.*100))./100;
        centy1(jj,:)=  temp_centy;
    end
    %            if  isempty(centy1) ~=1
    
    XY_data(ii).cdata= centy1   ;
    clear centy1;
    %            end
    pause(0.1);  %let the computer time to cool itself
end
close(h)
guidata(hObject,handles);
% =================================================================== --
function [XY_data]= Find_L(hObject, eventdata, handles,track_what)
box_Raw=get(handles.Raw_listbox,'string') ;
pathname_Raw=handles.data_file(2).cdata(track_what,1) ;
pathname_Threshold=handles.data_file(2).cdata(track_what,3) ;
Channel=1;
n=size(box_Raw,1) ;
h=timebar('Find  regionprops information. Please wait....');
set(h,'color','w');
for ii=1:n %2 Procced only if the complimantory thresholded file was found
    timebar(h,ii/n)
    filename_Threshold=box_Raw(ii) ;
    full_filename_Threshold= strcat(pathname_Threshold,filename_Threshold,'_ch0',num2str(track_what-1),'_Threshold.tif') ;
    full_filename_Threshold=char(full_filename_Threshold) ;
    temp_Threshold=imread( full_filename_Threshold,1);
    temp_Threshold=flipdim(temp_Threshold,1);
    temp_Threshold2=zeros(size(temp_Threshold));
    position= handles.data_file(6).cdata ;
    temp_Threshold2(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1))  =  temp_Threshold(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1));
    L=bwlabel(temp_Threshold2,4);
    XY_data(ii).cdata= regionprops(L,'Area','BoundingBox','Centroid','PixelList','Orientation','Eccentricity','Perimeter','Extent','Solidity','Majoraxislength','Minoraxislength','EquivDiameter');
    
    pause(0.1);  %let the computer time to cool itself
end
for ii=1:n
    for iii=1:size(XY_data(ii).cdata,1)
        XY_data(ii).cdata(iii).Centroid= round(XY_data(ii).cdata(iii).Centroid*100)/100;
    end
end
close(h)
guidata(hObject,handles);
% =========================
%   -------------------------------------------------------------
function popupmenu7_Callback(hObject, eventdata, handles)
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

function pushbutton10_Callback(hObject, eventdata, handles)
uiwait
% --------------------------------------------------------------------
function segmentation_type_Callback(hObject, eventdata, handles)
box_Raw=get(handles.Raw_listbox,'string')   ;  n=get(handles.Raw_listbox,'value')   ;
filename_Raw=char(box_Raw(n))  ;
track_what=get(handles.track_what,'Value') ;
segmentation_type=get(handles.segmentation_type,'Value');
[temp,centy1]=read_image(handles,n,segmentation_type);
if isempty(temp)==1
    'cant find the image'
    return; end;
pathname_Threshold=handles.data_file(2).cdata(track_what,3) ;
full_filename_Threshold= char(strcat(pathname_Threshold,filename_Raw,'_ch0',num2str(track_what-1),'_Threshold.tif')) ;
matrix=imread(full_filename_Threshold,1);
matrix=flipdim(matrix,1);
axes(handles.axes1)
cla
show_frame(hObject, eventdata, handles,n) ;



%   -----------------------------------------------------------------------





%-------------------------------------------------------------------------
function pushbutton31_Callback(hObject, eventdata, handles)


% ----------------------------------------------------------------------------------------------------------------
function [output]= Cell_data_function(vector,handles,jj,str,Quantify_by)
track_what=get(handles.track_what,'Value')  ;
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
%                               full_command=strcat('handles. data_file(4).cdata.L(',num2str(track_what) ,').cdata(ii+jj-1).cdata(vector(ii,3)).',str);
%                               output(kk,:)= eval(full_command) ; kk=kk+1;
%                           end
%               end

% -------------------------------------------------------------
function [MATRIX]= Find_Tracks(hObject, eventdata, handles,maxdisp,param,iii)
centy1 = handles.data_file(4).cdata.Centroids(iii).cdata ;

XYT=[]; jj=1;
for ii=1:size(centy1,2)
    if isempty(centy1(ii).cdata)~=1
        XYT(jj:jj+size(centy1(ii).cdata,1)-1,:)=centy1(ii).cdata ;
        jj=jj+size(centy1(ii).cdata,1);
    end
end
XYT(:,3)=round(XYT(:,3))    ;

param.quiet=0;
% perform multiple particle tracking using the list generated above
h=waitbar(0.5,'Tracking in Progress');
% save XYT XYT
% save maxdisp maxdisp
% save param param
tracks=track_crocker(XYT,maxdisp,param)  ;



for ii=1:max(tracks(:,4))
    temp_vec=tracks(:,4);
    vec_index=find(ismember(temp_vec,ii)) ; %index of cell start event.  min(vec_index) is the index when the cell apear
    temp_vec2= tracks(min(vec_index):max(vec_index),3); %frames where cell ii apear
    temp_vec3=diff(temp_vec2); % difference between each frame
    if max(temp_vec3)>1 % find steps larger than 1
        %        do
        %  Stop_here_frame=find(ismember( temp_vec3,max(temp_vec3)))+ min(temp_vec2) %frame where to stop
        Stop_here_index=find(ismember( temp_vec3,max(temp_vec3)))+ min(vec_index) %frame where to stop
        if length( Stop_here_index)==1
            tracks(Stop_here_index:end,4)=  tracks(Stop_here_index:end,4)+1;
        end
    end
end





%    tracks
%    pause
%    return
tracks2=zeros(1,4);
counter_ii=0;
counter_jj=0;
for ii=1:tracks(end,4) ;
    index=find(ismember(tracks(:,4),ii)) ;
    counter=tracks(max(index),3)-tracks(min(index),3);
    sizey=size(tracks2,1)+1;
    tracks2(sizey:sizey+counter,1:2)=0;
    tracks2(sizey:sizey+counter,3)=(tracks(min(index),3):tracks(max(index),3))'  ;
    tracks2(sizey:sizey+counter,4)=ii ;
end
tracks2(1,:)=[];

for iii=1:tracks2(end,4) ;
    index_tracks=find(ismember(tracks(:,4),iii)) ;    index_tracks2=find(ismember(tracks2(:,4),iii)) ;
    vec_tracks=(tracks(min( index_tracks):max( index_tracks),3))' ;
    vec_tracks2=tracks2(min( index_tracks2),3):tracks2(max( index_tracks2),3)  ;
    
    for ii=1:size(vec_tracks2,2)
        for jj=1:size(vec_tracks,2)
            if vec_tracks2(ii)==vec_tracks(jj)
                tracks2(ii+counter_ii,1:2)=tracks(jj+counter_jj,1:2) ;
            end
        end
    end
    counter_ii=counter_ii+length(vec_tracks2);
    counter_jj=counter_jj+length(vec_tracks);
end





MATRIX = [] ;
jj=1 ;
for ii=1:tracks2(end,4) ;
    index=find(ismember(tracks2(:,4),ii)) ;
    index_min=min(index) ;
    index_max=max(index) ;
    MATRIX( tracks2(index_min,3):tracks2(index_min,3)+ index_max- index_min  ,jj:jj+1) =tracks2(index_min:index_max,1:2) ;
    jj=jj+2 ;
end
close(h)

% -------------------------------------------------------------------------

% --------------------------------------------------------------------
function [MATRIX_out]=break_track(MATRIX_in,frame_index,cell_index,n,last_cell)

%      figure(1)
%      imagesc(MATRIX_in)
%
%      MATRIX_in
%
%      save   MATRIX_in   MATRIX_in
%      pause
%
%      save frame_index frame_index
%      save cell_index cell_index
%      save last_cell last_cell
%      save n n

MATRIX_out=zeros(size(MATRIX_in,1),size(MATRIX_in,2)+2);
%  -----
MATRIX_out(:,1:(cell_index*2-2))=MATRIX_in(:,1:(cell_index*2-2));%1
%  -----
MATRIX_out(1:frame_index, (cell_index*2-1):(cell_index*2)) = MATRIX_in(1:frame_index, (cell_index*2-1):(cell_index*2)) ;%2
%  -----


for ii=2:2:(last_cell-2+2*n)  %find the place where to put the new track (ii)
    X=MATRIX_in(:,ii-1)  ;
    X2=X  ;
    X=X(X~=0)
    start_X=find(ismember(X2,X(1))) ; start_X=start_X(1);
    if frame_index<start_X
        break
    end
end

MATRIX_out(:,cell_index*2+1:ii-2)=MATRIX_in(:,cell_index*2+1:ii-2);%3
%  -----

V=MATRIX_in(:,cell_index*2-1) ;
index_X=find(ismember(V,0));
V(index_X)=[]  ;
if isempty(index_X)==1
    start_X=0;
else
    start_X=length(index_X);
end
end_X=length(V)+start_X;


MATRIX_out((frame_index+1):end_X,  (ii-1):ii) = MATRIX_in((frame_index+1):end_X, (cell_index*2-1):(cell_index*2)); %4
MATRIX_out(:,(ii+1):end)=  MATRIX_in(:,(ii-1):end);%5
%  ------------------------------------------
function show_tracks_Callback(hObject, eventdata, handles)
Raw_listbox_Callback(hObject, eventdata, handles)
% -----------------------------------------
function edit_axes1_Callback(hObject, eventdata, handles)

n=get(handles.Raw_listbox,'value')

box_Raw=get(handles.Raw_listbox,'string');

filename=char(box_Raw(n));
track_what=get(handles.track_what,'Value');
moving_avg_value=str2double(get(handles.MA_value,'String'));
[temp,centy1] = Moving_Average(moving_avg_value,n,size(box_Raw,1),handles);
if isempty(temp)
    'cant find the image'
    return;
end

% scrsz = get(0,'ScreenSize')  ;
% scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
% scrsz(3)=scrsz(4) ;
framePos = getpixelposition(handles.axes1)
framePos(2)= framePos(2)*1.4;
framePos(4)=framePos(4)*0.925;
h=figure('color','w','units','pixels','position',  framePos,'numbertitle','off', 'name',char(filename),'colormap',handles.c) ;










hold on
imagesc(temp) ;

set(gca,'Ydir','normal',   'units','normalize', 'Position',[0 0 1 1])


%
% set(gcf,'colormap',handles.c);
set(gcf,'UserData',temp) ;
xlabel('X','FontSize',12,'Color',[0 0 0]);
ylabel('Y','FontSize',12,'Color',[0 0 0]);
set(gcf,'UserData',temp) ;
title(filename) ;
filename=char(filename);

h_axes1_imagesc = imagesc(temp);
set(h_axes1_imagesc, 'Hittest','Off');
%set(gcf,'colormap',handles.c);
xy_border=handles.data_file(6).cdata;
%rectangle('Position', xy_border,'LineWidth',5,'LineStyle','--','EdgeColor','m');
%axis tight; axis manual;
hold on
if findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')
    if get(handles.Show_boundingbox,'value')==1
        if isempty(centy1)~=1
            for ii=1:size(handles.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
                if  isempty(handles.data_file(4).cdata.L(track_what).cdata(n).cdata)~=1
                    XY= handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BoundingBox;
                    if XY(1)>xy_border(1) && XY(2)>xy_border(2) && (xy_border(1)+xy_border(3))>(XY(1)+XY(3)) && (xy_border(1)+xy_border(4))>(XY(2)+XY(4))
                        rectangle('Position', XY,'LineWidth',1  ,'EdgeColor','w'); %keep this one
                    end
                    
                end
            end
            %index_local=find(ismember(centy1(:,3),n+0.1));
            index_local = (centy1(:,3) == n+0.1);  % faster: use logical indexing
            h_axes2_plot=plot(centy1(index_local,1),centy1(index_local,2),'rx', 'MarkerSize',30, 'Hittest','Off');
        end
    end
    if findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
        if get(handles.show_tracks,'value')==1
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
                X2=MATRIX(:,xx(ii));  Y2=MATRIX(:,xxx(ii));
                X2=X2(X2>0); Y2=Y2(Y2>0);
                %vector =(1:length(X2)) / 5;
                if length(X2)~=length(Y2)
                    %Y=wavread('Error');
                    errordlg('X and Y must have the same length. Please check that the coordinates of both X and Y are valid!','Error');
                    return
                end
                %h_scatter=scatter(X2,Y2 , vector ,'filled'  ,'MarkerFaceColor' , handles.C(x(ii),:)    );   set(h_scatter, 'Hittest','Off');
                h_plot(ii) = plot(X2,Y2,'.-', 'color',handles.C(x(ii),:), 'Hittest','Off');
            end
            String = repmat({[STR '-']},sizee,1);
            if ~isempty(div_cells_Vec)
                String = strcat(String,div_cells_Vec);
            else
                String = strcat(String,arrayfun(@num2str,1:sizee,'un',0)');
            end
            text(X(X>0)-10, Y(X>0)+20, String(X>0), 'FontSize',10, 'Color','w');
        end
    end
end
axis tight; axis manual;     axis off





% --------------------------------------------------------------------
function Untitled_36_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% hObject    handle to Untitled_35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ==============================================
% ========     SEGMENTATION MODE  ===============
%+=============================================


%   ----------------------------
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)





% --- Executes during object creation, after setting all properties.
function min_var_for_consideration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_var_for_consideration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
point  = get(gcf,'CurrentPoint')    ;
xy1 =get(handles.TAC_Segmentation_Module, 'Position') ;
xy2 =get(handles.TAC_Cell_Tracking_Module, 'Position') ;
xy3 =get(handles.TAC_Measurments_Module, 'Position') ;
xy4 =get(handles.TAC_Robust_Module, 'Position') ;
xy5=get(handles.TAC_Analysis_Module, 'Position') ;
xy6=get(handles.TAC_Polarization_Module, 'Position') ;
if xy1(1)<point(1,1) && xy1(2)<point(1,2) && point(1,1)<(xy1(1)+xy1(3)) && point(1,2)<(xy1(2)+xy1(4))
    set(handles.TAC_Cell_Tracking_Module,'foregroundcolor','w')
    set(handles.TAC_Measurments_Module,'foregroundcolor','w')
    set(handles.TAC_Robust_Module,'foregroundcolor','c')
    set(handles.TAC_Analysis_Module,'foregroundcolor','c')
    set(handles.TAC_Cell_Tracking_Module2,'foregroundcolor','k')
    set(handles.TAC_Measurments_Module2,'foregroundcolor','k')
    set(handles.TAC_Robust_Module2,'foregroundcolor','k')
    set(handles.TAC_Analysis_Module2,'foregroundcolor','k')
    set(handles.TAC_Polarization_Module,'foregroundcolor','c')
    set(handles.TAC_Polarization_Module2,'foregroundcolor','k')
    set(gcf,'Pointer','hand')
    set(handles.TAC_Segmentation_Module,'foregroundcolor','y');  set(handles.TAC_Segmentation_Module2,'foregroundcolor','y');
elseif xy2(1)<point(1,1) && xy2(2)<point(1,2) && point(1,1)<(xy2(1)+xy2(3)) && point(1,2)<(xy2(2)+xy2(4))
    set(handles.TAC_Segmentation_Module,'foregroundcolor','w')
    set(handles.TAC_Measurments_Module,'foregroundcolor','w')
    set(handles.TAC_Robust_Module,'foregroundcolor','c')
    set(handles.TAC_Analysis_Module,'foregroundcolor','c')
    set(handles.TAC_Segmentation_Module2,'foregroundcolor','k')
    set(handles.TAC_Measurments_Module2,'foregroundcolor','k')
    set(handles.TAC_Robust_Module2,'foregroundcolor','k')
    set(handles.TAC_Analysis_Module2,'foregroundcolor','k')
    set(handles.TAC_Polarization_Module,'foregroundcolor','c')
    set(handles.TAC_Polarization_Module2,'foregroundcolor','k')
    set(gcf,'Pointer','hand')
    set(handles.TAC_Cell_Tracking_Module,'foregroundcolor','y');  set(handles.TAC_Cell_Tracking_Module2,'foregroundcolor','y')
elseif xy3(1)<point(1,1) && xy3(2)<point(1,2) && point(1,1)<(xy3(1)+xy3(3)) && point(1,2)<(xy3(2)+xy3(4))
    set(handles.TAC_Cell_Tracking_Module,'foregroundcolor','w')
    set(handles.TAC_Segmentation_Module,'foregroundcolor','w')
    set(handles.TAC_Robust_Module,'foregroundcolor','c')
    set(handles.TAC_Analysis_Module,'foregroundcolor','c')
    set(handles.TAC_Cell_Tracking_Module2,'foregroundcolor','k')
    set(handles.TAC_Segmentation_Module2,'foregroundcolor','k')
    set(handles.TAC_Robust_Module2,'foregroundcolor','k')
    set(handles.TAC_Analysis_Module2,'foregroundcolor','k')
    set(handles.TAC_Polarization_Module,'foregroundcolor','c')
    set(handles.TAC_Polarization_Module2,'foregroundcolor','k')
    set(gcf,'Pointer','hand')
    set(handles.TAC_Measurments_Module,'foregroundcolor','y'); set(handles.TAC_Measurments_Module2,'foregroundcolor','y')
elseif xy4(1)<point(1,1) && xy4(2)<point(1,2) && point(1,1)<(xy4(1)+xy4(3)) && point(1,2)<(xy4(2)+xy4(4))
    
    set(handles.TAC_Cell_Tracking_Module,'foregroundcolor','w')
    set(handles.TAC_Measurments_Module,'foregroundcolor','w')
    set(handles.TAC_Segmentation_Module,'foregroundcolor','w')
    set(handles.TAC_Analysis_Module,'foregroundcolor','c')
    set(handles.TAC_Cell_Tracking_Module2,'foregroundcolor','k')
    set(handles.TAC_Measurments_Module2,'foregroundcolor','k')
    set(handles.TAC_Segmentation_Module2,'foregroundcolor','k')
    set(handles.TAC_Analysis_Module2,'foregroundcolor','k')
    set(handles.TAC_Polarization_Module,'foregroundcolor','c')
    set(handles.TAC_Polarization_Module2,'foregroundcolor','k')
    set(gcf,'Pointer','hand')
    set(handles.TAC_Robust_Module,'foregroundcolor','y');  set(handles.TAC_Robust_Module2,'foregroundcolor','y')
elseif xy5(1)<point(1,1) && xy5(2)<point(1,2) && point(1,1)<(xy5(1)+xy5(3)) && point(1,2)<(xy5(2)+xy5(4))
    set(handles.TAC_Cell_Tracking_Module,'foregroundcolor','w')
    set(handles.TAC_Measurments_Module,'foregroundcolor','w')
    set(handles.TAC_Robust_Module,'foregroundcolor','c')
    set(handles.TAC_Segmentation_Module,'foregroundcolor','w')
    set(handles.TAC_Cell_Tracking_Module2,'foregroundcolor','k')
    set(handles.TAC_Measurments_Module2,'foregroundcolor','k')
    set(handles.TAC_Robust_Module2,'foregroundcolor','k')
    set(handles.TAC_Segmentation_Module2,'foregroundcolor','k')
    set(handles.TAC_Polarization_Module,'foregroundcolor','c')
    set(handles.TAC_Polarization_Module2,'foregroundcolor','k')
    set(gcf,'Pointer','hand')
    set(handles.TAC_Analysis_Module,'foregroundcolor','y');  set(handles.TAC_Analysis_Module2,'foregroundcolor','y')
elseif xy6(1)<point(1,1) && xy6(2)<point(1,2) && point(1,1)<(xy6(1)+xy6(3)) && point(1,2)<(xy6(2)+xy6(4))
    set(handles.TAC_Cell_Tracking_Module,'foregroundcolor','w')
    set(handles.TAC_Measurments_Module,'foregroundcolor','w')
    set(handles.TAC_Robust_Module,'foregroundcolor','c')
    set(handles.TAC_Segmentation_Module,'foregroundcolor','w')
    set(handles.TAC_Cell_Tracking_Module2,'foregroundcolor','k')
    set(handles.TAC_Measurments_Module2,'foregroundcolor','k')
    set(handles.TAC_Robust_Module2,'foregroundcolor','k')
    set(handles.TAC_Segmentation_Module2,'foregroundcolor','k')
    set(handles.TAC_Analysis_Module,'foregroundcolor','c')
    set(handles.TAC_Analysis_Module2,'foregroundcolor','k')
    set(gcf,'Pointer','hand')
    set(handles.TAC_Polarization_Module,'foregroundcolor','y');  set(handles.TAC_Polarization_Module2,'foregroundcolor','y')
else
    set(gcf,'Pointer','arrow')
    set(handles.TAC_Segmentation_Module,'foregroundcolor','w')
    set(handles.TAC_Cell_Tracking_Module,'foregroundcolor','w')
    set(handles.TAC_Measurments_Module,'foregroundcolor','w')
    set(handles.TAC_Robust_Module,'foregroundcolor','c')
    set(handles.TAC_Analysis_Module,'foregroundcolor','c')
    set(handles.TAC_Segmentation_Module2,'foregroundcolor','k')
    set(handles.TAC_Cell_Tracking_Module2,'foregroundcolor','k')
    set(handles.TAC_Measurments_Module2,'foregroundcolor','k')
    set(handles.TAC_Robust_Module2,'foregroundcolor','k')
    set(handles.TAC_Analysis_Module2,'foregroundcolor','k')
    set(handles.TAC_Polarization_Module,'foregroundcolor','c')
    set(handles.TAC_Polarization_Module2,'foregroundcolor','k')
end
function edit_axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)






% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

run('Change_path') ;
function vector1_Callback(hObject, eventdata, handles)
% hObject    handle to vector1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns vector1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from vector1


% --- Executes during object creation, after setting all properties.
function vector1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vector1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function zoom_in(handles, index,point1)
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
function zoom_out(handles, index,point1)
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
function sliderframes2_Callback(hObject, eventdata, handles)




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
    % show_frame(hObject, eventdata, handles,n);
catch
    % never mind
    a=1;  %debug point
end
setappdata(hObject,'inCallback',[]);




%
% n=get(hObject,'value')
% set(handles.Projected_by,'value',round(n),'min',1,'max',10)
%   Projected_by_Callback(hObject, eventdata, handles)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderframes2_CreateFcn(hObject, eventdata, handles)
hListener = handle.listener(hObject,'ActionEvent',{@sliderframes2_Callback,handles});
setappdata(hObject,'listener__',hListener);


% --- Executes on button press in Show_maximum_pixel.
function Show_maximum_pixel_Callback(hObject, eventdata, handles)
% hObject    handle to Show_maximum_pixel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Show_maximum_pixel
Raw_listbox_Callback(hObject, eventdata, handles)

% --- Executes on button press in Show_proximity_vector.
function Show_proximity_vector_Callback(hObject, eventdata, handles)
% hObject    handle to Show_proximity_vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Show_proximity_vector
Raw_listbox_Callback(hObject, eventdata, handles)







% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
track_what=get(handles.track_what,'value');
set(hObject,'Value',0)
h=waitbar(0,'reading stack file to memory ....');
speaker('reading stack file to memory ....');
set(h,'color','w');
segmentation_type=get(handles.segmentation_type,'Value')  ;
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

speaker(' stack was loaded to memory ....');




% --------------------------------------------------------------------
function uitoggletool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



axes(handles.axes1)

%           rectangle('Position',[handles.Y1 handles.X1 handles.Y handles.X],'LineWidth',3,'LineStyle','-','EdgeColor','m');
h = imrect(gca, [handles.Y1 handles.X1 handles.Y handles.X]);


%  api = iptgetapi(h);
% %     fcn = makeConstrainToRectFcn('impoint',get(gca,'XLim'),get(gca,'YLim'));
%     api.setPositionConstraintFcn(fcn);
%



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
% fig = gcf;






segmentation_type=get(handles.segmentation_type,'Value') ;
box_Raw=get(handles.Raw_listbox,'string') ;
if iscell(box_Raw)==0
    Y=wavread('Error');
    h = errordlg('No files in Raw Frame listbox','Error');
    return
end
n=round(get(handles.Raw_listbox,'Value')) ;


show_frame(hObject, eventdata, handles,n)  ;









function uipushtool1_ClickedCallback(hObject, eventdata, handles)
Open_Experiment_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
Save_Experiment_Callback(hObject, eventdata, handles)




% --------------------------------------------------------------------
function uitoggletool6_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

framePos = getpixelposition(handles.axes1)
n=get(handles.Raw_listbox,'value');
box_Raw=get(handles.Raw_listbox,'string');
filename=box_Raw(n);
h=figure('color','w','units','pixels','position',  framePos,'numbertitle','off', 'name',char(filename),'colormap',handles.c) ;
moving_avg_value=str2double(get(handles.MA_value,'String'));


track_what=get(handles.track_what,'value')

div_cells=[];
if get(handles.virtual_stack_mode,'value')~=1
    [temp,centy1] = Moving_Average(moving_avg_value,n,size(box_Raw,1),handles);
else
    temp= handles.stack(n).cdata;
    if isempty(temp)==1;
        [ 'Stack does not contain frame  ' num2str(n) '. Please load this frame to stack and try again!']
        return; end;
end




if isempty(temp)
    'cant find the image'
    return;
end

h_axes1_imagesc = imagesc(temp, 'Hittest','Off');


hold on

set(h,'userdata',temp)
set(gca,'Ydir','reverse',   'units','normalize', 'Position',[0 0 1 1])


%
% set(gcf,'colormap',handles.c);

xlabel('X','FontSize',12,'Color',[0 0 0]);
ylabel('Y','FontSize',12,'Color',[0 0 0]);
set(gcf,'UserData',temp) ;
title(filename) ;
filename=char(filename);




%%%%%%%%

% set(h_axes1_imagesc, 'Hittest','Off');
%set(gcf,'colormap',handles.c);
xy_border=handles.data_file(6).cdata;
%rectangle('Position', xy_border,'LineWidth',5,'LineStyle','--','EdgeColor','m');
%axis tight; axis manual;


if findstr(char(handles.data_file(7).cdata(track_what,2)),'Y')
    if get(handles.Show_boundingbox,'value')==1
        if isempty(centy1)~=1
            for ii=1:size(handles.data_file(4).cdata.L(track_what).cdata(n).cdata,1)
                if  isempty(handles.data_file(4).cdata.L(track_what).cdata(n).cdata)~=1
                    XY= handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BoundingBox;
                    if XY(1)>xy_border(1) && XY(2)>xy_border(2) && (xy_border(1)+xy_border(3))>(XY(1)+XY(3)) && (xy_border(1)+xy_border(4))>(XY(2)+XY(4))
                        rectangle('Position', XY,'LineWidth',1  ,'EdgeColor','w', 'Hittest','Off'); %keep this one
                        
                        
                        if get(handles.Show_maximum_pixel,'value')==1
                            vec1= round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_3)  ;
                            h_axes3_plot=plot(centy1(ii,1),centy1(ii,2),'m.',     'MarkerSize',20, 'Hittest','Off');
                            %                       h_axes4_plot=plot(vec1(:,1),vec1(:,2),'m.', 'MarkerSize',30, 'Hittest','Off');
                            centroid=round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Centroid) ;
                            vec1= round(handles.data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_3)  ;
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
            index_local = (centy1(:,3) == n+0.1);  % faster: use logical indexing
            h_axes2_plot=plot(centy1(index_local,1),centy1(index_local,2),'rx', 'Hittest','Off');
            
            
        end
    end
    
    
    if findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1
        if get(handles.show_tracks,'value')==1
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
                X2=MATRIX(:,xx(ii));  Y2=MATRIX(:,xxx(ii));
                X2=X2(X2>0); Y2=Y2(Y2>0);
                vector =(1:length(X2)) / 5;
                if length(X2)~=length(Y2)
                    %Y=wavread('Error');
                    errordlg('X and Y must have the same length. Please check that the coordinates of both X and Y are valid!','Error');
                    return
                end
                h_scatter=scatter(X2,Y2 , vector ,'filled'  ,'MarkerFaceColor' , handles.C(x(ii),:)    );   set(h_scatter, 'Hittest','Off');
                h_plot(ii) = plot(X2,Y2,'.-', 'color',handles.C(x(ii),:), 'Hittest','Off');
            end
            String = repmat({[STR '-']},sizee,1);
            if ~isempty(div_cells_Vec)
                String = strcat(String,div_cells_Vec);
            else
                String = strcat(String,arrayfun(@num2str,1:sizee,'un',0)');
            end
            text(X(X>0)-10, Y(X>0)+20, String(X>0), 'FontSize',10, 'Color','w');
        end
    end
    
    
    
    
    
    
    
    
    
end
axis tight; axis manual;






function start_threshold_at_Callback(hObject, eventdata, handles)
% hObject    handle to start_threshold_at (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of start_threshold_at as text
%        str2double(get(hObject,'String')) returns contents of start_threshold_at as a double



function end_threshold_at_Callback(hObject, eventdata, handles)







% --------------------------------------------------------------------
function Untitled_26_Callback(hObject, eventdata, handles)
uiwait(msg_box_1)
h = imrect;
position = wait(h)
handles.data_file(6).cdata=  [ceil(position(1)) ceil(position(2)) round(position(3))  round(position(4))]  ;
guidata(hObject,handles);
n=get(handles.Raw_listbox,'Value') ;
box_Raw=get(handles.Raw_listbox,'string') ;
filename=char(box_Raw(n)) ;
show_frame(hObject, eventdata, handles,n);



% --- Executes on button press in TAC_Segmentation_Module.
function TAC_Segmentation_Module_Callback(hObject, eventdata, handles)

if isempty(handles.data_file)~=1
    run('TAC_Segmentation_Module',handles.data_file) ;
else
    run('TAC_Segmentation_Module') ;
end

% --- Executes on button press in TAC_Measurments_Module.
function TAC_Measurments_Module_Callback(hObject, eventdata, handles)
% hObject    handle to TAC_Measurments_Module (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.data_file)~=1
    run('TAC_Measurments_Module',handles.data_file) ;
else
    run('TAC_Measurments_Module') ;
end
% --- Executes on button press in TAC_Analysis_Module.
function TAC_Analysis_Module_Callback(hObject, eventdata, handles)
% hObject    handle to TAC_Analysis_Module (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.data_file)~=1
    run('TAC_Analysis_Module',handles.data_file) ;
else
    run('TAC_Analysis_Module') ;
end
% --- Executes on button press in TAC_Robust_Module.
function TAC_Robust_Module_Callback(hObject, eventdata, handles)
% hObject    handle to TAC_Robust_Module (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.data_file)~=1
    run('TAC_Robust_Module',handles.data_file) ;
else
    run('TAC_Robust_Module') ;
end
% --- Executes on button press in TAC_Cell_Tracking_Module.
function TAC_Cell_Tracking_Module_Callback(hObject, eventdata, handles)
% hObject    handle to TAC_Cell_Tracking_Module (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.data_file)~=1
    run('TAC_Cell_Tracking_Module',handles.data_file) ;
else
    run('TAC_Cell_Tracking_Module') ;
end
% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('Experiment_Generator') ;


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

open('Acknowledgment.txt')


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(TACTICS)
exit


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in text30.
function text30_Callback(hObject, eventdata, handles)
% hObject    handle to text30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('Experiment_Generator') ;


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in TAC_Polarization_Module.
function TAC_Polarization_Module_Callback(hObject, eventdata, handles)
run('TAC_Polarization_Module') ;


% --- Executes when uipanel23 is resized.
function uipanel23_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



