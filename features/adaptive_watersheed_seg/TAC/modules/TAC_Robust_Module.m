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
function varargout = TAC_Robust_Module(varargin)
% TAC_Robust_Module M-file for TAC_Robust_Module.fig
%      TAC_Robust_Module, by itself, creates a new TAC_Robust_Module or raises the existing
%      singleton*.
%
%      H = TAC_Robust_Module returns the handle to a new TAC_Robust_Module or the handle to
%      the existing singleton*.
%
%      TAC_Robust_Module('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TAC_Robust_Module.M with the given input arguments.
%
%      TAC_Robust_Module('Property','Value',...) creates a new TAC_Robust_Module or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TAC_Robust_Module_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TAC_Robust_Module_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TAC_Robust_Module

% Last Modified by GUIDE v2.5 05-Nov-2012 14:49:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TAC_Robust_Module_OpeningFcn, ...
    'gui_OutputFcn',  @TAC_Robust_Module_OutputFcn, ...
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


% --- Executes just before TAC_Robust_Module is made visible.
function TAC_Robust_Module_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;
handles.data_file  =[];
guidata(hObject, handles);


A= {
    'Not active'
    'TAC_Segmentation_Module'
    'TAC_Cell_Tracking_Module'
    'TAC_Measurments_Module'
    'TACTICS_U'
    'Tool for sub-section multiple positions'
    };

B= {
    'Ch_00'
    'Ch_01'
    'Ch_02'
    'Ch_03'
    'Ch_04'
    'Ch_05'
    'Ch_06'
    'Ch_07'
    'Ch_08'
    'Ch_09'
    'Ch_10'
    'Ch_11'
    'Ch_12'
    'Ch_13'
    'Ch_14'
    'Ch_15'
    'Ch_16'
    'Ch_17'
    'Ch_18'
    'Ch_19'
    'Ch_20'
    'Ch_21'
    'Ch_22'
    'Ch_23'
    'Ch_24'
    };


C= {
    'By max'
    'By mean'
    'z01'
    'z02'
    'z03'
    'z04'
    'z05'
    'z06'
    'z07'
    'z07'
    'z08'
    'z09'
    'z10'
    'z11'
    'z12'
    'z13'
    'z14'
    'z15'
    'z16'
    };

for iii=1:28
    eval(strcat('set(handles.Module_Option_',num2str(iii),',''String'',   A) '));
end

for iii=1:28
    eval(strcat('set(handles.Channel_',num2str(iii),',''String'',  B) '));
end
for iii=1:28
    eval(strcat('set(handles.Channel_',num2str(iii),'b',',''String'',  B) '));
end
for iii=1:28
    eval(strcat('set(handles.Section_',num2str(iii),',''String'',  C) '));
end

% --- Outputs from this function are returned to the command line.
function varargout = TAC_Robust_Module_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function temp_path_Callback(~, ~, ~)
% hObject    handle to temp_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_path as text
%        str2double(get(hObject,'String')) returns contents of temp_path as a double


% --- Executes during object creation, after setting all properties.
function temp_path_CreateFcn(hObject, ~, ~)
% hObject    handle to temp_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Raw_listbox.
function Raw_listbox_Callback(~, ~, ~)
% hObject    handle to Raw_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Raw_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Raw_listbox


% --- Executes during object creation, after setting all properties.
function Raw_listbox_CreateFcn(hObject, ~, ~)
% hObject    handle to Raw_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(~, ~, handles)
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


% ----------------------------
function pushbutton3_Callback(~, ~, handles)
Filter_list_option1=get(handles.Filter_list_option1,'Value');
Filter_list_option2=get(handles.Filter_list_option2,'Value');
filename_str= cellstr(get(handles.Raw_listbox,'string'))
filename_str=filename_str';   new_filename_str(1)={''};
jj=1;
for ii=1:size(filename_str,2)
    switch Filter_list_option1
        case 1%-  if filter C is on:
            switch Filter_list_option2
                case  1
                    'case 1'
                    if  isempty(strfind(char(filename_str(ii)),'TACTICS_EXP'))~=1
                        new_filename_str(jj)=filename_str(ii); jj=jj+1;
                    end
                case 2
                    'case 2'
                    if  isempty(strfind(char(filename_str(ii)),'TACTICS_EXP'))==1
                        new_filename_str(jj)=filename_str(ii); jj=jj+1;
                    end
            end
        case 2%-  if filter C is on:
            switch Filter_list_option2
                case  1
                    'case 1'
                    if  isempty(strfind(char(filename_str(ii)),'TACTICS_EXP_C'))~=1
                        new_filename_str(jj)=filename_str(ii); jj=jj+1;
                    end
                case 2
                    'case 2'
                    if  isempty(strfind(char(filename_str(ii)),'TACTICS_EXP_C'))==1
                        new_filename_str(jj)=filename_str(ii); jj=jj+1;
                    end
            end
        case 3%    if filter F is on:
            switch Filter_list_option2
                case  1
                    if  isempty(strfind(char(filename_str(ii)),'TACTICS_EXP_F'))~=1
                        new_filename_str(jj)=filename_str(ii); jj=jj+1;
                    end
                case 2
                    if  isempty(strfind(char(filename_str(ii)),'TACTICS_EXP_F'))==1
                        new_filename_str(jj)=filename_str(ii); jj=jj+1;
                    end
            end
            
        case 4%   if filter New is on:
            switch Filter_list_option2
                case  1
                    if  isempty(strfind(char(filename_str(ii)),'TACTICS_EXP_New'))~=1
                        new_filename_str(jj)=filename_str(ii); jj=jj+1;
                    end
                case 2
                    if  isempty(strfind(char(filename_str(ii)),'TACTICS_EXP_New'))==1
                        new_filename_str(jj)=filename_str(ii); jj=jj+1;
                    end
            end
            
            
        case 5
            edit_box=char(get(handles.edit_box,'string'))
            switch Filter_list_option2
                case  1
                    if  isempty(strfind(char(filename_str(ii)),edit_box))~=1
                        new_filename_str(jj)=filename_str(ii); jj=jj+1;
                    end
                case 2
                    if  isempty(strfind(char(filename_str(ii)),edit_box))==1
                        new_filename_str(jj)=filename_str(ii); jj=jj+1;
                    end
            end
            
    end
end

if isempty(new_filename_str)~=1
    new_filename_str=char(new_filename_str)
    set(handles.Raw_listbox,'String',new_filename_str);
    set(handles.Raw_listbox,'Max',  length(new_filename_str) );
    set(handles.Raw_listbox,'Value',1) ;
    set(handles.Raw_listbox,'Min',0);
else
    set(handles.Raw_listbox,'String','');
    set(handles.Raw_listbox,'Max',  1 );
    set(handles.Raw_listbox,'Value',1) ;
    set(handles.Raw_listbox,'Min',0);
end

% ------------------------------

% --- Executes on selection change in Filter_list_option1.
function Filter_list_option1_Callback(hObject, ~, handles)

if get(hObject,'Value')==5
    set(handles.edit_box,'Visible','on')
else
    set(handles.edit_box,'Visible','off')
end
%    ---------------------------------------------------------
function Load_File_Edit_Vis(handles,index)  %#ok<INUSL>

eval(strcat('set(handles.Load_File_Edit_',num2str(index),',''Visible'',''off'')'));
eval(strcat('set(handles.New_pathname_',num2str(index),',''Visible'',''off'')'));
eval(strcat('set(handles.Channel_',num2str(index),',''Visible'',''off'')'));
eval(strcat('set(handles.Channel_',num2str(index),'b,''Visible'',''off'')'));
eval(strcat('Module_Option=get(handles.Module_Option_',num2str(index),',''Value'');'));

if  Module_Option==2 ||  Module_Option==4 ||  Module_Option==5 ||  Module_Option==6
    eval(strcat('set(handles.Load_File_Edit_',num2str(index),',''Visible'',''on'')'));
end
if  Module_Option==4
    eval(strcat('set(handles.New_pathname_',num2str(index),',''Visible'',''on'')'));
    eval(strcat('set(handles.Section_',num2str(index),',''Visible'',''off'')'));
    eval(strcat('set(handles.Channel_',num2str(index),',''Visible'',''off'')'));
    eval(strcat('set(handles.Channel_',num2str(index),'b,''Visible'',''off'')'));
end
if  Module_Option==2 || Module_Option==3 ||   Module_Option==5
    eval(strcat('set(handles.Channel_',num2str(index),',''Visible'',''on'')'));
    eval(strcat('set(handles.Channel_',num2str(index),'b,''Visible'',''on'')'));
    eval(strcat('set(handles.Section_',num2str(index),',''Visible'',''on'')'));
end
if  Module_Option==3
    eval(strcat('set(handles.Channel_',num2str(index),'b,''Visible'',''off'')'));
end




%---------------------------------------------------

function Module_Option_1_CreateFcn(~, ~, ~)
function Module_Option_2_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,2);
function Module_Option_2_CreateFcn(~, ~, ~)
function Module_Option_3_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,3);
function Module_Option_3_CreateFcn(~, ~, ~)
function Module_Option_4_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,4);
function Module_Option_4_CreateFcn(~, ~, ~)
function Module_Option_5_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,5);
function Module_Option_5_CreateFcn(~, ~, ~)
function Module_Option_6_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,6);
function Module_Option_6_CreateFcn(~, ~, ~)
function Module_Option_7_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,7);
function Module_Option_7_CreateFcn(~, ~, ~)
function Module_Option_8_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,8);
function Module_Option_8_CreateFcn(~, ~, ~)
function Module_Option_9_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,9);
function Module_Option_9_CreateFcn(~, ~, ~)
function Module_Option_10_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,10);
function Module_Option_10_CreateFcn(~, ~, ~)
function Module_Option_11_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,11);
function Module_Option_11_CreateFcn(~, ~, ~)
function Module_Option_12_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,12);
function Module_Option_12_CreateFcn(~, ~, ~)
function Module_Option_13_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,13);
function Module_Option_13_CreateFcn(~, ~, ~)
function Module_Option_14_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,14);
function Module_Option_14_CreateFcn(~, ~, ~)
function Module_Option_15_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,15);
function Module_Option_15_CreateFcn(~, ~, ~)
function Module_Option_16_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,16);
function Module_Option_16_CreateFcn(~, ~, ~)
function Module_Option_17_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,17);
function Module_Option_17_CreateFcn(~, ~, ~)
function Module_Option_18_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,18);
function Module_Option_18_CreateFcn(~, ~, ~)
function Module_Option_19_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,19);
function Module_Option_19_CreateFcn(~, ~, ~)
function Module_Option_20_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,20);
function Module_Option_20_CreateFcn(~, ~, ~)
function Module_Option_21_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,21);
function Module_Option_21_CreateFcn(~, ~, ~)
function Module_Option_22_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,22);
function Module_Option_22_CreateFcn(~, ~, ~)
function Module_Option_23_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,23);
function Module_Option_23_CreateFcn(~, ~, ~)
function Module_Option_24_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,24);
function Module_Option_24_CreateFcn(~, ~, ~)
function Module_Option_25_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,25);
function Module_Option_25_CreateFcn(~, ~, ~)
function Module_Option_26_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,26);
function Module_Option_26_CreateFcn(~, ~, ~)
function Module_Option_27_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,27);
function Module_Option_27_CreateFcn(~, ~, ~)
function Module_Option_28_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,28);
function Module_Option_28_CreateFcn(~, ~, ~)

function Module_Option_1_Callback(~, ~, handles)
Load_File_Edit_Vis(handles,1);
function Filter_list_option1_CreateFcn(~, ~, ~)
function Filter_list_option2_Callback(~, ~, ~)
function Filter_list_option2_CreateFcn(~, ~, ~)
%  ------------------------------------------------------------------------
function Load_File_Edit_1_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_2_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_3_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_4_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_5_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_6_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_7_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_8_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_9_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_10_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_11_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_12_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_13_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_14_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_15_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_16_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_17_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_18_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_19_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_20_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_21_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_22_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_23_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_24_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_25_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_26_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_27_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;
function Load_File_Edit_28_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose setting file',    current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0)
    h = msgbox('User selected Cancel','Aborted');   return;
end
set(hObject,'String',char(strcat(pathname,filename))) ;


% --- Executes during object creation, after setting all properties.
function Load_File_Edit_1_CreateFcn(~, ~,~)
function Load_File_Edit_2_CreateFcn(~, ~,~)
function Load_File_Edit_3_CreateFcn(~, ~,~)
function Load_File_Edit_4_CreateFcn(~, ~,~)
function Load_File_Edit_5_CreateFcn(~, ~,~)
function Load_File_Edit_6_CreateFcn(~, ~,~)
function Load_File_Edit_7_CreateFcn(~, ~,~)
function Load_File_Edit_8_CreateFcn(~, ~,~)
function Load_File_Edit_9_CreateFcn(~, ~,~)
function Load_File_Edit_10_CreateFcn(~, ~,~)
function Load_File_Edit_11_CreateFcn(~, ~,~)
function Load_File_Edit_12_CreateFcn(~, ~,~)
function Load_File_Edit_13_CreateFcn(~, ~,~)
function Load_File_Edit_14_CreateFcn(~, ~,~)
function Load_File_Edit_15_CreateFcn(~, ~,~)
function Load_File_Edit_16_CreateFcn(~, ~,~)
function Load_File_Edit_17_CreateFcn(~, ~,~)
function Load_File_Edit_18_CreateFcn(~, ~,~)
function Load_File_Edit_19_CreateFcn(~, ~,~)
function Load_File_Edit_20_CreateFcn(~, ~,~)
function Load_File_Edit_21_CreateFcn(~, ~,~)
function Load_File_Edit_22_CreateFcn(~, ~,~)
function Load_File_Edit_23_CreateFcn(~, ~,~)
function Load_File_Edit_24_CreateFcn(~, ~,~)
function Load_File_Edit_25_CreateFcn(~, ~,~)
function Load_File_Edit_26_CreateFcn(~, ~,~)
function Load_File_Edit_27_CreateFcn(~, ~,~)
function Load_File_Edit_28_CreateFcn(~, ~,~)


function New_pathname_1_CreateFcn(~, ~,~)
function New_pathname_2_CreateFcn(~, ~,~)
function New_pathname_3_CreateFcn(~, ~,~)
function New_pathname_4_CreateFcn(~, ~,~)
function New_pathname_5_CreateFcn(~, ~,~)
function New_pathname_6_CreateFcn(~, ~,~)
function New_pathname_7_CreateFcn(~, ~,~)
function New_pathname_8_CreateFcn(~, ~,~)
function New_pathname_9_CreateFcn(~, ~,~)
function New_pathname_10_CreateFcn(~, ~,~)
function New_pathname_11_CreateFcn(~, ~,~)
function New_pathname_12_CreateFcn(~, ~,~)
function New_pathname_13_CreateFcn(~, ~,~)
function New_pathname_14_CreateFcn(~, ~,~)
function New_pathname_15_CreateFcn(~, ~,~)
function New_pathname_16_CreateFcn(~, ~,~)
function New_pathname_17_CreateFcn(~, ~,~)
function New_pathname_18_CreateFcn(~, ~,~)
function New_pathname_19_CreateFcn(~, ~,~)
function New_pathname_20_CreateFcn(~, ~,~)
function New_pathname_21_CreateFcn(~, ~,~)
function New_pathname_22_CreateFcn(~, ~,~)
function New_pathname_23_CreateFcn(~, ~,~)
function New_pathname_24_CreateFcn(~, ~,~)
function New_pathname_25_CreateFcn(~, ~,~)
function New_pathname_26_CreateFcn(~, ~,~)
function New_pathname_27_CreateFcn(~, ~,~)
function New_pathname_28_CreateFcn(~, ~,~)

function Channel_1_CreateFcn(~, ~,~)
function Channel_2_CreateFcn(~, ~,~)
function Channel_3_CreateFcn(~, ~,~)
function Channel_4_CreateFcn(~, ~,~)
function Channel_5_CreateFcn(~, ~,~)
function Channel_6_CreateFcn(~, ~,~)
function Channel_7_CreateFcn(~, ~,~)
function Channel_8_CreateFcn(~, ~,~)
function Channel_9_CreateFcn(~, ~,~)
function Channel_10_CreateFcn(~, ~,~)
function Channel_11_CreateFcn(~, ~,~)
function Channel_12_CreateFcn(~, ~,~)
function Channel_13_CreateFcn(~, ~,~)
function Channel_14_CreateFcn(~, ~,~)
function Channel_15_CreateFcn(~, ~,~)
function Channel_16_CreateFcn(~, ~,~)
function Channel_17_CreateFcn(~, ~,~)
function Channel_18_CreateFcn(~, ~,~)
function Channel_19_CreateFcn(~, ~,~)
function Channel_20_CreateFcn(~, ~,~)
function Channel_21_CreateFcn(~, ~,~)
function Channel_22_CreateFcn(~, ~,~)
function Channel_23_CreateFcn(~, ~,~)
function Channel_24_CreateFcn(~, ~,~)
function Channel_25_CreateFcn(~, ~,~)
function Channel_26_CreateFcn(~, ~,~)
function Channel_27_CreateFcn(~, ~,~)
function Channel_28_CreateFcn(~, ~,~)

function Channel_1_Callback(~, ~,~)
function Channel_2_Callback(~, ~,~)
function Channel_3_Callback(~, ~,~)
function Channel_4_Callback(~, ~,~)
function Channel_5_Callback(~, ~,~)
function Channel_6_Callback(~, ~,~)
function Channel_7_Callback(~, ~,~)
function Channel_8_Callback(~, ~,~)
function Channel_9_Callback(~, ~,~)
function Channel_10_Callback(~, ~,~)
function Channel_11_Callback(~, ~,~)
function Channel_12_Callback(~, ~,~)
function Channel_13_Callback(~, ~,~)
function Channel_14_Callback(~, ~,~)
function Channel_15_Callback(~, ~,~)
function Channel_16_Callback(~, ~,~)
function Channel_17_Callback(~, ~,~)
function Channel_18_Callback(~, ~,~)
function Channel_19_Callback(~, ~,~)
function Channel_20_Callback(~, ~,~)
function Channel_21_Callback(~, ~,~)
function Channel_22_Callback(~, ~,~)
function Channel_23_Callback(~, ~,~)
function Channel_24_Callback(~, ~,~)
function Channel_25_Callback(~, ~,~)
function Channel_26_Callback(~, ~,~)
function Channel_27_Callback(~, ~,~)
function Channel_28_Callback(~, ~,~)

% ----------------------------------------------------

function Channel_28b_Callback(~, ~,~)
function Channel_28b_CreateFcn(~, ~,~)
function Channel_27b_Callback(~, ~,~)
function Channel_27b_CreateFcn(~, ~,~)
function Channel_26b_Callback(~, ~,~)
function Channel_26b_CreateFcn(~, ~,~)
function Channel_25b_Callback(~, ~,~)
function Channel_25b_CreateFcn(~, ~,~)
function Channel_24b_Callback(~, ~,~)
function Channel_24b_CreateFcn(~, ~,~)
function Channel_23b_Callback(~, ~,~)
function Channel_23b_CreateFcn(~, ~,~)
function Channel_22b_Callback(~, ~,~)
function Channel_22b_CreateFcn(~, ~,~)
function Channel_21b_Callback(~, ~,~)
function Channel_21b_CreateFcn(~, ~,~)
function Channel_20b_Callback(~, ~,~)
function Channel_20b_CreateFcn(~, ~,~)
function Channel_19b_Callback(~, ~,~)
function Channel_19b_CreateFcn(~, ~,~)
function Channel_18b_Callback(~, ~,~)
function Channel_18b_CreateFcn(~, ~,~)
function Channel_17b_Callback(~, ~,~)
function Channel_17b_CreateFcn(~, ~,~)
function Channel_16b_Callback(~, ~,~)
function Channel_16b_CreateFcn(~, ~,~)
function Channel_15b_Callback(~, ~,~)
function Channel_15b_CreateFcn(~, ~,~)
function Channel_14b_Callback(~, ~,~)
function Channel_14b_CreateFcn(~, ~,~)
function Channel_13b_Callback(~, ~,~)
function Channel_13b_CreateFcn(~, ~,~)
function Channel_12b_Callback(~, ~,~)
function Channel_12b_CreateFcn(~, ~,~)
function Channel_11b_Callback(~, ~,~)
function Channel_11b_CreateFcn(~, ~,~)
function Channel_10b_Callback(~, ~,~)
function Channel_10b_CreateFcn(~, ~,~)
function Channel_9b_Callback(~, ~,~)
function Channel_9b_CreateFcn(~, ~,~)
function Channel_8b_Callback(~, ~,~)
function Channel_8b_CreateFcn(~, ~,~)
function Channel_7b_Callback(~, ~,~)
function Channel_7b_CreateFcn(~, ~,~)
function Channel_6b_Callback(~, ~,~)
function Channel_6b_CreateFcn(~, ~,~)
function Channel_5b_Callback(~, ~,~)
function Channel_5b_CreateFcn(~, ~,~)
function Channel_4b_Callback(~, ~,~)
function Channel_4b_CreateFcn(~, ~,~)
function Channel_3b_Callback(~, ~,~)
function Channel_3b_CreateFcn(~, ~,~)
function Channel_2b_Callback(~, ~,~)
function Channel_2b_CreateFcn(~, ~,~)
function Channel_1b_Callback(~, ~,~)
function Channel_1b_CreateFcn(~, ~,~)

% ----------------------------------------------------
function Steps_number_Callback(~, ~, handles)



set(handles.panel_3,'Visible','on');
set(handles.panel_4,'Visible','on'); set(handles.panel_4b,'Visible','on')
set(handles.panel_5,'Visible','on');
set(handles.panel_6,'Visible','on')
set(handles.panel_7,'Visible','on')


Steps_number=get(handles.Steps_number,'Value');
for ii=1:Steps_number
    eval(strcat('set(handles.Module_Option_',num2str(ii),',''Visible'',''on'')'))
    eval(strcat('set(handles.Channel_',num2str(ii),',''Visible'',''on'')'))
    eval(strcat('set(handles.Channel_',num2str(ii),'b,''Visible'',''on'')'))
    eval(strcat('set(handles. Load_File_Edit_',num2str(ii),',''Visible'',''on'')'))
    eval(strcat('set(handles.New_pathname_',num2str(ii),',''Visible'',''on'')'))
    
end

for ii=Steps_number+1:28
    eval(strcat('set(handles.Module_Option_',num2str(ii),',''Visible'',''off'')'))
    eval(strcat('set(handles.Channel_',num2str(ii),',''Visible'',''off'')'))
    eval(strcat('set(handles.Channel_',num2str(ii),'b,''Visible'',''off'')'))
    eval(strcat('set(handles. Load_File_Edit_',num2str(ii),',''Visible'',''off'')'))
    eval(strcat('set(handles.New_pathname_',num2str(ii),',''Visible'',''off'')'))
    eval(strcat('set(handles.Section_',num2str(ii),',''Visible'',''off'')'))
    eval(strcat('set(handles.Section_',num2str(ii),',''Visible'',''off'')'))
end



for ii=1:Steps_number
    Load_File_Edit_Vis(handles,ii)
end
function Steps_number_CreateFcn(~, ~, ~)
function New_pathname_1_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_2_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_3_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_4_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_5_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_6_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_7_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_8_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_9_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_10_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_11_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_12_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_13_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_14_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_15_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_16_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_17_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_18_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_19_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_20_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_21_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_22_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_23_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_24_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_25_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
function New_pathname_26_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;

function New_pathname_27_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;

function New_pathname_28_ButtonDownFcn(hObject, ~, handles)
current_dir=get(handles.temp_path,'String') ;
new_dir=uigetdir(current_dir,'Choose destination directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
set(hObject,'String',new_dir) ;
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over New_pathname_29.

% --------------------------------------------------------------------
function Save_Settings_Callback(~, ~, handles)

Steps_number=get(handles.Steps_number,'Value');
DATA(1).cdata=Steps_number;
for iii=1:Steps_number
    eval(strcat('Module_Option_DATA(',num2str(iii),').cdata=get(handles.Module_Option_',num2str(iii),',''Value'')'));
    eval(strcat('New_pathname_DATA(',num2str(iii),').cdata=get(handles.New_pathname_',num2str(iii),',''String'')'));
    eval(strcat(' Load_File_Edit_DATA(',num2str(iii),').cdata=get(handles. Load_File_Edit_',num2str(iii),',''String'')'));
    eval(strcat(' Channel_DATA(',num2str(iii),').cdata=get(handles.Channel_',num2str(iii),',''Value'')'));
    eval(strcat(' Channel_DATA_b(',num2str(iii),').cdata=get(handles.Channel_',num2str(iii),'b',',''Value'')'));
    eval(strcat(' Section(',num2str(iii),').cdata=get(handles.Section_',num2str(iii),',''Value'')'));
end

DATA(2).cdata=Module_Option_DATA;
DATA(3).cdata=New_pathname_DATA;
DATA(4).cdata=Load_File_Edit_DATA;
DATA(5).cdata=Channel_DATA;
DATA(6).cdata=Channel_DATA_b;
DATA(7).cdata=Section;
DATA(8).cdata=get(handles.Raw_listbox,'string');
[filename, pathname, filterindex] = uiputfile({  '*.dat','DAT-files (*.dat)';}, 'Save TAC_Robust_Module settings');
if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
regexprep(filename, 'TAC_Robust_Module_SETTINGS','')
full_filename= strcat(pathname,'TAC_Robust_Module_SETTINGS_',filename) ;
full_filename=char(full_filename);
save(full_filename, 'DATA') ;
% --------------------------------------------------------------------
function Load_Settings_Callback(hObject, ~, handles)
% hObject    handle to Load_Settings (see GCBO)
[filename, pathname, filterindex] = uigetfile({  '*.dat','DAT-files (*.dat)';}, 'Please Choose TAC_Robust_Module setting file')% handles.directory_name); %pick files to combine
if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
full_filename= strcat(pathname,filename);
full_filename=char(full_filename);
DATA=importdata(full_filename)  ;
Steps_number=DATA(1).cdata;
set(handles.Steps_number,'Value',Steps_number);
Steps_number_Callback(hObject, eventdata, handles)
Module_Option_DATA=DATA(2).cdata;
New_pathname_DATA=DATA(3).cdata;
Load_File_Edit_DATA=DATA(4).cdata;
Channel_DATA=DATA(5).cdata;
Channel_DATA_b=DATA(6).cdata;
Section=DATA(7).cdata  ;
for iii=1:Steps_number
    A= (New_pathname_DATA(iii).cdata);
    B= (Load_File_Edit_DATA(iii).cdata);
    
    eval(strcat('set(handles.Module_Option_',num2str(iii),',''Value'',Module_Option_DATA(',num2str(iii),').cdata)'));
    eval(strcat('set(handles.New_pathname_',num2str(iii),',''String'',   A) '));
    eval(strcat('set(handles.Load_File_Edit_',num2str(iii),',''String'',    B) '));
    eval(strcat('set(handles.Channel_',num2str(iii),',''Value'',Channel_DATA(',num2str(iii),').cdata)'));
    eval(strcat('set(handles.Channel_',num2str(iii),'b',',''Value'',Channel_DATA_b(',num2str(iii),').cdata)'));
    eval(strcat('set(handles.Section_',num2str(iii),',''Value'',Section(',num2str(iii),').cdata)'));
    Load_File_Edit_Vis(handles,iii);
end

set(handles.Raw_listbox,'string',DATA(8).cdata);
% --------------------------------------------------------------------
function Untitled_1_Callback(~, ~, handles)
'raz'
filename_str= cellstr(get(handles.Raw_listbox,'string'))  ;
filename_str=filename_str';
Steps_number=get(handles.Steps_number,'Value');
for iii=1:Steps_number
    eval(strcat('Module_Option(',num2str(iii),')=get(handles.Module_Option_',num2str(iii),',''Value'')'));
    eval(strcat('New_pathname(',num2str(iii),')={get(handles.New_pathname_',num2str(iii),',''String'')}'));
    eval(strcat(' Load_File_Edit(',num2str(iii),')={get(handles. Load_File_Edit_',num2str(iii),',''String'')}'));
    eval(strcat(' Channel(',num2str(iii),')=get(handles.Channel_',num2str(iii),',''Value'')'));
end

for ii=1:size(filename_str,2)
    %Manual correction for sometimes
    data_file=importdata(char( filename_str(ii))) ;
    data_file(9).cdata=8;
    save (char( filename_str(ii)) ,  'data_file')
    % char( filename_str(ii))
    %      data_file=importdata(char( filename_str(ii))) ;
    pause(20);
    %      for iii=1:Steps_number
    %            if Module_Option(iii) ==2
    %                   TAC_Segmentation_Module(data_file, filename_str(ii), Channel(iii),Load_File_Edit_char) ;
    %            end
    %                if Module_Option(iii) ==3
    %                   TAC_Cell_Tracking_Module(data_file, filename_str(ii), Channel(iii)) ;
    %                end
    %            if Module_Option(iii) ==4
    %                   TAC_Measurments_Module(data_file,filename_str(ii),    Load_File_Edit_char,char(New_pathname(iii))) ;
    %            end
    %      end
end


function Section_1_Callback(~, ~,~)
function Section_1_CreateFcn(~, ~,~)
function Section_2_Callback(~, ~,~)
function Section_2_CreateFcn(~, ~,~)
function Section_3_Callback(~, ~,~)
function Section_3_CreateFcn(~, ~,~)
function Section_4_Callback(~, ~,~)
function Section_4_CreateFcn(~, ~,~)
function Section_5_Callback(~, ~,~)
function Section_5_CreateFcn(~, ~,~)
function Section_6_Callback(~, ~,~)
function Section_6_CreateFcn(~, ~,~)
function Section_7_Callback(~, ~,~)
function Section_7_CreateFcn(~, ~,~)
function Section_8_Callback(~, ~,~)
function Section_8_CreateFcn(~, ~,~)
function Section_9_Callback(~, ~,~)
function Section_9_CreateFcn(~, ~,~)
function Section_10_Callback(~, ~,~)
function Section_10_CreateFcn(~, ~,~)
function Section_11_Callback(~, ~,~)
function Section_11_CreateFcn(~, ~,~)
function Section_12_Callback(~, ~,~)
function Section_12_CreateFcn(~, ~,~)
function Section_13_Callback(~, ~,~)
function Section_13_CreateFcn(~, ~,~)
function Section_14_Callback(~, ~,~)
function Section_14_CreateFcn(~, ~,~)
function Section_15_Callback(~, ~,~)
function Section_15_CreateFcn(~, ~,~)
function Section_16_Callback(~, ~,~)
function Section_16_CreateFcn(~, ~,~)
function Section_17_Callback(~, ~,~)
function Section_17_CreateFcn(~, ~,~)
function Section_18_Callback(~, ~,~)
function Section_18_CreateFcn(~, ~,~)
function Section_19_Callback(~, ~,~)
function Section_19_CreateFcn(~, ~,~)
function Section_20_Callback(~, ~,~)
function Section_20_CreateFcn(~, ~,~)
function Section_21_Callback(~, ~,~)
function Section_21_CreateFcn(~, ~,~)
function Section_22_Callback(~, ~,~)
function Section_22_CreateFcn(~, ~,~)
function Section_23_Callback(~, ~,~)
function Section_23_CreateFcn(~, ~,~)
function Section_24_Callback(~, ~,~)
function Section_24_CreateFcn(~, ~,~)
function Section_25_Callback(~, ~,~)
function Section_25_CreateFcn(~, ~,~)
function Section_26_Callback(~, ~,~)
function Section_26_CreateFcn(~, ~,~)
function Section_27_Callback(~, ~,~)
function Section_27_CreateFcn(~, ~,~)
function Section_28_Callback(~, ~,~)
function Section_28_CreateFcn(~, ~,~)
function New_pathname_25_Callback(~, ~,~)
% --------------------------------------------------------------------
function Untitled_2_Callback(~, ~, ~)
% --------------------------------------------------------------------
function Untitled_3_Callback(~, ~, handles)
new_dir = uigetdir(get(handles.temp_path,'String'),'Please select folder containing the subfolders of the positions') ;
if isequal(new_dir ,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
h=waitbar(0.1,'Searching for dat files. Please wait ....');
set(h,'color','w');
pathname=strcat(new_dir,'\');
set(handles.temp_path,'String',pathname);
dir_filename=dir(new_dir);
jjj=1
list_of_exp=cellstr({});
n= size(dir_filename,1);
% ###1
for ii=1:n %loop 1
    waitbar(ii/n)
    temp=cellstr(dir_filename(ii).name)  ;
    temp=(strcat(pathname,temp)) ;
    if  isdir(char(temp))==1 && length(dir_filename(ii).name)>2
        dir_dat_name=dir(char(strcat(temp  ,'\*.dat')))
        for jj=1:size(dir_dat_name,1)
            filename_str(jjj)=cellstr(strcat(temp ,'\',dir_dat_name(jj).name))
            if  isempty(strfind(char(filename_str(jjj)),'TACTICS_EXP'))~=1
                jjj=jjj+1
            end
        end
    end
end
cur_dat_name=dir(char(strcat(new_dir  ,'\*.dat')))
for jj=1:size(cur_dat_name,1)
    filename_str(jjj)=cellstr(strcat(new_dir ,'\',  cur_dat_name(jj).name))
    jjj=jjj+1
end
filename_str=char(filename_str)
set(handles.Raw_listbox,'String',filename_str);
set(handles.Raw_listbox,'Max',n) ;
set(handles.Raw_listbox,'Value',1) ;
set(handles.Raw_listbox,'Min',0);
set(handles.panel_1,'Visible','on');  set(handles.panel_2,'Visible','on')
close(h)
% --------------------------------------------------------------------
function Untitled_4_Callback(~, ~, handles)
new_dir = uigetdir(get(handles.temp_path,'String'),'Please select folder containing the subfolders of the positions') ;
if isequal(new_dir ,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
h=waitbar(0.1,'Searching for dat files. Please wait ....');
set(h,'color','w');
pathname=strcat(new_dir,'\');
set(handles.temp_path,'String',pathname);
dir_filename=dir(new_dir);
jj=1;
n= size(dir_filename,1);
% ###1
for ii=1:n %loop 1
    waitbar(ii/n)
    temp=cellstr(dir_filename(ii).name)  ;
    temp=(strcat(pathname,temp))  ;
    if  isdir(char(temp))==1 && length(dir_filename(ii).name)>2
        dir_filename2=dir(char(temp));
        for iii=1:size(dir_filename2,1)  %loop 2
            temp2=cellstr(dir_filename2(iii).name);
            temp2=(strcat(temp,'\',temp2))  ;
            if  isdir(char(temp2))==1 && length(dir_filename2(iii).name)>2
                dir_filename3=dir(char(temp2));
                for iiii=1:size(dir_filename3,1)  %loop 3
                    temp3=cellstr(dir_filename3(iiii).name);
                    temp3=(strcat(temp2,'\',temp3))  ;
                    if  isdir(char(temp3))==1 && length(dir_filename3(iiii).name)>2
                        % search in more subdirectories
                    else
                        if  strfind(char(dir_filename3(iiii).name),'TACTICS_EXP')==1
                            filename_str(jj)= (temp3);    jj=jj+1;
                        end
                        
                    end
                end
                
            else
                if  strfind(char(dir_filename2(iii).name),'TACTICS_EXP')==1
                    filename_str(jj)= (temp2);    jj=jj+1;
                end
                
            end
        end
    else
        z=char(temp)
        z=z(end)
        if isempty(strfind(z,'.'))==1
            temp=  strcat(char(pathname),z,'\TACTICS_EXP_New_' )
            z= char(strcat(char(  temp),z,'.dat') )
            filename_str(jj)=cellstr(z); jj=jj+1;
        end
    end
end
filename_str=char(filename_str);
set(handles.Raw_listbox,'String',filename_str);
set(handles.Raw_listbox,'Max',n) ;
set(handles.Raw_listbox,'Value',1) ;
set(handles.Raw_listbox,'Min',0);
set(handles.panel_1,'Visible','on');  set(handles.panel_2,'Visible','on')
close(h)
% --------------------------------------------------------------------
function Untitled_5_Callback(~, ~, ~)
% --------------------------------------------------------------------
function Untitled_6_Callback(~, ~, ~)
% --------------------------------------------------------------------
function Untitled_7_Callback(~, ~, ~)
% --------------------------------------------------------------------
function Untitled_8_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
    run('TACTICS',handles.data_file) ;
else
    run('TACTICS') ;
end
% --------------------------------------------------------------------
function Untitled_9_Callback(~, ~, ~)
close  all
function New_pathname_1_Callback(~, ~, ~)
function New_pathname_2_Callback(~, ~, ~)
function New_pathname_3_Callback(~, ~, ~)
function New_pathname_4_Callback(~, ~, ~)
function New_pathname_5_Callback(~, ~, ~)
function New_pathname_6_Callback(~, ~, ~)
function New_pathname_7_Callback(~, ~, ~)
function New_pathname_8_Callback(~, ~, ~)
function New_pathname_9_Callback(~, ~, ~)
function New_pathname_10_Callback(~, ~, ~)
function New_pathname_11_Callback(~, ~, ~)
function New_pathname_12_Callback(~, ~, ~)
function New_pathname_13_Callback(~, ~, ~)
function New_pathname_14_Callback(~, ~, ~)
function New_pathname_15_Callback(~, ~, ~)
function New_pathname_16_Callback(~, ~, ~)
function New_pathname_17_Callback(~, ~, ~)
function New_pathname_18_Callback(~, ~, ~)
function New_pathname_19_Callback(~, ~, ~)
% --------------------------------------------------------------------
function Untitled_10_Callback(~, ~, handles)
set(handles.panel_1,'Visible','on');  set(handles.panel_2,'Visible','on')
function uipushtool2_ClickedCallback(~, ~, handles)
Run_batch_process_Callback([], [], handles)
function Load_File_Edit_1_Callback(~, ~, ~)
function Load_File_Edit_8_Callback(~, ~, ~)
function edit_box_Callback(~, ~, ~)
function edit_box_CreateFcn(~, ~, ~)
% --------------------------------------------------------------------
function Run_batch_process_Callback(~, ~, handles)
filename_str= cellstr(get(handles.Raw_listbox,'string'))  ;
filename_str=filename_str';
Steps_number=get(handles.Steps_number,'Value');
for iii=1:Steps_number
    eval(strcat('Module_Option(',num2str(iii),')=get(handles.Module_Option_',num2str(iii),',''Value'')'));
    eval(strcat('New_pathname(',num2str(iii),')={get(handles.New_pathname_',num2str(iii),',''String'')}'));
    eval(strcat(' Load_File_Edit(',num2str(iii),')={get(handles. Load_File_Edit_',num2str(iii),',''String'')}'));
    eval(strcat(' Channel(',num2str(iii),')=get(handles.Channel_',num2str(iii),',''Value'')'));
    eval(strcat(' Channel_b(',num2str(iii),')=get(handles.Channel_',num2str(iii),'b,''Value'')'));
    eval(strcat(' Section(',num2str(iii),')=get(handles.Section_',num2str(iii),',''Value'')'));
end
experiment_H  =waitbar(0,'Processing experiments. please wait....');
Position=get(experiment_H,'Position');
Position(2)=Position(2)+100;
set(experiment_H,'Position',Position)
for ii=1:size(filename_str,2)
    
    importdata_file=importdata(char( filename_str(ii)))   ;
    
    
    pause(2);
    waitbar(ii/size(filename_str,2) )
    for iii=1:Steps_number
        
        
        set(handles.Raw_listbox,'value',ii)
        
        
        eval(strcat( 'set(handles.Module_Option_',num2str(iii),',''Backgroundcolor'',','','''y','','''',')'))
        
        try
            Load_File_Edit_char= char(Load_File_Edit(iii));
        catch
            Load_File_Edit_char=  Load_File_Edit(iii);
            Load_File_Edit_char=char( Load_File_Edit_char{1});
        end
        
        
        try
            filename_str_char= char(filename_str(ii));
        catch
            filename_str_char=  filename_str(ii);
            filename_str_char=char( filename_str_char{1});
        end
        
        
        try
            New_pathname_char= char(New_pathname(iii));
        catch
            
            New_pathname_char=  New_pathname(iii);
            New_pathname_char=char( New_pathname_char{1});
        end
        
        
        if Module_Option(iii) ==2
            try
                TAC_Segmentation_Module(importdata_file,filename_str_char,  [Channel(iii) Channel_b(iii)],Load_File_Edit_char,Section(iii)) ;
            end
            save_segmentaion_setup(importdata_file,filename_str_char,  Channel_b(iii) ,Load_File_Edit_char) ;
        end
        if Module_Option(iii) ==3
            try
                TAC_Cell_Tracking_Module(importdata_file,filename_str_char, Channel(iii),Section(iii));
            end
        end
        
        if Module_Option(iii) ==4
            
            
            try
                
                TAC_Measurments_Module(importdata_file,filename_str_char,    Load_File_Edit_char,New_pathname_char,Section(iii)) ;
                
                
            end
        end
        
        if Module_Option(iii) ==5
            TACTICS_U(importdata_file,filename_str_char,  [Channel(iii) Channel_b(iii) Channel(iii) Channel_b(iii)],Section(iii),[alpha  beta]) ;
            msgbox('setup alpha and beta manually!!')
            'setup alpha and beta manually!!'
            'setup alpha and beta manually!!'
            'setup alpha and beta manually!!'
            'setup alpha and beta manually!!'
            'setup alpha and beta manually!!'
            'setup alpha and beta manually!!'
            
        end
        if Module_Option(iii) ==6
            try
                TAC_Cell_Tracking_Module(importdata_file,filename_str_char,Load_File_Edit_char);
            end
        end
        
        
        eval(strcat( 'set(handles.Module_Option_',num2str(iii),',''Backgroundcolor'',','','''g','','''',')'))
        
        
    end
end
timebar_TACWrapper('Ready :)');
