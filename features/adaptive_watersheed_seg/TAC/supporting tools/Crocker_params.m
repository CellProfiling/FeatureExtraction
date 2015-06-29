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
function varargout = Crocker_params(varargin)
% CROCKER_PARAMS M-file for Crocker_params.fig
%      CROCKER_PARAMS, by itself, creates a new CROCKER_PARAMS or raises the existing
%      singleton*.
%
%      H = CROCKER_PARAMS returns the handle to a new CROCKER_PARAMS or the handle to
%      the existing singleton*.
%
%      CROCKER_PARAMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CROCKER_PARAMS.M with the given input arguments.
%
%      CROCKER_PARAMS('Property','Value',...) creates a new CROCKER_PARAMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before set_track_params_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Crocker_params_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help Crocker_params

% Last Modified by GUIDE v2.5 30-Oct-2012 10:02:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Crocker_params_OpeningFcn, ...
    'gui_OutputFcn',  @Crocker_params_OutputFcn, ...
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


% --- Executes just before Crocker_params is made visible.
function Crocker_params_OpeningFcn(hObject, eventdata, handles, varargin)
handles.maxdisp=50;
handles.dim=2
handles.good=1;
handles.mem=1;
uiwait
handles.maxdisp=get(handles.max_disps,'String')
handles.dim=get(handles.dimensions,'String');
handles.good=get(handles.edit3,'String');
handles.mem=get(handles.memory_track,'String');
handles
% pause
% 'fuck off you bastard'
guidata(hObject,handles);




% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Crocker_params (see VARARGIN)

% Choose default command line output for Crocker_params
% handles.output = hObject;

% Update handles structure
% guidata(hObject, handles);

% UIWAIT makes Crocker_params wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Crocker_params_OutputFcn(hObject, eventdata, handles)

varargout{1}=str2num(handles.maxdisp);
varargout{2}=str2num(handles.dim);
varargout{3}=str2num(handles.good);
varargout{4}=str2num(handles.mem);
close

% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;



function max_disps_Callback(hObject, eventdata, handles)
maxdisp=get(hObject,'String');
handles.maxdisp=str2num(maxdisp);
set(hObject,'String',maxdisp);

guidata(hObject,handles);

% hObject    handle to max_disps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_disps as text
%        str2double(get(hObject,'String')) returns contents of max_disps as a double


% --- Executes during object creation, after setting all properties.
function max_disps_CreateFcn(hObject, eventdata, handles)

% hObject    handle to max_disps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function dimensions_Callback(hObject, eventdata, handles)
dim=get(hObject,'String');
handles.dim=str2num(dim);
set(hObject,'String',dim);


guidata(hObject,handles);

% hObject    handle to dimensions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dimensions as text
%        str2double(get(hObject,'String')) returns contents of dimensions as a double


% --- Executes during object creation, after setting all properties.
function dimensions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dimensions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit3_Callback(hObject, eventdata, handles)
good=get(hObject,'String');
handles.good=str2num(good);
set(hObject,'String',good);


guidata(hObject,handles);

% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function memory_track_Callback(hObject, eventdata, handles)
mem=get(hObject,'String');
handles.mem=num2str(mem);

guidata(hObject,handles);

% hObject    handle to memory_track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of memory_track as text
%        str2double(get(hObject,'String')) returns contents of memory_track as a double


% --- Executes during object creation, after setting all properties.
function memory_track_CreateFcn(hObject, eventdata, handles)
% hObject    handle to memory_track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

handles.maxdisp=str2num(get(handles.max_disps,'String'))

handles.dim=str2num(get(handles.dimensions,'String'))
handles.good=str2num(get(handles.edit3,'String'))
handles.mem=str2num(get(handles.memory_track,'String'))
% varargout{1}=handles.maxdisp
% varargout{2}=handles.dim
% varargout{3}=handles.good
% varargout{4}=handles.mem

guidata(hObject,handles);

uiresume
% varargout{1}=handles.maxdisp;
% varargout{2}=handles.dim;
% varargout{3}=handles.good;
% varargout{4}=handles.mem;
% handles


%
% close

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


