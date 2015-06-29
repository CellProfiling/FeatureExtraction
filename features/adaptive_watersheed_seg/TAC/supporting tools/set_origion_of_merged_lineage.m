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
function varargout = set_origion_of_merged_lineage(varargin)
% SET_ORIGION_OF_MERGED_LINEAGE M-file for set_origion_of_merged_lineage.fig
%      SET_ORIGION_OF_MERGED_LINEAGE, by itself, creates a new SET_ORIGION_OF_MERGED_LINEAGE or raises the existing
%      singleton*.
%
%      H = SET_ORIGION_OF_MERGED_LINEAGE returns the handle to a new SET_ORIGION_OF_MERGED_LINEAGE or the handle to
%      the existing singleton*.
%
%      SET_ORIGION_OF_MERGED_LINEAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SET_ORIGION_OF_MERGED_LINEAGE.M with the given input arguments.
%
%      SET_ORIGION_OF_MERGED_LINEAGE('Property','Value',...) creates a new SET_ORIGION_OF_MERGED_LINEAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before set_origion_of_merged_lineage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to set_origion_of_merged_lineage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help set_origion_of_merged_lineage

% Last Modified by GUIDE v2.5 04-Jan-2013 13:31:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @set_origion_of_merged_lineage_OpeningFcn, ...
    'gui_OutputFcn',  @set_origion_of_merged_lineage_OutputFcn, ...
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


% --- Executes just before set_origion_of_merged_lineage is made visible.
function set_origion_of_merged_lineage_OpeningFcn(hObject, eventdata, handles, varargin)


handles.output = hObject;
guidata(hObject, handles);
set(handles.set_value1,'string',num2str(varargin{1}))
set(handles.set_value2,'string',num2str(varargin{2}))
uiwait


% --- Outputs from this function are returned to the command line.
function varargout = set_origion_of_merged_lineage_OutputFcn(hObject, eventdata, handles)

varargout{1}=str2num(get(handles.input_value1,'string'))
varargout{2}=str2num(get(handles.input_value2,'string'))
guidata(hObject, handles);
close


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
function popupmenu1_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
uiresume



% --- Executes on selection change in Vs.
function Vs_Callback(hObject, eventdata, handles)
% hObject    handle to Vs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Vs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Vs


% --- Executes during object creation, after setting all properties.
function Vs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_value1_Callback(hObject, eventdata, handles)

input_value1=str2num(get(handles.input_value1,'string'));
input_value2=str2num(get(handles.input_value2,'string'));
if isempty(input_value1)  ||  isempty(input_value2)
    return
end

if input_value1<0
    set(handles.input_value1,'string',num2str(0))
end
if input_value2<0
    set(handles.input_value2,'string',num2str(0))
end


set_value1=str2num(get(handles.set_value1,'string'))
set_value2=str2num(get(handles.set_value2,'string'))




Difference=input_value1+set_value1-input_value2-set_value2;
set(handles.Difference,'string',num2str(Difference))
if  Difference==0
    set(handles.pushbutton1,'Visible','on')
else
    set(handles.pushbutton1,'Visible','off')
end


function input_value2_Callback(hObject, eventdata, handles)
% hObject    handle to input_value2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input_value1=str2num(get(handles.input_value1,'string'));
input_value2=str2num(get(handles.input_value2,'string'));
if isempty(input_value1)  ||  isempty(input_value2)
    return
end

if input_value1<0
    set(handles.input_value1,'string',num2str(0))
end
if input_value2<0
    set(handles.input_value2,'string',num2str(0))
end


set_value1=str2num(get(handles.set_value1,'string'));
set_value2=str2num(get(handles.set_value2,'string'));




Difference=input_value1+set_value1-input_value2-set_value2;
set(handles.Difference,'string',num2str(Difference))

if  Difference==0
    set(handles.pushbutton1,'Visible','on')
else
    set(handles.pushbutton1,'Visible','off')
end
% Hints: get(hObject,'String') returns contents of input_value2 as text
%        str2double(get(hObject,'String')) returns contents of input_value2 as a double
