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
function varargout = Consider_8_GUI(varargin)


% CONSIDER_8_GUI M-file for Consider_8_GUI.fig
%      CONSIDER_8_GUI, by itself, creates a new CONSIDER_8_GUI or raises the existing
%      singleton*.
%
%      H = CONSIDER_8_GUI returns the handle to a new CONSIDER_8_GUI or the handle to
%      the existing singleton*.
%
%      CONSIDER_8_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONSIDER_8_GUI.M with the given input arguments.
%
%      CONSIDER_8_GUI('Property','Value',...) creates a new CONSIDER_8_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Consider_8_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Consider_8_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Consider_8_GUI

% Last Modified by GUIDE v2.5 19-Jan-2010 12:48:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Consider_8_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @Consider_8_GUI_OutputFcn, ...
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


% --- Executes just before Consider_8_GUI is made visible.
function Consider_8_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
if nargin <4
    handles.output = hObject;
    guidata(hObject, handles);
end
clc
uiwait
clc

% --- Outputs from this function are returned to the command line.
function varargout = Consider_8_GUI_OutputFcn(hObject, eventdata, handles)

varargout{1}= get(handles.plot_list,'String')  ;
guidata(hObject, handles);
close
clc

% --- Executes on selection change in plot_list.
function plot_list_Callback(hObject, eventdata, handles)
% hObject    handle to plot_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns plot_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot_list


% --- Executes during object creation, after setting all properties.
function plot_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
str =get(handles.plot_edit,'string');
if isempty(str)==1
    return
end
str2=str;
all_added_str =[cellstr('./') cellstr('.*') cellstr('(') cellstr(')') cellstr('-') cellstr('+') cellstr('X_R') cellstr('X_L') cellstr('Y_L') cellstr('Y_R')   cellstr('y') cellstr('x')  ];
for ii=1:12
    added_str=char(all_added_str(ii))
    while isempty(findstr(str2,added_str))~=1
        str_index=findstr(str2,added_str);
        str2(str_index:str_index+length(added_str)-1)=[]
    end
end


str_index=findstr(str2,' ')
str2(str_index)=[]



if isempty(str2)~=1
    Y=wavread('Error');  sound(Y,22000);
    h = msgbox('The matematic command is faulty','Aborted');
    return
end



n=get(handles.plot_list,'Value') ;
plot_list=get(handles.plot_list,'string')  ;
if isempty(plot_list)==1
    n=1 ;
    plot_list=cellstr(plot_list);
    plot_list(n)=cellstr(str)  ;
    set(handles.plot_list,'string',plot_list);
else
    n=size(plot_list,1)+1 ;
    plot_list=cellstr(plot_list);
    plot_list(n)=cellstr(str)  ;
    set(handles.plot_list,'string',plot_list);
end
set(handles.plot_edit,'string','');
function plot_edit_Callback(hObject, eventdata, handles)
% hObject    handle to plot_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of plot_edit as text
%        str2double(get(hObject,'String')) returns contents of plot_edit as a double


% --- Executes during object creation, after setting all properties.
function plot_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

clc;
n=get(handles.plot_list,'Value') ;
plot_list=get(handles.plot_list,'string');

if (n==1 && n==size(plot_list,1))
    set(handles.plot_list,'string','Selected plot:');
    return
end
if  (n==1 &&  size(plot_list,1)>1)
    for ii=1:(size(plot_list,1)-1)
        newplot_list(ii)=plot_list(ii+1);
    end
    set(handles.plot_list,'string',newplot_list);
    return
end
if  (n>1 && size(plot_list,1)>1&&size(plot_list,1)>n)
    for   ii=1:(n-1)
        newplot_list(ii)=plot_list(ii);
    end
    for ii=n:(size(plot_list,1)-1)
        newplot_list(ii)=plot_list(ii+1);
    end
    set(handles.plot_list,'string',newplot_list);
    return
end
if (n==size(plot_list,1) && n>1)
    for  ii=1:(n-1)
        newplot_list(ii)=plot_list(ii);
    end
    set(handles.plot_list,'Value',n-1);
    set(handles.plot_list,'string',newplot_list);
    return
end% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
set(handles.plot_list,'Value',1)
set(handles.plot_list,'string',[]);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
if isempty(get(handles.plot_list,'String'))==1
    Y=wavread('Error');
    h = errordlg('List is still empty!','Error');
    return
else
    uiresume
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);
% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);




% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);




% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
set(handles.plot_edit,'string','');

% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);
% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);
% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);

% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);

% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
added_str=get(hObject, 'string');
str=get(handles.plot_edit,'string')  ;
if isempty(str)==1
    str=added_str;
else
    str(end+1:end+length(added_str))=added_str;
end
set(handles.plot_edit,'string',str);
