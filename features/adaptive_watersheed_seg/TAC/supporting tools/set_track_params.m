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
function varargout = set_track_params(varargin)
% SET_TRACK_PARAMS M-file for set_track_params.fig
%      SET_TRACK_PARAMS, by itself, creates a new SET_TRACK_PARAMS or raises the existing
%      singleton*.
%
%      H = SET_TRACK_PARAMS returns the handle to a new SET_TRACK_PARAMS or the handle to
%      the existing singleton*.
%
%      SET_TRACK_PARAMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SET_TRACK_PARAMS.M with the given input arguments.
%
%      SET_TRACK_PARAMS('Property','Value',...) creates a new SET_TRACK_PARAMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before set_track_params_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to set_track_params_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help set_track_params

% Last Modified by GUIDE v2.5 05-Oct-2012 03:26:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @set_track_params_OpeningFcn, ...
    'gui_OutputFcn',  @set_track_params_OutputFcn, ...
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


% --- Executes just before set_track_params is made visible.
function set_track_params_OpeningFcn(hObject, eventdata, handles, varargin)



varargin{2}

set(handles.start_track,'String',num2str(varargin{1}))
set(handles.end_track,'String',num2str(varargin{2}))



varargout{1}= 1;
varargout{2}=1 ;
varargout{3}= 1;




uiwait

handles.mindisp=str2num(get(handles.min_disps_GUI,'String'))
handles.start_track=str2num(get(handles.start_track,'String'))
handles.end_track=str2num(get(handles.end_track,'String'))
guidata(hObject,handles);




% --- Outputs from this function are returned to the command line.
function varargout = set_track_params_OutputFcn(hObject, eventdata, handles)






varargout{1}=handles.mindisp
varargout{2}=handles.start_track
varargout{3}=handles.end_track
varargout{4}=get(handles.MODE,'value')

close



function min_disps_GUI_Callback(hObject, eventdata, handles)
good=get(hObject,'String');
handles.good=str2num(good);
set(hObject,'String',good);


guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function min_disps_GUI_CreateFcn(hObject, eventdata, handles)



function memory_track_GUI_Callback(hObject, eventdata, handles)
mem=get(hObject,'String');
handles.mem=num2str(mem);

guidata(hObject,handles);




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)




handles.mindisp=str2num(get(handles.min_disps_GUI,'String'))
guidata(hObject,handles);

uiresume




function start_track_Callback(hObject, eventdata, handles)
function start_track_CreateFcn(hObject, eventdata, handles)
function end_track_Callback(hObject, eventdata, handles)
function end_track_CreateFcn(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function algorithm_GUI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to algorithm_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in MODE.
function MODE_Callback(hObject, eventdata, handles)
% hObject    handle to MODE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MODE
