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
function varargout = Tracking_option_GUI(varargin)
% TRACKING_OPTION_GUI M-file for Tracking_option_GUI.fig
%      TRACKING_OPTION_GUI, by itself, creates a new TRACKING_OPTION_GUI or raises the existing
%      singleton*.
%
%      H = TRACKING_OPTION_GUI returns the handle to a new TRACKING_OPTION_GUI or the handle to
%      the existing singleton*.
%
%      TRACKING_OPTION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACKING_OPTION_GUI.M with the given input arguments.
%
%      TRACKING_OPTION_GUI('Property','Value',...) creates a new TRACKING_OPTION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Tracking_option_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Tracking_option_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Tracking_option_GUI

% Last Modified by GUIDE v2.5 04-Oct-2012 07:55:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Tracking_option_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @Tracking_option_GUI_OutputFcn, ...
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


% --- Executes just before Tracking_option_GUI is made visible.
function Tracking_option_GUI_OpeningFcn(hObject, eventdata, handles, varargin)

movegui(gcf,'center')
if nargin <4
    handles.output = hObject;
    handles.MATRIX=[];handles.centy1=[];handles.selection=1;
    guidata(hObject, handles);
    
    
    %    load    closest_track
    %   load  n
    % load  XY_min_index
    %    load   XY
    %    load   MATRIX
    %      load   centy1
    %     load   div_cells_Vec
    
    
else
    
    
    
    
    
    closest_track=varargin{1}
    n= varargin{2}
    XY_min_index=    varargin{3}   ;
    XY= varargin{4} ;
    MATRIX=  varargin{5} ;
    centy1= varargin{6} ;
    div_cells_Vec =  varargin{7} ;
    
    
    new_cell_num= div_cells_Vec(closest_track)    ;
    
    
    
    
    handles.XY=XY ;
    handles.MATRIX=MATRIX;
    handles.centy1=centy1;
    handles.XY_min_index=XY_min_index;
    handles.div_cells_Vec=div_cells_Vec;
    
    set(handles.new_cell_num_1,'string', new_cell_num)
    set(handles.new_cell_num_3,'string', new_cell_num)
    set(handles.new_cell_num_4,'string', new_cell_num)
    set(handles.new_cell_num_6,'string', new_cell_num)
    
    
    set(handles.n_1,'string',num2str(n))
    set(handles.n_2,'string',num2str(n))
    set(handles.n_3,'string',num2str(n))
    set(handles.n_4,'string',num2str(n))
    set(handles.n_5,'string',num2str(n))
    set(handles.n_7,'string',num2str(n))
    set(handles.n_8,'string',num2str(n))
    set(handles.n_9,'string',num2str(n))
    set(handles.n_11,'string',num2str(n))
    set(handles.n_12,'string',num2str(n))
    
    
    set(handles.cell1_7,'string',new_cell_num)
    set(handles.cell1_8,'string',new_cell_num)
    set(handles.cell1_9,'string',new_cell_num)
    set(handles.cell1_11,'string',new_cell_num)
    set(handles.cell1_12,'string',new_cell_num)
    
    %
    set(handles.cell2_7,'string','')
    set(handles.cell2_8,'string','')
    set(handles.cell2_9,'string','')
    set(handles.cell2_12,'string','')
    set(handles.cell2_12,'string','')
    
    
    
    
    
    guidata(hObject, handles);
    
end


uiwait
clc

% --- Outputs from this function are returned to the command line.
function varargout = Tracking_option_GUI_OutputFcn(hObject, eventdata, handles)
try
    varargout{1}=handles.MATRIX;
    varargout{2}=handles.centy1;
    varargout{3}=handles.selection;
    guidata(hObject, handles);
    close
    clc
end

% --- Executes on selection change in Tracking_options.
function Tracking_options_Callback(hObject, eventdata, handles)

SELECTION=get(hObject, 'Value');
handles.selection=SELECTION;
guidata(hObject, handles);
for ii=1:9
    if ii==SELECTION
        eval(strcat('set(handles.uipanel',num2str(ii),' ,''Visible''',',''','on'')'))
    else
        eval(strcat('set(handles.uipanel',num2str(ii),' ,''Visible''',',''','off'')'))
    end
end
for ii=11:12
    if ii==SELECTION
        eval(strcat('set(handles.uipanel',num2str(ii),' ,''Visible''',',''','on'')'))
    else
        eval(strcat('set(handles.uipanel',num2str(ii),' ,''Visible''',',''','off'')'))
    end
end



% --- Executes during object creation, after setting all properties.
function Tracking_options_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tracking_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)


Tracking_options=get(handles.Tracking_options,'value')






MATRIX=handles.MATRIX;
centy1=handles.centy1;
div_cells_Vec=handles.div_cells_Vec;
XY_min_index=handles.XY_min_index;


switch  Tracking_options
    
    case 1  %      Use an exist  track path, and put the current point as its 'n' track point
        n=get(handles.n_1,'string') ;   n=str2num(n);
        new_cell_num=get(handles.new_cell_num_1,'string')
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(new_cell_num))
                break
            end
        end
        new_cell_num=ii;
        
        
        cell_index=2*new_cell_num; % location of new cell num chosen by the user in MATRIX
        MATRIX(n,   cell_index-1)=centy1(n).cdata(XY_min_index,1);
        MATRIX(n,   cell_index)=centy1(n).cdata(XY_min_index,2);
    case 2   %  Create new cell track, and put the current point as its first track point
        n=get(handles.n_2,'string');  n=str2num(n);
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
        MATRIX_out( n,cell_index*2-1:cell_index*2)=centy1(n).cdata(XY_min_index,1:2)
        MATRIX_out(:,cell_index*2+1:end)=MATRIX(:,cell_index*2-1:end);
        MATRIX=MATRIX_out;
    case 3 % Delete this point
        new_cell_num=get(handles.new_cell_num_3,'string')
        n=get(handles.n_3,'string')
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(new_cell_num))
                break
            end
        end
        new_cell_num=ii;
        n=str2num(n);
        
        cell_index=2*new_cell_num; % location of new cell num chosen by the user in MATRIX
        MATRIX(n,   cell_index-1)=0 ;
        MATRIX(n,   cell_index)=0;
    case 4 % Delete all the next track points from image 'n' further  for selected cell
        new_cell_num=get(handles.new_cell_num_4,'string')
        n=get(handles.n_4,'string')
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(new_cell_num))
                break
            end
        end
        new_cell_num=ii;
        n=str2num(n);
        MATRIX(n:end, new_cell_num*2-1:new_cell_num*2)=0;
    case 5 % Delete all the next track points from image 'n' further   for all cells
        n=get(handles.n_5,'string') ;
        n=str2num(n);
        MATRIX(n:end, :)=0;
        
    case 6 % Delete path  ('input ')
        new_cell_num=get(handles.new_cell_num_6,'string')
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(new_cell_num))
                break
            end
        end
        new_cell_num=ii;
        
        
        MATRIX(:, new_cell_num*2-1:new_cell_num*2)=[];
    case 7% If two cells flipped-Transform track path ('input 1')  to track path ('input 2') from images 'n'
        cell1=get(handles.cell1_7,'string');
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(cell1))
                break
            end
        end
        cell1=ii;
        
        cell2=get(handles.cell2_7,'string');
        
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(cell2))
                break
            end
        end
        cell2=ii;
        
        n=get(handles.n_7,'string');       n=str2num(n);
        
        
        backup_vec=MATRIX(n, cell1*2-1:cell1*2);
        MATRIX(n, cell1*2-1:cell1*2)=MATRIX(n, cell2*2-1:cell2*2);
        MATRIX(n, cell2*2-1:cell2*2)= backup_vec;
    case 8
        cell1=get(handles.cell1_8,'string');
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(cell1))
                break
            end
        end
        cell1=ii;
        
        cell2=get(handles.cell2_8,'string');
        
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(cell2))
                break
            end
        end
        cell2=ii;
        
        n=get(handles.n_8,'string');       n=str2num(n);
        
        backup_track=MATRIX(n:end, cell1*2-1:cell1*2);
        MATRIX(n:end, cell1*2-1:cell1*2)=MATRIX(n:end, cell2*2-1:cell2*2);
        MATRIX(n:end, cell2*2-1:cell2*2)=backup_track;
    case 9 % merge trajectories
        cell1=get(handles.cell1_9,'string');
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(cell1))
                break
            end
        end
        cell1=ii;
        
        cell2=get(handles.cell2_9,'string');
        
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(cell2))
                break
            end
        end
        cell2=ii;
        
        n=get(handles.n_9,'string');       n=str2num(n);
        
        if  isempty(MATRIX)==1
            return
        end
        
        MATRIX(:, cell1*2-1:cell1*2)=MATRIX(:, cell1*2-1:cell1*2)+MATRIX(:, cell2*2-1:cell2*2) ;
        MATRIX(:, cell2*2-1:cell2*2)=[];
        
    case 11
        
        cell1=get(handles.cell1_11,'string')
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(cell1))
                break
            end
        end
        cell1=ii;
        
        cell2=get(handles.cell2_11,'string')
        
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(cell2))
                break
            end
        end
        cell2=ii;
        
        n=get(handles.n_11,'string');       n=str2num(n);
        
        
        cell1= MATRIX(n,cell1*2-1:cell1*2)
        cell2= MATRIX(n,cell2*2-1:cell2*2)
        
        XY= (( centy1(n).cdata(:,1)-cell1(1)).^2+ (centy1(n).cdata(:,2)-cell1(2)).^2).^2     ;
        cell1=find(ismember(XY,(min(XY)))) ;
        
        
        XY= (( centy1(n).cdata(:,1)-cell2(1)).^2+ (centy1(n).cdata(:,2)-cell2(2)).^2).^2     ;
        cell2=find(ismember(XY,(min(XY)))) ;
        
        temp_val=centy1(n).cdata(cell1,4);
        centy1(n).cdata(cell1,4)= centy1(n).cdata(cell2,4) ;
        centy1(n).cdata(cell2,4)= temp_val ;
        
        %%%%%%%%%%%%
    case 12
        
        %  1. go to MATRIX and get coordinates of CELL1
        %     2. find the location of cell 1 in centy n-1
        %   3. go to MATRIX and get coordinates of CELL2
        %     4. find the location of cell 2 in centy n
        
        % 5. give value in column 4 in centy to
        
        
        
        cell1=get(handles.cell1_12,'string');
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(cell1))
                break
            end
        end
        cell1=ii;
        
        cell2=get(handles.cell2_12,'string');
        
        for ii=1:length(div_cells_Vec)
            if  strcmp(char(cellstr(div_cells_Vec(ii))),char(cell2))
                break
            end
        end
        cell2=ii;
        
        n=get(handles.n_12,'string');       n=str2num(n);
        
        
        
        cell1= MATRIX(n-1,cell1*2-1:cell1*2)
        cell2= MATRIX(n,cell2*2-1:cell2*2)
        
        XY= (( centy1(n-1).cdata(:,1)-cell1(1)).^2+ (centy1(n-1).cdata(:,2)-cell1(2)).^2).^2     ;
        cell1=find(ismember(XY,(min(XY)))) ;
        
        
        XY= (( centy1(n).cdata(:,1)-cell2(1)).^2+ (centy1(n).cdata(:,2)-cell2(2)).^2).^2     ;
        cell2=find(ismember(XY,(min(XY)))) ;
        %
        % %    temp_val=centy1(n-1).cdata(cell1,4);
        %    centy1(n).cdata(cell1,4)= centy1(n-1).cdata(cell2,4) ;
        centy1(n).cdata(cell2,4)= cell1  ;
        
end

handles.centy1=centy1;
handles.MATRIX=MATRIX;
guidata(hObject, handles);
uiresume



function n_7_Callback(hObject, eventdata, handles)
% hObject    handle to n_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_7 as text
%        str2double(get(hObject,'String')) returns contents of n_7 as a double


% --- Executes during object creation, after setting all properties.
function n_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_1_Callback(hObject, eventdata, handles)
% hObject    handle to n_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_1 as text
%        str2double(get(hObject,'String')) returns contents of n_1 as a double


% --- Executes during object creation, after setting all properties.
function n_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_9_Callback(hObject, eventdata, handles)
% hObject    handle to n_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_9 as text
%        str2double(get(hObject,'String')) returns contents of n_9 as a double


% --- Executes during object creation, after setting all properties.
function n_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cell1_9_Callback(hObject, eventdata, handles)
% hObject    handle to cell1_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell1_9 as text
%        str2double(get(hObject,'String')) returns contents of cell1_9 as a double


% --- Executes during object creation, after setting all properties.
function cell1_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell1_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cell2_9_Callback(hObject, eventdata, handles)
% hObject    handle to cell2_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell2_9 as text
%        str2double(get(hObject,'String')) returns contents of cell2_9 as a double


% --- Executes during object creation, after setting all properties.
function cell2_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell2_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_8_Callback(hObject, eventdata, handles)
% hObject    handle to n_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_8 as text
%        str2double(get(hObject,'String')) returns contents of n_8 as a double


% --- Executes during object creation, after setting all properties.
function n_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cell1_8_Callback(hObject, eventdata, handles)
% hObject    handle to cell1_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell1_8 as text
%        str2double(get(hObject,'String')) returns contents of cell1_8 as a double


% --- Executes during object creation, after setting all properties.
function cell1_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell1_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cell2_8_Callback(hObject, eventdata, handles)
% hObject    handle to cell2_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell2_8 as text
%        str2double(get(hObject,'String')) returns contents of cell2_8 as a double


% --- Executes during object creation, after setting all properties.
function cell2_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell2_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cell1_7_Callback(hObject, eventdata, handles)
% hObject    handle to cell1_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell1_7 as text
%        str2double(get(hObject,'String')) returns contents of cell1_7 as a double


% --- Executes during object creation, after setting all properties.
function cell1_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell1_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cell2_7_Callback(hObject, eventdata, handles)
% hObject    handle to cell2_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell2_7 as text
%        str2double(get(hObject,'String')) returns contents of cell2_7 as a double


% --- Executes during object creation, after setting all properties.
function cell2_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell2_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function new_cell_num_6_Callback(hObject, eventdata, handles)
% hObject    handle to new_cell_num_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of new_cell_num_6 as text
%        str2double(get(hObject,'String')) returns contents of new_cell_num_6 as a double


% --- Executes during object creation, after setting all properties.
function new_cell_num_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_cell_num_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_5_Callback(hObject, eventdata, handles)
% hObject    handle to n_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_5 as text
%        str2double(get(hObject,'String')) returns contents of n_5 as a double


% --- Executes during object creation, after setting all properties.
function n_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_4_Callback(hObject, eventdata, handles)
% hObject    handle to n_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_4 as text
%        str2double(get(hObject,'String')) returns contents of n_4 as a double


% --- Executes during object creation, after setting all properties.
function n_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function new_cell_num_4_Callback(hObject, eventdata, handles)
% hObject    handle to new_cell_num_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of new_cell_num_4 as text
%        str2double(get(hObject,'String')) returns contents of new_cell_num_4 as a double


% --- Executes during object creation, after setting all properties.
function new_cell_num_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_cell_num_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_3_Callback(hObject, eventdata, handles)
% hObject    handle to n_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_3 as text
%        str2double(get(hObject,'String')) returns contents of n_3 as a double


% --- Executes during object creation, after setting all properties.
function n_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function new_cell_num_3_Callback(hObject, eventdata, handles)
% hObject    handle to new_cell_num_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of new_cell_num_3 as text
%        str2double(get(hObject,'String')) returns contents of new_cell_num_3 as a double


% --- Executes during object creation, after setting all properties.
function new_cell_num_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_cell_num_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_2_Callback(hObject, eventdata, handles)
% hObject    handle to n_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_2 as text
%        str2double(get(hObject,'String')) returns contents of n_2 as a double


% --- Executes during object creation, after setting all properties.
function n_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function new_cell_num_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_11_Callback(hObject, eventdata, handles)
% hObject    handle to n_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_11 as text
%        str2double(get(hObject,'String')) returns contents of n_11 as a double


% --- Executes during object creation, after setting all properties.
function n_11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cell1_11_Callback(hObject, eventdata, handles)
% hObject    handle to cell1_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell1_11 as text
%        str2double(get(hObject,'String')) returns contents of cell1_11 as a double


% --- Executes during object creation, after setting all properties.
function cell1_11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell1_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cell2_12_Callback(hObject, eventdata, handles)
% hObject    handle to cell2_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell2_12 as text
%        str2double(get(hObject,'String')) returns contents of cell2_12 as a double


% --- Executes during object creation, after setting all properties.
function cell2_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell2_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_12_Callback(hObject, eventdata, handles)
% hObject    handle to n_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_12 as text
%        str2double(get(hObject,'String')) returns contents of n_12 as a double


% --- Executes during object creation, after setting all properties.
function n_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cell1_12_Callback(hObject, eventdata, handles)
% hObject    handle to cell1_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell1_12 as text
%        str2double(get(hObject,'String')) returns contents of cell1_12 as a double


% --- Executes during object creation, after setting all properties.
function cell1_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell1_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_13_Callback(hObject, eventdata, handles)
% hObject    handle to n_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_13 as text
%        str2double(get(hObject,'String')) returns contents of n_13 as a double


% --- Executes during object creation, after setting all properties.
function n_13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function new_cell_num_13_Callback(hObject, eventdata, handles)
% hObject    handle to new_cell_num_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of new_cell_num_13 as text
%        str2double(get(hObject,'String')) returns contents of new_cell_num_13 as a double


% --- Executes during object creation, after setting all properties.
function new_cell_num_13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_cell_num_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function cell2_11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell2_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cell2_11_Callback(hObject, eventdata, handles)
% hObject    handle to cell2_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell2_11 as text
%        str2double(get(hObject,'String')) returns contents of cell2_11 as a double
