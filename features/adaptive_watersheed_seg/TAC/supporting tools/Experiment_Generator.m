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
function varargout = Experiment_Generator(varargin)
% EXPERIMENT_GENERATOR M-file for Experiment_Generator.fig
%      EXPERIMENT_GENERATOR, by itself, creates a new EXPERIMENT_GENERATOR or raises the existing
%      singleton*.
%
%      H = EXPERIMENT_GENERATOR returns the handle to a new EXPERIMENT_GENERATOR or the handle to
%      the existing singleton*.
%
%      EXPERIMENT_GENERATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENT_GENERATOR.M with the given input arguments.
%
%      EXPERIMENT_GENERATOR('Property','Value',...) creates a new EXPERIMENT_GENERATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Experiment_Generator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Experiment_Generator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Experiment_Generator

% Last Modified by GUIDE v2.5 12-Feb-2013 09:32:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Experiment_Generator_OpeningFcn, ...
    'gui_OutputFcn',  @Experiment_Generator_OutputFcn, ...
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
%  =========================================================
function Experiment_Generator_OpeningFcn(hObject, eventdata, handles, varargin)
set(handles.show_section,'userdata',[]);
guidata(hObject, handles);
handles.output = hObject;
guidata(hObject, handles);
%  =========================================================
function varargout = Experiment_Generator_OutputFcn(hObject, eventdata, handles)


varargout{1} = handles.output;
replaceSlider(hObject,handles);
varargout{1}=  handles.output

function replaceSlider(hFig,handles)
sliderPos = getpixelposition(handles.sliderframes);
delete(handles.sliderframes);
handles.sliderframes = javacomponent('javax.swing.JSlider',sliderPos,hFig);
handles.sliderframes.setEnabled(false);

set(handles.sliderframes,'StateChangedCallback',{@sliderframes_Callback,handles});
guidata(hFig, handles);  % update handles struct


%  =========================================================
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%  =========================================================
function pushbutton8_Callback(hObject, eventdata, handles)
n=get(handles.listbox1,'Value') ;
listbox=get(handles.listbox1,'string')  ;
pathname=get(handles.ch00_Raw_folder,'String');
if (n==1 && n==size(listbox,1))
    new_listbox=[];
    set(handles.listbox1,'string',new_listbox);
    return
end
if (n==1 &&  size(listbox,1)>1)
    for ii=1:(size(listbox,1)-1)
        new_listbox(ii)=listbox(ii+1);
    end
    filename=new_listbox(1);
    filename= strcat(pathname,filename);
    filename=char(filename);
    set(handles.ch00_Raw_folder,'String',pathname);
    set(handles.listbox1,'string',new_listbox);
    return
end
if (n>1 &&  size(listbox,1)>1 && size(listbox,1)>n)
    for ii=1:(n-1)
        new_listbox(ii)=listbox(ii);
    end
    
    for ii=n:(size(listbox,1)-1)
        new_listbox(ii)=listbox(ii+1);
    end
    filename=new_listbox(n);
    filename= strcat(pathname,filename);
    filename=char(filename);
    set(handles.ch00_Raw_folder,'String',pathname);
    set(handles.listbox1,'string',new_listbox);
    return
end
if (n==size(listbox,1) && n>1)
    for  ii=1:(n-1)
        new_listbox(ii)=listbox(ii);
    end
    set(handles.listbox1,'Value',n-1);
    set(handles.listbox1,'string',new_listbox);
    return
end
%  =========================================================
function pushbutton9_Callback(hObject, eventdata, handles)

% ====================================================


% ====================================================


% --- Executes on selection change in ch_3.
function ch_3_Callback(hObject, eventdata, handles)
% hObject    handle to ch_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ch_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ch_3


% --- Executes during object creation, after setting all properties.
function ch_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ch_2.
function ch_2_Callback(hObject, eventdata, handles)
% hObject    handle to ch_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ch_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ch_2


% --- Executes during object creation, after setting all properties.
function ch_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% ------------------------------------------------------------------
function ch_00_Callback(hObject, eventdata, handles)
ch_00=get(handles.ch_00,'Value')
switch ch_00
    case 1
        set(handles.panel_ch00,'visible','off')
    case 2
        set(handles.panel_ch00,'visible','on')
        set(handles.panel_ch00,'foregroundcolor','w')
        set(handles.panel_ch00,'highlightcolor','w')
    case 3
        set(handles.panel_ch00,'visible','on')
        set(handles.panel_ch00,'foregroundcolor','b')
        set(handles.panel_ch00,'highlightcolor','b')
    case 4
        set(handles.panel_ch00,'visible','on')
        set(handles.panel_ch00,'foregroundcolor','g')
        set(handles.panel_ch00,'highlightcolor','g')
    case 5
        set(handles.panel_ch00,'visible','on')
        set(handles.panel_ch00,'foregroundcolor','y')
        set(handles.panel_ch00,'highlightcolor','y')
    case 6
        set(handles.panel_ch00,'visible','on')
        set(handles.panel_ch00,'foregroundcolor',[1 0.2 0])
        set(handles.panel_ch00,'highlightcolor',[1 0.2 0])
    case 7
        set(handles.panel_ch00,'visible','on')
        set(handles.panel_ch00,'foregroundcolor','r')
        set(handles.panel_ch00,'highlightcolor','r')
end
% ------------------------------------------------------------------
function ch_00_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch_00 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ch_1.
function ch_1_Callback(hObject, eventdata, handles)
% hObject    handle to ch_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ch_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ch_1


% --- Executes during object creation, after setting all properties.
function ch_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%  =========================================================
function ch01_Raw_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
function ch02_Raw_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
function pushbutton14_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
function ch01_Filtered_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
function ch02_Filtered_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
function ch3_Filtered_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
function ch01_Segmented_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
function ch02_Segmented_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
function ch03_Segmented_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
function ch00_Raw_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
function ch00_Filtered_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
function ch00_Segmented_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)
%  =========================================================
function setfolder(hObject, eventdata, handles)
current_dir=get(hObject,'String') ;
new_dir=uigetdir(current_dir,'Current Directory');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir);
set(hObject,'String',new_dir) ;
%  =========================================================



function edit_ch00_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ch00 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ch00 as text
%        str2double(get(hObject,'String')) returns contents of edit_ch00 as a double


% --- Executes during object creation, after setting all properties.
function edit_ch00_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ch00 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ch01_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ch01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ch01 as text
%        str2double(get(hObject,'String')) returns contents of edit_ch01 as a double


% --- Executes during object creation, after setting all properties.
function edit_ch01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ch01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ch02_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ch02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ch02 as text
%        str2double(get(hObject,'String')) returns contents of edit_ch02 as a double


% --- Executes during object creation, after setting all properties.
function edit_ch02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ch02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ch_01.
function ch_01_Callback(hObject, eventdata, handles)
ch_01=get(handles.ch_01,'Value')
switch ch_01
    case 1
        set(handles.panel_ch01,'visible','off')
    case 2
        set(handles.panel_ch01,'visible','on')
        set(handles.panel_ch01,'foregroundcolor','w')
        set(handles.panel_ch01,'highlightcolor','w')
    case 3
        set(handles.panel_ch01,'visible','on')
        set(handles.panel_ch01,'foregroundcolor','b')
        set(handles.panel_ch01,'highlightcolor','b')
    case 4
        set(handles.panel_ch01,'visible','on')
        set(handles.panel_ch01,'foregroundcolor','g')
        set(handles.panel_ch01,'highlightcolor','g')
    case 5
        set(handles.panel_ch01,'visible','on')
        set(handles.panel_ch01,'foregroundcolor','y')
        set(handles.panel_ch01,'highlightcolor','y')
        
    case 6
        set(handles.panel_ch01,'visible','on')
        set(handles.panel_ch01,'foregroundcolor',  [1 0.2 0])
        set(handles.panel_ch01,'highlightcolor',  [1 0.2 0])
        
    case 7
        set(handles.panel_ch01,'visible','on')
        set(handles.panel_ch01,'foregroundcolor','r')
        set(handles.panel_ch01,'highlightcolor','r')
end
%  ---------------------------------------
function ch_01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch_01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ch_02.
function ch_02_Callback(hObject, eventdata, handles)
ch_02=get(handles.ch_02,'Value')
switch ch_02
    case 1
        set(handles.panel_ch02,'visible','off')
    case 2
        set(handles.panel_ch02,'visible','on')
        set(handles.panel_ch02,'foregroundcolor','w')
        set(handles.panel_ch02,'highlightcolor','w')
    case 3
        set(handles.panel_ch02,'visible','on')
        set(handles.panel_ch02,'foregroundcolor','b')
        set(handles.panel_ch02,'highlightcolor','b')
    case 4
        set(handles.panel_ch02,'visible','on')
        set(handles.panel_ch02,'foregroundcolor','g')
        set(handles.panel_ch02,'highlightcolor','g')
    case 5
        set(handles.panel_ch02,'visible','on')
        set(handles.panel_ch02,'foregroundcolor','y')
        set(handles.panel_ch02,'highlightcolor','y')
    case 6
        set(handles.panel_ch02,'visible','on')
        set(handles.panel_ch02,'foregroundcolor',  [1 0.2 0])
        set(handles.panel_ch02,'highlightcolor',  [1 0.2 0])
    case 7
        set(handles.panel_ch02,'visible','on')
        set(handles.panel_ch02,'foregroundcolor','r')
        set(handles.panel_ch02,'highlightcolor','r')
end
%  ---------------------------------------
function ch_02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch_02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ch_03.
function ch_03_Callback(hObject, eventdata, handles)
ch_03=get(handles.ch_03,'Value')
switch ch_03
    case 1
        set(handles.panel_ch03,'visible','off')
    case 2
        set(handles.panel_ch03,'visible','on')
        set(handles.panel_ch03,'foregroundcolor','w')
        set(handles.panel_ch03,'highlightcolor','w')
    case 3
        set(handles.panel_ch03,'visible','on')
        set(handles.panel_ch03,'foregroundcolor','b')
        set(handles.panel_ch03,'highlightcolor','b')
    case 4
        set(handles.panel_ch03,'visible','on')
        set(handles.panel_ch03,'foregroundcolor','g')
        set(handles.panel_ch03,'highlightcolor','g')
    case 5
        set(handles.panel_ch03,'visible','on')
        set(handles.panel_ch03,'foregroundcolor','y')
        set(handles.panel_ch03,'highlightcolor','y')
    case 6
        set(handles.panel_ch03,'visible','on')
        set(handles.panel_ch03,'foregroundcolor',  [1 0.2 0])
        set(handles.panel_ch03,'highlightcolor',  [1 0.2 0])
    case 7
        set(handles.panel_ch03,'visible','on')
        set(handles.panel_ch03,'foregroundcolor','r')
        set(handles.panel_ch03,'highlightcolor','r')
end
%  ---------------------------------------
function ch_03_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch_03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ch03_Raw_folder.
function ch03_Raw_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)

% --- Executes on button press in ch03_Filtered_folder.
function ch03_Filtered_folder_Callback(hObject, eventdata, handles)
setfolder(hObject, eventdata, handles)

% --- Executes on button press in ch03_Segmented_folder.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to ch03_Segmented_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_ch03_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ch03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ch03 as text
%        str2double(get(hObject,'String')) returns contents of edit_ch03 as a double


% --- Executes during object creation, after setting all properties.
function edit_ch03_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ch03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ch02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ch02 as text
%        str2double(get(hObject,'String')) returns contents of edit_ch02 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ch02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ch02_Segmented_folder.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to ch02_Segmented_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ch02_Filtered_folder.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to ch02_Filtered_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ch02_Raw_folder.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to ch02_Raw_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ch01_Raw_folder.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to ch01_Raw_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ch01_Filtered_folder.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to ch01_Filtered_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ch01_Segmented_folder.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to ch01_Segmented_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ch01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ch01 as text
%        str2double(get(hObject,'String')) returns contents of edit_ch01 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ch01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton33.


function define_section_name_Callback(hObject, eventdata, handles)
% hObject    handle to define_section_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of define_section_name as text
%        str2double(get(hObject,'String')) returns contents of define_section_name as a double


% --- Executes during object creation, after setting all properties.
function define_section_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to define_section_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ch03_Raw_folder.
function ch03_Raw_folder_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ch03_Raw_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_ch02.
function edit_ch02_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_ch02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Import_settings_file_Callback(hObject, eventdata, handles)
[filename, pathname, filterindex] = uigetfile({  '*.dat','DAT-files (*.dat)';}, 'Please Choose optimal setting file')% handles.directory_name); %pick files to combine
if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end



full_filename= strcat(pathname,filename);
full_filename=char(full_filename);
DATA=importdata(full_filename)  ;





set(handles.ch_00,'Value', str2num(char(DATA(3).cdata(1,1)))+1)
set(handles.ch_01,'Value', str2num(char(DATA(3).cdata(2,1)))+1)
set(handles.ch_02,'Value', str2num(char(DATA(3).cdata(3,1)))+1)
set(handles.ch_03,'Value', str2num(char(DATA(3).cdata(4,1)))+1)


ch_00_Callback(hObject, eventdata, handles)
ch_01_Callback(hObject, eventdata, handles)
ch_02_Callback(hObject, eventdata, handles)
ch_03_Callback(hObject, eventdata, handles)





set(handles.edit_ch00,'string', DATA(3).cdata(1,2));
set(handles.edit_ch01,'string', DATA(3).cdata(2,2));
set(handles.edit_ch02,'string', DATA(3).cdata(3,2));
set(handles.edit_ch03,'string', DATA(3).cdata(4,2));







% --------------------------------------------------------------------
function Export_settings_file_Callback(hObject, eventdata, handles)
[filename, pathname, filterindex] = uiputfile({  '*.dat','DAT-files (*.dat)';}, 'save  optimal settings');
if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
regexprep(filename, 'TACTICS_SETUP_','')
full_filename= strcat(pathname,'TACTICS_SETUP_',filename) ;
full_filename=char(full_filename);


ch_0=get(handles.ch_00,'Value')-1;
ch_1=get(handles.ch_01,'Value')-1 ;
ch_2=get(handles.ch_02,'Value')-1;
ch_3=get(handles.ch_03,'Value')-1;

if ch_0==0
    Y=wavread('Error');
    h = errordlg('Chanel 0 must be defined!','Error');
    sound(Y,22000);
    return
end

DATA(3).cdata=cell(4,2) ;
DATA(3).cdata(1,1)=cellstr(num2str(ch_0));
DATA(3).cdata(2,1)=cellstr(num2str(ch_1));
DATA(3).cdata(3,1)=cellstr(num2str(ch_2));
DATA(3).cdata(4,1)=cellstr(num2str(ch_3));

DATA(3).cdata(1,2)=cellstr(get(handles.edit_ch00,'string'));
DATA(3).cdata(2,2)=cellstr(get(handles.edit_ch01,'string'));
DATA(3).cdata(3,2)=cellstr(get(handles.edit_ch02,'string'));
DATA(3).cdata(4,2)=cellstr(get(handles.edit_ch03,'string'));


save(full_filename, 'DATA') ;















% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)


close
run



% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
new_dir=uigetdir('Current Directory','Please select folder containing the subfolders of the positions');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end

pathname=strcat(new_dir,'\');
set(handles.pathname,'string',pathname);
guidata(hObject,handles);

jj=1;


[list_of_folders]=read_list_of_folders(pathname) %maybe 1, maybe more

if isempty(list_of_folders)==1
    return
end



h =waitbar(0.5,'Please wait....');
set(h ,'color','w');
while size(list_of_folders,2)>0
    'loop 1'
    [temp_list_of_folders]=read_list_of_folders(char(list_of_folders(1)));
    
    if      isempty(strfind(char(list_of_folders(1)),'Projection'))==1    &&   ( isempty(strfind(char(list_of_folders(1)),'pos'))~=1 ||  isempty(strfind(char(list_of_folders(1)),'Pos'))~=1 )
        filename_str(jj)= list_of_folders(1) ; jj=jj+1;
    end
    
    
    
    
    list_of_folders(1)=[]
    while size(temp_list_of_folders,2)>0
        'loop 2'
        [temp2_list_of_folders]=read_list_of_folders(char(temp_list_of_folders(1)));
        
        
        if  isempty(strfind(char(temp_list_of_folders(1)),'Projection'))==1    &&   ( isempty(strfind(char(temp_list_of_folders(1)),'pos'))~=1 ||  isempty(strfind(char(temp_list_of_folders(1)),'Pos'))~=1 )
            filename_str(jj)= temp_list_of_folders(1) ; jj=jj+1;
        end
        
        temp_list_of_folders(1)=[] ;
        while size(temp2_list_of_folders,2)>0
            'loop 3'
            [temp3_list_of_folders]=read_list_of_folders(char(temp2_list_of_folders(1)));
            if  isempty(strfind(char(temp2_list_of_folders(1)),'Projection'))==1    &&   ( isempty(strfind(char(temp2_list_of_folders(1)),'pos'))~=1 ||  isempty(strfind(char(temp2_list_of_folders(1)),'Pos'))~=1 )
                filename_str(jj)= temp2_list_of_folders(1) ; jj=jj+1;
            end
            temp2_list_of_folders(1)=[] ;
            
            
            while size(temp3_list_of_folders,2)>0
                'loop 4'
                [temp4_list_of_folders]=read_list_of_folders(char(temp3_list_of_folders(1)));
                if  isempty(strfind(char(temp3_list_of_folders(1)),'Projection'))==1    &&   ( isempty(strfind(char(temp3_list_of_folders(1)),'pos'))~=1 ||  isempty(strfind(char(temp3_list_of_folders(1)),'Pos'))~=1 )
                    filename_str(jj)= temp3_list_of_folders(1) ; jj=jj+1;
                end
                temp3_list_of_folders(1)=[]
                while size(temp4_list_of_folders,2)>0
                    'loop 5'
                    [temp5_list_of_folders]=read_list_of_folders(char(temp4_list_of_folders(1)));
                    if  isempty(strfind(char(temp4_list_of_folders(1)),'Projection'))==1    &&   ( isempty(strfind(char(temp4_list_of_folders(1)),'pos'))~=1 ||  isempty(strfind(char(temp4_list_of_folders(1)),'Pos'))~=1 )
                        filename_str(jj)= temp4_list_of_folders(1) ; jj=jj+1;
                    end
                    temp4_list_of_folders(1)=[]  ;
                end
            end
        end
    end
end



%command error if there is only one position here
set(handles.listbox1,'string',filename_str);
set(handles.listbox1,'Max',size(filename_str,1)) ;
set(handles.listbox1,'Value',1) ;
set(handles.listbox1,'Min',0);
set(handles.listbox1,'value',1)
close(h)
 


% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
 
new_dir=uigetdir('Current Directory','Please select folder containing the subfolders of the positions');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end

pathname=strcat(new_dir,'\') ;
 list_of_folders =read_list_of_folders(pathname)  ;
 
 
 

find_ind=findstr(pathname , '\\') ;
if isempty(find_ind)~=1
    pathname(find_ind)=[] ;
end
set(handles.pathname,'string',pathname);
% guidata(hObject,handles);
%  
 clc
 list_of_folders =read_list_of_folders(pathname)  ;

if isempty(list_of_folders)==1
    return
end 
%command error if there is only one position here
set(handles.listbox1,'string',list_of_folders);
set(handles.listbox1,'Max',size(list_of_folders,1)) ;
set(handles.listbox1,'Value',1) ;
set(handles.listbox1,'Min',0);
set(handles.listbox1,'value',1)




% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_12_Callback(hObject, eventdata, handles)
new_dir=uigetdir('Current Directory','Please select folder containing the subfolders of the positions');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end

pathname=strcat(new_dir,'\');
set(handles.pathname,'string',pathname);
guidata(hObject,handles);


h=waitbar(0.1,'Searching for dat files. Please wait ....');
set(h,'color','w');






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
            jjj=jjj+1
        end
        
        
        
    end
end
cur_dat_name=dir(char(strcat(new_dir  ,'\*.dat')))
for jj=1:size(cur_dat_name,1)
    filename_str(jjj)=cellstr(strcat(new_dir ,'\',  cur_dat_name(jj).name))
    jjj=jjj+1
end

filename_str=char(filename_str)
set(handles.listbox1,'String',filename_str);
set(handles.listbox1,'Max',n) ;
set(handles.listbox1,'Value',1) ;
set(handles.listbox1,'Min',0);
close(h)



% --------------------------------------------------------------------
function Untitled_13_Callback(hObject, eventdata, handles)
filename_str= cellstr(get(handles.listbox1,'string'))  ;
filename_str=filename_str';



ch_0=get(handles.ch_00,'Value')-1;
ch_1=get(handles.ch_01,'Value')-1 ;
ch_2=get(handles.ch_02,'Value')-1;
ch_3=get(handles.ch_03,'Value')-1;









h=timebar('Calculating....');
set(h,'color','w');



for ii=1:size(filename_str,2)
    timebar(h,ii/size(filename_str,2) )
    set(handles.listbox1,'value',ii)
    %Manual correction for sometimes
    data_file=importdata(char( filename_str(ii)))
    
    
    cellstr(num2str(ch_0))
    cellstr(num2str(ch_1))
    cellstr(get(handles.edit_ch00,'string'))
    cellstr(get(handles.edit_ch01,'string'))
    
    data_file(3).cdata=cell(4,2) ;
    data_file(3).cdata(1,1)=cellstr(num2str(ch_0))
    data_file(3).cdata(2,1)=cellstr(num2str(ch_1))
    data_file(3).cdata(3,1)=cellstr(num2str(ch_2))
    data_file(3).cdata(4,1)=cellstr(num2str(ch_3))
    
    data_file(3).cdata(1,2)=cellstr(get(handles.edit_ch00,'string'))
    data_file(3).cdata(2,2)=cellstr(get(handles.edit_ch01,'string'))
    data_file(3).cdata(3,2)=cellstr(get(handles.edit_ch02,'string'))
    data_file(3).cdata(4,2)=cellstr(get(handles.edit_ch03,'string'))
    
    
    
    data_file(10).cdata=char(filename_str(ii));
    
    
    
    
    %     data_file(7).cdata(2,1)= cellstr('N');
    %      data_file(7).cdata(2,2)= cellstr('N');
    %  data_file(7).cdata(1,1)= cellstr('Y');
    %          data_file(7).cdata(1,2)= cellstr('Y');
    
    pause(2)
    
    %      data_file(9).cdata=8;
    save (char( filename_str(ii)) ,  'data_file')
    % char( filename_str(ii))
    
end
timebar('Readys :)');



% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_17_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_18_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_19_Callback(hObject, eventdata, handles)

listbox2=get(handles.listbox2,'String')
ch_0=get(handles.ch_00,'Value')-1;
ch_1=get(handles.ch_01,'Value')-1 ;
ch_2=get(handles.ch_02,'Value')-1;
ch_3=get(handles.ch_03,'Value')-1;
active=4;
if ch_0==0
    Y=wavread('Error');
    h = errordlg('Chanel 0 must be defined!','Error');
    sound(Y,22000);
    return
end
if ch_1==0
    active=active-1 ;
end
if ch_2==0
    active=active-1;
end
if ch_3==0
    active=active-1 ;
end
if iscell(listbox2)~=0
    %      -----------------
    n=size(listbox2,1); %ch 0
    jj=1;
    index_listbox2_ch_0=[]
    for ii=1:n
        file_name= char(listbox2(ii));
        if isempty(findstr(file_name,'ch00.tif'))~=0
            index_listbox2_ch_0(jj)=ii;
            jj=jj+1;
        end
    end
    clc
    if ch_1~=0 %ch 1
        jj=1
        index_listbox2_ch_1=[]
        for ii=1:n
            file_name= char(listbox2(ii));
            if isempty(findstr(file_name,'ch01.tif'))~=0
                index_listbox2_ch_1(jj)=ii;
                jj=jj+1;
            end
        end
        if length(index_listbox2_ch_1)~=length(index_listbox2_ch_0)
            Y=wavread('Error');
            h = errordlg('Should be same files in Chanel 0 and 1','Error');
            sound(Y,22000);
            return
        end
        for iii=1:n
            data_file(8).cdata(1).Frame(iii).DATA(1).vector =zeros(1,24);
            data_file(8).cdata(1).Frame(iii).DATA(2).vector =zeros(1,11);
        end
    end
    
    
    if ch_2~=0 %ch 2
        jj=1
        index_listbox2_ch_2=[]
        for ii=1:n
            file_name= char(listbox2(ii));
            if isempty(findstr(file_name,'ch02.tif'))~=0
                index_listbox2_ch_2(jj)=ii;
                jj=jj+1;
            end
        end
        if length(index_listbox2_ch_2)~=length(index_listbox2_ch_0)
            Y=wavread('Error');
            h = errordlg('Should be same files in Chanel 0 and 2','Error');
            sound(Y,22000);
            return
        end
        for iii=1:n
            data_file(8).cdata(2).Frame(iii).DATA(1).vector =zeros(1,24);
            data_file(8).cdata(2).Frame(iii).DATA(2).vector =zeros(1,11);
        end
    end
    if ch_3~=0 %ch 3
        jj=1
        index_listbox2_ch_3=[]
        for ii=1:n
            file_name= char(listbox2(ii));
            if isempty(findstr(file_name,'ch03.tif'))~=0
                index_listbox2_ch_3(jj)=ii;
                jj=jj+1;
            end
        end
        if length(index_listbox2_ch_3)~=length(index_listbox2_ch_0)
            Y=wavread('Error');
            h = errordlg('Should be same files in Chanel 0 and 3','Error');
            sound(Y,22000);
            return
        end
        for iii=1:n
            data_file(8).cdata(3).Frame(iii).DATA(1).vector =zeros(1,24);
            data_file(8).cdata(3).Frame(iii).DATA(2).vector =zeros(1,11);
        end
    end
    %     -----------------
    
    
    %     listbox2(index_listbox2_ch_0)=[];
    %    listbox2= filename_str
    n=length(listbox2);
    iiii=1;
    zz=cell(1,1); zz(1)=cellstr('empty');
    for   ii=1:n
        
        file_name= char(listbox2(ii));
        file_name= char(regexprep(file_name, '_ch00', ''));
        file_name= char(regexprep(file_name, '_ch01', ''));
        file_name= char(regexprep(file_name, '_ch02', ''));
        file_name= char(regexprep(file_name, '_ch03', ''));
        file_name= char(regexprep(file_name, '_ch04', ''));
        file_name= char(regexprep(file_name, '_ch05', ''));
        file_name= char(regexprep(file_name, '.tif', ''));
        
        stat=0;
        for iii=1:length(zz)
            
            
            if isempty(strfind(file_name,char(zz(iii))))==0
                stat=1; break
            end
        end
        
        if stat==0
            zz(iiii)=  cellstr(file_name);iiii=iiii+1;
            
        end
    end
    
    
    % data_file(1).cdata=cell(length(listbox2),1) ;
    data_file(1).cdata(:,1)=zz;%listbox2;
    
    data_file(2).cdata=cell(9,3) ; %
    
    %
    %     for ii=1:9
    %         pathname_filtered_default=strcat(handles.pathname,'\ch0',num2str(ii),'_Filtered');
    %         mkdir(pathname_filtered_default)
    %         data_file(2).cdata(ii,2)=cellstr(char(pathname_filtered_default));
    %
    %         pathname_Segmented_default=strcat(handles.pathname,'\ch0',num2str(ii),'_Segmented');
    %         mkdir(pathname_Segmented_default)
    %         data_file(2).cdata(ii,3)=cellstr(char(pathname_Segmented_default));
    %     end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    pathname_temp= get(handles.ch00_Raw_folder,'String');
    pathname_temp
    mkdir(pathname_temp)
    data_file(2).cdata(1,1)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch01_Raw_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(2,1)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch02_Raw_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(3,1)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch03_Raw_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(4,1)=cellstr(char(pathname_temp));
    
    pathname_temp= get(handles.ch00_Filtered_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(1,2)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch01_Filtered_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(2,2)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch02_Filtered_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(3,2)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch03_Filtered_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(4,2)=cellstr(char(pathname_temp));
    
    
    pathname_temp= get(handles.ch00_Segmented_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(1,3)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch01_Segmented_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(2,3)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch02_Segmented_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(3,3)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch03_Segmented_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(4,3)=cellstr(char(pathname_temp));
    
    
    
    for ii=4:20
        data_file(2).cdata(ii,1)=data_file(2).cdata(1,1);
        if ii<10
            newstr=char(strcat('ch0',num2str(ii))) ;
        else
            newstr=char(strcat('ch',num2str(ii)))  ;
        end
        stremp2=regexprep(data_file(2).cdata(1,2) ,'ch00', newstr) ;
        data_file(2).cdata(ii,2)= stremp2;
        stremp3=regexprep(data_file(2).cdata(1,3) ,'ch00', newstr) ;
        data_file(2).cdata(ii,3)= stremp3;
    end
    
    %     data_file(2).cdata(1,5)=pathname_temp;
    %     data_file(2).cdata(2,5)=pathname_temp;
    %     data_file(2).cdata(3,5)=pathname_temp;
    
    data_file(3).cdata=cell(4,2) ;
    data_file(3).cdata(1,1)=cellstr(num2str(ch_0));
    data_file(3).cdata(2,1)=cellstr(num2str(ch_1));
    data_file(3).cdata(3,1)=cellstr(num2str(ch_2));
    data_file(3).cdata(4,1)=cellstr(num2str(ch_3));
    
    data_file(3).cdata(1,2)=cellstr(get(handles.edit_ch00,'string'));
    data_file(3).cdata(2,2)=cellstr(get(handles.edit_ch01,'string'));
    data_file(3).cdata(3,2)=cellstr(get(handles.edit_ch02,'string'));
    data_file(3).cdata(4,2)=cellstr(get(handles.edit_ch03,'string'));
    
    
    data_file(7).cdata=cell(6,2) ; %flags for tracking and labeling status (with label is easy only has to use isempty(centy1) command
    data_file(7).cdata(1,1)=cellstr('N');
    data_file(7).cdata(2,1)=cellstr('N');
    data_file(7).cdata(3,1)=cellstr('N');
    data_file(7).cdata(4,1)=cellstr('N');
    data_file(7).cdata(5,1)=cellstr('N');
    data_file(7).cdata(6,1)=cellstr('N');
    data_file(7).cdata(1,2)=cellstr('N');
    data_file(7).cdata(2,2)=cellstr('N');
    data_file(7).cdata(3,2)=cellstr('N');
    data_file(7).cdata(4,2)=cellstr('N');
    data_file(7).cdata(5,2)=cellstr('N');
    data_file(7).cdata(6,2)=cellstr('N');
    
    
    
    
    
    
    
    for ii=1:active
        data_file(4).cdata.Centroids(ii).cdata=[];
    end
    for ii=1:active
        data_file(4).cdata.L(ii).cdata=[];
    end
    for ii=1:active
        data_file(5).cdata.Tracks(ii).cdata=[];
    end
    
    sectionXY= get(handles.show_section,'userdata');
    
    filename= listbox2(1) ;
    pathname = get(handles.ch00_Raw_folder,'String');
    full_filename= char(strcat(pathname,filename));
    info=imfinfo(full_filename);
    
    data_file(6).cdata= [1 1  info.Width  info. Height];
    data_file(9).cdata=info.BitDepth;
    if isempty( sectionXY)~=1
        data_file(11).cdata= sectionXY;
    end
    
    
    
    
    
    handles.data_file=data_file;
    guidata(hObject,handles);
    
end

pathname=get(handles.pathname,'string');
str=pathname( strfind(pathname,'\pos'):end);
str_index=find(ismember(str,'\')) ;
str(str_index)=[]  ;
more_str=get(handles.define_section_name,'String');
filename=strcat(pathname,'TACTICS_EXP_New_',str,more_str ,'.dat')  ;
%This it the principle: the temp experiment should not be overwriiten
%completed experiments file by mistake.

temp=handles.data_file;
temp(10).cdata=filename;
save ( filename  ,  'temp');

close
clc

run
% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_20_Callback(hObject, eventdata, handles)
handles.directory_name= get(handles.ch00_Raw_folder,'String');
[filename, pathname, filterindex] = uigetfile({  '*.tif','Tif-files (*.tif)';}, 'Please Choose raw tif files','MultiSelect', 'on', handles.directory_name); %pick files to combine
if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
handles.select='files';
set(handles.pathname,'string',pathname);

set(handles.ch00_Raw_folder,'String',pathname);


set(handles.ch01_Raw_folder,'String',pathname);


set(handles.ch02_Raw_folder,'String',pathname);


set(handles.ch03_Raw_folder,'String',pathname);


pathname_temp= strcat(pathname,'ch00_Filtered\');
set(handles.ch00_Filtered_folder,'String',pathname_temp);

pathname_temp= strcat(pathname,'ch01_Filtered\');
set(handles.ch01_Filtered_folder,'String',pathname_temp);

pathname_temp= strcat(pathname,'ch02_Filtered\');
set(handles.ch02_Filtered_folder,'String',pathname_temp);

pathname_temp= strcat(pathname,'ch03_Filtered\');
set(handles.ch03_Filtered_folder,'String',pathname_temp);

pathname_temp= strcat(pathname,'ch00_Segmented\');
set(handles.ch00_Segmented_folder,'String',pathname_temp);

pathname_temp= strcat(pathname,'ch01_Segmented\');
set(handles.ch01_Segmented_folder,'String',pathname_temp);

pathname_temp= strcat(pathname,'ch02_Segmented\');
set(handles.ch02_Segmented_folder,'String',pathname_temp);

pathname_temp= strcat(pathname,'ch03_Segmented\');
set(handles.ch03_Segmented_folder,'String',pathname_temp);


if  iscell(filename)==0  %Only one image was sellected
    filename_for_listbox=cellstr(filename);
    filename_for_listbox=cell(filename_for_listbox);
    set(handles.listbox2,'String',filename_for_listbox);
    set(handles.listbox2,'Max',1)
    set(handles.listbox2,'Value',1)
    set(handles.listbox2,'Min',0)
    full_filename= strcat(pathname,filename);
    full_filename=cellstr( full_filename);
else  %Multiple images were selected
    set(handles.listbox2,'String',filename);
    set(handles.listbox2,'Max',size(filename,2))
    set(handles.listbox2,'Value',1)
    set(handles.listbox2,'Min',0)
    filename=filename(1) ;
    full_filename= strcat(pathname,filename);
end

numFiles =size(filename,2);
set(handles.sliderframes, 'Value',1, 'Maximum',numFiles, 'Minimum',1);
try
    handles.sliderframes.setEnabled(true);  % Java JSlider
catch
    set(handles.sliderframes, 'Enable','on', 'SliderStep',[1/numFiles, 0.1]);  % Matlab scrollbar
end


guidata(hObject,handles);


% --------------------------------------------------------------------
function Untitled_21_Callback(hObject, eventdata, handles)

pathname = uigetdir;
if isequal(pathname,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
pathname =strcat(pathname,'\');
handles.select='folder';
set(handles.pathname,'string',pathname);

set(handles.ch00_Raw_folder,'String',pathname);
set(handles.ch01_Raw_folder,'String',pathname);
set(handles.ch02_Raw_folder,'String',pathname);
set(handles.ch03_Raw_folder,'String',pathname);




pathname_temp= strcat(pathname,'ch00_Filtered\');
set(handles.ch00_Filtered_folder,'String',pathname_temp);
pathname_temp= strcat(pathname,'ch01_Filtered\');
set(handles.ch01_Filtered_folder,'String',pathname_temp);
pathname_temp= strcat(pathname,'ch02_Filtered\');
set(handles.ch02_Filtered_folder,'String',pathname_temp);
pathname_temp= strcat(pathname,'ch03_Filtered\');
set(handles.ch03_Filtered_folder,'String',pathname_temp);


pathname_temp= strcat(pathname,'ch00_Segmented\');
set(handles.ch00_Segmented_folder,'String',pathname_temp);
pathname_temp= strcat(pathname,'ch01_Segmented\');
set(handles.ch01_Segmented_folder,'String',pathname_temp);
pathname_temp= strcat(pathname,'ch02_Segmented\');
set(handles.ch02_Segmented_folder,'String',pathname_temp);
pathname_temp= strcat(pathname,'ch03_Segmented\');
set(handles.ch03_Segmented_folder,'String',pathname_temp);



str=strcat(pathname,'*.tif');
dir_filename=dir(str);
jj=0;
for ii=1:size(dir_filename,1)
    if    isempty(findstr(dir_filename(ii).name,'tif'))~=1
        jj=jj+1 ;
    end
end



filename_str=cell(jj,1);

jj=1;
for ii=1:size(dir_filename,1)
    if    isempty(findstr(dir_filename(ii).name,'tif'))~=1
        filename_str(jj)=cellstr(dir_filename(ii).name) ; jj=jj+1;
    end
end




temp=strfind(filename_str,'ch00');
ind=[];
for ii=1:size(temp,2)
    if isempty(cell2mat(temp(ii)))  ;
        ind(ii)=1;
    end
end
handles.index_ch00= find(ismember(ind,0));


set(handles.listbox2,'String',filename_str);
set(handles.listbox2,'Max',size(dir_filename,1)) ;
set(handles.listbox2,'Value',1) ;
set(handles.listbox2,'Min',0);

numFiles =size(dir_filename,1)  ;
set(handles.sliderframes, 'Value',1, 'Maximum',numFiles, 'Minimum',1);
try
    handles.sliderframes.setEnabled(true);  % Java JSlider
catch
    set(handles.sliderframes, 'Enable','on', 'SliderStep',[1/numFiles, 0.1]);  % Matlab scrollbar
end


guidata(hObject,handles);
listbox2_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function Untitled_23_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_24_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_27_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_28_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function Untitled_26_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_29_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_30_Callback(hObject, eventdata, handles)
[filename, pathname, filterindex] = uiputfile({  '*.dat','Dat-files (*.dat)';}, 'save  session to a data file');
if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
filename=regexprep(filename, 'TACTICS_EXP_','');
full_filename= strcat(pathname,'TACTICS_EXP_',filename) ;
full_filename=char(full_filename);

Raw_listbox=get(handles.listbox1,'String')

DATA= handles.data_file;

if iscell(Raw_listbox)~=0
    DATA(1).cdata=cell(length(Raw_listbox),1) ;
    DATA(1).cdata(:,1)=Raw_listbox;
end




ch_0=get(handles.ch_00,'Value')-1;
ch_1=get(handles.ch_01,'Value')-1 ;
ch_2=get(handles.ch_02,'Value')-1;
ch_3=get(handles.ch_03,'Value')-1;

if ch_0==0
    Y=wavread('Error');
    h = errordlg('Chanel 0 must be defined!','Error');
    sound(Y,22000);
    return
end

DATA(3).cdata=cell(20,2) ;
DATA(3).cdata(1,1)=cellstr(num2str(ch_0));
DATA(3).cdata(2,1)=cellstr(num2str(ch_1));
DATA(3).cdata(3,1)=cellstr(num2str(ch_2));
DATA(3).cdata(4,1)=cellstr(num2str(ch_3));
DATA(3).cdata(5,1)=cellstr('5');
DATA(3).cdata(6,1)=cellstr('5');
DATA(3).cdata(7,1)=cellstr('5');
DATA(3).cdata(8,1)=cellstr('5');
DATA(3).cdata(9,1)=cellstr('5');
DATA(3).cdata(10,1)=cellstr('5');
DATA(3).cdata(11,1)=cellstr('5');
DATA(3).cdata(12,1)=cellstr('5');
DATA(3).cdata(13,1)=cellstr('5');
DATA(3).cdata(14,1)=cellstr('5');
DATA(3).cdata(15,1)=cellstr('5');
DATA(3).cdata(16,1)=cellstr('5');
DATA(3).cdata(17,1)=cellstr('5');
DATA(3).cdata(18,1)=cellstr('5');
DATA(3).cdata(19,1)=cellstr('5');
DATA(3).cdata(20,1)=cellstr('5');




DATA(3).cdata(1,2)=cellstr(get(handles.edit_ch00,'string'));
DATA(3).cdata(2,2)=cellstr(get(handles.edit_ch01,'string'));
DATA(3).cdata(3,2)=cellstr(get(handles.edit_ch02,'string'));
DATA(3).cdata(4,2)=cellstr(get(handles.edit_ch03,'string'));
DATA(3).cdata(5,2)=cellstr('v5');
DATA(3).cdata(6,2)=cellstr('v6');
DATA(3).cdata(7,2)=cellstr('v7');
DATA(3).cdata(8,2)=cellstr('v8');
DATA(3).cdata(9,2)=cellstr('v9');
DATA(3).cdata(10,2)=cellstr('v10');
DATA(3).cdata(11,2)=cellstr('v11');
DATA(3).cdata(12,2)=cellstr('v12');
DATA(3).cdata(13,2)=cellstr('v13');
DATA(3).cdata(14,2)=cellstr('v14');
DATA(3).cdata(15,2)=cellstr('v15');
DATA(3).cdata(16,2)=cellstr('v16');
DATA(3).cdata(17,2)=cellstr('v17');
DATA(3).cdata(18,2)=cellstr('v18');
DATA(3).cdata(19,2)=cellstr('v19');
DATA(3).cdata(20,2)=cellstr('v20');

save(full_filename, 'DATA') ;


% --------------------------------------------------------------------
function Untitled_31_Callback(hObject, eventdata, handles)
[filename, pathname, filterindex] = uigetfile({  '*.dat','dat-files (*.dat)';}, 'Please Choose experiment DATA file')% handles.directory_name); %pick files to combine
if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end


full_filename= strcat(pathname,filename);
full_filename=char(full_filename);

DATA=importdata(full_filename)  ;
str=DATA(1).cdata  ;
set(handles.listbox1,'Value',1)
set(handles.listbox1,'String', str(:,1))


set(handles.ch_00,'Value', str2num(char(DATA(3).cdata(1,1)))+1)
set(handles.ch_01,'Value', str2num(char(DATA(3).cdata(2,1)))+1)
set(handles.ch_02,'Value', str2num(char(DATA(3).cdata(3,1)))+1)
set(handles.ch_03,'Value', str2num(char(DATA(3).cdata(4,1)))+1)


ch_00_Callback(hObject, eventdata, handles)
ch_01_Callback(hObject, eventdata, handles)
ch_02_Callback(hObject, eventdata, handles)
ch_03_Callback(hObject, eventdata, handles)





set(handles.edit_ch00,'string', DATA(3).cdata(1,2));
set(handles.edit_ch01,'string', DATA(3).cdata(2,2));
set(handles.edit_ch02,'string', DATA(3).cdata(3,2));
set(handles.edit_ch03,'string', DATA(3).cdata(4,2));


handles.data_file=DATA;
guidata(hObject,handles);


% --------------------------------------------------------------------
function Untitled_32_Callback(hObject, eventdata, handles)


DATA=[];
ch_0=get(handles.ch_00,'Value')-1;
ch_1=get(handles.ch_01,'Value')-1 ;
ch_2=get(handles.ch_02,'Value')-1;
ch_3=get(handles.ch_03,'Value')-1;

if ch_0==0
    Y=wavread('Error');
    h = errordlg('Chanel 0 must be defined!','Error');
    sound(Y,22000);
    return
end

active=4;
if ch_0==0
    Y=wavread('Error');
    h = errordlg('Chanel 0 must be defined!','Error');
    sound(Y,22000);
    return
end
if ch_1==0
    active=active-1 ;
end
if ch_2==0
    active=active-1;
end
if ch_3==0
    active=active-1 ;
end

DATA=[];
DATA(3).cdata=cell(4,2) ;
DATA(3).cdata(1,1)=cellstr(num2str(ch_0));
DATA(3).cdata(2,1)=cellstr(num2str(ch_1));
DATA(3).cdata(3,1)=cellstr(num2str(ch_2));
DATA(3).cdata(4,1)=cellstr(num2str(ch_3));

DATA(3).cdata(1,2)=cellstr(get(handles.edit_ch00,'string'));
DATA(3).cdata(2,2)=cellstr(get(handles.edit_ch01,'string'));
DATA(3).cdata(3,2)=cellstr(get(handles.edit_ch02,'string'));
DATA(3).cdata(4,2)=cellstr(get(handles.edit_ch03,'string'));

DATA(2).cdata=cell(9,3) ; %




for ii=1:active
    DATA(4).cdata.Centroids(ii).cdata=[];
end
for ii=1:active
    DATA(4).cdata.L(ii).cdata=[];
end
for ii=1:active
    DATA(5).cdata.Tracks(ii).cdata=[];
end

DATA(7).cdata=cell(6,2) ; %flags for tracking and labeling status (with label is easy only has to use isempty(centy1) command
DATA(7).cdata(1,1)=cellstr('N');
DATA(7).cdata(2,1)=cellstr('N');
DATA(7).cdata(3,1)=cellstr('N');
DATA(7).cdata(4,1)=cellstr('N');
DATA(7).cdata(5,1)=cellstr('N');
DATA(7).cdata(6,1)=cellstr('N');
DATA(7).cdata(1,2)=cellstr('N');
DATA(7).cdata(2,2)=cellstr('N');
DATA(7).cdata(3,2)=cellstr('N');
DATA(7).cdata(4,2)=cellstr('N');
DATA(7).cdata(5,2)=cellstr('N');
DATA(7).cdata(6,2)=cellstr('N');

try
Data= handles.temp2(2).cdata;
end
listbox1=get(handles.listbox1,'string');
for nn=1:size(listbox1,1)
    set(handles.listbox1,  'value',nn)
    %      pathname= char( listbox1(nn));
    %  str=strcat( pathname,'\*.tif') ;
    
    
    data_file=[];
    data_file=DATA;
    %        pathname=listbox1(nn);
    %
    % if isequal(pathname,0)  %$#1
    %     h = msgbox('User selected Cancel','Aborted');
    %    return;
    % end
    pathname =char(strcat(listbox1(nn),'\'));
    
    
    
    pathname_temp= char(strcat(pathname)) ;    mkdir(pathname_temp) ;    data_file(2).cdata(1,1)=cellstr(char(pathname_temp));
    pathname_temp= char(strcat(pathname));     mkdir(pathname_temp) ;    data_file(2).cdata(2,1)=cellstr(char(pathname_temp));
    pathname_temp= char(strcat(pathname));     mkdir(pathname_temp) ;    data_file(2).cdata(3,1)=cellstr(char(pathname_temp));
    pathname_temp= char(strcat(pathname));     mkdir(pathname_temp) ;    data_file(2).cdata(4,1)=cellstr(char(pathname_temp));
    
    pathname_temp= char(strcat(pathname,'ch00_Filtered\'));     mkdir(pathname_temp) ;    data_file(2).cdata(1,2)=cellstr(char(pathname_temp));
    pathname_temp= char(strcat(pathname,'ch01_Filtered\'));     mkdir(pathname_temp) ;    data_file(2).cdata(2,2)=cellstr(char(pathname_temp));
    pathname_temp= char(strcat(pathname,'ch02_Filtered\'));     mkdir(pathname_temp) ;    data_file(2).cdata(3,2)=cellstr(char(pathname_temp));
    pathname_temp= char(strcat(pathname,'ch03_Filtered\'));     mkdir(pathname_temp) ;    data_file(2).cdata(4,2)=cellstr(char(pathname_temp));
    
    pathname_temp= char(strcat(pathname,'ch00_Segmented\'));     mkdir(pathname_temp) ;    data_file(2).cdata(1,3)=cellstr(char(pathname_temp));
    pathname_temp= char(strcat(pathname,'ch01_Segmented\'));    mkdir(pathname_temp) ;    data_file(2).cdata(2,3)=cellstr(char(pathname_temp));
    pathname_temp= char(strcat(pathname,'ch02_Segmented\'));    mkdir(pathname_temp) ;    data_file(2).cdata(3,3)=cellstr(char(pathname_temp));
    pathname_temp= char(strcat(pathname,'ch03_Segmented\'));   mkdir(pathname_temp) ;    data_file(2).cdata(4,3)=cellstr(char(pathname_temp));
    
    
    
    
    str=char(strcat(pathname,'*.tif'));
    dir_filename=dir(str);
    jj=0;
    for ii=1:size(dir_filename,1)
        if    isempty(findstr(dir_filename(ii).name,'tif'))~=1
            jj=jj+1 ;
        end
    end
    
    
    
    Raw_listbox =cell(jj,1);
    
    jj=1;
    for ii=1:size(dir_filename,1)
        if    isempty(findstr(dir_filename(ii).name,'tif'))~=1
            Raw_listbox(jj)=cellstr(dir_filename(ii).name) ; jj=jj+1;
        end
    end
    
    
    
    
    
    n=length(Raw_listbox);
    iiii=1;
    zz=cell(1,1); zz(1)=cellstr('empty');
    for   ii=1:n
        file_name= char(Raw_listbox(ii));
        file_name= char(regexprep(file_name, '_ch00', ''));
        file_name= char(regexprep(file_name, '_ch01', ''));
        file_name= char(regexprep(file_name, '_ch02', ''));
        file_name= char(regexprep(file_name, '_ch03', ''));
        file_name= char(regexprep(file_name, '_ch04', ''));
        file_name= char(regexprep(file_name, '_ch05', ''));
        file_name= char(regexprep(file_name, '.tif', ''));
        stat=0;
        for iii=1:length(zz)
            if isempty(strfind(file_name,char(zz(iii))))==0
                stat=1; break
            end
        end
        if stat==0
            zz(iiii)=  cellstr(file_name);iiii=iiii+1;
        end
    end
    % data_file(1).cdata=cell(length(listbox1),1) ;
    data_file(1).cdata(:,1)=zz;%Raw_listbox;
    
    
    
    %           ------------
    
    
    if iscell(Raw_listbox)==0
        return
    end
    %      -----------------
    n=size(Raw_listbox,1); %ch 0
    jj=1;
    index_Raw_listbox_ch_0=[]
    for ii=1:n
        file_name= char(Raw_listbox(ii));
        if isempty(findstr(file_name,'ch00.tif'))~=0
            index_Raw_listbox_ch_0(jj)=ii;
            jj=jj+1;
        end
    end
    clc
    if ch_1~=0 %ch 1
        jj=1
        index_Raw_listbox_ch_1=[]
        for ii=1:n
            file_name= char(Raw_listbox(ii));
            if isempty(findstr(file_name,'ch01.tif'))~=0
                index_Raw_listbox_ch_1(jj)=ii;
                jj=jj+1;
            end
        end
        if length(index_Raw_listbox_ch_1)~=length(index_Raw_listbox_ch_0)
            Y=wavread('Error');
            h = errordlg('Should be same files in Chanel 0 and 1','Error');
            sound(Y,22000);
            return
        end
        for iii=1:n
            data_file(8).cdata(1).Frame(iii).DATA(1).vector =zeros(1,24);
            data_file(8).cdata(1).Frame(iii).DATA(2).vector =zeros(1,11);
        end
    end
    
    
    if ch_2~=0 %ch 2
        jj=1
        index_Raw_listbox_ch_2=[]
        for ii=1:n
            file_name= char(Raw_listbox(ii));
            if isempty(findstr(file_name,'ch02.tif'))~=0
                index_Raw_listbox_ch_2(jj)=ii;
                jj=jj+1;
            end
        end
        if length(index_Raw_listbox_ch_2)~=length(index_Raw_listbox_ch_0)
            Y=wavread('Error');
            h = errordlg('Should be same files in Chanel 0 and 2','Error');
            sound(Y,22000);
            return
        end
        for iii=1:n
            data_file(8).cdata(2).Frame(iii).DATA(1).vector =zeros(1,24);
            data_file(8).cdata(2).Frame(iii).DATA(2).vector =zeros(1,11);
        end
    end
    if ch_3~=0 %ch 3
        jj=1
        index_Raw_listbox_ch_3=[]
        for ii=1:n
            file_name= char(Raw_listbox(ii));
            if isempty(findstr(file_name,'ch03.tif'))~=0
                index_Raw_listbox_ch_3(jj)=ii;
                jj=jj+1;
            end
        end
        if length(index_Raw_listbox_ch_3)~=length(index_Raw_listbox_ch_0)
            Y=wavread('Error');
            h = errordlg('Should be same files in Chanel 0 and 3','Error');
            sound(Y,22000);
            return
        end
        for iii=1:n
            data_file(8).cdata(3).Frame(iii).DATA(1).vector =zeros(1,24);
            data_file(8).cdata(3).Frame(iii).DATA(2).vector =zeros(1,11);
        end
    end
    
    %     -----------------
    
    filename= Raw_listbox(1) ;
    full_filename= char(strcat(pathname,filename));
    info=imfinfo(full_filename);
    
    data_file(6).cdata= [1 1  info.Width  info. Height];
    data_file(9).cdata=info.BitDepth;
    
    
    
    pathname=listbox1(nn)
    % str= pathname( strfind(char(pathname),'\pos'):end);
    % str_index=find(ismember(str,'\')) ;
    % str(str_index)=[]  ;
    a=char(pathname);
    try
        
        str=a(findstr(a,'\Pos')+4:end)
        
        
        %   for ii=1:size(Data,2)
        %       for jj=1:size(Data,1)
        for ii=1:size(Data,1)
            for jj=1:size(Data,2)
                try
                    if strcmp(char(Data(ii,jj)),str)
                        iijj=[ii jj];
                    end
                end
            end
        end
        
        
        
        data_file(11).cdata=handles.temp2(3).cdata(iijj(1)).cdata(iijj(2)).cdata;
        
    end
    
    str=a(findstr(a,'\Pos')+1:end);
    more_str=get(handles.define_section_name,'String');
    if isempty(str)~=1
        filename=char(strcat(pathname,'/TACTICS_EXP_New_',more_str,'_',str,'.dat'))
    else
        filename=char(strcat(pathname,'/TACTICS_EXP_New_',more_str,'.dat'))
    end
    %This it the principle: the temp experiment should not be overwriiten
    %completed experiments file by mistake.
    
    data_file(10).cdata=filename;
    save ( filename  ,  'data_file');
    pause(0.3)
end

msgbox('Experiment files were created. Press OK to continue','Saved')


% --------------------------------------------------------------------
function Untitled_33_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ch01_Filtered_folder.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to ch01_Filtered_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ch01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ch01 as text
%        str2double(get(hObject,'String')) returns contents of edit_ch01 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ch01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ch01_Segmented_folder.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to ch01_Segmented_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ch01_Raw_folder.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to ch01_Raw_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ch02_Filtered_folder.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to ch02_Filtered_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ch02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ch02 as text
%        str2double(get(hObject,'String')) returns contents of edit_ch02 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ch02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ch02_Segmented_folder.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to ch02_Segmented_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ch02_Raw_folder.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to ch02_Raw_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ch03_Filtered_folder.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to ch03_Filtered_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ch03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ch03 as text
%        str2double(get(hObject,'String')) returns contents of edit_ch03 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ch03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ch03_Segmented_folder.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to ch03_Segmented_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ch03_Raw_folder.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to ch03_Raw_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%  =========================================================
function listbox1_Callback(hObject, eventdata, handles)
Raw_listbox=get(handles.listbox1,'String')

if iscell(Raw_listbox)==0
    Raw_listbox=cellstr(Raw_listbox);
    1
end
if isempty(Raw_listbox)==1
    2
    return
end


n=get(handles.listbox1,'value')
set(handles.pathname,'string',char(Raw_listbox(n)));

pathname=char(Raw_listbox(n))

 
find_ind=findstr(pathname , '\\');
if isempty(find_ind)~=1
    pathname(find_ind)=[];
end
 pathname=char( pathname)
guidata(hObject, handles);
str=strcat(pathname,'\*.tif') ;
dir_filename=dir(str)  ;





filename_str=cell(size(dir_filename));


for ii=1:size(dir_filename,1)
    
    filename_str(ii)=cellstr(dir_filename(ii).name) ;
    
end


set(handles.listbox2,'String',filename_str);
set(handles.listbox2,'Max',size(dir_filename,1)) ;
set(handles.listbox2,'Value',1) ;
set(handles.listbox2,'Min',0);

try

a= char(Raw_listbox(n))  ;


Data= handles.temp2(2).cdata;

str=a(findstr(a,'\Pos')+4:end);

%  for ii=1:size(Data,2)
%       for jj=1:size(Data,1)
for ii=1:size(Data,1)
    for jj=1:size(Data,2)
        try
            if strcmp(char(Data(ii,jj)),str)
                iijj=[ii jj];
            end
        end
    end
end


set(handles.show_section,'userdata',handles.temp2(3).cdata(iijj(1)).cdata(iijj(2)).cdata);

guidata(hObject, handles);
%      save all
end

listbox2_Callback(hObject, eventdata, handles)


% --- Executes on button press in define_section.
function define_section_Callback(hObject, eventdata, handles)
clear_section_Callback(hObject, eventdata, handles)

point1 =get(handles.axes1,'Position');
point1=point1./2;
axes(handles.axes1);
h_rectangle = impoly(gca);




setColor(h_rectangle,[0 0.2 0.2]);
sectionXY = wait(h_rectangle) ;
set(handles.show_section,'userdata', sectionXY)


guidata(hObject, handles);



n=round(get(handles.listbox2,'Value'));
show_frame(hObject, eventdata, handles,n)


%
%
%     for ii=1:size(handles.xy,2)
%         xy=handles.xy(ii).cdata;
%        in = inpolygon(p_X,p_Y,xy(:,1),xy(:,2)); in=double(in);
%         in(in==0)=nan;
%         in_matrix(ii,:)=in;
%     end
%
%    if size(in_matrix,1)>1
%
%      in=   nansum(in_matrix);
%
%    end
%
%
%     in(in==0)=nan;
%
%    if size(in,2)>1
%  handles.G=in';
%  else
%   handles.G=in ;
%  end
%
%
%
%
%
%



% --- Executes on button press in clear_section.
function clear_section_Callback(hObject, eventdata, handles)
set(handles.show_section,'userdata', []); guidata(hObject, handles);
n=round(get(handles.listbox2,'Value'));
show_frame(hObject, eventdata, handles,n)


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
n=round(get(handles.listbox2,'Value'));
show_frame(hObject, eventdata, handles,n)
function show_frame(hObject, eventdata, handles,n)
box_Raw=get(handles.listbox2,'string');
if iscell(box_Raw)==0
    Y=wavread('Error');
    h = errordlg('No files in Raw Frame listbox','Error');
    return
end

pathname=get(handles.pathname,'string');

try
    full_filename = char(strcat( pathname,char( box_Raw(n)))) ;  temp=imread(full_filename,'tif',1);
catch
    
    full_filename = char(strcat( pathname,'\',char( box_Raw(n)))) ;  temp=imread(full_filename,'tif',1);
end
try
    axes(handles.axes1);
    cla(handles.axes1);
    imagesc(temp, 'Hittest','Off'); axis tight
    % set(h_axes1_imagesc, 'Hittest','Off');
    %set(gcf,'colormap',handles.c);
    % % xy_border=handles.data_file(6).cdata;
    
    sectionXY= get(handles.show_section,'userdata');
    
    
    if isempty(sectionXY)~=1
        plot(sectionXY(:,1),sectionXY(:,2),'Color','m','LineWidth',9,'Hittest','Off');
        plot([sectionXY(1,1) sectionXY(end,1) ],[ sectionXY(1,2) sectionXY(end,2)],'Color','m','LineWidth',9,'Hittest','Off');
        
    end
    %rectangle('Position', xy_border,'LineWidth',5,'LineStyle','--','EdgeColor','m');
    %axis tight; axis manual;
    hold on
    
    axis tight
    axis manual
    % Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from listbox2
    
end
% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%
% % --- Executes on button press in pushbutton48.
% function pushbutton48_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton48 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%
%
% % --------------------------------------------------------------------
% [filename, pathname, filterindex] = uigetfile({ '*.dat','DAT-files (*.dat)';}, 'Please Choose optimal setting file')% handles.directory_name); %pick files to combine
% if isequal(filename,0) %$#1
%   h = msgbox('User selected Cancel','Aborted');
%   return;
% end
% full_filename= strcat(pathname,filename);
% full_filename=char(full_filename);
% handles.temp2=importdata(full_filename)  ;
%  guidata(hObject, handles);
%
%

% hObject    handle to Untitled_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_34_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
[filename, pathname, filterindex] = uigetfile({ '*.dat','DAT-files (*.dat)';}, 'Please Choose optimal setting file')% handles.directory_name); %pick files to combine
if isequal(filename,0) %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
full_filename= strcat(pathname,filename);
full_filename=char(full_filename);
handles.temp2=importdata(full_filename)  ;
guidata(hObject, handles);



% --------------------------------------------------------------------
function uitoggletool4_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=round(get(handles.listbox2,'Value'));

box_Raw=get(handles.listbox2,'string');
if iscell(box_Raw)==0
    Y=wavread('Error');
    h = errordlg('No files in Raw Frame listbox','Error');
    return
end


pathname=get(handles.pathname,'string');
try
    full_filename = char(strcat(pathname,char( box_Raw(n)))) ;  temp=imread(full_filename,'tif',1);
catch
    
    full_filename = char(strcat(pathname,'\',char( box_Raw(n)))) ;  temp=imread(full_filename,'tif',1);
end



imageinfo(full_filename)


% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_35_Callback(hObject, eventdata, handles)

listbox2=get(handles.listbox2,'String')
ch_0=get(handles.ch_00,'Value')-1;
ch_1=get(handles.ch_01,'Value')-1 ;
ch_2=get(handles.ch_02,'Value')-1;
ch_3=get(handles.ch_03,'Value')-1;
active=4;
if ch_0==0
    Y=wavread('Error');
    h = errordlg('Chanel 0 must be defined!','Error');
    sound(Y,22000);
    return
end
if ch_1==0
    active=active-1 ;
end
if ch_2==0
    active=active-1;
end
if ch_3==0
    active=active-1 ;
end
if iscell(listbox2)~=0
    %      -----------------
    n=size(listbox2,1); %ch 0
    jj=1;
    index_listbox2_ch_0=[]
    for ii=1:n
        file_name= char(listbox2(ii));
        if isempty(findstr(file_name,'ch00.tif'))~=0
            index_listbox2_ch_0(jj)=ii;
            jj=jj+1;
        end
    end
    clc
    if ch_1~=0 %ch 1
        jj=1
        index_listbox2_ch_1=[]
        for ii=1:n
            file_name= char(listbox2(ii));
            if isempty(findstr(file_name,'ch01.tif'))~=0
                index_listbox2_ch_1(jj)=ii;
                jj=jj+1;
            end
        end
        if length(index_listbox2_ch_1)~=length(index_listbox2_ch_0)
            Y=wavread('Error');
            h = errordlg('Should be same files in Chanel 0 and 1','Error');
            sound(Y,22000);
            return
        end
        for iii=1:n
            data_file(8).cdata(1).Frame(iii).DATA(1).vector =zeros(1,24);
            data_file(8).cdata(1).Frame(iii).DATA(2).vector =zeros(1,11);
        end
    end
    
    
    if ch_2~=0 %ch 2
        jj=1
        index_listbox2_ch_2=[]
        for ii=1:n
            file_name= char(listbox2(ii));
            if isempty(findstr(file_name,'ch02.tif'))~=0
                index_listbox2_ch_2(jj)=ii;
                jj=jj+1;
            end
        end
        if length(index_listbox2_ch_2)~=length(index_listbox2_ch_0)
            Y=wavread('Error');
            h = errordlg('Should be same files in Chanel 0 and 2','Error');
            sound(Y,22000);
            return
        end
        for iii=1:n
            data_file(8).cdata(2).Frame(iii).DATA(1).vector =zeros(1,24);
            data_file(8).cdata(2).Frame(iii).DATA(2).vector =zeros(1,11);
        end
    end
    if ch_3~=0 %ch 3
        jj=1
        index_listbox2_ch_3=[]
        for ii=1:n
            file_name= char(listbox2(ii));
            if isempty(findstr(file_name,'ch03.tif'))~=0
                index_listbox2_ch_3(jj)=ii;
                jj=jj+1;
            end
        end
        if length(index_listbox2_ch_3)~=length(index_listbox2_ch_0)
            Y=wavread('Error');
            h = errordlg('Should be same files in Chanel 0 and 3','Error');
            sound(Y,22000);
            return
        end
        for iii=1:n
            data_file(8).cdata(3).Frame(iii).DATA(1).vector =zeros(1,24);
            data_file(8).cdata(3).Frame(iii).DATA(2).vector =zeros(1,11);
        end
    end
    %     -----------------
    
    
    %     listbox2(index_listbox2_ch_0)=[];
    %    listbox2= filename_str
    n=length(listbox2);
    iiii=1;
    zz=cell(1,1); zz(1)=cellstr('empty');
    for   ii=1:n
        
        file_name= char(listbox2(ii));
        file_name= char(regexprep(file_name, '_ch00', ''));
        file_name= char(regexprep(file_name, '_ch01', ''));
        file_name= char(regexprep(file_name, '_ch02', ''));
        file_name= char(regexprep(file_name, '_ch03', ''));
        file_name= char(regexprep(file_name, '_ch04', ''));
        file_name= char(regexprep(file_name, '_ch05', ''));
        file_name= char(regexprep(file_name, '.tif', ''));
        
        stat=0;
        for iii=1:length(zz)
            
            
            if isempty(strfind(file_name,char(zz(iii))))==0
                stat=1; break
            end
        end
        
        if stat==0
            zz(iiii)=  cellstr(file_name);iiii=iiii+1
            
        end
    end
    
    zz(1)
    % data_file(1).cdata=cell(length(listbox2),1) ;
    data_file(1).cdata(:,1)=zz;%listbox2;
    
    data_file(2).cdata=cell(9,3) ; %
    
    %
    %     for ii=1:9
    %         pathname_filtered_default=strcat(handles.pathname,'\ch0',num2str(ii),'_Filtered');
    %         mkdir(pathname_filtered_default)
    %         data_file(2).cdata(ii,2)=cellstr(char(pathname_filtered_default));
    %
    %         pathname_Segmented_default=strcat(handles.pathname,'\ch0',num2str(ii),'_Segmented');
    %         mkdir(pathname_Segmented_default)
    %         data_file(2).cdata(ii,3)=cellstr(char(pathname_Segmented_default));
    %     end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    pathname_temp= get(handles.ch00_Raw_folder,'String');
    pathname_temp
    mkdir(pathname_temp)
    data_file(2).cdata(1,1)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch01_Raw_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(2,1)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch02_Raw_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(3,1)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch03_Raw_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(4,1)=cellstr(char(pathname_temp));
    
    pathname_temp= get(handles.ch00_Filtered_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(1,2)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch01_Filtered_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(2,2)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch02_Filtered_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(3,2)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch03_Filtered_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(4,2)=cellstr(char(pathname_temp));
    
    
    pathname_temp= get(handles.ch00_Segmented_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(1,3)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch01_Segmented_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(2,3)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch02_Segmented_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(3,3)=cellstr(char(pathname_temp));
    pathname_temp= get(handles.ch03_Segmented_folder,'String');
    mkdir(pathname_temp)
    data_file(2).cdata(4,3)=cellstr(char(pathname_temp));
    
    
    
    for ii=4:20
        data_file(2).cdata(ii,1)=data_file(2).cdata(1,1);
        if ii<10
            newstr=char(strcat('ch0',num2str(ii))) ;
        else
            newstr=char(strcat('ch',num2str(ii)))  ;
        end
        stremp2=regexprep(data_file(2).cdata(1,2) ,'ch00', newstr) ;
        data_file(2).cdata(ii,2)= stremp2;
        stremp3=regexprep(data_file(2).cdata(1,3) ,'ch00', newstr) ;
        data_file(2).cdata(ii,3)= stremp3;
    end
    
    %     data_file(2).cdata(1,5)=pathname_temp;
    %     data_file(2).cdata(2,5)=pathname_temp;
    %     data_file(2).cdata(3,5)=pathname_temp;
    
    data_file(3).cdata=cell(4,2) ;
    data_file(3).cdata(1,1)=cellstr(num2str(ch_0));
    data_file(3).cdata(2,1)=cellstr(num2str(ch_1));
    data_file(3).cdata(3,1)=cellstr(num2str(ch_2));
    data_file(3).cdata(4,1)=cellstr(num2str(ch_3));
    
    data_file(3).cdata(1,2)=cellstr(get(handles.edit_ch00,'string'));
    data_file(3).cdata(2,2)=cellstr(get(handles.edit_ch01,'string'));
    data_file(3).cdata(3,2)=cellstr(get(handles.edit_ch02,'string'));
    data_file(3).cdata(4,2)=cellstr(get(handles.edit_ch03,'string'));
    
    
    data_file(7).cdata=cell(6,2) ; %flags for tracking and labeling status (with label is easy only has to use isempty(centy1) command
    data_file(7).cdata(1,1)=cellstr('N');
    data_file(7).cdata(2,1)=cellstr('N');
    data_file(7).cdata(3,1)=cellstr('N');
    data_file(7).cdata(4,1)=cellstr('N');
    data_file(7).cdata(5,1)=cellstr('N');
    data_file(7).cdata(6,1)=cellstr('N');
    data_file(7).cdata(1,2)=cellstr('N');
    data_file(7).cdata(2,2)=cellstr('N');
    data_file(7).cdata(3,2)=cellstr('N');
    data_file(7).cdata(4,2)=cellstr('N');
    data_file(7).cdata(5,2)=cellstr('N');
    data_file(7).cdata(6,2)=cellstr('N');
    
    
    
    
    
    
    
    for ii=1:active
        data_file(4).cdata.Centroids(ii).cdata=[];
    end
    for ii=1:active
        data_file(4).cdata.L(ii).cdata=[];
    end
    for ii=1:active
        data_file(5).cdata.Tracks(ii).cdata=[];
    end
    
    
    
    filename= listbox2(1) ;
    pathname = get(handles.ch00_Raw_folder,'String');
    full_filename= char(strcat(pathname,filename));
    info=imfinfo(full_filename);
    sectionXY= get(handles.show_section,'userdata');
    data_file(6).cdata= [1 1  info.Width  info. Height];
    data_file(9).cdata=info.BitDepth;
    if isempty(sectionXY)~=1
        data_file(11).cdata=sectionXY;
    end
    
    
    
    
    
    handles.data_file=data_file;
    guidata(hObject,handles);
    
end

pathname=get(handles.pathname,'string');
str=handles.pathname( strfind(pathname,'\pos'):end);
str_index=find(ismember(str,'\')) ;
str(str_index)=[]  ;
more_str=get(handles.define_section_name,'String');
filename=strcat(pathname,'TACTICS_EXP_New_',str,more_str ,'.dat')  ;
%This it the principle: the temp experiment should not be overwriiten
%completed experiments file by mistake.

temp=handles.data_file;
temp(10).cdata=filename;
save ( filename  ,  'temp');

msgbox('Experiment file was created. Press OK to continue','Saved')

% --- Executes on slider movement.
function sliderframes_Callback(hObject, eventdata, handles)
if  toc<0.05
    return
end


tic


n = round(get(hObject,'Value')) ;
box_list=get(handles.listbox2,'string');

pathname=get(handles.pathname,'string');



try
    full_filename = char(strcat(pathname,char( box_list(n)))) ;  temp=imread(full_filename,'tif',1);
catch
    
    full_filename = char(strcat(pathname,'\',char( box_list(n)))) ;  temp=imread(full_filename,'tif',1);
end

axes(handles.axes1);
cla(handles.axes1);
imagesc(temp, 'Hittest','Off');

if get(handles.show_section,'value')==1
    sectionXY= get(handles.show_section,'userdata');
    if isempty( sectionXY)~=1
        plot( sectionXY(:,1), sectionXY(:,2),'Color','m','LineWidth',9,'Hittest','Off');
        plot([ sectionXY(1,1)  sectionXY(end,1) ],[  sectionXY(1,2)  sectionXY(end,2)],'Color','m','LineWidth',9,'Hittest','Off');
        
    end
end


axis manual


% --- Executes during object creation, after setting all properties.
function sliderframes_CreateFcn(hObject, eventdata, handles)
hListener = handle.listener(hObject,'ActionEvent',{@sliderframes_Callback,handles});
setappdata(hObject,'listener__',hListener);



% --- Executes on button press in show_section.
function show_section_Callback(hObject, eventdata, handles)
% hObject    handle to show_section (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of show_section


% --------------------------------------------------------------------
function Untitled_36_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_37_Callback(hObject, eventdata, handles)
handles.c=change_LUT ;
guidata(hObject,handles);
set(gcf,'colormap',handles.c);


% --------------------------------------------------------------------
function Untitled_38_Callback(hObject, eventdata, handles)
colormapeditor
handles.c=  get(gcf,'colormap')
guidata(hObject,handles)


% --------------------------------------------------------------------
function Untitled_39_Callback(hObject, eventdata, handles)
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




% --------------------------------------------------------------------
function Untitled_40_Callback(hObject, eventdata, handles)
axes(handles.axes1)
imtool(gca)


 
