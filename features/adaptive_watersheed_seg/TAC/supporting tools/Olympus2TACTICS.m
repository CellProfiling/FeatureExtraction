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
function varargout = Olympus2TACTICS(varargin)
% OLYMPUS2TACTICS M-file for Olympus2TACTICS.fig
%      OLYMPUS2TACTICS, by itself, creates a new OLYMPUS2TACTICS or raises the existing
%      singleton*.
%
%      H = OLYMPUS2TACTICS returns the handle to a new OLYMPUS2TACTICS or the handle to
%      the existing singleton*.
%
%      OLYMPUS2TACTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OLYMPUS2TACTICS.M with the given input arguments.
%
%      OLYMPUS2TACTICS('Property','Value',...) creates a new OLYMPUS2TACTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Olympus2TACTICS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Olympus2TACTICS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Olympus2TACTICS

% Last Modified by GUIDE v2.5 08-Sep-2012 06:07:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Olympus2TACTICS_OpeningFcn, ...
    'gui_OutputFcn',  @Olympus2TACTICS_OutputFcn, ...
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


% --- Executes just before Olympus2TACTICS is made visible.
function Olympus2TACTICS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Olympus2TACTICS (see VARARGIN)

% Choose default command line output for Olympus2TACTICS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Olympus2TACTICS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Olympus2TACTICS_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Raw_listbox.
function Raw_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to Raw_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Raw_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Raw_listbox


% --- Executes during object creation, after setting all properties.
function Raw_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Raw_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton9_Callback(hObject, eventdata, handles)

function pushbutton2_Callback(hObject, eventdata, handles)
n=get(handles.Raw_listbox,'Value') ;
box= cellstr(get(handles.Raw_listbox,'string'))


if (n==1 && n==size(box,1))
    new_box=[];
    set(handles.Raw_listbox,'string',new_box);
    return
end
if (n==1 &&  size(box,1)>1)
    for ii=1:(size(box,1)-1)
        new_box(ii)=box(ii+1);
    end
    new_box=char(new_box);
    set(handles.Raw_listbox,'string',new_box);
    return
end
if (n>1 &&  size(box,1)>1 && size(box,1)>n)
    for ii=1:(n-1)
        new_box(ii)=box(ii);
    end
    
    for ii=n:(size(box,1)-1)
        new_box(ii)=box(ii+1);
    end
    
    new_box=char(new_box);
    set(handles.Raw_listbox,'string',new_box);
    return
end
if (n==size(box,1) && n>1)
    for  ii=1:(n-1)
        new_box(ii)=box(ii);
    end
    set(handles.Raw_listbox,'Value',n-1);
    new_box=char(new_box);
    set(handles.Raw_listbox,'string',new_box);
    return
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
close
h=TACTICS;
drawnow;
j = get(h,'javaframe');
jfig = j.fFigureClient.getWindow; %undocumented
jfig.setAlwaysOnTop(0);%places window on top, 0 to disable
jfig.setMaximized(1); %maximizes the window, 0 to minimize

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)

Raw_listbox=get(handles.Raw_listbox,'String')
Add_to_Back=get(handles.edit1,'string')
if iscell(Raw_listbox)==0
    Raw_listbox=cellstr(Raw_listbox);
end
if isempty(Raw_listbox)==1
    return
end




n=length(Raw_listbox);
h=timebar('Please wait....');
set(h,'color','w');
for   ii=1:n
    timebar(h,ii/(n))
    pathname= char(Raw_listbox(ii));
    
    str=strcat(pathname,'\*.tif') ;
    dir_filename=dir(str) ;
    
    
    %  filename=  dir_filename.name
    for jj=1:size(dir_filename,1)
        file_name=char(cellstr(dir_filename(jj).name));
        save file_name file_name
        save pathname pathname
        return
        full_filename= char(strcat(pathname,'\',  file_name )  ) ;
        
        %              -------------------------------------------
        %                       channel=findstr(file_name,'_Ch0')
        %              if isempty(channel)==1
        %                   channel=findstr(file_name,'_ch0')
        %              end
        %              if  isempty(channel)==1
        %                           Y=wavread('Error');
        %                            h = errordlg('channel is empty','Error');
        %                            sound(Y,22000);
        %                            return
        %              end
        %
        %
        
        %
        %
        
        % pos=findstr(file_name,'_Pos');
        %            if isempty(pos)==1
        %                pos=findstr(file_name,'_pos');
        %            end
        %                 if isempty(pos)==1
        %                pos=findstr(file_name,' pos');
        %            end
        %                    if isempty(pos)==1
        %                pos=findstr(file_name,' Pos');
        %            end
        %
        %           if  isempty(pos)==1
        %                            Y=wavread('Error');
        %                            h = errordlg('pos/Pos is empty','Error');
        %                            sound(Y,22000);
        %                            return
        %           end
        %              -------------------------------------------
        ch=findstr(file_name,'_Ch');
        if isempty(ch)==1
            ch=findstr(file_name,'_ch');
        end
        if isempty(ch)==1
            ch=findstr(file_name,' ch');
        end
        if isempty(ch)==1
            ch=findstr(file_name,' Ch');
        end
        
        if  isempty(ch)==1
            ch='00'
        else
            ch=ch(end);
            %and  to find the ch index fro here
        end
        %              -------------------------------------------
        t=findstr(file_name,'_T');
        if isempty(t)==1
            t=findstr(file_name,'_t');
        end
        t=t(end)
        
        %           if  isempty(t)==1
        %
        %           end
        %   %              -------------------------------------------
        %       Tif=findstr(file_name,'_Tif');
        temp_T=[]
        temp_t=file_name(t+2:end)
        for iii=1:length(temp_t)
            if  isempty(str2num(temp_t(iii)))==1
                break
            else
                temp_T(iii)=str2num(temp_t(iii))
            end
        end
        
        
        
        tt='000'
        if length(temp_T)==1
            tt(3)=num2str(temp_T)
        elseif length(temp_T)==2
            tt(2)=num2str(temp_T(1))
            tt(3)=num2str(temp_T(2))
        elseif length(temp_T)==3
            'keep it like that'
        end
        
        
        
        
        Backbone=file_name(1:t-1)
        
        %if backbone start with nuber add index before it
        
        if isempty(str2num(Backbone(1)))~=1
            new_name=char(strcat(pathname,'\',Add_to_Back,Backbone,'_t', tt,  '_ch',ch,'.tif')) ;
            
        else
            new_name=char(strcat(pathname,'\',Backbone,'_t', tt,  '_ch',ch,'.tif')) ;
        end
        
        movefile(file_name,new_name)
        
        
    end
    
    
    pause(2)
end




close(h)
% ====================================================
function pushbutton11_Callback(hObject, eventdata, handles)
close all
clc
% ====================================================


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
val=get(hObject,'value');
if val==1
    set(handles.popupmenu2, 'Visible','off')
elseif   val==2
    set(handles.popupmenu2, 'Visible','on')
end
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% -------------------------------------------------------------------------

function pushbutton6_Callback(hObject, eventdata, handles)

pathname = uigetdir(get(handles.temp_path,'String'));
if isequal(pathname,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
pathname =strcat(pathname,'\');
set(handles.temp_path,'String',pathname);
handles.select='folder';






dir_filename=dir(pathname);
%  filename=  dir_filename.name
jj=1;
for ii=1:size(dir_filename,1)
    if  length(dir_filename(ii).name)>2
        temp=cellstr(dir_filename(ii).name)   ;
        %               if  strfind(char(temp),'pos')~=1
        temp=char(strcat(pathname,temp)) ;
        if isdir(temp)==1
            filename_str(jj)= cellstr(temp);    jj=jj+1;
        end
        %               end
    end
end





filename_str=char(filename_str);
set(handles.Raw_listbox,'String',filename_str);
set(handles.Raw_listbox,'Max',size(dir_filename,1)) ;
set(handles.Raw_listbox,'Value',1) ;
set(handles.Raw_listbox,'Min',0);


handles.pathname=pathname;
guidata(hObject,handles);

% -----------------------------------------------------------------------

% --- Executes on button press in temp_path.
function temp_path_Callback(hObject, eventdata, handles)
current_dir=get(hObject,'String') ;
new_dir=uigetdir(current_dir,'Current Directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
