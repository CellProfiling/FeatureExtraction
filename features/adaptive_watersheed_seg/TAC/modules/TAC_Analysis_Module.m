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
function varargout = TAC_Analysis_Module(varargin)
% TAC_Analysis_Module M-file for TAC_Analysis_Module.fig
%      TAC_Analysis_Module, by itself, creates go new TAC_Analysis_Module or raises the existing
%      singleton*.
%
%      H = TAC_Analysis_Module returns the handle to go new TAC_Analysis_Module or the handle to
%      the existing singleton*.
%
%      TAC_Analysis_Module('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TAC_Analysis_Module.M with the given input arguments.
%
%      TAC_Analysis_Module('Property','Value',...) creates go new TAC_Analysis_Module or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TAC_Analysis_Module_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TAC_Analysis_Module_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only onee
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TAC_Analysis_Module

% Last Modified by GUIDE v2.5 05-Feb-2013 13:14:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TAC_Analysis_Module_OpeningFcn, ...
    'gui_OutputFcn',  @TAC_Analysis_Module_OutputFcn, ...
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


% -------------------------------------
function TAC_Analysis_Module_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.c=jet;
handles.C=[1 1 1];
handles.data_file =[];
guidata(hObject,handles) ;




handles.flag.axis1=-1;
handles.flag.axis2=-1;
handles.flag.axis3=-1;
handles.flag.axis4=-1;
handles.flag.axis5=-1;
handles.flag.axis6=-1;
handles.flag.Absolut=-1;





guidata(hObject,handles) ;
handles = addPlabackControls(hObject, handles);
guidata(hObject,handles) ;
% ---------------------------------
function varargout = TAC_Analysis_Module_OutputFcn(hObject, eventdata, handles)
%     setWindowState(hObject,'maximize','icon.gif');  % Undocumented feature!
pause(0.05); drawnow;

varargout{1} = handles.output;
% ---------------------------------------
function handles = addPlabackControls(hObject, handles)
icons = load(fullfile(fileparts(mfilename), 'animatorIcons.mat'));

% -------
function popupmenu1_Callback(hObject, eventdata, handles)
plot_data(handles,1,'Axes')
function popupmenu2_Callback(hObject, eventdata, handles)
plot_data(handles,2,'Axes')
function popupmenu3_Callback(hObject, eventdata, handles)
plot_data(handles,3,'Axes')
function popupmenu4_Callback(hObject, eventdata, handles)
plot_data(handles,4,'Axes')
function popupmenu5_Callback(hObject, eventdata, handles)
plot_data(handles,5,'Axes')
function popupmenu6_Callback(hObject, eventdata, handles)
plot_data(handles,6,'Axes')
% ----


%  ----------------------------------------------------------
function lock_listbox(handles,n,send_from)
for ii=1:6
    if ii~=send_from
        str= strcat('if  get(handles.Lock_listbox_option',num2str(ii),',''Value'')==get(handles.Lock_listbox_option',num2str(ii),',''Max'')');
        str= strcat(str, '&& ',num2str(ii),'~=send_from && ~(',  num2str(n),'>get(handles.listbox',num2str(ii),',''Max''))');
        str= strcat(str,'; set(handles.listbox',num2str(ii),',''value'',',num2str(n),'); plot_data(handles,',num2str(ii),',''Axes'')  ; end') ;
        eval(str)
    end
end

%     ----------------------------------------------------------




function listbox1_Callback(hObject, eventdata, handles)

plot_data(handles,1,'Axes')
n=get(handles.listbox1,'Value');
lock_listbox( handles,n,1)
function listbox2_Callback(hObject, eventdata, handles)
plot_data(handles,2,'Axes')
n=get(handles.listbox2,'Value');
lock_listbox( handles,n,2)
function listbox3_Callback(hObject, eventdata, handles)
plot_data(handles,3,'Axes')
n=get(handles.listbox3,'Value');
lock_listbox( handles,n,3)
function listbox4_Callback(hObject, eventdata, handles)
plot_data(handles,4,'Axes')
n=get(handles.listbox4,'Value');
lock_listbox( handles,n,4)
function listbox5_Callback(hObject, eventdata, handles)
plot_data(handles,5,'Axes')
n=get(handles.listbox5,'Value');
lock_listbox( handles,n,5)
function listbox6_Callback(hObject, eventdata, handles)
plot_data(handles,6,'Axes')
n=get(handles.listbox6,'Value');
lock_listbox( handles,n,6)
% ------





function listbox1_CreateFcn(hObject, eventdata, handles)
function listbox2_CreateFcn(hObject, eventdata, handles)
function listbox3_CreateFcn(hObject, eventdata, handles)
function listbox4_CreateFcn(hObject, eventdata, handles)
function listbox5_CreateFcn(hObject, eventdata, handles)
function listbox6_CreateFcn(hObject, eventdata, handles)

function popupmenu1_CreateFcn(hObject, eventdata, handles)
function popupmenu2_CreateFcn(hObject, eventdata, handles)
function popupmenu3_CreateFcn(hObject, eventdata, handles)
function popupmenu4_CreateFcn(hObject, eventdata, handles)
function popupmenu5_CreateFcn(hObject, eventdata, handles)
function popupmenu6_CreateFcn(hObject, eventdata, handles)

function  checkbox1_CreateFcn(hObject, eventdata, handles)
function  checkbox2_CreateFcn(hObject, eventdata, handles)
function  checkbox3_CreateFcn(hObject, eventdata, handles)
function  checkbox4_CreateFcn(hObject, eventdata, handles)
function  checkbox5_CreateFcn(hObject, eventdata, handles)
function  checkbox6_CreateFcn(hObject, eventdata, handles)
function  checkbox7_CreateFcn(hObject, eventdata, handles)
function  checkbox8_CreateFcn(hObject, eventdata, handles)
function  checkbox9_CreateFcn(hObject, eventdata, handles)
function  checkbox10_CreateFcn(hObject, eventdata, handles)
function  checkbox11_CreateFcn(hObject, eventdata, handles)
function  checkbox12_CreateFcn(hObject, eventdata, handles)

function checkbox1_Callback(hObject, eventdata, handles)
function checkbox2_Callback(hObject, eventdata, handles)
function checkbox3_Callback(hObject, eventdata, handles)
function checkbox4_Callback(hObject, eventdata, handles)
function checkbox5_Callback(hObject, eventdata, handles)
function checkbox6_Callback(hObject, eventdata, handles)
function checkbox7_Callback(hObject, eventdata, handles)
function checkbox8_Callback(hObject, eventdata, handles)
function checkbox9_Callback(hObject, eventdata, handles)
function checkbox10_Callback(hObject, eventdata, handles)
function checkbox11_Callback(hObject, eventdata, handles)
function checkbox12_Callback(hObject, eventdata, handles)

function Lock_listbox_option1_Callback(hObject, eventdata, handles)
function Lock_listbox_option2_Callback(hObject, eventdata, handles)
function Lock_listbox_option3_Callback(hObject, eventdata, handles)
function Lock_listbox_option4_Callback(hObject, eventdata, handles)
function Lock_listbox_option5_Callback(hObject, eventdata, handles)
function Lock_listbox_option6_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------
function load_and_store(hObject, eventdata, handles,index)
[filename, pathname, filterindex] = uigetfile({  '*.fig','Fig-files (*.fig)';}, 'Please Choose saved figure files','MultiSelect', 'on'); %pick files to combine
if isequal(filename,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
load_and_store2(hObject, eventdata, handles,index,filename, pathname)
Close
% ----------------------------------------
function load_and_store2(hObject, eventdata, handles,index,filename, pathname)
eval(strcat('set(handles.text',num2str(index),',''String'',pathname)'));
if  iscell(filename)==0  %Only one image was sellected
    filename_for_listbox=cellstr(filename);
    filename_for_listbox=cell(filename_for_listbox);
    eval(strcat('set(handles.listbox',num2str(index),',''String'',filename_for_listbox)'));
    eval(strcat('set(handles.listbox',num2str(index),',''Max'',1)'));
else  %Multiple images were selected
    eval(strcat('set(handles.listbox',num2str(index),',''String'',filename)'));
    eval(strcat('set(handles.listbox',num2str(index),',''Max'',size(filename,2))'));
end
eval(strcat('set(handles.listbox',num2str(index),',''Min'',0)'));
eval(strcat('set(handles.listbox',num2str(index),',''Value'',1)'));
eval(strcat('set(handles.popupmenu',num2str(index),',''Value'',1)'));
eval(strcat('filename=get(handles.listbox',num2str(index),',''String'')'));
eval(strcat('pathname=get(handles.text',num2str(index),',''String'')'));
full_filename= strcat(pathname,filename)
file_name= char(full_filename(1))
h2=  open (file_name)
Name=get(h2,'Name')



if isempty(strfind(Name,'Cell'))
    if   isempty(strfind(Name,'Dividing'))
        Name=char(filename(1))
    end
end



Data=get(h2,'userdata')
% read firt figure to decide data type, therfore all figures should be at
% the same data format and structure!

eval(strcat('set(handles.text',num2str(index+6),',''String'',Name)'));


if isempty(findstr(Name,'Cell'))~=1
    if isempty(findstr(Name,'trajectories'))~=1
        set(handles.Parameters,'Visible','on')
        str=cell(2,1);
        str(1)=cellstr('Cell_trajectories');
        eval(strcat('set(handles.popupmenu',num2str(index),',''String'',  str)'));
        close(h2)
        n=size(full_filename,1)  ;
        h1=waitbar(0,'Calculating....');
        set(h1,'color','w');
        for ii=1:n
            waitbar(ii/n)
            file_name= char(full_filename(ii))
            h2=  open (file_name)
            data(ii).cdata=get(h2,'userdata')
            close(h2)
        end
        save all
        eval(strcat('set(handles.popupmenu',num2str(index),',''String'',  str)'));
        eval(strcat('set(handles.listbox',num2str(index),',''Userdata'',data)'));
        close(h1)
    end
    if isempty(strfind(Name,'Intensity'))~=1 || ...
            isempty(strfind(Name,'I_per_A'))~=1 || ...
            isempty(strfind(Name,'Area'))~=1 || ...
            isempty(strfind(Name,'Orientation'))~=1 || ...
            isempty(strfind(Name,'Eccentricity'))~=1 || ...
            isempty(strfind(Name,'EquivDiameter'))~=1 || ...
            isempty(strfind(Name,'Solidity'))~=1 ||...
            isempty(strfind(Name,'graycoprops'))~=1  || ...
            isempty(strfind(Name,'Polarisation'))~=1 || ...
            isempty(strfind(Name,'Extent'))~=1  || ...
            isempty(strfind(Name,'Perimeter'))~=1  || ...
            isempty(strfind(Name,'Ellipticity'))~=1 ||  ...
            isempty(strfind(Name,'Time'))~=1   || ...
            isempty(strfind(Name,'Velocity'))~=1   || ...
            isempty(strfind(Name,'number_of'))~=1
        
        
        str=cell(3,1);
        str(1)=cellstr('Cell_specific');
        str(2)=cellstr('Cell_Group');
        str(3)=cellstr('Cell_Lineage');
        
        close(h2)
        n=size(full_filename,1)  ;
        h1=waitbar(0,'Calculating....');
        set(h1,'color','w');
        for ii=1:n
            waitbar(ii/n)
            file_name= char(full_filename(ii)) ;
            h2=  open (file_name) ;
            
            data.Data(ii).cdata=Data;
            
            
            
            data.Data(ii).cdata=get(h2,'userdata')
            
            
            z=get(h2,'Children'); zz=get(z,'title');   temp_data=get(zz,'string');
            data.Cell(ii).cdata= temp_data(6:end);
            
            
            
            
            
            
            
            close(h2)
        end
        close(h1)
        
        eval(strcat('set(handles.popupmenu',num2str(index),',''String'',  str)'));
        eval(strcat('set(handles.listbox',num2str(index),',''Userdata'',data)'));
        
        try
            if size( handles.C,1)<size(data.Data,2)
                handles.C=distinguishable_colors_TACWrapper(size(data.Data,2),'w') ;
            end
            guidata(hObject,handles) ;
        catch
            if size( handles.C,1)<size(data,2)
                handles.C=distinguishable_colors_TACWrapper(size(data,2),'w') ;
            end
            guidata(hObject,handles) ;
        end
        
        
    end
    
    
    
    
    
    
    if isempty(strfind(Name,'Projection'))~=1
        str=cell(4,1);
        str(1)=cellstr('Cell_Projection_specific');
        str(2)=cellstr('Cell_Projection_Group');
        str(3)=cellstr('Cell_Projection_Lineage1');
        str(4)=cellstr('Cell_Projection_Lineage2');
        
        close(h2)
        n=size(full_filename,1)  ;
        h1=waitbar(0,'Calculating....');
        set(h1,'color','w');
        for ii=1:n
            waitbar(ii/n)
            file_name= char(full_filename(ii)) ;
            h2=  open (file_name) ;
            
            data.Data(ii).cdata=Data;
            
            
            
            data.Data(ii).cdata=get(h2,'userdata')  ;
            
            
            z=get(h2,'Children'); zz=get(z,'title');   temp_data=get(zz,'string');
            data.Cell(ii).cdata= temp_data(findstr(temp_data,'-Projection-')+12:end);
            
            
            
            
            
            
            
            
            close(h2)
        end
        close(h1)
        
        eval(strcat('set(handles.popupmenu',num2str(index),',''String'',  str)'));
        eval(strcat('set(handles.listbox',num2str(index),',''Userdata'',data)'));
        
        try
            if size( handles.C,1)<size(data.Data,2)
                handles.C=distinguishable_colors_TACWrapper(size(data.Data,2),'w') ;
            end
            guidata(hObject,handles) ;
        catch
            if size( handles.C,1)<size(data,2)
                handles.C=distinguishable_colors_TACWrapper(size(data,2),'w') ;
            end
            guidata(hObject,handles) ;
        end
    end
end

if isempty(findstr(Name,'Dividing'))~=1
    
    if isempty(strfind(Name,'Intensity'))~=1 || ...
            isempty(strfind(Name,'I_per_A'))~=1 || ...
            isempty(strfind(Name,'Area'))~=1 || ...
            isempty(strfind(Name,'Orientation'))~=1 || ...
            isempty(strfind(Name,'Eccentricity'))~=1 || ...
            isempty(strfind(Name,'EquivDiameter'))~=1 || ...
            isempty(strfind(Name,'Solidity'))~=1 ||...
            isempty(strfind(Name,'graycoprops'))~=1  || ...
            isempty(strfind(Name,'Polarisation'))~=1 || ...
            isempty(strfind(Name,'Extent'))~=1  || ...
            isempty(strfind(Name,'Perimeter'))~=1  || ...
            isempty(strfind(Name,'Ellipticity'))~=1 ||  ...
            isempty(strfind(Name,'Time'))~=1   || ...
            isempty(strfind(Name,'Velocity'))~=1   || ...
            isempty(strfind(Name,'number_of'))~=1
        
        str=cell(4,1);
        str(1)=cellstr('Plot Parental');
        str(2)=cellstr('Plot D1 and D2');
        str(3)=cellstr('Plot (D1-D2)\(D1+D2)');
        str(4)=cellstr('Plot Average (D1-D2)\(D1+D2)');
    end
    
    
    if isempty(findstr(Name,'Dividing_2D_Projection'))~=1
        str=cell(2,1);
        str(1)=cellstr('Imagesc Dividing_2D_Projection');
        str(2)=cellstr('Imagesc Fused_Dividing_2D_Projection');
    end
    if isempty(findstr(Name,'Dividing_Montage'))~=1
        str=cell(2,1);
        str(1)=cellstr('Imagesc Dividing_Montage');
        str(2)=cellstr('Imagesc Dividing_Movie');
        str(3)=cellstr('Imagesc Dividing_Montage_box');
    end
    
    if isempty(findstr(Name,'Dividing_SEQtage'))~=1
        str=cell(1,1);
        str(1)=cellstr('Imagesc Dividing_SEQtage');
    end
    
    
    if isempty(findstr(Name,'Dividing_Montage'))~=1
        str=cell(2,1);
        str(1)=cellstr('Imagesc Dividing_Montage');
        str(2)=cellstr('Imagesc Dividing_Movie');
        str(3)=cellstr('Imagesc Dividing_Montage_box');
    end
    
    
    
    
    
    
    
    
    
    eval(strcat('set(handles.popupmenu',num2str(index),',''String'',  str)'));
    close(h2)
    
    n=size(full_filename,1)  ;
    h1=waitbar(0,'Calculating....');
    set(h1,'color','w');
    for ii=1:n
        waitbar(ii/n)
        file_name= char(full_filename(ii))
        h2=  open (file_name)
        if isempty(findstr(Name,'Dividing_Montage'))~=1 ||     isempty(findstr(Name,'Dividing_SEQtage'))~=1
            temp_data=get(h2,'userdata')   ;
            z=get(h2,'Children'); zz=get(z,'title');   temp_data.upper_cell=get(zz,'string');
            data(ii).cdata=temp_data;
        else
            data(ii).cdata=get(h2,'userdata')
        end
        close(h2)
    end
    close(h1)
    
    
    
    
    
    
    
    eval(strcat('set(handles.listbox',num2str(index),',''Userdata'',data)'));
    try
        if size( handles.C,1)<size(data.Data,2)
            handles.C=distinguishable_colors_TACWrapper(size(data.Data,2),'w') ;
        end
        guidata(hObject,handles) ;
    catch
        if size( handles.C,1)<size(data,2)
            handles.C=distinguishable_colors_TACWrapper(size(data,2),'w') ;
        end
        guidata(hObject,handles) ;
    end
    
    
    
    
    
    
    
end


if isempty(findstr(Name,'Angles'))~=1
    set(handles.Parameters,'Visible','on')
    struct_Names=fieldnames(Data);
    str=cell(2,1);
    str(1)=cellstr('plot Rose histogram');
    str(2)=cellstr(['plot Polar Vs.'      char(struct_Names(2))]);
    str(3)=cellstr(['plot Polar Vs.'      char(struct_Names(3))])
    str(4)=cellstr(['scatter vectors'      char(struct_Names(2))  'Vs.'  char(struct_Names(3)) ])
    
end


% -------------------------
function delete_selected(handles,index)
eval(strcat('listbox=get(handles.listbox',num2str(index),',''String'')'));
eval(strcat('n=get(handles.listbox',num2str(index),',''Value'')'));
eval(strcat('data=get(handles.listbox',num2str(index),',''Userdata'')'));



if (n==1 && n==size(listbox,1))
    eval(strcat('set(handles.listbox',num2str(index),',''String'',[])'));
    eval(strcat('set(handles.listbox',num2str(index),',''Userdata'',[])'));
    eval(strcat('axes(handles.axes',num2str(index),'); cla;'));
    return
end

if (n==1 &&  size(listbox,1)>1)
    for ii=1:(size(listbox,1)-1)
        new_box(ii)=listbox(ii+1);
        try % for regular data
            new_data(ii)=data(ii+1);
        catch % for data.Data and data.Cell data format
            new_data.Data(ii)=data.Data(ii+1);
            new_data.Cell(ii)=data.Cell(ii+1);
        end
        
    end
    eval(strcat('set(handles.listbox',num2str(index),',''String'',new_box)'));
    eval(strcat('set(handles.listbox',num2str(index),',''Userdata'',new_data)'));
    plot_data(handles,index,'Axes')
    return
end
if (n>1 &&  size(listbox,1)>1 && size(listbox,1)>n)
    for ii=1:(n-1)
        new_box(ii)=listbox(ii);
        try % for regular data
            new_data(ii)=data(ii);
        catch % for data.Data and data.Cell data format
            new_data.Data(ii)=data.Data(ii);
            new_data.Cell(ii)=data.Cell(ii);
        end
    end
    
    for ii=n:(size(listbox,1)-1)
        new_box(ii)=listbox(ii+1);
        try % for regular data
            new_data(ii)=data(ii+1);
        catch % for data.Data and data.Cell data format
            new_data.Data(ii)=data.Data(ii+1);
            new_data.Cell(ii)=data.Cell(ii+1);
        end
    end
    eval(strcat('set(handles.listbox',num2str(index),',''String'',new_box)'));
    eval(strcat('set(handles.listbox',num2str(index),',''Userdata'',new_data)'));
    plot_data(handles,index,'Axes')
    return
end
if   (n==size(listbox,1) && n>1)
    for  ii=1:(n-1)
        new_box(ii)=listbox(ii);
        try % for regular data
            new_data(ii)=data(ii);
        catch % for data.Data and data.Cell data format
            new_data.Data(ii)=data.Data(ii);
            new_data.Cell(ii)=data.Cell(ii);
        end
    end
    eval(strcat('set(handles.listbox',num2str(index),',''Value'',n-1)'));
    eval(strcat('set(handles.listbox',num2str(index),',''String'',new_box)'));
    eval(strcat('set(handles.listbox',num2str(index),',''Userdata'',new_data)'));
    plot_data(handles,index,'Axes')
    return
end


%  -----------------------------------------
function delete_list(handles,index)
eval(strcat('set(handles.listbox',num2str(index),',''Value'',1)'));
eval(strcat('set(handles.listbox',num2str(index),',''String'',[])'));
eval(strcat('set(handles.listbox',num2str(index),',''Userdata'',[])'));
eval(strcat('axes(handles.axes',num2str(index),'); cla;'));
%  -----------------------------------------

function text7_ButtonDownFcn(hObject, eventdata, handles)
% plot_data(handles,1,'Figure')
function text8_ButtonDownFcn(hObject, eventdata, handles)
% plot_data(handles,2,'Figure')
function text9_ButtonDownFcn(hObject, eventdata, handles)
% plot_data(handles,3,'Figure')
function text10_ButtonDownFcn(hObject, eventdata, handles)
% plot_data(handles,4,'Figure')
function text11_ButtonDownFcn(hObject, eventdata, handles)
% plot_data(handles,5,'Figure')
function text12_ButtonDownFcn(hObject, eventdata, handles)
% plot_data(handles,6,'Figure')
function text8_CreateFcn(hObject, eventdata, handles)




function DATA_1_CreateFcn(hObject, eventdata, handles)
function DATA_2_CreateFcn(hObject, eventdata, handles)
function Math_operation_1_CreateFcn(hObject, eventdata, handles)
function Target_into_CreateFcn(hObject, eventdata, handles)






function DATA_1_Callback(hObject, eventdata, handles)
function DATA_2_Callback(hObject, eventdata, handles)
function Math_operation_1_Callback(hObject, eventdata, handles)
function Target_into_Callback(hObject, eventdata, handles)


function Exicute_math_Callback(hObject, eventdata, handles)
listbox1=[];popupmenu_1=[];
Math_operation_1=get(handles.Math_operation_1,'string');
Math_operation_11=get(handles.Math_operation_1,'value');
Math_operation_1=Math_operation_1(Math_operation_11);
Math_operation_2=get(handles.Math_operation_2 ,'string');
Math_operation_22=get(handles.Math_operation_2,'value');
Math_operation_2=Math_operation_2(Math_operation_22);

DATA1=[]; DATA2=[]; DATA3=[];  DATA4=[]; DATA5=[];  popupmenu_1=[];  popupmenu_2=[];  popupmenu_3=[]; popupmenu_4=[];  popupmenu_5=[]; Target_into =get(handles.Target_into,'Value') ;
index_1=get(handles.DATA_1,'Value')  ;index_2=get(handles.DATA_2,'Value') ;index_3=get(handles.DATA_3,'Value')  ;index_4=get(handles.DATA_4,'Value') ; index_5=get(handles.DATA_5,'Value') ;
if index_1~=7
    eval(strcat('DATA1=get(handles.listbox',num2str(index_1),',''Userdata'')'));
    eval(strcat('listbox1=get(handles.listbox',num2str(index_1),',''String'')'));
    eval(strcat('popupmenu_Value_1=get(handles.popupmenu',num2str(index_1),',''Value'')'));
    eval(strcat('popupmenu_String_1=get(handles.popupmenu',num2str(index_1),',''String'')'));
    popupmenu_1= popupmenu_String_1(popupmenu_Value_1);
    popupmenu_1=char( popupmenu_1)   ;
    DATA6=DATA1;
end
if index_2~=7
    eval(strcat('DATA2=get(handles.listbox',num2str(index_2),',''Userdata'')'));
    eval(strcat('listbox2=get(handles.listbox',num2str(index_2),',''String'')'));
    eval(strcat('popupmenu_Value_2=get(handles.popupmenu',num2str(index_2),',''Value'')'));
    eval(strcat('popupmenu_String_2=get(handles.popupmenu',num2str(index_2),',''String'')'));
    popupmenu_2= popupmenu_String_2(popupmenu_Value_2);
    popupmenu_2=char( popupmenu_2)   ;
    DATA6=DATA2;
end
if index_3~=7
    eval(strcat('DATA3=get(handles.listbox',num2str(index_3),',''Userdata'')'));
    eval(strcat('listbox3=get(handles.listbox',num2str(index_3),',''String'')'));
    eval(strcat('popupmenu_Value_3=get(handles.popupmenu',num2str(index_3),',''Value'')'));
    eval(strcat('popupmenu_String_3=get(handles.popupmenu',num2str(index_3),',''String'')'));
    popupmenu_3= popupmenu_String_3(popupmenu_Value_3);
    popupmenu_3=char( popupmenu_3)   ;
    DATA6=DATA3;
end
if index_4~=7
    eval(strcat('DATA4=get(handles.listbox',num2str(index_4),',''Userdata'')'));
    eval(strcat('listbox4=get(handles.listbox',num2str(index_4),',''String'')'));
    eval(strcat('popupmenu_Value_4=get(handles.popupmenu',num2str(index_4),',''Value'')'));
    eval(strcat('popupmenu_String_4=get(handles.popupmenu',num2str(index_4),',''String'')'));
    popupmenu_4= popupmenu_String_4(popupmenu_Value_4);
    popupmenu_4=char( popupmenu_4)   ;
    DATA6=DATA4;
end

if index_5~=7
    eval(strcat('DATA5=get(handles.listbox',num2str(index_5),',''Userdata'')'));
    eval(strcat('listbox5=get(handles.listbox',num2str(index_5),',''String'')'));
    eval(strcat('popupmenu_Value_5=get(handles.popupmenu',num2str(index_5),',''Value'')'));
    eval(strcat('popupmenu_String_5=get(handles.popupmenu',num2str(index_5),',''String'')'));
    popupmenu_5= popupmenu_String_4(popupmenu_Value_5);
    popupmenu_5=char( popupmenu_5)   ;
    DATA6=DATA5;
end
Target_into=get(handles.Target_into,'Value')
n1=size(DATA1,2); n2=size(DATA2,2);  n3=size(DATA3,2);n4=size(DATA4,2);n5=size(DATA5,2);n=n1;



if isempty(listbox1)==1
    listbox1= get(handles.listbox1,'string')
end
if isempty(popupmenu_1)==1
    DATA1=get(handles.listbox1,'userdata');
    DATA2=get(handles.listbox2,'userdata');
    DATA3=get(handles.listbox3,'userdata');
    DATA4=get(handles.listbox4,'userdata');
    DATA5=get(handles.listbox5,'userdata');
    popupmenu_Value_1=get(handles.popupmenu1,'value');
    popupmenu_String_1=get(handles.popupmenu1,'String');
    popupmenu_1= popupmenu_String_1(popupmenu_Value_1);
    popupmenu_1=char( popupmenu_1)
    
    
    eval(strcat('set(handles.listbox',num2str(Target_into),',''String'',listbox1)'));
    eval(strcat('set(handles.listbox',num2str(Target_into),',''Max'',size(listbox1,2))'));
    eval(strcat('set(handles.listbox',num2str(Target_into),',''Min'',0)'));
    eval(strcat('set(handles.listbox',num2str(Target_into),',''Value'',1)'));
end




if n1~=n2
    Y=wavread('Error');
    h = errordlg('Length of first and second DATA must be the same!! ','Error');
    sound(Y,22000);
    return
end






if  ((isempty(findstr( popupmenu_1,'Plot Parental'))~=1 || isempty(findstr( popupmenu_1,'Plot D1 and D2'))~=1 || ...
        isempty(findstr( popupmenu_1,'Plot (D1-D2)\(D1+D2)'))~=1 ||  isempty(findstr( popupmenu_1,'Plot Average (D1-D2)\(D1+D2)'))~=1)) ...
        &&   ((isempty(findstr( popupmenu_2,'Plot Parental'))~=1 || isempty(findstr( popupmenu_2,'Plot D1 and D2'))~=1 || ...
        isempty(findstr( popupmenu_2,'Plot (D1-D2)\(D1+D2)'))~=1 ||  isempty(findstr( popupmenu_2,'Plot Average (D1-D2)\(D1+D2)'))~=1))
    h1=timebar_TACWrapper('Calculating 2D Projection for population ....');
    set(h1,'color','w');
    for ii=1:n
        timebar_TACWrapper(h1,ii/n)
        if isempty( popupmenu_1)~=1 &&  isempty( popupmenu_2)~=1 &&  isempty( popupmenu_3)~=1
            eval(strcat('DATA4(ii).cdata  =DATA1(ii).cdata',char(Math_operation_1),'DATA2(ii).cdata' ,char(Math_operation_2),'DATA3(ii).cdata'))   ;
        end
        if isempty( popupmenu_1)~=1 &&  isempty( popupmenu_2)~=1
            eval(strcat('DATA4(ii).cdata  =DATA1(ii).cdata',char(Math_operation_1),'DATA2(ii).cdata'))   ;
        end
        if isempty( popupmenu_1)~=1 &&  isempty( popupmenu_3)~=1
            eval(strcat('DATA4(ii).cdata  =DATA1(ii).cdata',char(Math_operation_1),'DATA3(ii).cdata'))   ;
        end
        if isempty( popupmenu_2)~=1 &&  isempty( popupmenu_3)~=1
            eval(strcat('DATA4(ii).cdata  =DATA2(ii).cdata',char(Math_operation_2),'DATA3(ii).cdata'))   ;
        end
    end
    close(h1)
    str=cell(4,1);
    str(1)=cellstr('Plot Parental');
    str(2)=cellstr('Plot D1 and D2');
    str(3)=cellstr('Plot (D1-D2)\(D1+D2)');
    str(4)=cellstr('Plot Average (D1-D2)\(D1+D2)');
end


%
%
%  if isempty(findstr( popupmenu,'Imagesc Dividing_2D_Projection'))~=1
%     imagesc(data(n1).cdata) % Projections can not be averaged!!!
%           switch excel_option
%               case 1
%      filename=listbox(n1);
%       filename=regexprep(filename, '.fig', '_Imagesc Dividing_2D_Projection.xls');
%         filename=char(strcat(pathname,filename));
%           if isempty(dir(filename))==0
%                delete(filename)
%            end
%        xlswrite(filename, data(n1).cdata) ; %Projections can not be averaged!!!
% end
%  end
%%%%%



if   (isempty(findstr(popupmenu_1,'Imagesc Dividing_2D_Projection'))~=1  && isempty(findstr(popupmenu_1,'Imagesc Dividing_2D_Projection'))~=1)
    h1=timebar_TACWrapper('Calculating 2D Projection for population ....');
    set(h1,'color','w');
    for ii=1:n
        timebar_TACWrapper(h1,ii/n)
        if isempty( popupmenu_1)~=1 &&  isempty( popupmenu_2)~=1 &&  isempty( popupmenu_3)~=1 &&  ...
                isempty(findstr( char(Math_operation_1),'Co-localization'))==1 &&    isempty(findstr( char(Math_operation_2),'Co-localization'))==1
            eval(strcat('DATA4(ii).cdata  =DATA1(ii).cdata',char(Math_operation_1),'DATA2(ii).cdata' ,char(Math_operation_2),'DATA3(ii).cdata'))   ;
        end
        if isempty( popupmenu_1)~=1 &&  isempty( popupmenu_2)~=1   &&    isempty(findstr( char(Math_operation_1),'Co-localization'))==1
            eval(strcat('DATA4(ii).cdata  =DATA1(ii).cdata',char(Math_operation_1),'DATA2(ii).cdata'))   ;
        end
        if isempty( popupmenu_1)~=1 &&  isempty( popupmenu_3)~=1  &&    isempty(findstr( char(Math_operation_1),'Co-localization'))==1
            eval(strcat('DATA4(ii).cdata  =DATA1(ii).cdata',char(Math_operation_1),'DATA3(ii).cdata'))   ;
        end
        if isempty( popupmenu_2)~=1 &&  isempty( popupmenu_3)~=1  &&    isempty(findstr( char(Math_operation_2),'Co-localization'))==1
            eval(strcat('DATA4(ii).cdata  =DATA2(ii).cdata',char(Math_operation_2),'DATA3(ii).cdata'))   ;
        end
        
        if isempty( popupmenu_1)~=1 &&  isempty( popupmenu_2)~=1 &&  isempty( popupmenu_3)~=1 &&   isempty(findstr( char(Math_operation_2),'Co-localization'))~=1
            a=uint8(255*DATA1(ii).cdata/(max(max(DATA1(ii).cdata))));
            b=uint8(255*DATA2(ii).cdata/(max(max(DATA2(ii).cdata))));
            c=  uint8(255*DATA3(ii).cdata/(max(max(DATA3(ii).cdata))));
            DATA4(ii).cdata  =cat(3,a,b,c);
        end
        if isempty( popupmenu_1)~=1 &&  isempty( popupmenu_2)~=1 &&    isempty(findstr( char(Math_operation_1),'Co-localization'))~=1
            a=uint8(255*DATA1(ii).cdata/(max(max(DATA1(ii).cdata))));
            b=uint8(255*DATA2(ii).cdata/(max(max(DATA2(ii).cdata))));
            c=  uint8(zeros(size(DATA1(ii).cdata)));
            DATA4(ii).cdata  =cat(3,a,b,c);
            
        end
        if isempty( popupmenu_1)~=1 &&  isempty( popupmenu_3)~=1   &&    isempty(findstr( char(Math_operation_1),'Co-localization'))~=1
            a=uint8(255*DATA1(ii).cdata/(max(max(DATA1(ii).cdata))));
            c=uint8(255*DATA3(ii).cdata/(max(max(DATA3(ii).cdata))));
            b=  uint8(zeros(size(DATA1(ii).cdata)));
            DATA4(ii).cdata  =cat(3,a,b,c);
        end
        if isempty( popupmenu_2)~=1 &&  isempty( popupmenu_3)~=1  &&   isempty(findstr( char(Math_operation_2),'Co-localization'))~=1
            b=uint8(255*DATA2(ii).cdata/(max(max(DATA2(ii).cdata))));
            c=uint8(255*DATA3(ii).cdata/(max(max(DATA3(ii).cdata))));
            a=  uint8(zeros(size(DATA1(ii).cdata)));
            DATA4(ii).cdata  =cat(3,a,b,c);
        end
    end
    
    str=cell(1,1);
    str(1)=cellstr('Imagesc Dividing_2D_Projection');
    close(h1)
end

%%%%%

popupmenu_1
%         if   isempty(findstr(popupmenu_1,'Imagesc Dividing_SEQtage'))~=1
%








set(handles.listbox6,'userdata',[]);
set(handles.listbox6,'value',1,'max',1);
set(handles.listbox6,'string',[]);
listbox3= cellstr('1');


strfilename=get(handles.text1,'string');
strfilename_index=findstr(strfilename,'\');
strfilename=strfilename(strfilename_index(end-1)+1:strfilename_index(end));

pathname2 = uigetdir;
if isequal(pathname2,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
pathname2 =strcat(pathname2,'\');
new_filename=char(strcat(pathname2,strfilename))
if isdir(new_filename)==0
    mkdir(new_filename)
end


listbox3 =listbox1;
for iii=1:size(DATA1,2)
    set(handles.listbox1,'value',iii);
    
    new_filename2=char(strcat(new_filename, listbox1( iii))) ;
    
    
    
    DATA6(iii).cdata=DATA1(iii).cdata;
    for jj=1:size(DATA1(iii).cdata.Montage,2)
        temp=[]
        temp(:,:,1) =double(DATA1(iii).cdata.Montage(jj).cdata);
        temp(:,:,2)=double(DATA2(iii).cdata.Montage(jj).cdata);
        temp(:,:,3)=double(DATA3(iii).cdata.Montage(jj).cdata);
        temp(:,:,4)=double(DATA4(iii).cdata.Montage(jj).cdata);
        temp(:,:,5)=double(DATA5(iii).cdata.Montage(jj).cdata);
        
        
        %                            save    temp   temp
        %                              load temp
        
        %                       figure(1); imagesc(temp(:,:,1))
        %                                figure(2 ); imagesc(temp(:,:,2))
        %                                         figure(3); imagesc(temp(:,:,3))
        %                                                  figure(4); imagesc(temp(:,:,4))
        %                                                           figure(5); imagesc(temp(:,:,5))
        
        vec=[mean(mean(temp(:,:,1))) mean(mean(temp(:,:,2))) mean(mean(temp(:,:,3))) mean(mean(temp(:,:,4))) mean(mean(temp(:,:,5)))]
        [b,a]=sort(vec)
        a(1:2)=[]
        
        %                         vec=[var(var(temp(:,:,1))) var(var(temp(:,:,2))) var(var(temp(:,:,3))) var(var(temp(:,:,4))) var(var(temp(:,:,5)))]
        %                            [b,a]=sort(vec)
        %                              b(1:2)=[]
        %
        
        
        %
        %                       figure(6)
        %                       plot(vec)
        %
        %
        %
        %
        %                       save temp temp
        
        %                                  DATA6(iii).cdata.Montage(jj).cdata = double(temp1)+  double(temp2)+  double(temp3)+  double(temp4)+  double(temp5) ;
        
        tempy=   temp(:,:,a(1)) + temp(:,:,a(2))+ temp(:,:,a(3));
        tempy=tempy./3;
        
        %                      figure(7)
        %                      imagesc(tempy)
        %
        
        tempy = wiener2( tempy,[2 2]);
        
        %                      figure(8)
        %                      imagesc(tempy)
        %
        %                      pause
        DATA6(iii).cdata.Montage(jj).cdata =     tempy;
    end
    Close
    
    h_montage= figure
    max_x=0;
    max_y=0;
    for ii=1:size(DATA6(iii).cdata.Montage,2)
        if max_x<size(DATA6(iii).cdata.Montage(ii).cdata,1)
            max_x=size(DATA6(iii).cdata.Montage(ii).cdata,1);
        end
        if max_y<size(DATA6(iii).cdata.Montage(ii).cdata,2)
            max_y=size(DATA6(iii).cdata.Montage(ii).cdata,2);
        end
    end
    
    D=zeros(max_x,max_y,1,ii);
    for ii=1:size(DATA6(iii).cdata.Montage,2)
        D(end-size(DATA6(iii).cdata.Montage(ii).cdata,1)+1:end, end-size(DATA6(iii).cdata.Montage(ii).cdata,2)+1:end,1,ii)=DATA6(iii).cdata.Montage(ii).cdata(:,:) ;
    end
    montage(D, 'DisplayRange', []);
    set(h_montage,'Colormap',jet);
    axis   tight  ;
    pause(1)
    
    
    set(h_montage,'userdata',DATA6(iii).cdata);
    set(h_montage,'Name','Dividing_SEQtage')
    
    
    saveas(h_montage,new_filename2)
    
    
    
    pause(0.1)
    Close
    
end



set(handles.listbox3,'Userdata',DATA6) ;
set(handles.listbox3,'String',listbox3);
set(handles.listbox3,'max',length(listbox3),'value',length(listbox3));
axes(handles.axes6);cla
montage(D, 'DisplayRange', []);
set(gcf,'Colormap',jet);
axis   tight  ;


guidata(hObject,handles);








str=cell(1,1);
str(1)=cellstr('Imagesc montage');

return

%           end









eval(strcat('set(handles.popupmenu',num2str(Target_into),',''String'',  str)'));
eval(strcat('set(handles.listbox',num2str(Target_into),',''Userdata'',DATA4)'));
eval(strcat('set(handles.text',num2str(Target_into+6),',''string'',''Colocaliztion of projection'')'));


eval(strcat('listbox', num2str(Target_into),'_Callback(hObject, eventdata, handles)'))


%

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have go light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=get(hObject ,'value')
n= round(n*1000) ;
set(handles.Tlevel,'string',['T=' num2str(n/1000)])
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

axes(handles.xes1)
ylim([0 n])
axes(handles.xes2)
ylim([0 n])
axes(handles.xes3)
ylim([0 n])
axes(handles.xes4)
ylim([0 n])
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have go light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have go light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have go light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have go light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have go light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in Math_operation_2.
function Math_operation_2_Callback(hObject, eventdata, handles)
% hObject    handle to Math_operation_2 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Math_operation_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Math_operation_2


% --- Executes during object creation, after setting all properties.
function Math_operation_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Math_operation_2 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have go white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DATA_3.
function DATA_3_Callback(hObject, eventdata, handles)
% hObject    handle to DATA_3 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DATA_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DATA_3


% --- Executes during object creation, after setting all properties.
function DATA_3_CreateFcn(hObject, eventdata, ~)
% hObject    handle to DATA_3 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have go white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)

run('TACTICS') ;
% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
close  all


% --- Executes on button press in Merge_channels_6.
function Merge_channels_6_Callback(hObject, eventdata, handles)
% hObject    handle to Merge_channels_6 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Merge_channels_6


% --- Executes on button press in Merge_channels_5.
function Merge_channels_5_Callback(hObject, eventdata, handles)
% hObject    handle to Merge_channels_5 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Merge_channels_5


% --- Executes on button press in Merge_channels_4.
function Merge_channels_4_Callback(hObject, eventdata, handles)
% hObject    handle to Merge_channels_4 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Merge_channels_4


% --- Executes on button press in Merge_channels_3.
function Merge_channels_3_Callback(hObject, eventdata, handles)
% hObject    handle to Merge_channels_3 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Merge_channels_3


% --- Executes on button press in Merge_channels_2.
function Merge_channels_2_Callback(hObject, eventdata, handles)
% hObject    handle to Merge_channels_2 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Merge_channels_2


% --- Executes on button press in Merge_channels_1.
function Merge_channels_1_Callback(hObject, eventdata, handles)
% hObject    handle to Merge_channels_1 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Merge_channels_1

function [Data_out]=plot_data(handles,index,selected_mode)
%     ~~~~~~~~~~~~~~~~~
Data_out=[];
Thresh_input=[];
eval(strcat('Merge_channels_Value=get(handles.Merge_channels_',num2str(index),',''Value'')'));
eval(strcat('popupmenu_Value=get(handles.popupmenu',num2str(index),',''Value'')'));
eval(strcat('popupmenu_String=get(handles.popupmenu',num2str(index),',''String'')'));
eval(strcat('data=get(handles.listbox',num2str(index),',''Userdata'')'));
eval(strcat('pathname=get(handles.text',num2str(index),',''String'')'));
eval(strcat('listbox=get(handles.listbox',num2str(index),',''String'')'));
eval(strcat('Thresh_input =get(handles.slider ',num2str(index),',''String'')'));
Thresh_input=str2double(Thresh_input);
popupmenu= popupmenu_String(popupmenu_Value);
popupmenu=char( popupmenu)   ;
Absolut=handles.flag.Absolut;
group_option=0; eval(strcat('if (get(handles.checkbox',num2str(index+6),',''Value'')==get(handles.checkbox',num2str(index+6),',''Max'')); group_option=1; end;  '))
excel_option=0; eval(strcat('if (get(handles.checkbox',num2str(index),',''Value'')==get(handles.checkbox',num2str(index),',''Max'')); excel_option=1; end;  '))



matrix=[];



if isempty(data)==1
    Y=wavread('Error');
    h = errordlg('No figures in listbox!! ','Error');
    sound(Y,22000);
    return
end
%  -------

switch group_option
    case 1
        n1=1;
        n2=size(data,2);
    case 0
        n1=[];
        eval(strcat('n1=get(handles.listbox',num2str(index),',''Value'')'));
        n2=n1;
end

n=n2-n1+1;
if strcmp(selected_mode,'Axes')==1
    eval(strcat('axes(handles.axes',num2str(index),')'));
    eval(strcat('cla(handles.axes',num2str(index),')'));
    
    
end


if strcmp(selected_mode,'Figure')==1
    
    Pos =[300 100 500 500]
    h=figure('color','w','units','pixels','position', Pos) ;
    % set(h,'colormap',handles.c);
    
    axis on
end




if strfind(popupmenu,'Cell')==1
    
    if isempty(strfind(popupmenu,'Cell_trajectories'))~=1
        Data_out=  data(n1).cdata;
        
        
        X=Data_out.Data_out(:,1) ;  Y=Data_out.Data_out(:,2) ;
        X=X-(X(1)) ;
        Y=Y-(Y(1)) ;
        
        vector=1:length(X); vector= vector./5;
        h_n_plot=plot(X,Y)
        hold on
        scatter(X,Y , vector ,'filled' ,'facecolor','black' );
        xlabel('X-Coordinate');  ylabel('Y-Coordinate');
        set(gcf,'userdata',Data_out)
    end
    
    
    
    
    if isempty(strfind(popupmenu,'Cell_Projection_specific'))~=1
        
        Projection=data.Data(n1).cdata.Projection;
        h_plot=imagesc(Projection)
        set(h_plot, 'Hittest','Off')  ;
        axis tight
        
    end
    
    
    if isempty(strfind(popupmenu,'Cell_Projection_Lineage1'))~=1
        %
        %  save all
        
        Cell2=data.Cell(n1).cdata
        Point=findstr(Cell2,'.') ;
        if isempty(Point)~=1
            Cell=str2num(Cell2(1:Point-1));
        else
            Cell=str2num(Cell2);
        end
        
        
        % So we are going to create lineage tree based on Cell
        % Next, to create matrix of all cells
        
        Lineage_data= data.Data(n1).cdata.Lineage_data
        max_Points=0;
        for ii=1: size(Lineage_data,1)
            temp_Lineage=char(Lineage_data(ii,1))  % only the relevant cells
            Point=findstr(temp_Lineage,'.')
            
            if max_Points<length(Point)
                max_Points=length(Point);
            end
            
            for iii=1:size(data.Data,2)
                temp_data=data.Cell(iii).cdata
                if  strcmp(temp_Lineage, temp_data)
                    Lineage_vector(ii)=iii
                    % vector of locations of relevant cells within data
                    Lineage_relevant_data(ii).cdata.Projection= data.Data(iii).cdata.Projection ;
                    
                    
                    
                end
            end
        end
        
        
        
        
        %
        %  Lineage(max_Points,Cell, Lineage_data,Lineage_relevant_data)
        new_Div_Cells=Lineage_data;
        n=max_Points
        
        temp=1; vector1(1)=1
        for ii=2:n
            temp=temp*2+1;
            vector1(ii)=temp;
        end
        
        temp=1; vector2(1)=1
        for ii=1:n
            temp=temp*2+1;
            vector2(ii)=temp;
        end
        
        
        
        
        for ii=1:n
            
            seq=ones(vector1(ii),1);
            seq(end+1)=0;
            seq(end+1:end+length(seq))=seq*2;
            try
                matrix(:,ii)= repmat(seq,[ 0.5*(vector2(end)+1)/(vector1(ii)+1) 1]) ;
            catch
                matrix(:,ii)= repmat(seq',[ 0.5*(vector2(end)+1)/(vector1(ii)+1) 1]) ;
                
            end
        end
        
        matrix=rot90(matrix)';
        matrix2=ones(size(matrix,1) ,size(matrix,2)+1)*Cell;
        matrix2(:,2:end)=matrix;
        
        
        jjj=1;
        for ii=1:size(matrix2,1)
            matrix2_temp=num2str(matrix2(ii,:)) ;
            matrix2_temp=regexprep(matrix2_temp, ' ', '') ;
            matrix2_temp=regexprep(matrix2_temp, '0', '') ;
            if   isempty(str2num(matrix2_temp))~=1
                Generations(jjj)=str2num(matrix2_temp)  ; jjj=jjj+1;
            end
        end
        
        Generations(end)=[];
        Generations
        
        
        
        
        % 2.a. create matrix of lineage
        %
        % a b c
        % a is where is start
        % b is where its end (add a square)
        % c is the location by generation vector, c must be covered by generation
        
        matrix=[];
        for ii=1:size(new_Div_Cells,1)
            temp=char(new_Div_Cells(ii,1));
            temp(findstr(temp,'.'))=[];
            matrix(ii,3)=str2num(temp);
            matrix(ii,1)=str2num(char(new_Div_Cells(ii,2)));
            matrix(ii,2)=str2num(char(new_Div_Cells(ii,3)));
            matrix(ii,5)=str2num(char(new_Div_Cells(ii,4)));
        end
        
        % 2.b. sort the matrix of lineage according the order of generations
        V=matrix(:,3);
        for ii=1:length(V)
            Index(ii)=find(ismember(Generations,V(ii)));
        end
        
        matrix(:,4)=Index;
        matrix=sortrows(matrix,4);
        
        
        
        [a,b]=sort(Index)
        
        
        
        
        
        for ii=1:size(matrix,1)
            sizey(ii)= size(Lineage_relevant_data(b(ii)).cdata.Projection,1) ;
        end
        cumsumsizey=cumsum(sizey);
        cumsumsizey2=zeros(1,length(cumsumsizey)+1);cumsumsizey2(2:end)=cumsumsizey;
        cumsumsizey3= sizey/2+cumsumsizey2(1:end-1);
        
        
        new_matrix=zeros(max(matrix(:,2))-min(matrix(:,1)),sum(sizey));
        
        
        
        
        
        for ii=1:size(matrix,1)
            matrix5=  Lineage_relevant_data(b(ii)).cdata.Projection   ;
            new_matrix(matrix(ii,1):matrix(ii,2),1+cumsumsizey2(ii):cumsumsizey2(ii+1))=matrix5'   ;
        end
        
        
        
        
        h_plot=imagesc(new_matrix)
        set(h_plot, 'Hittest','Off')  ;
        
        hold on
        
        % 3.a. add the horizontal line of division
        V=matrix(:,3);
        for ii=1:length(V)
            a=num2str(V(ii));
            for jj=(ii+1):length(V)
                b=  num2str(V(jj));
                if strcmp(a(1:end-1),b(1:end-1))
                    %       plot
                    
                    if matrix(ii,1)==matrix(jj,1)
                        plot( cumsumsizey3(ii):cumsumsizey3(jj),ones(1,cumsumsizey3(jj)-cumsumsizey3(ii)+1)*matrix(ii,1),'linewidth',3,'color',[1 0 0])
                        
                    end
                end
            end
            
        end
        
        %  3.b. add text at the buttom
        
        %            clear  new_V
        for iii=1:length(V)
            temp_num=num2str(V(iii))
            new_num=  temp_num(1)
            for kk=2:length(temp_num)
                new_num=strcat(new_num,'.',temp_num(kk))
            end
            new_V(iii)={new_num}
        end
        
        Start_at=min(cumsumsizey3);
        End_at=max(cumsumsizey3);
        Total_length=End_at-Start_at;
        
        set(gca, 'XTick', cumsumsizey3)
        
        
        set(gca,'XTickLabel',{  ;char(new_V)   ;})
        ylim([1 max(matrix(:,2))+20])
        xlim([0 length(V)+1])
        ylabel('Time points (points where cell a5pear)')
        xlabel('cell index')
        set(gca,'Ydir','reverse' )
        
        %  3.c. add squares
        
        
        
        
        for ii=1:size(matrix,1)
            if matrix(ii,5)==0
                plot(  cumsumsizey3(ii),  matrix(ii,2),'bv',     'MarkerSize',10,'Marker','square','LineStyle','none', 'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[1 0 1])
            else
                plot(  cumsumsizey3(ii),  matrix(ii,2),'bv',     'MarkerSize',12,'Marker','+','LineStyle','none', 'LineWidth',3, 'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[1 0 1])
            end
        end
        
        
        
        
        
        %    for ii=1:size(matrix,1)
        %        for iii=1:matrix(ii,2)-matrix(ii,1)
        %            matrix(ii,1)+iii-1:matrix(ii,1)+iii
        %
        %             plot([1 1]*ii, matrix(ii,1)+iii-1:matrix(ii,1)+iii,'linewidth',3,'color',[0.01*iii 0 0])
        %        end
        %
        %
        %    end
        
        
        
        axis tight
        
    end
    
    if isempty(strfind(popupmenu,'Cell_Projection_Lineage2'))~=1
        
        Cell2=data.Cell(n1).cdata
        Point=findstr(Cell2,'.') ;
        if isempty(Point)~=1
            Cell=str2num(Cell2(1:Point-1));
        else
            Cell=str2num(Cell2);
        end
        
        
        % So we are going to create lineage tree based on Cell
        % Next, to create matrix of all cells
        Lineage_data= data.Data(n1).cdata.Lineage_data
        Width=10;
        max_Points=0;
        for ii=1: size(Lineage_data,1)
            temp_Lineage=char(Lineage_data(ii,1))  % only the relevant cells
            Point=findstr(temp_Lineage,'.');
            if max_Points<length(Point)
                max_Points=length(Point);
            end
            
            for iii=1:size(data.Data,2)
                temp_data=data.Cell(iii).cdata
                if  strcmp(temp_Lineage, temp_data)
                    Lineage_vector(ii)=iii
                    % vector of locations of relevant cells within data
                    Lineage_relevant_data(ii).cdata.Projection=imresize(data.Data(iii).cdata.Projection,[Width size(data.Data(iii).cdata.Projection,2)]);
                    
                    
                end
            end
        end
        %
        %
        %  Lineage(max_Points,Cell, Lineage_data,Lineage_relevant_data)
        new_Div_Cells=Lineage_data;
        n=max_Points
        
        temp=1; vector1(1)=1
        for ii=2:n
            temp=temp*2+1;
            vector1(ii)=temp;
        end
        
        temp=1; vector2(1)=1
        for ii=1:n
            temp=temp*2+1;
            vector2(ii)=temp;
        end
        
        
        
        
        for ii=1:n
            
            seq=ones(vector1(ii),1);
            seq(end+1)=0;
            seq(end+1:end+length(seq))=seq*2;
            try
                matrix(:,ii)= repmat(seq,[ 0.5*(vector2(end)+1)/(vector1(ii)+1) 1]) ;
            catch
                matrix(:,ii)= repmat(seq',[ 0.5*(vector2(end)+1)/(vector1(ii)+1) 1]) ;
                
            end
        end
        
        matrix=rot90(matrix)';
        matrix2=ones(size(matrix,1) ,size(matrix,2)+1)*Cell;
        matrix2(:,2:end)=matrix;
        
        
        jjj=1;
        for ii=1:size(matrix2,1)
            matrix2_temp=num2str(matrix2(ii,:)) ;
            matrix2_temp=regexprep(matrix2_temp, ' ', '') ;
            matrix2_temp=regexprep(matrix2_temp, '0', '') ;
            if   isempty(str2num(matrix2_temp))~=1
                Generations(jjj)=str2num(matrix2_temp)  ; jjj=jjj+1;
            end
        end
        
        Generations(end)=[];
        
        
        
        
        
        % 2.a. create matrix of lineage
        %
        % a b c
        % a is where is start
        % b is where its end (add a square)
        % c is the location by generation vector, c must be covered by generation
        
        matrix=[];
        for ii=1:size(new_Div_Cells,1)
            temp=char(new_Div_Cells(ii,1));
            temp(findstr(temp,'.'))=[];
            matrix(ii,3)=str2num(temp);
            matrix(ii,1)=str2num(char(new_Div_Cells(ii,2)));
            matrix(ii,2)=str2num(char(new_Div_Cells(ii,3)));
            matrix(ii,5)=str2num(char(new_Div_Cells(ii,4)));
        end
        
        % 2.b. sort the matrix of lineage according the order of generations
        V=matrix(:,3);
        for ii=1:length(V)
            Index(ii)=find(ismember(Generations,V(ii)));
        end
        
        matrix(:,4)=Index;
        matrix=sortrows(matrix,4);
        
        
        
        
        
        new_matrix=zeros(max(matrix(:,2))-min(matrix(:,1)),size(matrix,1)*Width);
        [a,b]=sort(Index)
        %
        for ii=1:size(matrix,1)
            matrix5=  Lineage_relevant_data(b(ii)).cdata.Projection  ;
            new_matrix(matrix(ii,1):matrix(ii,2),1+(ii-1)*10:10*ii)=matrix5';
        end
        Projection=data.Data(n1).cdata.Projection;
        
        h_plot=imagesc(new_matrix)
        set(h_plot, 'Hittest','Off')  ;
        axis tight
        
        
        hold on
        % 3.a. add the horizontal line of division
        V=matrix(:,3);
        for ii=1:length(V)
            a=num2str(V(ii));
            for jj=(ii+1):length(V)
                b=  num2str(V(jj));
                if strcmp(a(1:end-1),b(1:end-1))
                    %       plot
                    
                    if matrix(ii,1)==matrix(jj,1)
                        plot( ii:jj,ones(1,jj-ii+1)*matrix(ii,1),'linewidth',3,'color',[1 0 0])
                        
                    end
                end
            end
            
        end
        
        %  3.b. add text at the buttom
        
        %            clear  new_V
        for iii=1:length(V)
            temp_num=num2str(V(iii))
            new_num=  temp_num(1)
            for kk=2:length(temp_num)
                new_num=strcat(new_num,'.',temp_num(kk))
            end
            new_V(iii)={new_num}
        end
        
        
        
        
        set(gca,'XTickLabel',{ ;'';char(new_V)  ;'';})
        %            ylim([1 max(matrix(:,2))+20])
        % %             xlim([0 length(V)+1])
        
        set(gca,'Ydir','reverse' )
        
        %  3.c. add squares
        
        
        for ii=1:size(matrix,1)
            plot( ii,  matrix(ii,2),'bv',     'MarkerSize',20,'Marker','square','LineStyle','none', 'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[1 0 1])
        end
        
        %    for ii=1:size(matrix,1)
        %        for iii=1:matrix(ii,2)-matrix(ii,1)
        %            matrix(ii,1)+iii-1:matrix(ii,1)+iii
        %
        %             plot([1 1]*ii, matrix(ii,1)+iii-1:matrix(ii,1)+iii,'linewidth',3,'color',[0.01*iii 0 0])
        %        end
        %
        %
        %    end
        
        
        
        
        new_matrix=zeros(max(matrix(:,2))-min(matrix(:,1)),size(matrix,1))
        [a,b]=sort(Index)
        
        max_vec=0;
        for ii=1:size(matrix,1)
            
            vec=  Lineage_relevant_data(b(ii)).cdata.Y_data
            if max(vec)>  max_vec
                max_vec=max(vec);
            end
        end
        
        for ii=1:size(matrix,1)
            vec=  Lineage_relevant_data(b(ii)).cdata.Y_data
            for iii=1:matrix(ii,2)-matrix(ii,1)
                plot([1 1]*ii, matrix(ii,1)+iii-1:matrix(ii,1)+iii,'linewidth',10,'color',[0 vec(iii)/max_vec 0])
            end
        end
        
        
        
        
        
        
        
        
        
        
        
        
        axis tight
        
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    if isempty(strfind(popupmenu,'Cell_specific'))~=1
        str=char(listbox(1));
        Index=findstr(str,'_');
        Index2= find(ismember(Index, findstr(str,'_Vs_')));
        Ystr=str(Index(Index2-1)+1:Index(Index2)-1)  ;
        Xstr=str(Index(Index2+1)+1:Index(Index2+2)-1);
        X=data.Data(n1).cdata.X_data;Y=data.Data(n1).cdata.Y_data;
        
        h_plot=plot(X,Y ,'MarkerFaceColor','b','MarkerEdgeColor','b',  'Marker','.', 'LineStyle','none')
        set(h_plot, 'Hittest','Off')  ;
        axis tight
        xlabel(Xstr); ylabel(Ystr)
        
    end
    if isempty(strfind(popupmenu,'Cell_Group'))~=1
        hold on
        C=handles.C;
        
        for ii=1: size(data.Data,2)
            
            X=data.Data(ii).cdata.X_data;Y=data.Data(ii).cdata.Y_data;
            h_plot=plot(X,Y  ,'MarkerEdgeColor',  C(ii,:),'Marker','.','LineStyle','none','Hittest','Off')
            
            
            
            
        end
        str=char(listbox(1));
        Index=findstr(str,'_');
        Index2= find(ismember(Index, findstr(str,'_Vs_')));
        Ystr=str(Index(Index2-1)+1:Index(Index2)-1)  ;
        Xstr=str(Index(Index2+1)+1:Index(Index2+2)-1);
        str=char(listbox(1));
        Index=findstr(str,'_');
        Index2= find(ismember(Index, findstr(str,'_Vs_')));
        Ystr=str(Index(Index2-1)+1:Index(Index2)-1)  ;
        Xstr=str(Index(Index2+1)+1:Index(Index2+2)-1);
        
        
        axis tight
    end
    if isempty(strfind(popupmenu,'Cell_Lineage'))~=1
        plot_Cell_Lineage(n1,data)
    end
end

















if isempty(findstr( popupmenu,'Plot (D1-D2)\(D1+D2)'))~=1||...
        isempty(findstr( popupmenu,'Plot Parental'))~=1 || isempty(findstr( popupmenu,'Plot D1 and D2'))~=1
    hold on
end




























if  isempty(findstr( popupmenu,'Plot Parental'))~=1 || isempty(findstr( popupmenu,'Plot D1 and D2'))~=1 || ...
        isempty(findstr( popupmenu,'Plot (D1-D2)\(D1+D2)'))~=1 ||  isempty(findstr( popupmenu,'Plot Average (D1-D2)\(D1+D2)'))~=1
    if strcmp(selected_mode,'Off')~=1
        eval(strcat('set(handles.axes',num2str(index),',''XColor'',''k''',')'));
        eval(strcat('set(handles.axes',num2str(index),',''YColor'',''k''',')'));
    end
    
    
    
    
    max_length0=0; max_length1=0;max_length2=0; max_length_D1D2=0;
    for ii=n1:n2
        vec0=data(ii).cdata.Y_data(1).cdata  ;
        vec1=data(ii).cdata.Y_data(2).cdata  ;
        vec2=(data(ii).cdata.Y_data(3).cdata)  ;
        vec0(vec0==inf)=0;
        vec1(vec1==inf)=0;
        vec2(vec2==inf)=0;
        if length(vec1)>length(vec2)
            vec1 =vec1(1:length(vec2));
        end
        if length(vec2)>length(vec1)
            vec2 =vec2(1:length(vec1));
        end
        VECTOR0(ii).cdata=vec0;
        VECTOR1(ii).cdata=vec1;
        VECTOR2(ii).cdata=vec2;
        
        if max_length0<length(vec0)
            max_length0=length(vec0) ;
        end
        if max_length1<length(vec1)
            max_length1=length(vec1) ;
        end
        if max_length2<length(vec2)
            max_length2=length(vec2) ;
        end
        
        if Absolut
            D1D2_vec=abs(vec1-vec2)./(vec1+vec2);
        else
            D1D2_vec=(vec1-vec2)./(vec1+vec2);
        end
        D1D2_vec(D1D2_vec==inf)=0;
        D1D2_vec(isnan(D1D2_vec))=0;
        D1D2_VECTOR(ii).cdata=D1D2_vec;
        if max_length_D1D2<length(D1D2_vec)
            max_length_D1D2=length(D1D2_vec);
        end
    end
    
    
    matrix0=nan(max_length0,n);matrix1=nan(max_length1,n); matrix2=nan(max_length2,n);D1D2_matrix=nan(max_length_D1D2,n);
    for ii=n1:n2
        matrix0(end+1-length(VECTOR0(ii).cdata):end,ii)=VECTOR0(ii).cdata;
        matrix1(1:length(VECTOR1(ii).cdata),ii)=VECTOR1(ii).cdata;
        matrix2(1:length(VECTOR2(ii).cdata),ii)=VECTOR2(ii).cdata;
        D1D2_matrix(1:length(D1D2_VECTOR(ii).cdata),ii)=D1D2_VECTOR(ii).cdata;
    end
    if size(D1D2_matrix,1)~=1 && size(D1D2_matrix,2)~=1
        AVG=nanmean(D1D2_matrix,2)    ;
        STD=    nanstd(D1D2_matrix')   ;
        while STD(end)==0
            STD(end)=[];
            if length(STD)==1
                break
            end
        end
        AVG=AVG(1:length(STD));
    else
        AVG= D1D2_matrix      ;
        STD=  0  ;
    end
    %  --
    %  -------
    if isempty(findstr( popupmenu,'Plot Parental'))~=1
        switch group_option
            case 0
                Data_out= VECTOR0(ii).cdata;
                vec0= VECTOR0(ii).cdata;   %(because ii=n1, and also n2...)
                if strcmp(selected_mode,'Off')~=1
                    h_plot= plot(1:length(vec0),vec0 ,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 1],  'Marker','square', 'LineStyle','none');
                    set(h_plot, 'Hittest','Off')  ;
                end
                
                
                switch excel_option
                    case 1
                        filename=listbox(n1) ;
                        filename=char(filename);
                        filename=regexprep(filename, '.fig', '_Plot Parental.xls');
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename,  vec0)
                end
                
            case 1
                
                for ii=n1:n2
                    vec0= VECTOR0(ii).cdata;
                    Data_out(1:length(vec0),ii)=vec0;
                    if strcmp(selected_mode,'Off')~=1
                        h_plot= plot(1:length(vec0),vec0)% ,'MarkerFaceColor', handles.C(ii,:),'MarkerEdgeColor', handles.C(ii,:),  'Marker','square', 'LineStyle','none')
                        set(h_plot, 'Hittest','Off')  ;
                    end
                end
                switch excel_option
                    case 1
                        filename=listbox(1) ;
                        filename=char(filename);
                        filename=regexprep(filename, filename( findstr(filename,'_pos'):end), '_Plot Parental.xls')
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename, matrix0)
                end
                
        end
        
        
        if strcmp(selected_mode,'Off')~=1
            xlabel('Frames');    ylabel('Measured Value');
            if strcmp(selected_mode,'Figure')==1
                set(gcf,'userdata', data(popupmenu_Value).cdata)
                set(gcf,'colormap',handles.c);
            end
            hold off
            axis on
            axis tight
        end
    end
    
    %  --
    %  -------
    if isempty(findstr( popupmenu,'Plot D1 and D2'))~=1
        switch group_option
            case 1
                for ii=n1:n2
                    vec1= VECTOR1(ii).cdata;     Data_out(1).cdata(1:length(vec1),ii)=vec1;
                    if strcmp(selected_mode,'Off')~=1
                        h1_plot=plot(1:length(vec1),vec1 ,'MarkerFaceColor',handles.C(ii,:),'MarkerEdgeColor',handles.C(ii,:),  'Marker','.', 'LineStyle','none')
                        set(h1_plot, 'Hittest','Off')  ;
                    end
                    vec2= VECTOR2(ii).cdata;      Data_out(2).cdata(1:length(vec2),ii)=vec2;
                    if strcmp(selected_mode,'Off')~=1
                        h2_plot=plot(1:length(vec2),vec2 ,'MarkerFaceColor',handles.C(ii,:),'MarkerEdgeColor',handles.C(ii,:),  'Marker','.', 'LineStyle','none')
                        set(h2_plot, 'Hittest','Off')  ;
                    end
                end
                switch excel_option
                    case 1
                        filename=listbox(1) ;
                        filename=char(filename);
                        filename=regexprep(filename, filename( findstr(filename,'_pos'):end), '_Plot D1.xls')
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename, matrix1)
                        
                        filename=listbox(1) ;
                        filename=char(filename);
                        filename=regexprep(filename, filename( findstr(filename,'_pos'):end), '_Plot D2.xls')
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename, matrix2)
                end
            case 0
                Data_out(1).cdata= VECTOR1(ii).cdata; Data_out(2).cdata= VECTOR2(ii).cdata;
                vec1= VECTOR1(ii).cdata;   %(because ii=n1, and also n2...)
                if strcmp(selected_mode,'Off')~=1
                    h1_plot=plot(1:length(vec1),vec1 ,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 1],  'Marker','square', 'LineStyle','none')
                    set(h1_plot, 'Hittest','Off')  ;
                end
                vec2= VECTOR2(ii).cdata ;   %(because ii=n1, and also n2...)
                if strcmp(selected_mode,'Off')~=1
                    h2_plot=plot(1:length(vec2),vec2 ,'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[1 0 0],  'Marker','square', 'LineStyle','none')
                    set(h2_plot, 'Hittest','Off')  ;
                end
                switch excel_option
                    case 1
                        filename=listbox(n1) ;
                        filename=char(filename);
                        filename=regexprep(filename, '.fig', '_Plot D1.xls');
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename,  vec1)
                        filename=listbox(n1) ;
                        filename=char(filename);
                        filename=regexprep(filename, '.fig', '_Plot D2.xls');
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename,  vec2)
                end
        end
        
        if strcmp(selected_mode,'Off')~=1
            xlabel('Frames');    ylabel('Measured Value');
            if strcmp(selected_mode,'Figure')==1
                set(gcf,'userdata', data(popupmenu_Value).cdata)
                set(gcf,'colormap',handles.c);
            end
            
            hold off
            axis on
            axis tight
        end
    end
    
    %  --
    %  -------
    if isempty(findstr( popupmenu,'Plot (D1-D2)\(D1+D2)'))~=1
        switch group_option
            case 1
                
                for ii=n1:n2
                    D1D2_vec= D1D2_VECTOR(ii).cdata;
                    Data_out(1:length(D1D2_vec),ii)=D1D2_vec ;
                    if strcmp(selected_mode,'Off')~=1
                        h_plot=plot(1:length(D1D2_vec),D1D2_vec ,'MarkerFaceColor',handles.C(ii,:),'MarkerEdgeColor',handles.C(ii,:),  'Marker','.', 'LineStyle','none')
                        set(h_plot, 'Hittest','Off')  ;
                    end
                end
                switch excel_option
                    case 1
                        filename=listbox(1) ;
                        filename=char(filename);
                        filename=regexprep(filename, filename( findstr(filename,'_pos'):end), '_Plot (D1-D2)\(D1+D2).xls')
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename, D1D2_matrix)
                end
            case 0
                Data_out = D1D2_VECTOR(ii).cdata;
                D1D2_vec=D1D2_VECTOR(ii).cdata;  %(because ii=n1, and also n2...)
                h_plot= plot(1:length(D1D2_vec),D1D2_vec ,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 1],  'Marker','square', 'LineStyle','none')
                set(h_plot, 'Hittest','Off')  ;
        end
        
        switch excel_option
            case 1
                filename=listbox(n1) ;
                filename=char(filename);
                filename=regexprep(filename, '.fig', '_Plot (D1-D2)\(D1+D2).xls');
                filename=char(strcat(pathname,filename));
                if isempty(dir(filename))==0
                    delete(filename)
                end
                xlswrite(filename,  D1D2_vec)
        end
        if strcmp(selected_mode,'Off')~=1
            xlabel('Frames');
            hold off
            axis on
            if strcmp(selected_mode,'Figure')==1
                set(gcf,'userdata',data(popupmenu_Value).cdata)
                set(gcf,'colormap',handles.c);
            end
            
            axis tight
        end
    end
    
    
    %  --
    %  -------
    
    
    if isempty(findstr( popupmenu,'Plot Average (D1-D2)\(D1+D2)'))~=1
        if strcmp(selected_mode,'Off')~=1
            errorbar(AVG,STD,'MarkerSize',15,'MarkerEdgeColor',[0 0 1],'Marker','square',...
                'LineStyle','none',...
                'Color',[1 0 0]);
            
            eval(strcat('set(handles.axes',num2str(index),',''XColor'',''k''',')'));
            eval(strcat('set(handles.axes',num2str(index),',''YColor'',''k''',')'));
        end
        switch group_option
            case 1
                if strcmp(selected_mode,'Off')~=1
                    axis tight
                end
        end
        if strcmp(selected_mode,'Off')~=1
            ylabel('Mean')
            xlabel('Time')
            hold off
        end
        switch excel_option
            case 1
                filename=listbox(1) ;
                filename=char(filename);
                filename=regexprep(filename, filename( findstr(filename,'_pos'):end), '_Plot Average (D1-D2)\(D1+D2).xls')
                filename=char(strcat(pathname,filename));
                if isempty(dir(filename))==0
                    delete(filename)
                end
                
                xlswrite(filename, AVG')
        end
        
        if strcmp(selected_mode,'Figure')==1
            set(gcf,'userdata',data(popupmenu_Value).cdata)
            set(gcf,'colormap',handles.c);
        end
        
        
    end
    
    %  --
    %  -------
end

%  --
%  -------
%  ------------
%  ------------------


if isempty(findstr( popupmenu,'Imagesc Dividing_2D_Projection'))~=1
    if strcmp(selected_mode,'Off')~=1
        imagesc(data(n1).cdata.projection_matrix) % Projections can not be averaged!!!
    end
    switch excel_option
        case 1
            filename=listbox(n1);
            filename=regexprep(filename, '.fig', '_Imagesc Dividing_2D_Projection.xls');
            filename=char(strcat(pathname,filename));
            if isempty(dir(filename))==0
                delete(filename)
            end
            xlswrite(filename, data(n1).cdata.projection_matrix) ; %Projections can not be averaged!!!
    end
    if strcmp(selected_mode,'Figure')==1
        set(gcf,'userdata',data(n1).cdata.projection_matrix)
        set(gcf,'colormap',handles.c);
    end
    
end

%  --
%  -------
%  ------------
%  ------------------

if isempty(findstr( popupmenu,'Imagesc Fused_Dividing_2D_Projection'))~=1
    matrix=data(n1).cdata.projection_matrix; % Projections can not be averaged!!!
    for ii=1:size(matrix,2)
        vector=matrix(:,ii);
        
        
        for iii=1:size(vector,1)
            if vector(iii)<Thresh_input
                vector(iii)=0;
            end
        end
        
        vector(vector==0)=[];
        vec(ii).cdata=vector;
    end
    
    max_x=0;
    for ii=1:size(matrix,2)
        if max_x<length(vec(ii).cdata)
            max_x=length(vec(ii).cdata);
        end
    end
    new_matrix=zeros( max_x,size(matrix,2));
    for ii=1:size(matrix,2)
        V= vec(ii).cdata;
        Difference=size(new_matrix,1)-length(V);
        if Difference<2
            new_matrix(1:length(V),ii)=vec(ii).cdata ;
        else
            if  abs(round(Difference/2))/Difference*2==1
                new_matrix(Difference/2:Difference/2+size(vec(ii).cdata,1)-1,ii)=vec(ii).cdata';
            else
                new_matrix(1+Difference/2:Difference/2+size(vec(ii).cdata,1),ii)=vec(ii).cdata';
            end
        end
    end
    if strcmp(selected_mode,'Off')~=1
        imagesc(new_matrix)
    end
    switch excel_option
        case 1
            filename=listbox(n1);
            filename=regexprep(filename, '.fig', '_Imagesc Fused_Dividing_2D_Projection.xls');
            filename=char(strcat(pathname,filename));
            if isempty(dir(filename))==0
                delete(filename)
            end
            xlswrite(filename, new_matrix) ; %Projections can not be averaged!!!
    end
    if strcmp(selected_mode,'Figure')==1
        set(gcf,'userdata',matrix)
        set(gcf,'colormap',handles.c);
    end
    
end






% ----
% -------------
% ------------------------

if strcmp( popupmenu,'Imagesc Dividing_Montage')==1
    'Imagesc Dividing_Montage'
    Data=data(n1).cdata.Montage;
    Div_start_at_frame=data(n1).cdata.Div_start_at_frame ;
    
    temp_str=data(n1).cdata.upper_cell
    cell_number=temp_str(strfind(temp_str,':')+1:strfind(temp_str,'.')-1)
    on_top=temp_str(2:strfind(temp_str,':')-1); on_top=num2str(on_top);
    D1_tag=temp_str(strfind(temp_str,'.')+1:end);  D1_tag=str2num( D1_tag)
    if   D1_tag==1
        D2_tag=2
    else
        D2_tag=1
    end
    
    
    
    if  on_top==1
        str_UP=strcat('D1:  ',cell_number,'.', num2str(D1_tag));
        str_DOWN=strcat('D2:  ', cell_number,'.', num2str(D2_tag));
        
    else
        
        str_UP=strcat('D2:  ',cell_number,'.', num2str(D2_tag))
        str_DOWN=strcat('D1:  ',cell_number,'.', num2str(D1_tag))
    end
    
    
    Montage=Data;
    max_x=0;
    max_y=0;
    
    for ii=1:size(Montage,2)
        if max_x<size(Montage(ii).cdata,1)
            max_x=size(Montage(ii).cdata,1);
        end
        if max_y<size(Montage(ii).cdata,2)
            max_y=size(Montage(ii).cdata,2);
        end
    end
    
    try
        if   Merge_channels_Value==1
            if  max(max(max(Montage(ii).cdata)))<256
                D= uint8(zeros(max_x,max_y,3,ii));
            else
                D= uint16(zeros(max_x,max_y,3,ii));
            end
            
            
            for ii=1:size(Montage,2)
                D(end-size(Montage(ii).cdata,1)+1:end, end-size(Montage(ii).cdata,2)+1:end,:,ii)= Montage(ii).cdata ;
            end
        else
            D=zeros(max_x,max_y,1,ii);
            for ii=1:size(Montage,2)
                D(end-size(Montage(ii).cdata,1)+1:end, end-size(Montage(ii).cdata,2)+1:end,1,ii)=Montage(ii).cdata(:,:) ;
            end
        end
    catch
        msgbox('Merge channels option setting may be wrong')
        return
    end
    
    
    
    
    if strcmp(selected_mode,'Off')~=1
        montage(D, 'DisplayRange', []);
        set(gcf,'Colormap',jet);
        eval(strcat('set(handles.axes',num2str(index),',''YColor'',''k''',')'));
        ylabel(['Parental was tracked for  '   num2str(Div_start_at_frame)     '  frames before division'])
        title(str_UP);       xlabel(str_DOWN);
        set(gcf,'userdata',data(n1).cdata);
        
    end
    switch excel_option
        case 1
            Y=wavread('Error');  sound(Y,22000);
            set(handles.track_what_1,'Value',1) ;
            h = msgbox('Converstion to Excel is not supported for Montage ','Aborted');
    end
    
    return
end


% ----
% -------------
if isempty(findstr( popupmenu,'Imagesc Dividing_Movie'))~=1
    
    Data=data(n1).cdata.Montage ;
    for ii=1:size(Data,2)
        figure(1)
        if isempty(Data(ii).cdata)~=1
            if strcmp(selected_mode,'Off')~=1
                imagesc(Data(ii).cdata);
                axis equal
                axis tight
                pause(0.1)
                %       ii
                %       pause
            end
        end
    end
    close(1)
    switch excel_option
        case 1
            Y=wavread('Error');  sound(Y,22000);
            set(handles.track_what_1,'Value',1) ;
            h = msgbox('Converstion to Excel is not supported for Movie ','Aborted');
    end
    return
end

if strcmp( popupmenu,'Imagesc Dividing_Montage_box')==1
    'Imagesc Dividing_Montage_box'
    Data_temp=data(n1).cdata.Montage;
    Div_start_at_frame=data(n1).cdata.Div_start_at_frame ;
    start_at_frame=str2double(get(handles.param_edit1,'string'));
    end_at_frame=str2double(get(handles.param_edit2,'string'));
    %     set(handles.param_text1,'string','points before division') ;
    %      set(handles.param_text2,'string','points after division') ;
    set(handles.Parameters,'Visible','on') ;
    
    
    Div_start_at_frame= Div_start_at_frame-start_at_frame
    for ii=1:(end_at_frame+start_at_frame)
        Data(ii).cdata=Data_temp(Div_start_at_frame+ii).cdata;
    end
    
    max_x=0;
    max_y=0;
    for ii=1:size(Data,2)
        if max_x<size(Data(ii).cdata,1)
            max_x=size(Data(ii).cdata,1);
        end
        if max_y<size(Data(ii).cdata,2)
            max_y=size(Data(ii).cdata,2);
        end
    end
    
    if   Merge_channels_Value==1
        D= uint16(zeros(max_x,max_y,3,ii));  %uint8 or 16, can cause some bugs
        for ii=1:size(Data,2)
            D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,:,ii)= Data(ii).cdata  ;
        end
    else
        D=zeros(max_x,max_y,1,ii);
        for ii=1:size(Data,2)
            D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,1,ii)=Data(ii).cdata(:,:) ;
        end
    end
    
    
    
    z=[start_at_frame, end_at_frame];
    
    
    if strcmp(selected_mode,'Off')~=1
        montage(D, 'DisplayRange', [],  'Size',[((start_at_frame+end_at_frame)/min(z))  min(z)]);
        set(gcf,'Colormap',jet);
        eval(strcat('set(handles.axes',num2str(index),',''YColor'',''k''',')'));
        ylabel(['Parental was tracked for  '   num2str(Div_start_at_frame)     '  frames before division'])
    end
    switch excel_option
        case 1
            Y=wavread('Error');  sound(Y,22000);
            set(handles.track_what_1,'Value',1) ;
            h = msgbox('Converstion to Excel is not supported for Montage ','Aborted');
    end
    return
end





if strcmp( popupmenu,'Imagesc Dividing_SEQtage')==1
    'Imagesc Dividing_Montage'
    Data=data(n1).cdata.Montage;
    Div_start_at_frame=data(n1).cdata.Div_start_at_frame ;
    
    temp_str=data(n1).cdata.upper_cell
    cell_number=temp_str(strfind(temp_str,':')+1:strfind(temp_str,'.')-1)
    on_top=temp_str(2:strfind(temp_str,':')-1); on_top=num2str(on_top);
    D1_tag=temp_str(strfind(temp_str,'.')+1:end);  D1_tag=str2num( D1_tag)
    if   D1_tag==1
        D2_tag=2
    else
        D2_tag=1
    end
    
    if  on_top==1
        str_UP=strcat('D1:  ',cell_number,'.', num2str(D1_tag));
        str_DOWN=strcat('D2:  ', cell_number,'.', num2str(D2_tag));
        
    else
        
        str_UP=strcat('D2:  ',cell_number,'.', num2str(D2_tag))
        str_DOWN=strcat('D1:  ',cell_number,'.', num2str(D1_tag))
    end
    max_x=0;
    max_y=0;
    for ii=1:size(Data,2)
        if max_x<size(Data(ii).cdata,1)
            max_x=size(Data(ii).cdata,1);
        end
        if max_y<size(Data(ii).cdata,2)
            max_y=size(Data(ii).cdata,2);
        end
    end
    D=zeros(max_x,max_y,1,ii);
    for ii=1:size(Data,2)
        D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,1,ii)=Data(ii).cdata(:,:) ;
    end
    
    
    montage(D, 'DisplayRange', []);  set(gcf,'Colormap',jet);
    set(gcf,'Colormap',jet);
    eval(strcat('set(handles.axes',num2str(index),',''YColor'',''k''',')'));
    ylabel(['Parental was tracked for  '   num2str(Div_start_at_frame)     '  frames before division'])
    title(str_UP);       xlabel(str_DOWN);
    set(gcf,'userdata',data(n1).cdata);
    
    
    
    
    return
end










if isempty(findstr( popupmenu,'plot Rose histogram'))~=1
    theta=data(1).cdata.theta;
    param_edit1=str2num(get(handles.param_edit1,'string'));
    param_edit2=str2num(get(handles.param_edit2,'string'));
    
    theta=theta(param_edit1:param_edit2)
    hline = rose(theta*pi/180) ;
    set(hline,'LineWidth',1.5)
    %  title_str=strcat('Cell-  histogram of angles between cell and proximity:  ',num2str(n_tag))
    % title(title_str ,'fontsize',14)
    set(gcf,'userdata',theta*pi/180);
    xlabel('Angles between cell and proximity vector')
    set(gcf,'color','w')
    
end

if isempty(findstr( popupmenu,'scatter vectors'))~=1
    
    Data=data(1).cdata;
    theta=Data.theta;
    
    struct_Names=fieldnames(Data)  ;
    
    str1=char(struct_Names(2))  ;
    eval(strcat('vector1=Data.',str1,';'))
    str2=char(struct_Names(3))
    eval(strcat('vector2=Data.',str2,';'))
    
    param_edit1=str2num(get(handles.param_edit1,'string'));
    param_edit2=str2num(get(handles.param_edit2,'string'));
    theta=theta(param_edit1:param_edit2)
    vector1=vector1(param_edit1:param_edit2) ;
    vector2=vector2(param_edit1:param_edit2)  ;
    
    scatter(vector1,vector2  ,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 0],  'Marker','square');
    xlabel('Length of proximity vector  (pixels)')
    ylabel('Distance  between centroids (pixels)')
    hold off
end

if isempty(findstr( popupmenu,'plot Polar'))~=1
    
    Data=data(1).cdata;
    theta=Data.theta;
    
    struct_Names=fieldnames(Data);
    str =char(struct_Names(popupmenu_Value));    eval(strcat('vector=Data.',str,';'))
    
    
    param_edit1=str2num(get(handles.param_edit1,'string'));
    param_edit2=str2num(get(handles.param_edit2,'string'));
    theta=theta(param_edit1:param_edit2) ;
    vector =vector(param_edit1:param_edit2) ;
    
    
    
    index_max=find(ismember(vector,max(max(vector))));
    h_p2=polar(theta(index_max)*pi/180,vector(index_max));
    set(h_p2,'lineStyle', 'none'  ,'Marker', 'square','MarkerSize',0.4, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor' , [1 1 1])
    axis tight
    hold on
    
    n=1:length(theta);
    C=cool(length(theta));
    n= n./20;
    for ii=1:length(theta)
        h_p2=polar(theta(ii)*pi/180,vector(ii));
        set(h_p2,'lineStyle', 'none'  ,'Marker', 'square','MarkerSize',0.4, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor' , C(ii,:))
    end
    
    set(gcf ,'colormap',C);
    if strcmp(selected_mode,'Figure')==1
        
        colorbar_location=colorbar('location','southoutside')
        cbfreeze
    end
    
end








% --- Executes on button press in checkbox1.




%     axis image
if strcmp(selected_mode,'Off')~=1
    axis normal
end
% axis off
% axis on
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text7.




function param_edit1_Callback(hObject, eventdata, handles)
% hObject    handle to param_edit1 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param_edit1 as text
%        str2double(get(hObject,'String')) returns contents of param_edit1 as go double


% --- Executes during object creation, after setting all properties.
function param_edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_edit1 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have go white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param_edit2_Callback(hObject, eventdata, handles)
% hObject    handle to param_edit2 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param_edit2 as text
%        str2double(get(hObject,'String')) returns contents of param_edit2 as go double


% --- Executes during object creation, after setting all properties.
function param_edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_edit2 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have go white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
sel_typ = get(gcbf,'SelectionType')
point1 = get(hObject,'CurrentPoint')
ButtonDown_function(handles, sel_typ, point1,1)
function axes2_ButtonDownFcn(hObject, eventdata, handles)
sel_typ = get(gcbf,'SelectionType') ;  point1 = get(hObject,'CurrentPoint')  ;
ButtonDown_function(handles, sel_typ, point1,2) ;
function axes3_ButtonDownFcn(hObject, eventdata, handles)
sel_typ = get(gcbf,'SelectionType')
point1 = get(hObject,'CurrentPoint')
ButtonDown_function(handles, sel_typ, point1,3)
function axes4_ButtonDownFcn(hObject, eventdata, handles)
sel_typ = get(gcbf,'SelectionType') ;  point1 = get(hObject,'CurrentPoint')  ;
ButtonDown_function(handles, sel_typ, point1,4) ;
function axes5_ButtonDownFcn(hObject, eventdata, handles)
sel_typ = get(gcbf,'SelectionType') ;  point1 = get(hObject,'CurrentPoint')  ;
ButtonDown_function(handles, sel_typ, point1,5) ;
function axes6_ButtonDownFcn(hObject, eventdata, handles)
sel_typ = get(gcbf,'SelectionType') ;  point1 = get(hObject,'CurrentPoint')  ;
ButtonDown_function(handles, sel_typ, point1,6) ;
%  --------------------------------------------------
function ButtonDown_function(handles, sel_typ, point1,index)
%1. Getting index of box
%2 getting data from the indexed box
%3 getting case: parentsl. d1 and d2, ratio of d1 and d2. each case
%different data case
%    4. getting minimum between mouse position and nearest point will give
%    the indexed data set for a population within the box.

Data_out =plot_data(handles,index,'Off')
frame=round(point1(1))   ;
if strcmp(sel_typ,'normal')==1
    'free option'
end

if strcmp(sel_typ,'alt')==1
    eval(strcat('popupmenu_Value=get(handles.popupmenu',num2str(index),',''Value'')'));
    eval(strcat('popupmenu_String=get(handles.popupmenu',num2str(index),',''String'')'));
    popupmenu= popupmenu_String(popupmenu_Value);
    popupmenu=char( popupmenu)   ;
    group_option=0; eval(strcat('if (get(handles.checkbox',num2str(index+6),',''Value'')==get(handles.checkbox',num2str(index+6),',''Max'')); group_option=1; end;  '))
    excel_option=0; eval(strcat('if (get(handles.checkbox',num2str(index),',''Value'')==get(handles.checkbox',num2str(index),',''Max'')); excel_option=1; end;  '))
    if isempty(findstr( popupmenu,'Plot Parental'))~=1
        switch group_option
            case 0
                
            case 1
                vec=Data_out(frame,:) ;
                [a,n]=nanmin(abs(-vec+point1(4)));
                filenme=eval(strcat('get(handles.listbox',num2str(index),',''string'')'));
                str=char(filename(n));
                Pos= str(findstr(str,'_Pos')+4:findstr(str,'_div')-1) ;
                Div=str(findstr(str,'_div_')+5:findstr(str,'.fig')-1)  ;
                pathname=handles.pathname_pos ;
                pathname=strcat(pathname,'Pos',Pos) ;
                filename=dir(strcat(pathname,'\*.dat'));
                filename= filename(1); filename=filename.name;
                fullfilename=strcat(pathname,'\',filename);
                data_file=importdata(fullfilename)
                run('TAC_Measurments_Module',data_file,Div)
                
                
                %%
        end
    end
    if isempty(findstr( popupmenu,'Plot D1 and D2'))~=1
        switch group_option
            case 1
                vec1=Data_out(1).cdata(frame,:)
                vec2=Data_out(2).cdata(frame,:)
                
                
                [a1,n1]=nanmin(abs(-vec1+point1(4)))
                [a2,n2]=nanmin(abs(-vec2+point1(4)))
                
                if a1<a2
                    n=n1;
                else
                    n=n2;
                end
                
                filenme=eval(strcat('get(handles.listbox',num2str(index),',''string'')'));
                str=char(filename(n));
                Pos= str(findstr(str,'_Pos')+4:findstr(str,'_div')-1) ;
                Div=str(findstr(str,'_div_')+5:findstr(str,'.fig')-1)  ;
                pathname=handles.pathname_pos ;
                pathname=strcat(pathname,'Pos',Pos) ;
                filename=dir(strcat(pathname,'\*.dat'));
                filename= filename(1); filename=filename.name;
                fullfilename=strcat(pathname,'\',filename);
                data_file=importdata(fullfilename)
                run('TAC_Measurments_Module',data_file,Div)
                
                
                
                
                
            case 0
        end
    end
    if isempty(findstr( popupmenu,'Plot (D1-D2)\(D1+D2)'))~=1
        switch group_option
            case 1
                vec=Data_out(frame,:)
                [a,n]=nanmin(abs(-vec+point1(4)));
                filenme=eval(strcat('get(handles.listbox',num2str(index),',''string'')'));
                str=char(filename(n));
                Pos= str(findstr(str,'_Pos')+4:findstr(str,'_div')-1) ;
                Div=str(findstr(str,'_div_')+5:findstr(str,'.fig')-1)  ;
                pathname=handles.pathname_pos ;
                pathname=strcat(pathname,'Pos',Pos) ;
                filename=dir(strcat(pathname,'\*.dat'));
                filename= filename(1); filename=filename.name;
                fullfilename=strcat(pathname,'\',filename);
                data_file=importdata(fullfilename)
                run('TAC_Measurments_Module',data_file,Div)
                
            case 0
                
        end
    end
end
if strcmp(sel_typ,'extend')==1
    'extend'
    eval(strcat('popupmenu_Value=get(handles.popupmenu',num2str(index),',''Value'')'));
    eval(strcat('popupmenu_String=get(handles.popupmenu',num2str(index),',''String'')'));
    popupmenu= popupmenu_String(popupmenu_Value);
    popupmenu=char( popupmenu)   ;
    group_option=0; eval(strcat('if (get(handles.checkbox',num2str(index+6),',''Value'')==get(handles.checkbox',num2str(index+6),',''Max'')); group_option=1; end;  '))
    excel_option=0; eval(strcat('if (get(handles.checkbox',num2str(index),',''Value'')==get(handles.checkbox',num2str(index),',''Max'')); excel_option=1; end;  '))
    if isempty(findstr( popupmenu,'Plot Parental'))~=1
        switch group_option
            case 0
                
            case 1
                vec=Data_out(frame,:) ;
                [a,n]=nanmin(abs(-vec+point1(4)));
                eval(strcat('set(handles.listbox',num2str(index),',''Value'',n)'));
                lock_listbox( handles,n,index) ;
        end
    end
    if isempty(findstr( popupmenu,'Plot D1 and D2'))~=1
        switch group_option
            case 1
                vec1=Data_out(1).cdata(frame,:)
                vec2=Data_out(2).cdata(frame,:)
                
                
                [a1,n1]=nanmin(abs(-vec1+point1(4)))
                [a2,n2]=nanmin(abs(-vec2+point1(4)))
                
                if a1<a2
                    n=n1;
                else
                    n=n2;
                end
                
                eval(strcat('set(handles.listbox',num2str(index),',''Value'',n)'));
                lock_listbox( handles,n,index) ;
                
                
                
                
            case 0
        end
    end
    if isempty(findstr( popupmenu,'Plot (D1-D2)\(D1+D2)'))~=1
        switch group_option
            case 1
                vec=Data_out(frame,:)
                [a,n]=nanmin(abs(-vec+point1(4)));
                eval(strcat('set(handles.listbox',num2str(index),',''Value'',n)'));
                lock_listbox( handles,n,index) ;
            case 0
                
        end
    end
end
%   ---------------------------
function zoom_in(handles, index,point1)
if nargin==2
    eval(strcat('point1 =get(handles.axes',num2str(index),',''CurrentPoint'');'));
end
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','square','''',',','''','lim','''',']);'))
eval(strcat('curr_lim2=get(handles.axes',num2str(index),',','[','''','k','''',',','''','lim','''',']);'))
range_data1 = abs(diff(curr_lim1)) ;
range_data2 = abs(diff(curr_lim2)) ;
range_data1 = range_data1+range_data1*0.1;
range_data2 = range_data2+range_data2*0.1 ;
Xlim=[point1(1)-range_data1/2  point1(1)+range_data1/2];
Ylim=[point1(4)-range_data2/2  point1(4)+range_data2/2];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','square','''',',','''','lim','''','],Xlim);'))
eval(strcat('set(handles.axes',num2str(index),',','[','''','k','''',',','''','lim','''','],Ylim);'))
%  --------------------------------------------------
function zoom_out(handles, index,point1)
if nargin==2
    eval(strcat('point1 =get(handles.axes',num2str(index),',''CurrentPoint'');'));
end
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','square','''',',','''','lim','''',']);'))
eval(strcat('curr_lim2=get(handles.axes',num2str(index),',','[','''','k','''',',','''','lim','''',']);'))
range_data1 = abs(diff(curr_lim1)) ;
range_data2 = abs(diff(curr_lim2)) ;
range_data1 = range_data1-range_data1*0.1;
range_data2 = range_data2-range_data2*0.1 ;
Xlim=[point1(1)-range_data1/2  point1(1)+range_data1/2];
Ylim=[point1(4)-range_data2/2  point1(4)+range_data2/2];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','square','''',',','''','lim','''','],Xlim);'))
eval(strcat('set(handles.axes',num2str(index),',','[','''','k','''',',','''','lim','''','],Ylim);'))
%  --------------------------------------------------

% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
point  = get(gcf,'CurrentPoint')    ;
xy  =get(handles.axes1, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
    set(gcf,'Pointer','arrow')
else
    xy  =get(handles.axes2, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
    if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
        set(gcf,'Pointer','arrow')
    else
        xy  =get(handles.axes3, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
        if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
            set(gcf,'Pointer','arrow')
        else
            xy  =get(handles.axes4, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
            if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
                set(gcf,'Pointer','arrow')
            else
                xy  =get(handles.axes5, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
                if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
                    set(gcf,'Pointer','arrow')
                else
                    xy  =get(handles.axes6, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
                    if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
                        set(gcf,'Pointer','arrow')
                    else
                        set(gcf,'Pointer','hand')
                    end ;end;end;end;end;end


% --- Executes on mouse press over figure background, over go disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
point  = get(hObject,'CurrentPoint')  ;
xy  =get(handles.axes1, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
    index=1;
else
    xy  =get(handles.axes2, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
    if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
        index=2;
    else
        xy  =get(handles.axes3, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
        if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
            index=3;
        else
            xy  =get(handles.axes4, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
            if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
                index=4;
            else
                xy  =get(handles.axes5, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
                if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
                    index=5;
                else
                    xy  =get(handles.axes6, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
                    if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
                        index=6;
                    else
                        set(gcf,'Pointer','hand')
                    end ;end;end;end;end;end


%
%   if eventdata.VerticalScrollCount>0
%       zoom_in(handles,index)
%   else
%      zoom_out(handles, index)
%   end


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if   handles.flag.axis1==-1
    set(handles.uipanel1,'visible','on')
    set(handles.axes1,'visible','on')
    set(handles.text1,'visible','on')
    set(handles.text7,'visible','on')
    
else
    cla(handles.axes1)
    set(handles.uipanel1,'visible','off')
    set(handles.axes1,'visible','off')
    set(handles.text1,'visible','off')
    set(handles.text7,'visible','off')
end
handles.flag.axis1=handles.flag.axis1*(-1);
guidata(hObject, handles);

% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if   handles.flag.axis2==-1
    set(handles.uipanel2,'visible','on')
    set(handles.axes2,'visible','on')
    set(handles.text2,'visible','on')
    set(handles.text8,'visible','on')
    
else
    cla(handles.axes2)
    set(handles.uipanel2,'visible','off')
    set(handles.axes2,'visible','off')
    set(handles.text2,'visible','off')
    set(handles.text8,'visible','off')
end
handles.flag.axis2=handles.flag.axis2*(-1);
guidata(hObject, handles);
% --------------------------------------------------------------------
function uipushtool3_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool3 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if   handles.flag.axis3==-1
    set(handles.uipanel3,'visible','on')
    set(handles.axes3,'visible','on')
    set(handles.text3,'visible','on')
    set(handles.text9,'visible','on')
    
    
    
    
else
    cla(handles.axes3)
    set(handles.uipanel3,'visible','off')
    set(handles.axes3,'visible','off')
    set(handles.text3,'visible','off')
    set(handles.text9,'visible','off')
    
    
end
handles.flag.axis3=handles.flag.axis3*(-1);
guidata(hObject, handles);
% --------------------------------------------------------------------
function uipushtool4_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool4 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if   handles.flag.axis4==-1
    set(handles.uipanel4,'visible','on')
    set(handles.axes4,'visible','on')
    set(handles.text4,'visible','on')
    set(handles.text10,'visible','on')
    
else
    cla(handles.axes4)
    set(handles.uipanel4,'visible','off')
    set(handles.axes4,'visible','off')
    set(handles.text4,'visible','off')
    set(handles.text10,'visible','off')
end
handles.flag.axis4=handles.flag.axis4*(-1);
guidata(hObject, handles);
% --------------------------------------------------------------------
function uipushtool5_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool5 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if   handles.flag.axis5==-1
    set(handles.uipanel5,'visible','on')
    set(handles.axes5,'visible','on')
    set(handles.text5,'visible','on')
    set(handles.text11,'visible','on')
    
else
    cla(handles.axes5)
    set(handles.uipanel5,'visible','off')
    set(handles.axes5,'visible','off')
    set(handles.text5,'visible','off')
    set(handles.text11,'visible','off')
end
handles.flag.axis5=handles.flag.axis5*(-1);
guidata(hObject, handles);

% --------------------------------------------------------------------
function uipushtool6_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool6 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if   handles.flag.axis6==-1
    set(handles.uipanel6,'visible','on')
    set(handles.axes6,'visible','on')
    set(handles.text6,'visible','on')
    set(handles.text12,'visible','on')
    
    
    
    
    
    
    
else
    cla(handles.axes6)
    set(handles.uipanel6,'visible','off')
    set(handles.axes6,'visible','off')
    set(handles.text6,'visible','off')
    set(handles.text12,'visible','off')
    
    
    
end
handles.flag.axis6=handles.flag.axis6*(-1);
guidata(hObject, handles);

% --------------------------------------------------------------------
function uipushtool7_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool7 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if   handles.flag.axis1==-1
    set(handles.uipanel8,'visible','on')
    
    
else
    set(handles.uipanel8,'visible','off')
    
end
handles.flag.axis1=handles.flag.axis1*(-1);
guidata(hObject, handles);


% --------------------------------------------------------------------
function uipushtool8_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool8 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.c=change_LUT ;
guidata(hObject, handles);
set(gcf,'colormap',handles.c);% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in text7.
function text7_Callback(hObject, eventdata, handles)
plot_data(handles,1,'Figure')
function text8_Callback(hObject, eventdata, handles)
plot_data(handles,2,'Figure')
function text9_Callback(hObject, eventdata, handles)
plot_data(handles,3,'Figure')
function text10_Callback(hObject, eventdata, handles)
plot_data(handles,4,'Figure')
function text11_Callback(hObject, eventdata, handles)
plot_data(handles,5,'Figure')
function text12_Callback(hObject, eventdata, handles)
plot_data(handles,6,'Figure')


% --------------------------------------------------------------------
function uitoggletool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool1 (see GCBO)
% eventdata  reserved - to be defined in go future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if   handles.flag.Absolut==-1
    set(handles.text_Absolut,'Visible','on')
else
    set(handles.text_Absolut,'Visible','off')
end
handles.flag.Absolut=handles.flag.Absolut*(-1);
guidata(hObject, handles);





% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xy_border =get(handles.axes1, 'Position')
xy_border=xy_border./2
axes(handles.axes1)


%           rectangle('Position',[handles.Y1 handles.X1 handles.Y handles.X],'LineWidth',3,'LineStyle','-','EdgeColor','m');
h = imrect(gca);


%  api = iptgetapi(h);
% %     fcn = makeConstrainToRectFcn('impoint',get(gca,'XLim'),get(gca,'YLim'));
%     api.setPositionConstraintFcn(fcn);
%

% fig = gcf;

%  list

%   setColor(h,[1 0 1]);
xy = wait(h)



xy=round(xy);
handles.Y1=ceil(xy(1))
handles.X1=xy(2)
handles.Y=ceil(xy(3))
handles.X=xy(4)

guidata(hObject,handles)


% y=xy(1,1)
% x=xy(1,2)
listbox1_Callback(hObject, eventdata, handles)
h_rectangle=rectangle('Position', xy,'LineWidth',5,'LineStyle','--','EdgeColor','m');
set(h_rectangle, 'Hittest','Off')   ;
use_gate( hObject, eventdata, handles,index)

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
function use_gate( hObject, eventdata, handles,index)



% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%1. Getting index of box
%2 getting data from the indexed box
%3 getting case: parentsl. d1 and d2, ratio of d1 and d2. each case
%different data case
%    4.  gettings n _list which is list of all n`s of data within the box




Data_out =plot_data(handles,index,'Off')

rect=[handles.Y1 handles.X1 handles.Y   handles.X]

matrix1=Data_out;

matrix1(1:rect(1),:)=nan;
matrix1(rect(1)+rect(3):end,:)=nan;
matrix1(matrix1<rect(2))=nan;
matrix1(matrix1>rect(2)+rect(4))=nan;
matrix1=matrix1./matrix1




for ii=1:6
    if ii~=index
        eval(strcat('listbox=get(handles.listbox',num2str(ii),',''String'')'))
        if size(listbox,1)*size(listbox,2)>1
            plot_gate(handles,ii,'Axes',matrix1)
            
            pause(1)
        end
    end
end


% --------------------------------------------------------------------
function set_gate( hObject, eventdata, handles,index)
% hObject    handle to uipushtool15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





eval(strcat('point1 =get(handles.axes',num2str(index),',''Position'');'));
point1=point1./2;
eval(strcat('axes(handles.axes',num2str(index),')'));
h_rectangle = imrect(gca);
setColor(h_rectangle,[0 0 1]);
xy = wait(h_rectangle)

%    y=xy(1,1)
%   x=xy(1,2)

%     xy=round(xy);
handles.Y1=ceil(xy(1))
handles.X1=xy(2)
handles.Y=ceil(xy(3))
handles.X=xy(4)
%   x=xy(1,2)

guidata(hObject,handles)
set(h_rectangle, 'Hittest','Off')   ;



eval(strcat('listbox', num2str(index),'_Callback(hObject, eventdata, handles)'))



%
%   h_rectangle=rectangle('Position', xy,'LineWidth',5,'LineStyle','--','EdgeColor','m');
rectangle('Position',[handles.Y1 handles.X1 handles.Y   handles.X],'LineWidth',5,'LineStyle','-','EdgeColor','m');
use_gate( hObject, eventdata, handles,index)

function move_gate( hObject, eventdata, handles,index)
% hObject    handle to uipushtool15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


eval(strcat('axes(handles.axes',num2str(index),')'));
h_rectangle = imrect(gca,[handles.Y1 handles.X1 handles.Y   handles.X]  );
setColor(h_rectangle,[0 0 1]);
xy = wait(h_rectangle)

%    y=xy(1,1)
%   x=xy(1,2)

%     xy=round(xy);
handles.Y1=ceil(xy(1))
handles.X1=xy(2)
handles.Y=ceil(xy(3))
handles.X=xy(4)
%   x=xy(1,2)

guidata(hObject,handles)
set(h_rectangle, 'Hittest','Off')   ;



eval(strcat('listbox', num2str(index),'_Callback(hObject, eventdata, handles)'))



%
%   h_rectangle=rectangle('Position', xy,'LineWidth',5,'LineStyle','--','EdgeColor','m');
h_rectangle=  rectangle('Position',[handles.Y1 handles.X1 handles.Y   handles.X],'LineWidth',5,'LineStyle','-','EdgeColor','m');
set(h_rectangle, 'Hittest','Off')   ;



use_gate( hObject, eventdata, handles,index)
% --------------------------------------------------------------------
function Show_gate( hObject, eventdata, handles,index)

h_rectangle=  rectangle('Position',[handles.Y1 handles.X1 handles.Y   handles.X],'LineWidth',5,'LineStyle','-','EdgeColor','m');
set(h_rectangle, 'Hittest','Off')   ;

use_gate( hObject, eventdata, handles,index)

% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function set_gate_axes1_Callback(hObject, eventdata, handles)
set_gate( hObject, eventdata, handles,  1)
% --------------------------------------------------------------------
function set_gate_axes2_Callback(hObject, eventdata, handles)
set_gate( hObject, eventdata, handles, 2)
% --------------------------------------------------------------------
function set_gate_axes3_Callback(hObject, eventdata, handles)
set_gate( hObject, eventdata, handles,  3)
% --------------------------------------------------------------------
function set_gate_axes4_Callback(hObject, eventdata, handles)
set_gate( hObject, eventdata, handles,  4)
% --------------------------------------------------------------------
function set_gate_axes5_Callback(hObject, eventdata, handles)
set_gate( hObject, eventdata, handles,  5)
% --------------------------------------------------------------------
function set_gate_axes6_Callback(hObject, eventdata, handles)
set_gate( hObject, eventdata, handles,  6)
% --------------------------------------------------------------------


% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function move_gate_axes1_Callback(hObject, eventdata, handles)
% hObject    handle to move_gate_axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
move_gate( hObject, eventdata, handles,  1)

% --------------------------------------------------------------------
function move_gate_axes2_Callback(hObject, eventdata, handles)
% hObject    handle to move_gate_axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
move_gate( hObject, eventdata, handles, 2)

% --------------------------------------------------------------------
function move_gate_axes3_Callback(hObject, eventdata, handles)
% hObject    handle to move_gate_axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
move_gate( hObject, eventdata, handles,  3)

% --------------------------------------------------------------------
function move_gate_axes4_Callback(hObject, eventdata, handles)
% hObject    handle to move_gate_axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
move_gate( hObject, eventdata, handles,  4)

% --------------------------------------------------------------------
function move_gate_axes5_Callback(hObject, eventdata, handles)
% hObject    handle to move_gate_axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

move_gate( hObject, eventdata, handles,  5)
% --------------------------------------------------------------------
function move_gate_axes6_Callback(hObject, eventdata, handles)
% hObject    handle to move_gate_axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

move_gate( hObject, eventdata, handles,  6)


% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Show_gate_axes1_Callback(hObject, eventdata, handles)
% hObject    handle to Show_gate_axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Show_gate( hObject, eventdata, handles,  1)
% --------------------------------------------------------------------
function Show_gate_axes2_Callback(hObject, eventdata, handles)
% hObject    handle to Show_gate_axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Show_gate( hObject, eventdata, handles,  2)

% --------------------------------------------------------------------
function Show_gate_axes3_Callback(hObject, eventdata, handles)
% hObject    handle to Show_gate_axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Show_gate( hObject, eventdata, handles,  3)
% --------------------------------------------------------------------
function Show_gate_axes4_Callback(hObject, eventdata, handles)
% hObject    handle to Show_gate_axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Show_gate( hObject, eventdata, handles,  4)

% --------------------------------------------------------------------
function Show_gate_axes5_Callback(hObject, eventdata, handles)
% hObject    handle to Show_gate_axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Show_gate( hObject, eventdata, handles,  5)

% --------------------------------------------------------------------
function Show_gate_axes6_Callback(hObject, eventdata, handles)
% hObject    handle to Show_gate_axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Show_gate( hObject, eventdata, handles,  6)

% ---------------------------------------
function [Data_out]=plot_gate(handles,index,selected_mode,matrix)
%     ~~~~~~~~~~~~~~~~~
Data_out=[];
Thresh_input=[];
eval(strcat('Merge_channels_Value=get(handles.Merge_channels_',num2str(index),',''Value'')'));
eval(strcat('popupmenu_Value=get(handles.popupmenu',num2str(index),',''Value'')'));
eval(strcat('popupmenu_String=get(handles.popupmenu',num2str(index),',''String'')'));
eval(strcat('data=get(handles.listbox',num2str(index),',''Userdata'')'));
eval(strcat('pathname=get(handles.text',num2str(index),',''String'')'));
eval(strcat('listbox=get(handles.listbox',num2str(index),',''String'')'));
eval(strcat('Thresh_input =get(handles.slider ',num2str(index),',''String'')'));
Thresh_input=str2double(Thresh_input);
popupmenu= popupmenu_String(popupmenu_Value);
popupmenu=char( popupmenu)   ;
Absolut=handles.flag.Absolut;
group_option=0; eval(strcat('if (get(handles.checkbox',num2str(index+6),',''Value'')==get(handles.checkbox',num2str(index+6),',''Max'')); group_option=1; end;  '))
excel_option=0; eval(strcat('if (get(handles.checkbox',num2str(index),',''Value'')==get(handles.checkbox',num2str(index),',''Max'')); excel_option=1; end;  '))


if isempty(data)==1
    Y=wavread('Error');
    h = errordlg('No figures in listbox!! ','Error');
    sound(Y,22000);
    return
end
%  -------

switch group_option
    case 1
        n1=1;
        n2=size(data,2);
    case 0
        n1=[];
        eval(strcat('n1=get(handles.listbox',num2str(index),',''Value'')'));
        n2=n1;
end

n=n2-n1+1;
if strcmp(selected_mode,'Axes')==1
    eval(strcat('axes(handles.axes',num2str(index),')'));
    eval(strcat('cla(handles.axes',num2str(index),')'));
    %         cla reset
    
    %  eval(strcat('axes(handles.axes',num2str(index),')'));
end


if strcmp(selected_mode,'Figure')==1
    scrsz = get(0,'ScreenSize')  ;
    scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
    scrsz(3)=scrsz(4) ;
    h=figure('color','w','units','pixels','position', scrsz) ;
    % set(h,'colormap',handles.c);
    
    axis on
end


if isempty(findstr( popupmenu,'Plot (D1-D2)\(D1+D2)'))~=1||...
        isempty(findstr( popupmenu,'Plot Parental'))~=1 || isempty(findstr( popupmenu,'Plot D1 and D2'))~=1
    hold on
end

if  isempty(findstr( popupmenu,'Plot Parental'))~=1 || isempty(findstr( popupmenu,'Plot D1 and D2'))~=1 || ...
        isempty(findstr( popupmenu,'Plot (D1-D2)\(D1+D2)'))~=1 ||  isempty(findstr( popupmenu,'Plot Average (D1-D2)\(D1+D2)'))~=1
    if strcmp(selected_mode,'Off')~=1
        eval(strcat('set(handles.axes',num2str(index),',''XColor'',''k''',')'));
        eval(strcat('set(handles.axes',num2str(index),',''YColor'',''k''',')'));
    end
    
    
    
    
    max_length0=0; max_length1=0;max_length2=0; max_length_D1D2=0;
    for ii=n1:n2
        vec0=data(ii).cdata.Y_data(1).cdata  ;
        vec1=data(ii).cdata.Y_data(2).cdata  ;
        vec2=(data(ii).cdata.Y_data(3).cdata)  ;
        vec0(vec0==inf)=0;
        vec1(vec1==inf)=0;
        vec2(vec2==inf)=0;
        if length(vec1)>length(vec2)
            vec1 =vec1(1:length(vec2));
        end
        if length(vec2)>length(vec1)
            vec2 =vec2(1:length(vec1));
        end
        VECTOR0(ii).cdata=vec0;
        VECTOR1(ii).cdata=vec1;
        VECTOR2(ii).cdata=vec2;
        
        if max_length0<length(vec0)
            max_length0=length(vec0) ;
        end
        if max_length1<length(vec1)
            max_length1=length(vec1) ;
        end
        if max_length2<length(vec2)
            max_length2=length(vec2) ;
        end
        
        if Absolut
            D1D2_vec=abs(vec1-vec2)./(vec1+vec2);
        else
            D1D2_vec=(vec1-vec2)./(vec1+vec2);
        end
        D1D2_vec(D1D2_vec==inf)=0;
        D1D2_vec(isnan(D1D2_vec))=0;
        D1D2_VECTOR(ii).cdata=D1D2_vec;
        if max_length_D1D2<length(D1D2_vec)
            max_length_D1D2=length(D1D2_vec);
        end
    end
    
    
    matrix0=nan(max_length0,n);matrix1=nan(max_length1,n); matrix2=nan(max_length2,n);D1D2_matrix=nan(max_length_D1D2,n);
    for ii=n1:n2
        matrix0(end+1-length(VECTOR0(ii).cdata):end,ii)=VECTOR0(ii).cdata;
        matrix1(1:length(VECTOR1(ii).cdata),ii)=VECTOR1(ii).cdata;
        matrix2(1:length(VECTOR2(ii).cdata),ii)=VECTOR2(ii).cdata;
        D1D2_matrix(1:length(D1D2_VECTOR(ii).cdata),ii)=D1D2_VECTOR(ii).cdata;
    end
    if size(D1D2_matrix,1)~=1 && size(D1D2_matrix,2)~=1
        AVG=nanmean(D1D2_matrix,2)    ;
        STD=    nanstd(D1D2_matrix')   ;
        while STD(end)==0
            STD(end)=[];
            if length(STD)==1
                break
            end
        end
        AVG=AVG(1:length(STD));
    else
        AVG= D1D2_matrix      ;
        STD=  0  ;
    end
    %  --
    %  -------
    if isempty(findstr( popupmenu,'Plot Parental'))~=1
        switch group_option
            case 0
                Data_out= VECTOR0(ii).cdata;
                vec0= VECTOR0(ii).cdata;   %(because ii=n1, and also n2...)
                if strcmp(selected_mode,'Off')~=1
                    h_plot= plot(1:length(vec0),vec0 ,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 1],  'Marker','square', 'LineStyle','none');
                    set(h_plot, 'Hittest','Off')  ;
                end
                
                
                switch excel_option
                    case 1
                        filename=listbox(n1) ;
                        filename=char(filename);
                        filename=regexprep(filename, '.fig', '_Plot Parental.xls');
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename,  vec0)
                end
                
            case 1
                
                for ii=n1:n2
                    vec0= VECTOR0(ii).cdata;
                    Data_out(1:length(vec0),ii)=vec0;
                    if strcmp(selected_mode,'Off')~=1
                        h_plot= scatter(1:length(vec0),vec0 ,'MarkerFaceColor', handles.C(ii,:),'MarkerEdgeColor', handles.C(ii,:),  'Marker','.', 'LineStyle','none')
                        set(h_plot, 'Hittest','Off')  ;
                    end
                end
                switch excel_option
                    case 1
                        filename=listbox(1) ;
                        filename=char(filename);
                        filename=regexprep(filename, filename( findstr(filename,'_pos'):end), '_Plot Parental.xls') ;
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename, matrix0)  ;
                end
                
        end
        
        
        if strcmp(selected_mode,'Off')~=1
            xlabel('Frames');    ylabel('Measured Value');
            if strcmp(selected_mode,'Figure')==1
                set(gcf,'userdata',data)
                set(gcf,'colormap',handles.c);
            end
            hold off
            axis on
            axis tight
        end
    end
    
    %  --
    %  -------
    if isempty(findstr( popupmenu,'Plot D1 and D2'))~=1
        switch group_option
            case 1
                for ii=n1:n2
                    vec1= VECTOR1(ii).cdata;     Data_out(1).cdata(1:length(vec1),ii)=vec1;
                    if strcmp(selected_mode,'Off')~=1
                        h1_plot=plot(1:length(vec1),vec1 ,'MarkerFaceColor',handles.C(ii,:),'MarkerEdgeColor',handles.C(ii,:),  'Marker','square', 'LineStyle','none')
                        set(h1_plot, 'Hittest','Off')  ;
                    end
                    vec2= VECTOR2(ii).cdata;      Data_out(2).cdata(1:length(vec2),ii)=vec2;
                    if strcmp(selected_mode,'Off')~=1
                        h2_plot=plot(1:length(vec2),vec2 ,'MarkerFaceColor',handles.C(ii,:),'MarkerEdgeColor',handles.C(ii,:),  'Marker','square', 'LineStyle','none')
                        set(h2_plot, 'Hittest','Off')  ;
                    end
                end
                switch excel_option
                    case 1
                        filename=listbox(1) ;
                        filename=char(filename);
                        filename=regexprep(filename, filename( findstr(filename,'_pos'):end), '_Plot D1.xls')
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename, matrix1)
                        
                        filename=listbox(1) ;
                        filename=char(filename);
                        filename=regexprep(filename, filename( findstr(filename,'_pos'):end), '_Plot D2.xls')
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename, matrix2)
                end
            case 0
                Data_out(1).cdata= VECTOR1(ii).cdata; Data_out(2).cdata= VECTOR2(ii).cdata;
                vec1= VECTOR1(ii).cdata;   %(because ii=n1, and also n2...)
                if strcmp(selected_mode,'Off')~=1
                    h1_plot=plot(1:length(vec1),vec1 ,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 1],  'Marker','square', 'LineStyle','none')
                    set(h1_plot, 'Hittest','Off')  ;
                end
                vec2= VECTOR2(ii).cdata;   %(because ii=n1, and also n2...)
                if strcmp(selected_mode,'Off')~=1
                    h2_plot=plot(1:length(vec2),vec2 ,'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[1 0 0],  'Marker','square', 'LineStyle','none')
                    set(h2_plot, 'Hittest','Off')  ;
                end
                switch excel_option
                    case 1
                        filename=listbox(n1) ;
                        filename=char(filename);
                        filename=regexprep(filename, '.fig', '_Plot D1.xls');
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename,  vec1)
                        filename=listbox(n1) ;
                        filename=char(filename);
                        filename=regexprep(filename, '.fig', '_Plot D2.xls');
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename,  vec2)
                end
        end
        
        if strcmp(selected_mode,'Off')~=1
            xlabel('Frames');    ylabel('Measured Value');
            if strcmp(selected_mode,'Figure')==1
                set(gcf,'userdata',data)
                set(gcf,'colormap',handles.c);
            end
            
            hold off
            axis on
            axis tight
        end
    end
    
    %  --
    %  -------
    if isempty(findstr( popupmenu,'Plot (D1-D2)\(D1+D2)'))~=1
        switch group_option
            case 1
                
                
                for ii=n1:n2
                    D1D2_vec= D1D2_VECTOR(ii).cdata  ;
                    Data_out(1:length(D1D2_vec),ii)=D1D2_vec ;
                end
                for ii=n1:n2
                    D1D2_vec=   Data_out(:,ii).*matrix(:,ii);
                    
                    
                    if strcmp(selected_mode,'Off')~=1
                        h_plot=plot(1:length(D1D2_vec),D1D2_vec ,'MarkerFaceColor',handles.C(ii,:),'MarkerEdgeColor',handles.C(ii,:),  'Marker','.', 'LineStyle','none')
                        set(h_plot, 'Hittest','Off')  ;
                    end
                end
                
                switch excel_option
                    case 1
                        filename=listbox(1) ;
                        filename=char(filename);
                        filename=regexprep(filename, filename( findstr(filename,'_pos'):end), '_Plot (D1-D2)\(D1+D2).xls')
                        filename=char(strcat(pathname,filename));
                        if isempty(dir(filename))==0
                            delete(filename)
                        end
                        xlswrite(filename, D1D2_matrix)
                end
            case 0
                Data_out = D1D2_VECTOR(ii).cdata;
                D1D2_vec=D1D2_VECTOR(ii).cdata;  %(because ii=n1, and also n2...)
                h_plot= plot(1:length(D1D2_vec),D1D2_vec ,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 1],  'Marker','square', 'LineStyle','none')
                set(h_plot, 'Hittest','Off')  ;
        end
        
        switch excel_option
            case 1
                filename=listbox(n1) ;
                filename=char(filename);
                filename=regexprep(filename, '.fig', '_Plot (D1-D2)\(D1+D2).xls');
                filename=char(strcat(pathname,filename));
                if isempty(dir(filename))==0
                    delete(filename)
                end
                xlswrite(filename,  D1D2_vec)
        end
        if strcmp(selected_mode,'Off')~=1
            xlabel('Frames');
            hold off
            axis on
            if strcmp(selected_mode,'Figure')==1
                set(gcf,'userdata',data)
                set(gcf,'colormap',handles.c);
            end
            
            axis tight
        end
    end
    
    
    %  --
    %  -------
    
    
    if isempty(findstr( popupmenu,'Plot Average (D1-D2)\(D1+D2)'))~=1
        if strcmp(selected_mode,'Off')~=1
            errorbar(AVG,STD,'MarkerSize',15,'MarkerEdgeColor',[0 0 1],'Marker','square',...
                'LineStyle','none',...
                'Color',[1 0 0]);
            
            eval(strcat('set(handles.axes',num2str(index),',''XColor'',''k''',')'));
            eval(strcat('set(handles.axes',num2str(index),',''YColor'',''k''',')'));
        end
        switch group_option
            case 1
                if strcmp(selected_mode,'Off')~=1
                    axis tight
                end
        end
        if strcmp(selected_mode,'Off')~=1
            ylabel('Mean')
            xlabel('Time')
            hold off
        end
        switch excel_option
            case 1
                filename=listbox(1) ;
                filename=char(filename);
                filename=regexprep(filename, filename( findstr(filename,'_pos'):end), '_Plot Average (D1-D2)\(D1+D2).xls')
                filename=char(strcat(pathname,filename));
                if isempty(dir(filename))==0
                    delete(filename)
                end
                
                xlswrite(filename, AVG')
        end
        
        if strcmp(selected_mode,'Figure')==1
            set(gcf,'userdata',data)
            set(gcf,'colormap',handles.c);
        end
        
        
    end
    
    %  --
    %  -------
end

%  --
%  -------
%  ------------
%  ------------------


if isempty(findstr( popupmenu,'Imagesc Dividing_2D_Projection'))~=1
    if strcmp(selected_mode,'Off')~=1
        imagesc(data(n1).cdata.projection_matrix) % Projections can not be averaged!!!
    end
    switch excel_option
        case 1
            filename=listbox(n1);
            filename=regexprep(filename, '.fig', '_Imagesc Dividing_2D_Projection.xls');
            filename=char(strcat(pathname,filename));
            if isempty(dir(filename))==0
                delete(filename)
            end
            xlswrite(filename, data(n1).cdata.projection_matrix) ; %Projections can not be averaged!!!
    end
    if strcmp(selected_mode,'Figure')==1
        set(gcf,'userdata',data(n1).cdata.projection_matrix)
        set(gcf,'colormap',handles.c);
    end
    
end

%  --
%  -------
%  ------------
%  ------------------

if isempty(findstr( popupmenu,'Imagesc Fused_Dividing_2D_Projection'))~=1
    matrix=data(n1).cdata.projection_matrix; % Projections can not be averaged!!!
    for ii=1:size(matrix,2)
        vector=matrix(:,ii);
        
        
        for iii=1:size(vector,1)
            if vector(iii)<Thresh_input
                vector(iii)=0;
            end
        end
        
        vector(vector==0)=[];
        vec(ii).cdata=vector;
    end
    
    max_x=0;
    for ii=1:size(matrix,2)
        if max_x<length(vec(ii).cdata)
            max_x=length(vec(ii).cdata);
        end
    end
    new_matrix=zeros( max_x,size(matrix,2));
    for ii=1:size(matrix,2)
        V= vec(ii).cdata;
        Difference=size(new_matrix,1)-length(V);
        if Difference<2
            new_matrix(1:length(V),ii)=vec(ii).cdata ;
        else
            if  abs(round(Difference/2))/Difference*2==1
                new_matrix(Difference/2:Difference/2+size(vec(ii).cdata,1)-1,ii)=vec(ii).cdata';
            else
                new_matrix(1+Difference/2:Difference/2+size(vec(ii).cdata,1),ii)=vec(ii).cdata';
            end
        end
    end
    if strcmp(selected_mode,'Off')~=1
        imagesc(new_matrix)
    end
    switch excel_option
        case 1
            filename=listbox(n1);
            filename=regexprep(filename, '.fig', '_Imagesc Fused_Dividing_2D_Projection.xls');
            filename=char(strcat(pathname,filename));
            if isempty(dir(filename))==0
                delete(filename)
            end
            xlswrite(filename, new_matrix) ; %Projections can not be averaged!!!
    end
    if strcmp(selected_mode,'Figure')==1
        set(gcf,'userdata',matrix)
        set(gcf,'colormap',handles.c);
    end
    
end






% ----
% -------------
% ------------------------

if strcmp( popupmenu,'Imagesc Dividing_Montage')==1
    'Imagesc Dividing_Montage'
    Data=data(n1).cdata.Montage;
    Div_start_at_frame=data(n1).cdata.Div_start_at_frame ;
    max_x=0;
    max_y=0;
    for ii=1:size(Data,2)
        if max_x<size(Data(ii).cdata,1)
            max_x=size(Data(ii).cdata,1);
        end
        if max_y<size(Data(ii).cdata,2)
            max_y=size(Data(ii).cdata,2);
        end
    end
    
    if   Merge_channels_Value==1
        D= uint16(zeros(max_x,max_y,3,ii));  %uint8 or 16, can cause some bugs
        for ii=1:size(Data,2)
            D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,:,ii)= Data(ii).cdata  ;
        end
    else
        D=zeros(max_x,max_y,1,ii);
        for ii=1:size(Data,2)
            D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,1,ii)=Data(ii).cdata(:,:) ;
        end
    end
    if strcmp(selected_mode,'Off')~=1
        montage(D, 'DisplayRange', []);
        set(gcf,'Colormap',jet);
        eval(strcat('set(handles.axes',num2str(index),',''YColor'',''k''',')'));
        ylabel(['Parental was tracked for  '   num2str(Div_start_at_frame)     '  frames before division'])
    end
    switch excel_option
        case 1
            Y=wavread('Error');  sound(Y,22000);
            set(handles.track_what_1,'Value',1) ;
            h = msgbox('Converstion to Excel is not supported for Montage ','Aborted');
    end
    return
end


% ----
% -------------
if isempty(findstr( popupmenu,'Imagesc Dividing_Movie'))~=1
    
    Data=data(n1).cdata.Montage;
    for ii=1:size(Data,2)
        
        if isempty(Data(ii).cdata)~=1
            if strcmp(selected_mode,'Off')~=1
                imagesc(Data(ii).cdata);
                axis equal
                axis tight
                pause(0.15)
                %       ii
                %       pause
            end
        end
    end
    switch excel_option
        case 1
            Y=wavread('Error');  sound(Y,22000);
            set(handles.track_what_1,'Value',1) ;
            h = msgbox('Converstion to Excel is not supported for Movie ','Aborted');
    end
    return
end

if strcmp( popupmenu,'Imagesc Dividing_Montage_box')==1
    'Imagesc Dividing_Montage_box'
    Data_temp=data(n1).cdata.Montage;
    Div_start_at_frame=data(n1).cdata.Div_start_at_frame ;
    start_at_frame=str2double(get(handles.param_edit1,'string'));
    end_at_frame=str2double(get(handles.param_edit2,'string'));
    set(handles.param_text1,'string','points before division') ;
    set(handles.param_text2,'string','points after division') ;
    set(handles.Parameters,'Visible','on') ;
    
    
    Div_start_at_frame= Div_start_at_frame-start_at_frame
    for ii=1:(end_at_frame+start_at_frame)
        Data(ii).cdata=Data_temp(Div_start_at_frame+ii).cdata;
    end
    
    max_x=0;
    max_y=0;
    for ii=1:size(Data,2)
        if max_x<size(Data(ii).cdata,1)
            max_x=size(Data(ii).cdata,1);
        end
        if max_y<size(Data(ii).cdata,2)
            max_y=size(Data(ii).cdata,2);
        end
    end
    
    if   Merge_channels_Value==1
        D= uint16(zeros(max_x,max_y,3,ii));  %uint8 or 16, can cause some bugs
        for ii=1:size(Data,2)
            D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,:,ii)= Data(ii).cdata  ;
        end
    else
        D=zeros(max_x,max_y,1,ii);
        for ii=1:size(Data,2)
            D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,1,ii)=Data(ii).cdata(:,:) ;
        end
    end
    
    
    
    z=[start_at_frame, end_at_frame];
    
    
    if strcmp(selected_mode,'Off')~=1
        montage(D, 'DisplayRange', [],  'Size',[((start_at_frame+end_at_frame)/min(z))  min(z)]);
        set(gcf,'Colormap',jet);
        eval(strcat('set(handles.axes',num2str(index),',''YColor'',''k''',')'));
        ylabel(['Parental was tracked for  '   num2str(Div_start_at_frame)     '  frames before division'])
    end
    switch excel_option
        case 1
            Y=wavread('Error');  sound(Y,22000);
            set(handles.track_what_1,'Value',1) ;
            h = msgbox('Converstion to Excel is not supported for Montage ','Aborted');
    end
    return
end
















if isempty(findstr( popupmenu,'plot Rose histogram'))~=1
    theta=data(1).cdata.theta;
    param_edit1=str2num(get(handles.param_edit1,'string'));
    param_edit2=str2num(get(handles.param_edit2,'string'));
    
    theta=theta(param_edit1:param_edit2)
    hline = rose(theta*pi/180) ;
    set(hline,'LineWidth',1.5)
    %  title_str=strcat('Cell-  histogram of angles between cell and proximity:  ',num2str(n_tag))
    % title(title_str ,'fontsize',14)
    set(gcf,'userdata',theta*pi/180);
    xlabel('Angles between cell and proximity vector')
    set(gcf,'color','w')
    
end

if isempty(findstr( popupmenu,'scatter vectors'))~=1
    
    Data=data(1).cdata;
    theta=Data.theta;
    
    struct_Names=fieldnames(Data)  ;
    
    str1=char(struct_Names(2))  ;
    eval(strcat('vector1=Data.',str1,';'))
    str2=char(struct_Names(3))
    eval(strcat('vector2=Data.',str2,';'))
    
    param_edit1=str2num(get(handles.param_edit1,'string'));
    param_edit2=str2num(get(handles.param_edit2,'string'));
    theta=theta(param_edit1:param_edit2)
    vector1=vector1(param_edit1:param_edit2) ;
    vector2=vector2(param_edit1:param_edit2)  ;
    
    scatter(vector1,vector2  ,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 0],  'Marker','square');
    xlabel('Length of proximity vector  (pixels)')
    ylabel('Distance  between centroids (pixels)')
    hold off
end

if isempty(findstr( popupmenu,'plot Polar'))~=1
    
    Data=data(1).cdata;
    theta=Data.theta;
    
    struct_Names=fieldnames(Data);
    str =char(struct_Names(popupmenu_Value));    eval(strcat('vector=Data.',str,';'))
    
    
    param_edit1=str2num(get(handles.param_edit1,'string'));
    param_edit2=str2num(get(handles.param_edit2,'string'));
    theta=theta(param_edit1:param_edit2) ;
    vector =vector(param_edit1:param_edit2) ;
    
    
    
    index_max=find(ismember(vector,max(max(vector))));
    h_p2=polar(theta(index_max)*pi/180,vector(index_max));
    set(h_p2,'lineStyle', 'none'  ,'Marker', 'square','MarkerSize',0.4, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor' , [1 1 1])
    axis tight
    hold on
    
    n=1:length(theta);
    C=cool(length(theta));
    n= n./20;
    for ii=1:length(theta)
        h_p2=polar(theta(ii)*pi/180,vector(ii));
        set(h_p2,'lineStyle', 'none'  ,'Marker', 'square','MarkerSize',0.4, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor' , C(ii,:))
    end
    
    set(gcf ,'colormap',C);
    if strcmp(selected_mode,'Figure')==1
        
        colorbar_location=colorbar('location','southoutside')
        cbfreeze
    end
    
end








% --- Executes on button press in checkbox1.




%     axis image
if strcmp(selected_mode,'Off')~=1
    axis normal
end
% axis off
% axis on
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text7.


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------


% --------------------------------------------------------------------
function Untitled_17_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on selection change in DATA_4.
function DATA_4_Callback(hObject, eventdata, handles)
% hObject    handle to DATA_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DATA_4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DATA_4


% --- Executes during object creation, after setting all properties.
function DATA_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DATA_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DATA_5.
function DATA_5_Callback(hObject, eventdata, handles)
% hObject    handle to DATA_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DATA_5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DATA_5


% --- Executes during object creation, after setting all properties.
function DATA_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DATA_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Math_operation_3.
function Math_operation_3_Callback(hObject, eventdata, handles)
% hObject    handle to Math_operation_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Math_operation_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Math_operation_3


% --- Executes during object creation, after setting all properties.
function Math_operation_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Math_operation_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Math_operation_4.
function Math_operation_4_Callback(hObject, eventdata, handles)
% hObject    handle to Math_operation_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Math_operation_4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Math_operation_4


% --- Executes during object creation, after setting all properties.
function Math_operation_4_CreateFcn(hObject, eventdata, handles)
%

% --------------------------------------------------------------------
function Untitled_24_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
matrix=get(handles.xes1 ,'userdata');


str_YTick=get(handles.xes1 ,'YTick')
str_XTick=get(handles.xes1 ,'XTick')
str_YTickLabel=get(handles.xes1 ,'YTickLabel')
str_XTickLabel=get(handles.xes1 ,'XTickLabel')
str_ylim=get(handles.xes1 ,'ylim')




figure
h=imagesc(matrix)
hh=get(h,'Parent')

set(hh,'XTick',str_XTick)
set(hh,'YTick',str_YTick)
set(hh,'YTickLabel',str_YTickLabel)
set(hh,'XTickLabel',str_XTickLabel)
set(hh,'ylim',str_ylim)
ylabel('(D1-D2)/(D1+D2)')
%   ylabel('([D11+D21]-[D12+D22])/([D11+D21]+[D12+D22])')
title('GFP-Control')

set(gcf,'userdata',matrix)

% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
matrix=get(handles.xes2 ,'userdata');


str_YTick=get(handles.xes2 ,'YTick')
str_XTick=get(handles.xes2 ,'XTick')
str_YTickLabel=get(handles.xes2 ,'YTickLabel')
str_XTickLabel=get(handles.xes2 ,'XTickLabel')
str_ylim=get(handles.xes2 ,'ylim')




figure
h=imagesc(matrix)
hh=get(h,'Parent')

set(hh,'XTick',str_XTick)
set(hh,'YTick',str_YTick)
set(hh,'YTickLabel',str_YTickLabel)
set(hh,'XTickLabel',str_XTickLabel)
set(hh,'ylim',str_ylim)
ylabel('(D1-D2)/(D1+D2)')
%   ylabel('([D11+D21]-[D12+D22])/([D11+D21]+[D12+D22])')
title('Cherry-AP2A2')

set(gcf,'userdata',matrix)

% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
matrix=get(handles.xes3 ,'userdata');


str_YTick=get(handles.xes3 ,'YTick')
str_XTick=get(handles.xes3 ,'XTick')
str_YTickLabel=get(handles.xes3 ,'YTickLabel')
str_XTickLabel=get(handles.xes3 ,'XTickLabel')
str_ylim=get(handles.xes3 ,'ylim')




figure
h=imagesc(matrix)
hh=get(h,'Parent')

set(hh,'XTick',str_XTick)
set(hh,'YTick',str_YTick)
set(hh,'YTickLabel',str_YTickLabel)
set(hh,'XTickLabel',str_XTickLabel)
set(hh,'ylim',str_ylim)

ylabel('([D11+D21]-[D12+D22])/([D11+D21]+[D12+D22])')
title('GFP-Control')

set(gcf,'userdata',matrix)







function [vector_sorted]=sort_vector_function(vector_in,sorting_vector)
[sorted,b]=sort(sorting_vector);
vector_sorted=vector_in*0;
for ii=1:length(b)
    vector_sorted(:,ii)=vector_in(b(ii));
end

%
%
function [matrix_sorted]=sort_matrix_function(matrix_in,sorting_vector)
[sorted,b]=sort(sorting_vector);
matrix_sorted=matrix_in*0;
for ii=1:length(b)
    matrix_sorted(:,ii)=matrix_in(:,b(ii));
end
%
function [cell_sorted]=sort_cell_function(cell_in,sorting_vector)
[sorted,b]=sort(sorting_vector);
for ii=1:length(b)
    cell_sorted(ii)=cell_in(b(ii));
end

% --------------------------------------------------------------------
function Untitled_30_Callback(hObject, eventdata, handles)
pathname = uigetdir;
if isequal(pathname,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
handles.pathname_pos =strcat(pathname,'\');
guidata(hObject,handles) ;
function setWindowState(h,state,iconFilename)
if ~usejava('jvm'),  return;  end
drawnow; %need to make sure that the figures have been rendered or Java error can occur

%get the javaframes and desired operations
% is h all figure handles
if ~all(ishandle(h)) || ~isequal(length(h),length(findobj(h,'flat','Type','figure')))
    return;
end %if

%check that the states are all valid
if ~ismember(state,{'maximize','minimize','restore'}),  return;  end

% Get the figure's java frame
warning off MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame
jf = get(h,'javaframe');

%get version so we know which method to call
v = ver('matlab');
switch v.Release
    case {'(R14SP2)','(R14SP3)'}
        awtinvoke(jf,state);
    otherwise
        fp = jf.fFigureClient.getFrameProxy;
        switch state
            case 'maximize'
                awtinvoke(fp,'setMaximized(Z)',true)
            case 'minimize'
                awtinvoke(fp,'setMinimized(Z)',true)
            case 'restore'
                awtinvoke(fp,'setMaximized(Z)',false)
        end %switch
end %switch

% Set the java frame's icon
try
    newIcon = javax.swing.ImageIcon(iconFilename);
    jf.setFigureIcon(newIcon);
catch
    % never mind - filename is probably missing or invalid icon file
end

drawnow;
%end %setWindowState

function figResizeFcn(hFig,varargin)    %#ok
handles = guidata(hFig);


% ---

function Tlevel_Callback(hObject, eventdata, handles)
% hObject    handle to Tlevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tlevel as text
%        str2double(get(hObject,'String')) returns contents of Tlevel as a double


% --- Executes during object creation, after setting all properties.
function Tlevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tlevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --------------------------------------------------------------------
function Untitled_31_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



DATA1=[]; DATA2=[]; DATA3=[];  DATA4=[]; DATA5=[];  popupmenu_1=[];  popupmenu_2=[];  popupmenu_3=[]; popupmenu_4=[];  popupmenu_5=[]; Target_into =get(handles.Target_into,'Value') ;
index_1=get(handles.DATA_1,'Value')  ;index_2=get(handles.DATA_2,'Value') ;index_3=get(handles.DATA_3,'Value')  ;index_4=get(handles.DATA_4,'Value') ; index_5=get(handles.DATA_5,'Value') ;
if index_1~=7
    eval(strcat('DATA1=get(handles.listbox',num2str(index_1),',''Userdata'')'));
    eval(strcat('listbox1=get(handles.listbox',num2str(index_1),',''String'')'));
    eval(strcat('popupmenu_Value_1=get(handles.popupmenu',num2str(index_1),',''Value'')'));
    eval(strcat('popupmenu_String_1=get(handles.popupmenu',num2str(index_1),',''String'')'));
    popupmenu_1= popupmenu_String_1(popupmenu_Value_1);
    popupmenu_1=char( popupmenu_1)   ;
    DATA6=DATA1;
end
if index_2~=7
    eval(strcat('DATA2=get(handles.listbox',num2str(index_2),',''Userdata'')'));
    eval(strcat('listbox2=get(handles.listbox',num2str(index_2),',''String'')'));
    eval(strcat('popupmenu_Value_2=get(handles.popupmenu',num2str(index_2),',''Value'')'));
    eval(strcat('popupmenu_String_2=get(handles.popupmenu',num2str(index_2),',''String'')'));
    popupmenu_2= popupmenu_String_2(popupmenu_Value_2);
    popupmenu_2=char( popupmenu_2)   ;
    DATA6=DATA2;
end
if index_3~=7
    eval(strcat('DATA3=get(handles.listbox',num2str(index_3),',''Userdata'')'));
    eval(strcat('listbox3=get(handles.listbox',num2str(index_3),',''String'')'));
    eval(strcat('popupmenu_Value_3=get(handles.popupmenu',num2str(index_3),',''Value'')'));
    eval(strcat('popupmenu_String_3=get(handles.popupmenu',num2str(index_3),',''String'')'));
    popupmenu_3= popupmenu_String_3(popupmenu_Value_3);
    popupmenu_3=char( popupmenu_3)   ;
    DATA6=DATA3;
end
if index_4~=7
    eval(strcat('DATA4=get(handles.listbox',num2str(index_4),',''Userdata'')'));
    eval(strcat('listbox4=get(handles.listbox',num2str(index_4),',''String'')'));
    eval(strcat('popupmenu_Value_4=get(handles.popupmenu',num2str(index_4),',''Value'')'));
    eval(strcat('popupmenu_String_4=get(handles.popupmenu',num2str(index_4),',''String'')'));
    popupmenu_4= popupmenu_String_4(popupmenu_Value_4);
    popupmenu_4=char( popupmenu_4)   ;
    DATA6=DATA4;
end

if index_5~=7
    eval(strcat('DATA5=get(handles.listbox',num2str(index_5),',''Userdata'')'));
    eval(strcat('listbox5=get(handles.listbox',num2str(index_5),',''String'')'));
    eval(strcat('popupmenu_Value_5=get(handles.popupmenu',num2str(index_5),',''Value'')'));
    eval(strcat('popupmenu_String_5=get(handles.popupmenu',num2str(index_5),',''String'')'));
    popupmenu_5= popupmenu_String_4(popupmenu_Value_5);
    popupmenu_5=char( popupmenu_5)   ;
    DATA6=DATA5;
end
Target_into=get(handles.Target_into,'Value')
n1=size(DATA1,2); n2=size(DATA2,2);  n3=size(DATA3,2);n4=size(DATA4,2);n5=size(DATA5,2);n=n1;



if isempty(listbox1)==1
    listbox1= get(handles.listbox1,'string')
end
if isempty(popupmenu_1)==1
    DATA1=get(handles.listbox1,'userdata');
    DATA2=get(handles.listbox2,'userdata');
    DATA3=get(handles.listbox3,'userdata');
    DATA4=get(handles.listbox4,'userdata');
    DATA5=get(handles.listbox5,'userdata');
    popupmenu_Value_1=get(handles.popupmenu1,'value');
    popupmenu_String_1=get(handles.popupmenu1,'String');
    popupmenu_1= popupmenu_String_1(popupmenu_Value_1);
    popupmenu_1=char( popupmenu_1)
    
    
    eval(strcat('set(handles.listbox',num2str(Target_into),',''String'',listbox1)'));
    eval(strcat('set(handles.listbox',num2str(Target_into),',''Max'',size(listbox1,2))'));
    eval(strcat('set(handles.listbox',num2str(Target_into),',''Min'',0)'));
    eval(strcat('set(handles.listbox',num2str(Target_into),',''Value'',1)'));
end




if n1~=n2
    Y=wavread('Error');
    h = errordlg('Length of first and second DATA must be the same!! ','Error');
    sound(Y,22000);
    return
end






set(handles.listbox6,'userdata',[]);
set(handles.listbox6,'value',1,'max',1);
set(handles.listbox6,'string',[]);
listbox3= cellstr('1');


strfilename=get(handles.text1,'string');
strfilename_index=findstr(strfilename,'\');
strfilename=strfilename(strfilename_index(end-1)+1:strfilename_index(end));

pathname2 = uigetdir;
if isequal(pathname2,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
pathname2 =strcat(pathname2,'\');
new_filename=char(strcat(pathname2,strfilename))
if isdir(new_filename)==0
    mkdir(new_filename)
end


listbox3 =listbox1;
for iii=1:size(DATA1,2)
    set(handles.listbox1,'value',iii);
    
    new_filename2=char(strcat(new_filename, listbox1( iii))) ;
    
    
    
    DATA6(iii).cdata=DATA1(iii).cdata;
    for jj=1:size(DATA1(iii).cdata.Montage,2)
        temp=[]
        temp(:,:,1) =double(DATA1(iii).cdata.Montage(jj).cdata);
        temp(:,:,2)=double(DATA2(iii).cdata.Montage(jj).cdata);
        temp(:,:,3)=double(DATA3(iii).cdata.Montage(jj).cdata);
        temp(:,:,4)=double(DATA4(iii).cdata.Montage(jj).cdata);
        temp(:,:,5)=double(DATA5(iii).cdata.Montage(jj).cdata);
        
        
        %                            save    temp   temp
        %                              load temp
        
        %                       figure(1); imagesc(temp(:,:,1))
        %                                figure(2 ); imagesc(temp(:,:,2))
        %                                         figure(3); imagesc(temp(:,:,3))
        %                                                  figure(4); imagesc(temp(:,:,4))
        %                                                           figure(5); imagesc(temp(:,:,5))
        
        vec=[mean(mean(temp(:,:,1))) mean(mean(temp(:,:,2))) mean(mean(temp(:,:,3))) mean(mean(temp(:,:,4))) mean(mean(temp(:,:,5)))]
        [b,a]=sort(vec)
        a(1:2)=[]
        
        %                         vec=[var(var(temp(:,:,1))) var(var(temp(:,:,2))) var(var(temp(:,:,3))) var(var(temp(:,:,4))) var(var(temp(:,:,5)))]
        %                            [b,a]=sort(vec)
        %                              b(1:2)=[]
        %
        
        
        %
        %                       figure(6)
        %                       plot(vec)
        %
        %
        %
        %
        %                       save temp temp
        
        %                                  DATA6(iii).cdata.Montage(jj).cdata = double(temp1)+  double(temp2)+  double(temp3)+  double(temp4)+  double(temp5) ;
        
        tempy=   temp(:,:,a(1)) + temp(:,:,a(2))+ temp(:,:,a(3));
        tempy=tempy./3;
        
        %                      figure(7)
        %                      imagesc(tempy)
        %
        
        tempy = wiener2( tempy,[2 2]);
        
        %                      figure(8)
        %                      imagesc(tempy)
        %
        %                      pause
        DATA6(iii).cdata.Montage(jj).cdata =     tempy;
    end
    Close
    
    h_montage= figure
    max_x=0;
    max_y=0;
    for ii=1:size(DATA6(iii).cdata.Montage,2)
        if max_x<size(DATA6(iii).cdata.Montage(ii).cdata,1)
            max_x=size(DATA6(iii).cdata.Montage(ii).cdata,1);
        end
        if max_y<size(DATA6(iii).cdata.Montage(ii).cdata,2)
            max_y=size(DATA6(iii).cdata.Montage(ii).cdata,2);
        end
    end
    
    D=zeros(max_x,max_y,1,ii);
    for ii=1:size(DATA6(iii).cdata.Montage,2)
        D(end-size(DATA6(iii).cdata.Montage(ii).cdata,1)+1:end, end-size(DATA6(iii).cdata.Montage(ii).cdata,2)+1:end,1,ii)=DATA6(iii).cdata.Montage(ii).cdata(:,:) ;
    end
    montage(D, 'DisplayRange', []);
    set(h_montage,'Colormap',jet);
    axis   tight  ;
    pause(1)
    
    
    set(h_montage,'userdata',DATA6(iii).cdata);
    set(h_montage,'Name','Dividing_SEQtage')
    
    
    saveas(h_montage,new_filename2)
    
    
    
    pause(0.1)
    Close
    
end



set(handles.listbox3,'Userdata',DATA6) ;
set(handles.listbox3,'String',listbox3);
set(handles.listbox3,'max',length(listbox3),'value',length(listbox3));
axes(handles.axes6);cla
montage(D, 'DisplayRange', []);
set(gcf,'Colormap',jet);
axis   tight  ;


guidata(hObject,handles);








str=cell(1,1);
str(1)=cellstr('Imagesc montage');

return

%           end









eval(strcat('set(handles.popupmenu',num2str(Target_into),',''String'',  str)'));
eval(strcat('set(handles.listbox',num2str(Target_into),',''Userdata'',DATA4)'));
eval(strcat('set(handles.text',num2str(Target_into+6),',''string'',''Colocaliztion of projection'')'));


eval(strcat('listbox', num2str(Target_into),'_Callback(hObject, eventdata, handles)'))


%









% --------------------------------------------------------------------
function Untitled_33_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox14.
function listbox14_Callback(hObject, eventdata, handles)
% hObject    handle to listbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox14


% --- Executes during object creation, after setting all properties.
function listbox14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox49.
function checkbox49_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox49


% --- Executes on selection change in popupmenu25.
function popupmenu25_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu25 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu25


% --- Executes during object creation, after setting all properties.
function popupmenu25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox13.
function listbox13_Callback(hObject, eventdata, handles)
% hObject    handle to listbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox13


% --- Executes during object creation, after setting all properties.
function listbox13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton52.
function pushbutton52_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton53.
function pushbutton53_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox45.
function checkbox45_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox45


% --- Executes on selection change in popupmenu24.
function popupmenu24_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu24 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu24


% --- Executes during object creation, after setting all properties.
function popupmenu24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox12_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton49.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slider3 as text
%        str2double(get(hObject,'String')) returns contents of slider3 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Merge_channels_3.
function checkbox41_Callback(hObject, eventdata, handles)
% hObject    handle to Merge_channels_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Merge_channels_3


% --- Executes on selection change in popupmenu3.
function popupmenu23_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox11_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in text10.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to text10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slider2 as text
%        str2double(get(hObject,'String')) returns contents of slider2 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Merge_channels_2.
function checkbox37_Callback(hObject, eventdata, handles)
% hObject    handle to Merge_channels_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Merge_channels_2


% --- Executes on selection change in popupmenu2.
function popupmenu22_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox9.
function listbox9_Callback(hObject, eventdata, handles)
% hObject    handle to listbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox9


% --- Executes during object creation, after setting all properties.
function listbox9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox29.
function checkbox29_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox29


% --- Executes on selection change in popupmenu20.
function popupmenu20_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu20 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu20


% --- Executes during object creation, after setting all properties.
function popupmenu20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_34_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_35_Callback(hObject, eventdata, handles)
load_and_store(hObject, eventdata, handles,1)
wait_pause('Updating axes1',10,0.2);
plot_data(handles,1,'Axes')

% --------------------------------------------------------------------
function Untitled_36_Callback(hObject, eventdata, handles)
load_and_store3(hObject, eventdata, handles,1)

% --------------------------------------------------------------------
function Untitled_37_Callback(hObject, eventdata, handles)
load_and_store(hObject, eventdata, handles,2)
wait_pause('Updating axes2',10,0.2);
plot_data(handles,2,'Axes')

% --------------------------------------------------------------------
function Untitled_38_Callback(hObject, eventdata, handles)
load_and_store3(hObject, eventdata, handles,2)

% --------------------------------------------------------------------
function Untitled_39_Callback(hObject, eventdata, handles)
load_and_store(hObject, eventdata, handles,3)
wait_pause('Updating axes3',10,0.2);
plot_data(handles,3,'Axes')

% --------------------------------------------------------------------
function Untitled_40_Callback(hObject, eventdata, handles)
load_and_store3(hObject, eventdata, handles,3)


% --------------------------------------------------------------------
function Untitled_41_Callback(hObject, eventdata, handles)
load_and_store(hObject, eventdata, handles,4)
wait_pause('Updating axes4',10,0.2);
plot_data(handles,4,'Axes')
% --------------------------------------------------------------------
function Untitled_42_Callback(hObject, eventdata, handles)
load_and_store3(hObject, eventdata, handles,4)

% --------------------------------------------------------------------
function Untitled_43_Callback(hObject, eventdata, handles)
load_and_store(hObject, eventdata, handles,5)
wait_pause('Updating axes5',10,0.2);
plot_data(handles,5,'Axes')

% --------------------------------------------------------------------
function Untitled_44_Callback(hObject, eventdata, handles)
load_and_store3(hObject, eventdata, handles,5)
% --------------------------------------------------------------------
function Untitled_45_Callback(hObject, eventdata, handles)
load_and_store(hObject, eventdata, handles,6)
wait_pause('Updating axes6',10,0.2);
plot_data(handles,6,'Axes')

% --------------------------------------------------------------------
function Untitled_46_Callback(hObject, eventdata, handles)
load_and_store3(hObject, eventdata, handles,6)
function  load_and_store3(hObject, eventdata, handles,index)
pathname = uigetdir;
if isequal(pathname,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
pathname =strcat(pathname,'\');
dir_filename=dir(pathname) ;
jj=1;
clear filename_str
for ii=1:size(dir_filename,1) %loop 1
    temp=cellstr(dir_filename(ii).name)  ;
    if  isdir(char(temp))~=1  && isempty(findstr(dir_filename(ii).name,'.fig'))~=1
        filename_str(jj)= temp  ;
        jj=jj+1;
    end
end



load_and_store2(hObject, eventdata, handles,index,filename_str, pathname)
str=char(strcat('Updating axes', num2str(index)));
wait_pause(str,10,0.3);
eval(strcat('popupmenu',num2str(index),'_Callback(hObject, eventdata, handles)'))


% --------------------------------------------------------------------
function Untitled_47_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_48_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_49_Callback(hObject, eventdata, handles)
delete_selected(handles,1)
% --------------------------------------------------------------------
function Untitled_50_Callback(hObject, eventdata, handles)
delete_list(handles,1)

% --------------------------------------------------------------------
function Untitled_51_Callback(hObject, eventdata, handles)
delete_selected(handles,2)
% --------------------------------------------------------------------
function Untitled_52_Callback(hObject, eventdata, handles)
delete_list(handles,2)
% --------------------------------------------------------------------
function Untitled_53_Callback(hObject, eventdata, handles)
delete_selected(handles,3)

% --------------------------------------------------------------------
function Untitled_54_Callback(hObject, eventdata, handles)
delete_list(handles,3)

% --------------------------------------------------------------------
function Untitled_55_Callback(hObject, eventdata, handles)
delete_selected(handles,4)

% --------------------------------------------------------------------
function Untitled_56_Callback(hObject, eventdata, handles)
delete_list(handles,4)
% --------------------------------------------------------------------
function Untitled_57_Callback(hObject, eventdata, handles)
delete_selected(handles,5)

% --------------------------------------------------------------------
function Untitled_58_Callback(hObject, eventdata, handles)
delete_list(handles,5)

% --------------------------------------------------------------------
function Untitled_59_Callback(hObject, eventdata, handles)
delete_selected(handles,6)
% --------------------------------------------------------------------
function Untitled_60_Callback(hObject, eventdata, handles)
delete_list(handles,6)





% --------------------------------------------------------------------
function Untitled_61_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_62_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function popupmenupy6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function popupmenup5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in popupmenu6.
function popupmenupy6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --------------------------------------------------------------------
function Untitled_64_Callback(hObject, eventdata, handles)

[filename, pathname, filterindex] = uiputfile({ '*.dat','DAT-files (*.dat)';}, 'Select collection data file');
full_filename= char(strcat(pathname,'TAC_Polarization_data_',filename)) ;
h =waitbar(0,'Loading data from listboxes....');

listbox1=get(handles.listbox1,'string');    waitbar(1/7)
DATA1=get(handles.listbox1,'userdata');    waitbar(2/7)
DATA2=get(handles.listbox2,'userdata');    waitbar(3/7)
DATA3=get(handles.listbox3,'userdata');    waitbar(4/7)
DATA4=get(handles.listbox4,'userdata'); waitbar(5/7)
DATA5=get(handles.listbox5,'userdata'); waitbar(6/7)
DATA6=get(handles.listbox6,'userdata');  waitbar(7/7) %trajectories
%
close(h)
% [filename, pathname, filterindex] = uigetfile({ '*.dat','DAT-files (*.dat)';}, 'Select collection data file or press cancel to create new file')% handles.directory_name); %pick files to combine
% if isequal(filename,0)
% else
% full_filename= strcat(pathname,filename);
% full_filename=char(full_filename);
%  temp=importdata(full_filename)   ;
% end

%
%

SE = strel('square',6) ;   f = @(x) max(x(:));

h=timebar_TACWrapper('Label cells. Please  wait....');set(h,'color','w');
counter=1
for iii=1:size(DATA1,2)
    timebar_TACWrapper(h,iii/size(DATA1,2))
    for jj=1:size(DATA1(iii).cdata.Montage,2)
        try
            jj
            matrix_control_mean_projected=[];
            matrix_control_mean_projected=double(DATA4(iii).cdata.Montage(jj).cdata);
            temp.control_mean_projected(counter).cdata= matrix_control_mean_projected;
            matrix_control_unmixed=[];  matrix_control_unmixed=double(DATA5(iii).cdata.Montage(jj).cdata);
            temp.control_unmixed(counter).cdata= matrix_control_unmixed;
            matrix_control_segmented=[];  matrix_control_segmented=double(DATA6(iii).cdata.Montage(jj).cdata);
            matrix_control_segmented=matrix_control_segmented./max(max(matrix_control_segmented));
            temp.control_segmented(counter).cdata= matrix_control_segmented;
            matrix_poi_mean_projected=[];  matrix_poi_mean_projected=double(DATA1(iii).cdata.Montage(jj).cdata);
            temp.poi_mean_projected(counter).cdata= matrix_poi_mean_projected;
            matrix_poi_unmixed=[];  matrix_poi_unmixed=double(DATA2(iii).cdata.Montage(jj).cdata);
            temp.poi_unmixed(counter).cdata= matrix_poi_unmixed;
            Centroid= DATA3(iii).cdata ;  temp.trajectories(counter).cdata = Centroid(jj,:) ;
            
            
            temp.file_name(counter).cdata=char(listbox1( iii) )  ;
            temp.internal_counter(counter)=jj;
            temp.cell_index(counter)=iii;
            
            
            L=bwlabel_max(matrix_control_segmented) ;
            stats= regionprops(L,'Area','Centroid','Eccentricity','Majoraxislength','Minoraxislength','EquivDiameter','Perimeter','Orientation');
            stats.circularity=4*pi*stats.Area/(stats.Perimeter^2)  ;
            stats.aspect_ratio=stats.MinorAxisLength/stats.MajorAxisLength;
            
            temp.Label(counter).cdata=stats;
            temp.p1(counter)=1; %     Uropod' ;
            temp.p2(counter)=stats.Eccentricity;
            temp.p3(counter)=stats.aspect_ratio ;
            temp.p4(counter)= stats.Perimeter  ;
            temp.p5(counter)=stats.MinorAxisLength;
            temp.p6(counter)= stats.Area ;
            temp.p7(counter)= stats.MajorAxisLength;
            temp.p8(counter)= stats.EquivDiameter;
            temp.p9(counter)= stats.Orientation;
            temp.p10(counter)= stats.circularity;
            
            
            
            temp.p11(counter)=sum(sum(matrix_poi_mean_projected))  ;     %total_intensity_poi_raw;
            temp.p12(counter)=sum(sum(matrix_control_mean_projected));   %total_intensity_control_raw;
            temp.p13(counter)= sum(sum(matrix_poi_unmixed));  %      total_intensity_poi_unmix;
            temp.p14(counter)=sum(sum(matrix_control_unmixed));   %total_intensity_control_unmix;
            
            
            
            
            %%%%%%%
            
            
            idx=[];
            
            matrix1  =medfilt2( imsubtract(imadd(matrix_poi_unmixed,imtophat(matrix_poi_unmixed,SE)), imbothat(matrix_poi_unmixed,SE)));
            
            matrix_binned  = nlfilter_TACWrapper( matrix1,[3 3],f);
            matrix_binned=ismember(matrix_binned,max(max(matrix_binned)));
            L = bwlabel(matrix_binned);
            stats1 = regionprops(L,'Area','Centroid')  ;
            for kk=1:size(stats1,1)
                idx(kk) =   stats1(kk).Area ;
            end
            [idx,order]=sort(idx,'descend');
            temp.Label(counter).cdata.BP_poi_unmixed= stats1(order(1)).Centroid ;
            
            
            idx=[];
            matrix1  =medfilt2( imsubtract(imadd(matrix_control_unmixed,imtophat(matrix_control_unmixed,SE)), imbothat(matrix_control_unmixed,SE)));
            matrix_binned  = nlfilter_TACWrapper( matrix1,[3 3],f);
            matrix_binned=ismember(matrix_binned,max(max(matrix_binned)));
            L = bwlabel(matrix_binned);
            stats1 = regionprops(L,'Area','Centroid')  ;
            for kk=1:size(stats1,1)
                idx(kk) =   stats1(kk).Area ;
            end
            [idx,order]=sort(idx,'descend');
            temp.Label(counter).cdata.BP_control_unmixed= stats1(order(1)).Centroid ;
            
            
            
            
            
            %    temp.p18(counter)  =   ratio_X_longaxis(matrix_poi_unmixed,matrix_control_segmented,2);
            %    temp.p19(counter) =   ratio_X_longaxis(matrix_control_unmixed,matrix_control_segmented,2);
            %    temp.p20(counter) =abs( temp.p18(counter)  );
            %    temp.p21(counter) =abs( temp.p19(counter)  );
            %
            %
            %
            %    temp.p24(counter)  =  ratio_Y_longaxis(matrix_poi_unmixed,matrix_control_segmented,2);
            %    temp.p25(counter) =  ratio_Y_longaxis(matrix_control_unmixed,matrix_control_segmented,2);
            %    temp.p26(counter) =abs( temp.p24(counter)  );
            %    temp.p27(counter) =abs( temp.p25(counter)  );
            %
            %
            
            
            
        end
        counter=counter+1;
    end
end
close(h)
wait_pause('update...',10,0.2);





temp.p15=temp.p11./temp.p6;   %mean_intensity_poi_raw;
temp.p16=temp.p12./temp.p6 ;   %mean_intensity_control_raw;
temp.p17=temp.p13./temp.p6;%      mean_intensity_poi_unmix;
temp.p18=temp.p14./temp.p6;  %mean_intensity_control_unmix;



save temp temp


h=timebar_TACWrapper('Calculate angles. Please  wait....');set(h,'color','w');
for ii=1:length(temp.p1)
    timebar_TACWrapper(h,ii/length(temp.p1))
    
    
    
    %  $must be second rund t label the angles and velocity:
    try
        p1= temp.trajectories(ii+1).cdata;   %centroid at time t+1
    end
    try
        p2= temp.trajectories(ii).cdata ; %centroid at time t
    end
    try
        p3= temp.trajectories(ii-1).cdata ; %centroid at time t
    end
    try
        p4=(p2- temp.Label(ii).cdata.Centroid)+ temp.Label(ii).cdata.BP_poi_unmixed; % global maximum pixel
    end
    try
        p5=(p2- temp.Label(ii).cdata.Centroid)+ temp.Label(ii).cdata.BP_control_unmixed; % global maximum pixel
    end
    
    %       _________________________
    try
        %turning angle
        POINT_1=p1; POINT_2=p2;  POINT_3=p3;
        theta1(ii)=angle_deg_2d_TACWrapper( POINT_3, POINT_2, POINT_1) ;
        
        
        x =POINT_1(1)-POINT_2(1); y =POINT_1(2)-POINT_2(2); Dist1=sqrt(x^2+y^2);   x =POINT_3(1)-POINT_2(1); y =POINT_3(2)-POINT_2(2); Dist2=sqrt(x^2+y^2);   R1(ii)= (Dist1+Dist2)/2  ;
    catch
        theta1(ii)=nan  ;   R1(ii)=nan;
    end
    
    
    try
        POINT_1=p1; POINT_2=p2;  POINT_3=p4; %angle between brightest pixels in POI and direction of movement
        theta2(ii)=angle_deg_2d_TACWrapper( POINT_3, POINT_2, POINT_1)  ;
        x =POINT_1(1)-POINT_2(1); y =POINT_1(2)-POINT_2(2); Dist1=sqrt(x^2+y^2);   x =POINT_3(1)-POINT_2(1); y =POINT_3(2)-POINT_2(2); Dist2=sqrt(x^2+y^2);   R2(ii)= (Dist1+Dist2)/2  ;
    catch
        theta2(ii)=nan  ;   R2(ii)=nan;
    end
    
    
    
    
    try
        POINT_1=p4; POINT_2=p2;  POINT_3=p5; %angle between brightest pixels in two channels
        theta3(ii)=angle_deg_2d_TACWrapper( POINT_3, POINT_2, POINT_1)  ;
        x =POINT_1(1)-POINT_2(1); y =POINT_1(2)-POINT_2(2); Dist1=sqrt(x^2+y^2);   x =POINT_3(1)-POINT_2(1); y =POINT_3(2)-POINT_2(2); Dist2=sqrt(x^2+y^2);   R3(ii)= (Dist1+Dist2)/2  ;
    catch
        theta3(ii)=nan  ;   R3(ii)=nan;
    end
    
    
    try
        POINT_1=p1; POINT_2=p2;  POINT_3=p5; %angle between brightest pixels in control and direction of movement
        theta4(ii)=angle_deg_2d_TACWrapper( POINT_3, POINT_2, POINT_1)  ;
        x =POINT_1(1)-POINT_2(1); y =POINT_1(2)-POINT_2(2); Dist1=sqrt(x^2+y^2);   x =POINT_3(1)-POINT_2(1); y =POINT_3(2)-POINT_2(2); Dist2=sqrt(x^2+y^2);   R4(ii)= (Dist1+Dist2)/2  ;
    catch
        
        theta4(ii)=nan  ;   R4(ii)=nan;
    end
    
    
    
    
    %%%%
    try
        % angle between x axis and C(t+1)
        POINT_1= [p2(1)+1 0]    ; POINT_2=p2;  POINT_3=p1;
        theta5(ii)=angle_deg_2d_TACWrapper( POINT_3, POINT_2, POINT_1) ;
        
        
        x =POINT_1(1)-POINT_2(1); y =POINT_1(2)-POINT_2(2); Dist1=sqrt(x^2+y^2);   x =POINT_3(1)-POINT_2(1); y =POINT_3(2)-POINT_2(2); Dist2=sqrt(x^2+y^2);   R5(ii)= (Dist1+Dist2)/2 -1;
    catch
        theta5(ii)=nan  ;   R5(ii)=nan;
    end
    
    
    try  % angle between x axis and C(t-1)
        POINT_1= [p2(1)+1 0]    ; POINT_2=p2;  POINT_3=p3;
        theta6(ii)=angle_deg_2d_TACWrapper( POINT_3, POINT_2, POINT_1)  ;
        x =POINT_1(1)-POINT_2(1); y =POINT_1(2)-POINT_2(2); Dist1=sqrt(x^2+y^2);   x =POINT_3(1)-POINT_2(1); y =POINT_3(2)-POINT_2(2); Dist2=sqrt(x^2+y^2);   R6(ii)= (Dist1+Dist2)/2 -1 ;
    catch
        theta6(ii)=nan  ;   R6(ii)=nan;
    end
    
    try % angle between x axis and  brightest pixels in POI
        POINT_1= [p2(1)+1 0]    ; POINT_2=p2;  POINT_3=p4;
        theta7(ii)=angle_deg_2d_TACWrapper( POINT_3, POINT_2, POINT_1)  ;
        x =POINT_1(1)-POINT_2(1); y =POINT_1(2)-POINT_2(2); Dist1=sqrt(x^2+y^2);   x =POINT_3(1)-POINT_2(1); y =POINT_3(2)-POINT_2(2); Dist2=sqrt(x^2+y^2);   R7(ii)= (Dist1+Dist2)/2 -1 ;
    catch
        theta7(ii)=nan  ;   R7(ii)=nan;
    end
    
    
    try % angle between x axis and  brightest pixels in control
        POINT_1= [p2(1)+1 0]    ; POINT_2=p2;  POINT_3=p5;
        theta8(ii)=angle_deg_2d_TACWrapper( POINT_3, POINT_2, POINT_1)  ;
        x =POINT_1(1)-POINT_2(1); y =POINT_1(2)-POINT_2(2); Dist1=sqrt(x^2+y^2);   x =POINT_3(1)-POINT_2(1); y =POINT_3(2)-POINT_2(2); Dist2=sqrt(x^2+y^2);   R8(ii)= (Dist1+Dist2)/2 -1 ;
    catch
        
        theta8(ii)=nan  ;   R8(ii)=nan;
    end
    
    
    
    
end
%
%
%turning angle
%angle between brightest pixels in POI and direction of movement
%angle between brightest pixels in two channels
%angle between brightest pixels in control and direction of movement
% angle between x axis and C(t-1)
% angle between x axis and C(t-1)
% angle between x axis and  brightest pixels in POI
% angle between x axis and  brightest pixels in control





temp.p19=theta1;
temp.p20=theta2;
temp.p21=theta3;
temp.p22=theta4;
temp.p23=theta5;
temp.p24=theta6;
temp.p25=theta7;
temp.p26=theta8;


temp.p27=R1;
temp.p28=R2;
temp.p29=R3;
temp.p30=R4;
temp.p31=R5;
temp.p32=R6;
temp.p33=R7;
temp.p34=R8;



close(h)

save(full_filename,'temp')


% --------------------------------------------------------------------
function Untitled_65_Callback(hObject, eventdata, handles)




data1=get(handles.listbox1,'Userdata'); %lineage of daughter cell1 1
data2=get(handles.listbox2,'Userdata'); %lineage of daughter cell1 1
if isempty(data1)==1
    Y=wavread('Error');
    h = errordlg('No figures in listbox1!! ','Error');
    sound(Y,22000);
    return
end
if isempty(data2)==1
    Y=wavread('Error');
    h = errordlg('No figures in listbox2!! ','Error');
    sound(Y,22000);
    return
end


n1=get(handles.listbox1,'Value')
Pos =[300 100 500 500]
h=figure('color','w','units','pixels','position', Pos) ;
axis on
Lineage_data1 =data1.Data(1).cdata.Lineage_data;
Lineage_data2=data2.Data(1).cdata.Lineage_data;
Cell1_start= str2num(char(Lineage_data1(1,3)));
Cell2_start= str2num(char(Lineage_data2(1,3))) ;
[start1,start2]=set_origion_of_merged_lineage(Cell1_start,Cell2_start) ;
data=merge_lineage(data1,data2,start1,start2);
plot_Cell_Lineage(n1,data)






% --------------------------------------------------------------------
function Untitled_66_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_66 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_67_Callback(hObject, eventdata, handles)



%     number of points=generations

[filename, pathname, filterindex] = uiputfile({ '*.dat','DAT-files (*.dat)';}, 'Select collection data file');
full_filename= char(strcat(pathname,'TAC_Lineage_data_',filename)) ;
h =waitbar(0,'Loading data from listboxes....');

listbox1=get(handles.listbox1,'string');    waitbar(1/7)
%
DATA1=get(handles.listbox1,'userdata');    waitbar(2/7) % POI- Raw/filtered
%
DATA3=get(handles.listbox3,'userdata');    waitbar(4/7)  % trajectories
%
DATA4=get(handles.listbox4,'userdata'); waitbar(5/7)  % control raw/filter

DATA6=get(handles.listbox6,'userdata');  waitbar(7/7)  % control segment
%
close(h)

%   save  listbox1  listbox1
%   save DATA1 DATA1
%   save DATA3 DATA3
%     save DATA4 DATA4
%       save DATA6 DATA6
%
%
%
%  clear all
%
%   load  listbox1
%   load DATA1
%
%    load DATA3
%
%     load DATA4
%
%      load DATA6
h=timebar_TACWrapper('Label cells. Please  wait....');set(h,'color','w');
counter=1


for iii=1:size(DATA1,2)
    timebar_TACWrapper(h,iii/size(DATA1,2))
    for jj=1:size(DATA1(iii).cdata.Montage,2)
        matrix_control_mean_projected=[];
        matrix_control_mean_projected=double(DATA4(iii).cdata.Montage(jj).cdata);
        temp.control_mean_projected(counter).cdata= matrix_control_mean_projected;
        % matrix_control_unmixed=[];  matrix_control_unmixed=double(DATA5(iii).cdata.Montage(jj).cdata);
        % temp.control_unmixed(counter).cdata= matrix_control_unmixed;
        matrix_control_segmented=[];  matrix_control_segmented=double(DATA6(iii).cdata.Montage(jj).cdata);
        matrix_control_segmented=matrix_control_segmented./max(max(matrix_control_segmented));
        temp.control_segmented(counter).cdata= matrix_control_segmented;
        matrix_poi_mean_projected=[];  matrix_poi_mean_projected=double(DATA1(iii).cdata.Montage(jj).cdata);
        temp.poi_mean_projected(counter).cdata= matrix_poi_mean_projected;
        % matrix_poi_unmixed=[];  matrix_poi_unmixed=double(DATA2(iii).cdata.Montage(jj).cdata);
        % temp.poi_unmixed(counter).cdata= matrix_poi_unmixed;
        
        data= DATA3(iii).cdata ;
        Centroid=data.Data_out;
        temp.trajectories(counter).cdata = Centroid(jj,:) ;
        
        
        temp.file_name(counter).cdata=char(listbox1( iii) )  ;
        temp.internal_counter(counter)=jj;
        temp.cell_index(counter)=iii;
        
        filename= char(cellstr(temp.file_name(counter).cdata));
        temp.Position(counter)=str2num(filename(findstr(filename,'_Pos')+4:findstr(filename,'_div')-1)) ;
        
        
        
        Cell=DATA1(iii).cdata.Cell ;
        Cell=Cell(6:end);
        temp.cell_lineage_index(counter)={Cell};
        
        
        temp.p1(counter)=1; %      or 0 (d1 or d2) need manual input ;
        Index=findstr(Cell,'.');
        temp.p2(counter)=length(Index) ;
        temp.p3(counter)=size(DATA1(iii).cdata.Montage,2);
        
        temp.p4(counter)=data.start
        temp.p5(counter)=data.end
        temp.p6(counter)=data.fate
        
        
        
        
        
        
        L=bwlabel_max(matrix_control_segmented) ;
        stats= regionprops(L,'Area','Centroid','Eccentricity','Majoraxislength','Minoraxislength','EquivDiameter','Perimeter','Orientation');
        stats.circularity=4*pi*stats.Area/(stats.Perimeter^2)  ;
        stats.aspect_ratio=stats.MinorAxisLength/stats.MajorAxisLength;
        
        temp.Label(counter).cdata=stats;
        
        temp.p7(counter)=stats.Eccentricity;
        temp.p8(counter)=stats.aspect_ratio ;
        temp.p9(counter)= stats.Perimeter  ;
        temp.p10(counter)=stats.MinorAxisLength;
        temp.p11(counter)= stats.Area ;
        temp.p12(counter)= stats.MajorAxisLength;
        temp.p13(counter)= stats.EquivDiameter;
        temp.p14(counter)= stats.Orientation;
        temp.p15(counter)= stats.circularity;
        
        temp.p16(counter)=sum(sum(matrix_poi_mean_projected))  ;     %total_intensity_poi_raw;
        temp.p17(counter)=sum(sum(matrix_control_mean_projected));   %total_intensity_control_raw;
        
        
        counter=counter+1 ;
    end
    
end

close(h)
wait_pause('update...',10,0.2);





temp.p18=temp.p16./temp.p11;   %mean_intensity_poi_raw;
temp.p19=temp.p17./temp.p11 ;   %mean_intensity_control_raw;




h=timebar_TACWrapper('Calculate angles. Please  wait....');set(h,'color','w');
for ii=1:length(temp.p1)
    timebar_TACWrapper(h,ii/length(temp.p1))
    
    
    try
        p1= temp.trajectories(ii+1).cdata;   %centroid at time t+1
    end
    try
        p2= temp.trajectories(ii).cdata ; %centroid at time t
    end
    try
        p3= temp.trajectories(ii-1).cdata ; %centroid at time t
    end
    %
    %       _________________________
    try
        %turning angle
        POINT_1=p1; POINT_2=p2;  POINT_3=p3;
        theta1(ii)=angle_deg_2d_TACWrapper( POINT_3, POINT_2, POINT_1) ;
        
        
        x =POINT_1(1)-POINT_2(1); y =POINT_1(2)-POINT_2(2); Dist1=sqrt(x^2+y^2);   x =POINT_3(1)-POINT_2(1); y =POINT_3(2)-POINT_2(2); Dist2=sqrt(x^2+y^2);   R1(ii)= (Dist1+Dist2)/2  ;
    catch
        theta1(ii)=nan  ;   R1(ii)=nan;
    end
    
    
    try
        % angle between x axis and C(t+1)
        POINT_1= [p2(1)+1 0]    ; POINT_2=p2;  POINT_3=p1;
        theta2(ii)=angle_deg_2d_TACWrapper( POINT_3, POINT_2, POINT_1) ;
        
        
        x =POINT_1(1)-POINT_2(1); y =POINT_1(2)-POINT_2(2); Dist1=sqrt(x^2+y^2);   x =POINT_3(1)-POINT_2(1); y =POINT_3(2)-POINT_2(2); Dist2=sqrt(x^2+y^2);   R2(ii)= (Dist1+Dist2)/2 -1;
    catch
        theta2(ii)=nan  ;   R2(ii)=nan;
    end
    
    
    try  % angle between x axis and C(t-1)
        POINT_1= [p2(1)+1 0]    ; POINT_2=p2;  POINT_3=p3;
        theta3(ii)=angle_deg_2d_TACWrapper( POINT_3, POINT_2, POINT_1)  ;
        x =POINT_1(1)-POINT_2(1); y =POINT_1(2)-POINT_2(2); Dist1=sqrt(x^2+y^2);   x =POINT_3(1)-POINT_2(1); y =POINT_3(2)-POINT_2(2); Dist2=sqrt(x^2+y^2);   R3(ii)= (Dist1+Dist2)/2 -1 ;
    catch
        theta3(ii)=nan  ;   R3(ii)=nan;
    end
    
    
    
    
end
%
%
%turning angle
%angle between brightest pixels in POI and direction of movement
%angle between brightest pixels in two channels
%angle between brightest pixels in control and direction of movement
% angle between x axis and C(t-1)
% angle between x axis and C(t-1)
% angle between x axis and  brightest pixels in POI
% angle between x axis and  brightest pixels in control





temp.p20=theta1;
temp.p21=theta2;
temp.p22=theta3;



temp.p23=R1;
temp.p24=R2;
temp.p25=R3;


close(h)

save(full_filename,'temp')


% --------------------------------------------------------------------
function Untitled_68_Callback(hObject, eventdata, handles)


data1=get(handles.listbox1,'Userdata'); %lineage of daughter cell1 1
data2=get(handles.listbox2,'Userdata'); %lineage of daughter cell1 1
if isempty(data1)==1
    Y=wavread('Error');
    h = errordlg('No figures in listbox1!! ','Error');
    sound(Y,22000);
    return
end
if isempty(data2)==1
    Y=wavread('Error');
    h = errordlg('No figures in listbox2!! ','Error');
    sound(Y,22000);
    return
end


n1=get(handles.listbox1,'Value')
Pos =[300 100 500 500]
h=figure('color','w','units','pixels','position', Pos) ;
axis on
Lineage_data1 =data1.Data(1).cdata.Lineage_data;
Lineage_data2=data2.Data(1).cdata.Lineage_data;
Cell1_start= str2num(char(Lineage_data1(1,3)));
Cell2_start= str2num(char(Lineage_data2(1,3))) ;


[start1,start2]=set_origion_of_merged_lineage(Cell1_start,Cell2_start) ;
dcell=inputdlg( 'Please enter cell (i.e. 1.1.2.1)');
data =merge_lineage_delme(data1,data2,start2,dcell);


plot_Cell_Lineage(n1,data)
