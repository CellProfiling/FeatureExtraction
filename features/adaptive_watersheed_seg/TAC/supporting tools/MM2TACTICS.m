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
function varargout = MM2TACTICS(varargin)
% MM2TACTICS M-file for MM2TACTICS.fig
%      MM2TACTICS, by itself, creates a new MM2TACTICS or raises the existing
%      singleton*.
%
%      H = MM2TACTICS returns the handle to a new MM2TACTICS or the handle to
%      the existing singleton*.
%
%      MM2TACTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MM2TACTICS.M with the given input arguments.
%
%      MM2TACTICS('Property','Value',...) creates a new MM2TACTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MM2TACTICS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MM2TACTICS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MM2TACTICS

% Last Modified by GUIDE v2.5 30-Jan-2013 20:37:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MM2TACTICS_OpeningFcn, ...
    'gui_OutputFcn',  @MM2TACTICS_OutputFcn, ...
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


% --- Executes just before MM2TACTICS is made visible.
function MM2TACTICS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MM2TACTICS (see VARARGIN)

% Choose default command line output for MM2TACTICS
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MM2TACTICS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MM2TACTICS_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
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
pathname= char(Raw_listbox(n));
set(handles.pathname2,'string',pathname)
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
listbox2_Callback(hObject, eventdata, handles)





% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%
function pushbutton2_Callback(hObject, eventdata, handles)

n=get(handles.listbox1,'Value') ;
box= cellstr(get(handles.listbox1,'string')) ;box2=box;
Data=get(handles.uitable1,'Data');
Data(n,:)=[];
filename_str=get(handles.uitable1,'RowName');
box2(n)=[];
set(handles.uitable1,'RowName',box2 ,'Data',Data);


if (n==1 && n==size(box,1))
    new_box=[];
    set(handles.listbox1,'string',new_box);
    return
end
if (n==1 &&  size(box,1)>1)
    for ii=1:(size(box,1)-1)
        new_box(ii)=box(ii+1);
    end
    new_box=char(new_box);
    set(handles.listbox1,'string',new_box);
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
    set(handles.listbox1,'string',new_box);
    return
end
if (n==size(box,1) && n>1)
    for  ii=1:(n-1)
        new_box(ii)=box(ii);
    end
    set(handles.listbox1,'Value',n-1);
    new_box=char(new_box);
    set(handles.listbox1,'string',new_box);
    return
end



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



function edit_CH00_Callback(hObject, eventdata, handles)
% hObject    handle to edit_CH00 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_CH00 as text
%        str2double(get(hObject,'String')) returns contents of edit_CH00 as a double


% --- Executes during object creation, after setting all properties.
function edit_CH00_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_CH00 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_CH01_Callback(hObject, eventdata, handles)
% hObject    handle to edit_CH01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_CH01 as text
%        str2double(get(hObject,'String')) returns contents of edit_CH01 as a double


% --- Executes during object creation, after setting all properties.
function edit_CH01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_CH01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_CH02_Callback(hObject, eventdata, handles)
% hObject    handle to edit_CH02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_CH02 as text
%        str2double(get(hObject,'String')) returns contents of edit_CH02 as a double


% --- Executes during object creation, after setting all properties.
function edit_CH02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_CH02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_CH03_Callback(hObject, eventdata, handles)
% hObject    handle to edit_CH03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_CH03 as text
%        str2double(get(hObject,'String')) returns contents of edit_CH03 as a double


% --- Executes during object creation, after setting all properties.
function edit_CH03_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_CH03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
if get(handles.popupmenu3,'value')==1
    set(handles.edit_CH01,'visible','off')
    set(handles.edit_CH02,'visible','off')
    set(handles.edit_CH03,'visible','off')
end
if get(handles.popupmenu3,'value')==2
    set(handles.edit_CH01,'visible','on')
    set(handles.edit_CH02,'visible','off')
    set(handles.edit_CH03,'visible','off')
end
if get(handles.popupmenu3,'value')==3
    set(handles.edit_CH01,'visible','on')
    set(handles.edit_CH02,'visible','on')
    set(handles.edit_CH03,'visible','off')
end
if get(handles.popupmenu3,'value')==4
    set(handles.edit_CH01,'visible','on')
    set(handles.edit_CH02,'visible','on')
    set(handles.edit_CH03,'visible','on')
end
% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_as_8_bit.
function save_as_8_bit_Callback(hObject, eventdata, handles)
% hObject    handle to save_as_8_bit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_as_8_bit


% --- Executes on selection change in listbox2.



% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
pathname2=get(handles.pathname2,'string')
n2=round(get(handles.listbox2,'Value'));
box_Raw2=get(handles.listbox2,'string');
n1 =round(get(handles.listbox1,'Value'));








full_filename = char(strcat( pathname2,'/',box_Raw2(n2)))

if ~isempty(dir(full_filename))
    temp=imread(full_filename,'tif',1);
end

axes(handles.axes1);
cla(handles.axes1);
imagesc(temp, 'Hittest','Off'); axis tight
% set(h_axes1_imagesc, 'Hittest','Off');
%set(gcf,'colormap',handles.c);
% % xy_border=handles.data_file(6).cdata;

Data   = get(handles.uitable1,'Data') ;


try
    for ii=1:size(handles.sectionXY(n1).cdata,2)
        sectionXY=handles.sectionXY(n1).cdata(ii).cdata;
        
        plot(sectionXY(:,1),sectionXY(:,2),'Color','m','LineWidth',9,'Hittest','Off');
        plot([sectionXY(1,1) sectionXY(end,1) ],[ sectionXY(1,2) sectionXY(end,2)],'Color','m','LineWidth',9,'Hittest','Off');
        
        text(sectionXY(1,1),sectionXY(1,2) ,char(strcat('Pos',char(Data(n1,ii)))),'FontSize',22)
    end
end




%rectangle('Position', xy_border,'LineWidth',5,'LineStyle','--','EdgeColor','m');
%axis tight; axis manual;
hold on

axis tight
axis manual




% --- Executes on button press in pathname2.
function pathname2_Callback(hObject, eventdata, handles)
% hObject    handle to pathname2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Position_Callback(hObject, eventdata, handles)
% hObject    handle to Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Position as text
%        str2double(get(hObject,'String')) returns contents of Position as a double


% --- Executes during object creation, after setting all properties.
function Position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)

n1=round(get(handles.listbox1,'Value'));
handles.sectionXY(n1).cdata =[];
handles.Pos(n1).cdata=cell(1,1);


Data=get(handles.uitable1,'Data');
Data(n1,:)=[];

set(handles.uitable1, 'Data',Data);
guidata(hObject, handles);

listbox2_Callback(hObject, eventdata, handles)






% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


point1 =get(handles.axes1,'Position');
point1=point1./2;
axes(handles.axes1);
h_rectangle = impoly(gca);




setColor(h_rectangle,[0 0.2 0.2]);




n1=round(get(handles.listbox1,'Value'));
sectionXY = wait(h_rectangle) ;


if isempty(handles.sectionXY(n1).cdata)==1
    handles.sectionXY(n1).cdata(1).cdata= sectionXY;
    handles.Pos(n1).cdata(1)= {get(handles.Position,'string')} ;
else
    sizey=size(handles.sectionXY(n1).cdata,2);
    handles.sectionXY(n1).cdata(sizey+1).cdata=sectionXY;
    handles.Pos(n1).cdata(sizey+1)={ get(handles.Position,'string')} ;
end





guidata(hObject, handles);


str=get(handles.Position,'string');



Data=get(handles.uitable1,'Data')

jj=1;
for ii=1:size(Data,2)
    a=Data(n1,ii);
    try
        char(a);
    catch
        break
    end
    jj=jj+1;
end

Data(n1,jj)  ={ get(handles.Position,'string')}

set(handles.uitable1,'Data',Data   )

listbox2_Callback(hObject, eventdata, handles)




% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
n1=eventdata.Indices(1);
ii=eventdata.Indices(2);
set(handles.listbox1,'value',n1)

Data   = get(handles.uitable1,'Data') ;
listbox1_Callback(hObject, eventdata, handles)

try
    sectionXY=handles.sectionXY(n1).cdata(ii).cdata;
    
    plot(sectionXY(:,1),sectionXY(:,2),'Color','c','LineWidth',9,'Hittest','Off');
    plot([sectionXY(1,1) sectionXY(end,1) ],[ sectionXY(1,2) sectionXY(end,2)],'Color','c','LineWidth',9,'Hittest','Off');
    
    text(sectionXY(1,1),sectionXY(1,2) ,char(strcat('Pos',char(Data(n1,ii)))),'FontSize',22)
    
end

% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
n1=eventdata.Indices(1);
ii=eventdata.Indices(2);
set(handles.listbox1,'value',n1)

Data   = get(handles.uitable1,'Data') ;
listbox1_Callback(hObject, eventdata, handles)

try
    sectionXY=handles.sectionXY(n1).cdata(ii).cdata;
    
    plot(sectionXY(:,1),sectionXY(:,2),'Color','c','LineWidth',9,'Hittest','Off');
    plot([sectionXY(1,1) sectionXY(end,1) ],[ sectionXY(1,2) sectionXY(end,2)],'Color','c','LineWidth',9,'Hittest','Off');
    
    text(sectionXY(1,1),sectionXY(1,2) ,char(strcat('Pos',char(Data(n1,ii)))),'FontSize',22)
    
end


% --------------------------------------------------------------------
function Load_Callback(hObject, eventdata, handles)

pathname = uigetdir(get(handles.temp_path,'String'),'Important- subfolders names should be atleast 3 letters!');
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
            filename_str(jj)= {(temp)};    jj=jj+1;
        end
        %               end
    end
end



try
    
    filename_str=char(filename_str);
    set(handles.listbox1,'String',filename_str);
    set(handles.listbox1,'Max',size(dir_filename,1)) ;
    set(handles.listbox1,'Value',1) ;
    set(handles.listbox1,'Min',0);
    
catch
    msgbox('Please select "position" folders that contain the .tif')
    
end

set(handles.uitable1,'RowName',filename_str);

set(handles.uitable1,'Data',cell(size(dir_filename,1),1));





for ii=1:size(dir_filename,1)
    handles.sectionXY(ii).cdata=[];
    handles.Pos(ii).cdata=cell(1,1);
    
end

handles.pathname=pathname;
guidata(hObject,handles);
listbox1_Callback(hObject, eventdata, handles)
% ----------


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)

Raw_listbox=get(handles.listbox1,'String')
Add_to_Back=get(handles.edit1,'string')
if get(handles.save_as_8_bit,'value')==1
    Rbits=1; % reduce bits to 9
else
    Rbits=0;
end

if iscell(Raw_listbox)==0
    Raw_listbox=cellstr(Raw_listbox);
    1
end
if isempty(Raw_listbox)==1
    2
    return
end


edit_CH00=get(handles.edit_CH00,'string');
edit_CH01=get(handles.edit_CH01,'string');
edit_CH02=get(handles.edit_CH02,'string');
edit_CH03=get(handles.edit_CH03,'string');

edit_CH00= regexprep(edit_CH00,' ', '');edit_CH01 =regexprep(edit_CH01,' ', '');
edit_CH02= regexprep(edit_CH02,' ', '');edit_CH03 =regexprep(edit_CH03,' ', '');




n=length(Raw_listbox);
h=timebar_TACWrapper('Please wait....');
set(h,'color','w');
for   ii=1:n
    timebar_TACWrapper(h,ii/(n))
    pathname= char(Raw_listbox(ii));
    new_pathname= strcat(pathname,'\r');
    mkdir(new_pathname)
    str=strcat(pathname,'\*.tif') ;
    dir_filename=dir(str) ;
    
    
    % to find the number of zeros to add to time points:
    
    time_point=[]
    for jj=1:size(dir_filename,1)
        file_name=char(cellstr(dir_filename(jj).name));
        
        t=findstr(file_name,'_T');
        if isempty(t)==1
            t=findstr(file_name,'_t');
        end
        t=t(end);
        Tif=findstr(file_name,'.TIF');
        if isempty(Tif)==1
            Tif=findstr(file_name,'.Tif');
        end
        Tif=Tif(end) ;
        
        
        time_point(jj)= str2num(file_name(t+2:Tif-1));
        
        
    end
    time_point=max( time_point)
    
    if  time_point<10
        Mdigits=1;
    end
    if  time_point>9 && time_point<100
        Mdigits=2;
    end
    if  time_point>99 && time_point<1000
        Mdigits=3;
    end
    if  time_point>999 && time_point<10000
        Mdigits=4;
    end
    
    
    
    
    
    
    for jj=1:size(dir_filename,1)
        file_name=char(cellstr(dir_filename(jj).name));
        full_filename= char(strcat(pathname,'\',  file_name )  ) ;
        
        
        
        
        tempstr_filename=regexprep(file_name,' ', '');
        
        if isempty(findstr( tempstr_filename,edit_CH00))~=1
            Channel='0' ;
        else
            
            if isempty(findstr( tempstr_filename,edit_CH01))~=1
                Channel='1'  ;
            else
                if isempty(findstr( tempstr_filename,edit_CH02))~=1
                    Channel='2' ;
                else
                    if isempty(findstr( tempstr_filename,edit_CH03))~=1
                        Channel='3'  ;
                    end
                    
                end
                
            end
        end
        
        
        
        
        %              -------------------------------------------
        t=findstr(file_name,'_T');
        if isempty(t)==1
            t=findstr(file_name,'_t');
        end
        t=t(end)
        Tif=findstr(file_name,'.TIF');
        if isempty(Tif)==1
            Tif=findstr(file_name,'.Tif');
        end
        Tif=Tif(end)
        
        pos=findstr(file_name,'_s');
        if isempty(pos)==1
            pos=findstr(file_name,'_S');
        end
        pos=pos(end)
        
        w=findstr(file_name,'_w');
        
        
        
        position = file_name(pos+2:t-1);
        time_point= file_name(t+2:Tif-1) ;
        if Mdigits-length(num2str(time_point))==1
            time_point=strcat('0',time_point);
        end
        if Mdigits-length(num2str(time_point))==2
            time_point=strcat('00',time_point);
        end
        if Mdigits-length(num2str(time_point))==3
            time_point=strcat('000',time_point);
        end
        
        
        Backbone=file_name(1:w-1);
        
        %if backbone start with nuber add index before it
        
        if isempty(str2num(Backbone(1)))~=1
            new_name=char(strcat(new_pathname,'\',Add_to_Back,Backbone,'_Pos',position ,'_t',  time_point,  '_ch0', Channel,'.tif')) ;
            
        else
            new_name=char(strcat(new_pathname,'\',Backbone,'_Pos', position ,'_t',  time_point,  '_ch0', Channel,'.tif')) ;
        end
        
        if Rbits
            try
                temp=double(imread( full_filename));
                temp=uint8(255*(temp./max(max(temp))));
                imwrite(temp,new_name)
            catch
                save ll
            end
            
        else
            
            movefile(full_filename,new_name)
        end
        
    end
    
    
    pause(2)
end




close(h)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)

[filename, pathname, filterindex] = uiputfile({  '*.dat','Dat-files (*.dat)';}, 'save  session to a data file' );

if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
filename=regexprep(filename, 'TACTICS_Sec_','');
full_filename= strcat(pathname,'TACTICS_Sec_',filename) ;
full_filename=char(full_filename);

temp(1).cdata=get(handles.uitable1,'RowName');
temp(2).cdata=get(handles.uitable1,'Data');
temp(3).cdata=handles.sectionXY;
save(full_filename ,  'temp')


Raw_listbox=get(handles.listbox1,'String')
Add_to_Back=get(handles.edit1,'string')
if get(handles.save_as_8_bit,'value')==1
    Rbits=1; % reduce bits to 9
else
    Rbits=0;
end

if iscell(Raw_listbox)==0
    Raw_listbox=cellstr(Raw_listbox);
    1
end
if isempty(Raw_listbox)==1
    2
    return
end


edit_CH00=get(handles.edit_CH00,'string');
edit_CH01=get(handles.edit_CH01,'string');
edit_CH02=get(handles.edit_CH02,'string');
edit_CH03=get(handles.edit_CH03,'string');

edit_CH00= regexprep(edit_CH00,' ', '');edit_CH01 =regexprep(edit_CH01,' ', '');
edit_CH02= regexprep(edit_CH02,' ', '');edit_CH03 =regexprep(edit_CH03,' ', '');




n=length(Raw_listbox);
temp_path=get(handles.temp_path,'String');
for   ii=1:n
    for iii=1:size(handles.Pos(ii).cdata,2)
        position= char(handles.Pos(ii).cdata(iii));
        pathname= char(Raw_listbox(ii));
        new_pathname= strcat(temp_path,'\Pos',position)
        mkdir(new_pathname)
        
    end
end



h=timebar_TACWrapper('Please wait....');
set(h,'color','w');

for   ii=1:n
    timebar_TACWrapper(h,ii/(n))
    
    pathname= char(Raw_listbox(ii));
    str=strcat(pathname,'\*.tif') ;
    dir_filename=dir(str) ;
    
    
    % to find the number of zeros to add to time points:
    
    
    time_point=[]
    for jj=1:size(dir_filename,1)
        file_name=char(cellstr(dir_filename(jj).name));
        
        t=findstr(file_name,'_T');
        if isempty(t)==1
            t=findstr(file_name,'_t');
        end
        t=t(end);
        Tif=findstr(file_name,'.TIF');
        if isempty(Tif)==1
            Tif=findstr(file_name,'.Tif');
        end
        Tif=Tif(end) ;
        
        
        time_point(jj)= str2num(file_name(t+2:Tif-1));
        
        
    end
    time_point=max( time_point)
    
    if  time_point<10
        Mdigits=1;
    end
    if  time_point>9 && time_point<100
        Mdigits=2;
    end
    if  time_point>99 && time_point<1000
        Mdigits=3;
    end
    if  time_point>999 && time_point<10000
        Mdigits=4;
    end
    
    
    
    
    
    
    for jj=1:size(dir_filename,1)
        file_name=char(cellstr(dir_filename(jj).name));
        full_filename= char(strcat(pathname,'\',  file_name )  ) ;
        
        
        
        
        tempstr_filename=regexprep(file_name,' ', '');
        
        if isempty(findstr( tempstr_filename,edit_CH00))~=1
            Channel='0' ;
        else
            
            if isempty(findstr( tempstr_filename,edit_CH01))~=1
                Channel='1'  ;
            else
                if isempty(findstr( tempstr_filename,edit_CH02))~=1
                    Channel='2' ;
                else
                    if isempty(findstr( tempstr_filename,edit_CH03))~=1
                        Channel='3'  ;
                    end
                    
                end
                
            end
        end
        
        
        
        
        %              -------------------------------------------
        t=findstr(file_name,'_T');
        if isempty(t)==1
            t=findstr(file_name,'_t');
        end
        t=t(end);
        Tif=findstr(file_name,'.TIF');
        if isempty(Tif)==1
            Tif=findstr(file_name,'.Tif');
        end
        Tif=Tif(end)    ;
        
        
        w=findstr(file_name,'_w');
        
        
        
        
        time_point= file_name(t+2:Tif-1) ;
        if Mdigits-length(num2str(time_point))==1
            time_point=strcat('0',time_point);
        end
        if Mdigits-length(num2str(time_point))==2
            time_point=strcat('00',time_point);
        end
        if Mdigits-length(num2str(time_point))==3
            time_point=strcat('000',time_point);
        end
        
        
        Backbone=file_name(1:w-1);
        
        %if backbone start with nuber add index before it
        
        
        for iii=1:size(handles.Pos(ii).cdata,2)
            position= char(handles.Pos(ii).cdata(iii));
            new_pathname= strcat(temp_path,'\Pos',position)  ;
            
            
            
            if isempty(str2num(Backbone(1)))~=1
                new_name=char(strcat(new_pathname,'\',Add_to_Back,Backbone,'_Pos',position ,'_t',  time_point,  '_ch0', Channel,'.tif')) ;
                
            else
                new_name=char(strcat(new_pathname,'\',Backbone,'_Pos', position ,'_t',  time_point,  '_ch0', Channel,'.tif')) ;
            end
            
            if Rbits
                try
                    temp=double(imread( full_filename));
                    temp=uint8(255*(temp./max(max(temp))));
                    imwrite(temp,new_name)
                catch
                    save ll
                end
                
            else
                
                movefile(full_filename,new_name)
            end
            
            
        end
        
        
    end
    pause(3)
end



close(h)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)

close
h=TACTICS;
drawnow;
j = get(h,'javaframe');
jfig = j.fFigureClient.getWindow; %undocumented
jfig.setAlwaysOnTop(0);%places window on top, 0 to disable
jfig.setMaximized(1); %maximizes the window, 0 to minimize






% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)


%
% save handles handles
% return
pathname2=get(handles.pathname2,'string')
n2=round(get(handles.listbox2,'Value'));
box_Raw2=get(handles.listbox2,'string');
n1 =round(get(handles.listbox1,'Value'));








full_filename = char(strcat( pathname2,'/',box_Raw2(n2)))

if ~isempty(dir(full_filename))
    temp=imread(full_filename,'tif',1);
end



temp= uint8(255*(temp ./(max(max(temp ))))) ;    %norm matrix
level = graythresh(temp);      temp=imbinarize(temp,level);



temp=~temp;
temp=imfill(temp,'holes'); temp=bwareaopen(temp,5000,4);

stats=regionprops(temp,'BoundingBox')
%
%  save stats stats
n1=round(get(handles.listbox1,'Value'));

str=get(handles.Position,'string');
handles.sectionXY(n1).cdata =[];
handles.Pos(n1).cdata=cell(1,1);


Data=get(handles.uitable1,'Data');
try
    Data(n1,:)=[];
end
for jj=1:length(stats)
    XY=stats(jj).BoundingBox ;
    XY(3)=XY(1)+XY(3); XY(4)=XY(2)+XY(4) ;
    XY =[XY(1) XY(2); XY(1) XY(4)  ;   XY(3) XY(4);  XY(3) XY(2)];
    %
    handles.sectionXY(n1).cdata(jj).cdata= XY;
    handles.Pos(n1).cdata(jj)= {str} ;
    Data(n1,jj)  ={ num2str(jj)} ;
    
end


guidata(hObject, handles);



set(handles.uitable1,'Data',Data   )

listbox2_Callback(hObject, eventdata, handles)


