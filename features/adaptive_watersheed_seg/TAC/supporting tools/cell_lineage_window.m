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
function varargout = cell_lineage_window(varargin)
% CELL_LINEAGE_WINDOW MATLAB code for cell_lineage_window.fig
%      CELL_LINEAGE_WINDOW, by itself, creates a new CELL_LINEAGE_WINDOW or raises the existing
%      singleton*.
%
%      H = CELL_LINEAGE_WINDOW returns the handle to a new CELL_LINEAGE_WINDOW or the handle to
%      the existing singleton*.
%
%      CELL_LINEAGE_WINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CELL_LINEAGE_WINDOW.M with the given input arguments.
%
%      CELL_LINEAGE_WINDOW('Property','Value',...) creates a new CELL_LINEAGE_WINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cell_lineage_window_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cell_lineage_window_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cell_lineage_window

% Last Modified by GUIDE v2.5 14-Oct-2012 22:37:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @cell_lineage_window_OpeningFcn, ...
    'gui_OutputFcn',  @cell_lineage_window_OutputFcn, ...
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


% --- Executes just before cell_lineage_window is made visible.
function cell_lineage_window_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to h_cell_lineage_window.Untitled_1
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cell_lineage_window (see VARARGIN)
global h_TAC_Cell_Tracking_Module
global h_cell_lineage_window
h_cell_lineage_window=handles;
% Choose default command line output for cell_lineage_window
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cell_lineage_window wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cell_lineage_window_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Y_lim_end1_Callback(hObject, eventdata, handles)
% hObject    handle to Y_lim_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_lim_end1 as text
%        str2double(get(hObject,'String')) returns contents of Y_lim_end1 as a double


% --- Executes during object creation, after setting all properties.
function Y_lim_end1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_lim_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_lim_start1_Callback(hObject, eventdata, handles)
% hObject    handle to Y_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_lim_start1 as text
%        str2double(get(hObject,'String')) returns contents of Y_lim_start1 as a double


% --- Executes during object creation, after setting all properties.
function Y_lim_start1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
index=1


eval( strcat('Ylim(1)=str2num(get(handles.Y_lim_start1,','''string''))'))
eval( strcat('Ylim(2)=str2num(get(handles.Y_lim_end1,','''string''))'))


eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],Ylim);'))


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
sel_typ = get(gcbf,'SelectionType')
point1 = get(hObject,'CurrentPoint')

%  frame=round(point1(1))
%  if strcmp(sel_typ,'normal')==1
%       'free option'
%  end
%
%   if strcmp(sel_typ,'alt')==1
%             'free option'
%   end
%   if strcmp(sel_typ,'extend')==1
%      'extend'
% end
%
global h_cell_lineage_window


%
global h_TAC_Cell_Tracking_Module
set(h_TAC_Cell_Tracking_Module.Raw_listbox,'value',round(point1(3)))
%    h_TAC_Cell_Tracking_Module = guidata(TAC_Cell_Tracking_Module)
%     set(h_TAC_Cell_Tracking_Module.Raw_listbox,'value',round(point1(1)))
TAC_Cell_Tracking_Module('Raw_listbox_Callback', h_TAC_Cell_Tracking_Module.Raw_listbox,[],h_TAC_Cell_Tracking_Module)
%     important: gui1.m and gui1.fig must be in the path to be called



function X_lim_start1_Callback(hObject, eventdata, handles)
% hObject    handle to X_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_lim_start1 as text
%        str2double(get(hObject,'String')) returns contents of X_lim_start1 as a double


% --- Executes during object creation, after setting all properties.
function X_lim_start1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X_lim_end1_Callback(hObject, eventdata, handles)
% hObject    handle to X_lim_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_lim_end1 as text
%        str2double(get(hObject,'String')) returns contents of X_lim_end1 as a double


% --- Executes during object creation, after setting all properties.
function X_lim_end1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_lim_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
index=1


eval( strcat('Xlim(1)=str2num(get(handles.X_lim_start1,','''string''))'))
eval( strcat('Xlim(2)=str2num(get(handles.X_lim_end1,','''string''))'))


eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','X','''',',','''','lim','''','],Xlim);'))


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
global h_cell_lineage_window
h_cell_lineage_window=handles;

global h_TAC_Cell_Tracking_Module;



track_what=get(h_TAC_Cell_Tracking_Module.track_what2,'value');


MATRIX=h_TAC_Cell_Tracking_Module.data_file(5).cdata.Tracks(track_what ).cdata;


Div_Cells=get(h_TAC_Cell_Tracking_Module.Div_Cells,'string');



Cell=get(h_TAC_Cell_Tracking_Module.Div_Cells,'value');
Cell2=char(Div_Cells(Cell));
Point=findstr(Cell2,'.') ;
if isempty(Point)~=1
    Cell=str2num(Cell2(1:Point-1));
else
    Cell=str2num(Cell2);
end







jj=1;max_Points=0;
for ii=1:size(Div_Cells,1)
    temp_Div_Cells=char(Div_Cells(ii)) ;
    Point=findstr(temp_Div_Cells,'.');
    if max_Points<length(Point)
        max_Points=length(Point);
    end
    if isempty(Point)~=1
        temp_Cell=temp_Div_Cells(1:Point(1)-1);
        if  str2num(temp_Cell)==Cell
            new_Div_Cells(jj,1)=  Div_Cells(ii);
            %%
            cell_index= ii
            V=MATRIX(:,cell_index*2-1);
            V=V(find(V, 1 ):find(V, 1, 'last' ));
            for start_XY=1:size(MATRIX,1)
                if MATRIX(start_XY,cell_index*2 -1)>0
                    break
                end
            end
            V=cumsum(V); Index=find(ismember(V,max(max(V)))); end_XY=Index(1);
            %%
            new_Div_Cells(jj,2)=  {num2str(start_XY)};  new_Div_Cells(jj,3)= { num2str(end_XY+start_XY-1)};
            jj=jj+1;
        end
    else
        if  str2num(temp_Div_Cells)==Cell
            new_Div_Cells(jj,1)= Div_Cells(ii);
            %%
            cell_index= ii
            V=MATRIX(:,cell_index*2-1);
            V=V(find(V, 1 ):find(V, 1, 'last' ));
            for start_XY=1:size(MATRIX,1)
                if MATRIX(start_XY,cell_index*2 -1)>0
                    break
                end
            end
            V=cumsum(V); Index=find(ismember(V,max(max(V)))); end_XY=Index(1);
            %%
            new_Div_Cells(jj,2)=  {num2str(start_XY)};  new_Div_Cells(jj,3)= { num2str(end_XY+start_XY-1)};
            jj=jj+1;
        end
    end
end



n= max_Points;
View=get(handles.popupmenu1,'value');



plot_lineage(handles,n,Cell,new_Div_Cells,1,View)



% --------------------------------------------------------------------
function uitoggletool3_ClickedCallback(hObject, eventdata, handles)

global h_cell_lineage_window
h_cell_lineage_window=handles;

global h_TAC_Cell_Tracking_Module;



track_what=get(h_TAC_Cell_Tracking_Module.track_what2,'value');


MATRIX=h_TAC_Cell_Tracking_Module.data_file(5).cdata.Tracks(track_what ).cdata;


Div_Cells=get(h_TAC_Cell_Tracking_Module.Div_Cells,'string');



Cell=get(h_TAC_Cell_Tracking_Module.Div_Cells,'value');
Cell2=char(Div_Cells(Cell));
Point=findstr(Cell2,'.') ;
if isempty(Point)~=1
    Cell=str2num(Cell2(1:Point-1));
else
    Cell=str2num(Cell2);
end







jj=1;max_Points=0;
for ii=1:size(Div_Cells,1)
    temp_Div_Cells=char(Div_Cells(ii)) ;
    Point=findstr(temp_Div_Cells,'.');
    if max_Points<length(Point)
        max_Points=length(Point);
    end
    if isempty(Point)~=1
        temp_Cell=temp_Div_Cells(1:Point(1)-1);
        if  str2num(temp_Cell)==Cell
            new_Div_Cells(jj,1)=  Div_Cells(ii);
            %%
            cell_index= ii
            V=MATRIX(:,cell_index*2-1);
            V=V(find(V, 1 ):find(V, 1, 'last' ));
            for start_XY=1:size(MATRIX,1)
                if MATRIX(start_XY,cell_index*2 -1)>0
                    break
                end
            end
            V=cumsum(V); Index=find(ismember(V,max(max(V)))); end_XY=Index(1);
            %%
            new_Div_Cells(jj,2)=  {num2str(start_XY)};  new_Div_Cells(jj,3)= { num2str(end_XY+start_XY-1)};
            jj=jj+1;
        end
    else
        if  str2num(temp_Div_Cells)==Cell
            new_Div_Cells(jj,1)= Div_Cells(ii);
            %%
            cell_index= ii
            V=MATRIX(:,cell_index*2-1);
            V=V(find(V, 1 ):find(V, 1, 'last' ));
            for start_XY=1:size(MATRIX,1)
                if MATRIX(start_XY,cell_index*2 -1)>0
                    break
                end
            end
            V=cumsum(V); Index=find(ismember(V,max(max(V)))); end_XY=Index(1);
            %%
            new_Div_Cells(jj,2)=  {num2str(start_XY)};  new_Div_Cells(jj,3)= { num2str(end_XY+start_XY-1)};
            jj=jj+1;
        end
    end
end



n= max_Points;
View=get(handles.popupmenu1,'value');
plot_lineage(handles,n,Cell,new_Div_Cells,2,View)

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
if get( hObject ,'value')==1
    set(handles.text1,'string','Frames')
    set(handles.text2,'string','Cell')
else
    set(handles.text2,'string','Frames')
    set(handles.text1,'string','Cell')
end
Untitled_1_Callback(hObject, eventdata, handles)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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
