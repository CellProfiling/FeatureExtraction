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
function varargout = TAC_Measurments_Module(varargin)
% TAC_Measurments_Module M-file for TAC_Measurments_Module.fig
%   TAC_Measurments_Module, by itself, creates a new TAC_Measurments_Module or raises the existing
%   singleton*.
%%________________________________________________________________________
%%'off'
%
%   Created by Raz Shimoni as part TACTICS software.
%   Copyright TACTICS Inc. 
%   Melbourne, Australia.
%_________________________________________________________________________ 

%   H = TAC_Measurments_Module returns the handle to a new TAC_Measurments_Module or the handle
%   to
%   the existing singleton*.
%
%   TAC_Measurments_Module('CALLBACK',hObject,eventData,handles,...) calls the local
%   function named CALLBACK in TAC_Measurments_Module.M with the given input
%   arguments.
%
%   TAC_Measurments_Module('Property','Value',...) creates a new TAC_Measurments_Module or raises
%   the
%   existing singleton*. Starting from the left, property value pairs arep
%   applied to the GUI before TAC_Measurments_Module_OpeningFcn gets called. An
%   unrecognized property name or invalid value makes property application
%   stop. All inputs are passed to TAC_Measurments_Module_OpeningFcn via varargin.
%
%   *See GUI Options on GUIDE's Tools menu. Choose "GUI allows only one
%   instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TAC_Measurments_Module

% Last Modified by GUIDE v2.5 12-Nov-2012 13:06:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name', mfilename, ...
 'gui_Singleton', gui_Singleton, ...
 'gui_OpeningFcn', @TAC_Measurments_Module_OpeningFcn, ...
 'gui_OutputFcn', @TAC_Measurments_Module_OutputFcn, ...
 'gui_LayoutFcn', [] , ...
 'gui_Callback',  []);
if nargin && ischar(varargin{1})
  gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
  [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
  gui_mainfcn(gui_State, varargin{:});
end
 


% ------------- 
function TAC_Measurments_Module_OpeningFcn(hObject, eventdata, handles, varargin) 
   set(hObject, 'ResizeFcn',@figResizeFcn  );
  c=zeros(64,3);
  dic=c;
  dic(:,1)=0:0.0158:1;
  dic(:,2)=0:0.0158:1;
  dic(:,3)=0:0.0158:1;
  rfp=c;
  rfp(:,1)=0:0.0158:1;
  gfp=c;
  gfp(:,2)=0:0.0158:1;
  cfp=c;
  cfp(:,3)=0:0.0158:1;
  yfp=c;
  yfp(:,1)=0:0.0158:1;
  yfp(:,2)=0:0.0158:1;
  Cherry=c;
 Cherry(:,1)=0:0.0158:1;
 Cherry(:,2)= linspace(0,0.2,64)'; 
  handles.c1=dic; 
  handles.c2=cfp;
  handles.c3=gfp;
  handles.c4=yfp;
  handles.c5=Cherry;
  handles.c6=rfp;
  handles.C1=rand(500,3) ; 
  handles.C2=rand(500,3) ;
  handles.C3=rand(500,3) ; 
 set(handles.Green_factor,'Sliderstep', [0.005 0.1]);
 set(handles.Red_factor,'Sliderstep', [0.005 0.1]);
 set(handles.Blue_factor,'Sliderstep', [0.005 0.1]);    
%  To visualize the module in robust mode this line should be enabled:
 backgroundImage = importdata('TACTICS_logo2.jpg');  axes(handles.axes1); image(backgroundImage);  handles.output = hObject;  
 guidata(hObject, handles);
 if nargin ==3 
 backgroundImage = importdata('TACTICS_logo2.jpg'); axes(handles.axes1); image(backgroundImage);
   handles.nargin_num=3; 
   handles.output = hObject; 
  
 handles.data_file=[];
 
guidata(hObject, handles);
handles = addPlabackControls(hObject, handles);
 
set(handles.sliderframes2, 'Enable','on', 'SliderStep',[1, 0.1]); % Matlab scrollbar 
elseif nargin==4 
handles.data_file=varargin{1}; set(handles.figure1,'userdata',handles.data_file);
handles.output = hObject;  
guidata(hObject, handles); 
 if isempty( handles.data_file)==1
 handles.nargin_num=3; 
 guidata(hObject, handles);
  return
 end 
 set(handles.Current_Exp,'String',handles.data_file(10).cdata); 
 handles.nargin_num=4; 
 handles.output = hObject; 
 set(handles.showcurrentframe,'String',1);  
 set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1) ) ;
 set(handles.Raw_listbox,'Value', 1 ) ; 
 track_what_1=get(handles.track_what_1,'value'); 
 track_what_2=get(handles.track_what_2,'value'); 
 track_what_3=get(handles.track_what_3,'value');  
 track_what_4=get(handles.track_what_4,'value');  
 if  findstr(char(handles.data_file(7).cdata(track_what_1,1)),'Y')==1 
 handles.C1=rand(size(handles.data_file(5).cdata.Tracks(track_what_1).cdata ,2),3) ;
 end
 if  findstr(char(handles.data_file(7).cdata(track_what_2,1)),'Y')==1 
  handles.C2=rand(size(handles.data_file(5).cdata.Tracks(track_what_2).cdata ,2),3) ;
 end
 if  findstr(char(handles.data_file(7).cdata(track_what_3,1)),'Y')==1 
 handles.C3=rand(size(handles.data_file(5).cdata.Tracks(track_what_3).cdata ,2),3) ;
 end 
 if  findstr(char(handles.data_file(7).cdata(track_what_4,1)),'Y')==1 
 handles.C4=rand(size(handles.data_file(5).cdata.Tracks(track_what_4).cdata ,2),3) ;
 end 
set(handles.start_panel1,'visible','on') ;set(handles.start_panel3,'visible','on');
set(handles.Raw_listbox,'visible','on');
guidata(hObject, handles);  
handles = addPlabackControls(hObject, handles);
set(handles.sliderframes2, 'Enable','on', 'SliderStep',[1, 0.1]); % Matlab scrollbar   
elseif   nargin ==5 % loading with handles.data_file 
set(handles.start_panel1,'visible','on') ;set(handles.start_panel3,'visible','on');
set(handles.Raw_listbox,'visible','on');
handles.nargin_num=4; 
   data_file=varargin{1}; 
   handles.data_file=varargin{1}; 
   DIV=varargin{2};  
   guidata(hObject, handles); 
   if  isempty(handles.data_file)==1
 handles.output = hObject;
 guidata(hObject, handles);
 return
   end
handles.output = hObject; 
set(handles.edit_axes1,'String' ,char(data_file(1).cdata(1,1))); 
set(handles.showcurrentframe,'String',1);  
set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1) ) ;
set(handles.Raw_listbox,'Value', 1 ) ; 
set(handles.showcurrentframe,'String',1); 
 
guidata(hObject, handles);  
set(handles.track_what_1,'value',1); 
set(handles.track_what_2,'value',2); 
track_what_1_Callback(hObject, eventdata, handles)   
  %   ------------------------------Cell
 elseif   nargin ==7 % loading with handles.data_file  
   set(handles.start_panel1,'visible','on') ;set(handles.start_panel3,'visible','on');
  set(handles.Raw_listbox,'visible','on');
 handles.nargin_num=5; 
  data_file=varargin{1}; 
 handles.data_file=varargin{1}; 
 full_filename=varargin{2}; 
 Load_File_Edit=varargin{3}; 
 New_pathname=varargin{4};
 guidata(hObject, handles); 
  
   if  isempty(handles.data_file)==1
 handles.output = hObject;
 guidata(hObject, handles);
 return
   end
handles.output = hObject; 
 set(handles.edit_axes1,'String' ,char(data_file(1).cdata(1,1))); 
set(handles.showcurrentframe,'String',1);  
set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1) ) ;
set(handles.Raw_listbox,'Value', 1 ) ; 
set(handles.showcurrentframe,'String',1); 
 
track_what_1=get(handles.track_what_1,'value'); 
track_what_2=get(handles.track_what_2,'value'); 
track_what_3=get(handles.track_what_3,'value');  
track_what_4=get(handles.track_what_4,'value'); 
 
   
 guidata(hObject, handles); 
  iii=1
  try
  New_pathname_char= char(New_pathname(iii)); 
 catch
  New_pathname_char= New_pathname(iii);
 New_pathname_char=char( New_pathname_char{1});
  end
 
   try
   Load_File_Edit_char= char(Load_File_Edit(iii)) 
  catch
  Load_File_Edit_char= Load_File_Edit(iii) 
  Load_File_Edit_char=char( Load_File_Edit_char{1}) 
   end 
set(handles.save_Fig_option,'Value',1);  
set(handles.Current_Exp,'String',full_filename);
set(handles.save_Fig_folder,'String',New_pathname_char);   
TAC_Measurments_Module_Settings_filename=Load_File_Edit_char 
TAC_Measurments_Module_Settings=importdata(TAC_Measurments_Module_Settings_filename)
Set_TAC_Measurments_Module_Settings(hObject, eventdata, handles,TAC_Measurments_Module_Settings,data_file) ;
track_what=get(handles.track_by,'Value') ;
track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ; 
if  findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1   
set(handles.popup1,'Value',2);  wait_pause('Updating',10,0.1) ;popup1_Callback(hObject, eventdata, handles);
set(handles.popup2,'Value',3);;wait_pause('Updating',10,0.1); ;popup2_Callback(hObject, eventdata, handles);
set(handles.popup3,'Value',2);;wait_pause('Updating',10,0.1); ;popup3_Callback(hObject, eventdata, handles); 
div_cells_Vec =get(handles.Div_Cells,'string');  
for ii=1:length(div_cells_Vec) 
    set(handles.Div_Cells,'value',ii);
    Div_Cells_Callback(hObject, eventdata, handles);  ;wait_pause('Updating',10,0.1);
    Add_to_plotlist_Callback(hObject, eventdata, handles);  
end 
plot_list=get(handles.plot_list,'String'); 
for ii=1:length(div_cells_Vec)  
    set(handles.plot_list,'Value',ii)
      str=char(plot_list(ii));
  str=regexprep(str,'X is long axis','');
  str=regexprep(str,'Y is long axis','');
  str_index=findstr(str,'()');
 if isempty(str_index)~=1
   str=str(1:str_index-1);
 end  
 str(min(findstr(str,'-')):findstr(str,'--'))=[];  
 Vs=str(findstr(str,'Vs.')+4:end) ; 
   Cell_Montage_function(handles,ii,Vs);  
 ;wait_pause('Updating',10,0.1);
 Close
end 
end
  
  for iii=2:size(Load_File_Edit,2)  
  try
   Load_File_Edit_char= char(Load_File_Edit(iii)) 
  catch
  Load_File_Edit_char= Load_File_Edit(iii) 
  Load_File_Edit_char=char( Load_File_Edit_char{1}) 
  end 
 try
   New_pathname_char= char(New_pathname(iii)) 
  catch
  New_pathname_char= New_pathname(iii) 
  New_pathname_char=char( New_pathname_char{1}) 
 end 
   
  set(handles.save_Fig_folder,'String',New_pathname_char);   
 TAC_Measurments_Module_Settings_filename=Load_File_Edit_char 
 TAC_Measurments_Module_Settings=importdata(TAC_Measurments_Module_Settings_filename)
 Set_TAC_Measurments_Module_Settings(hObject, eventdata, handles,TAC_Measurments_Module_Settings,data_file) ;  
  track_what=get(handles.track_by,'Value') ;
  track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ; 
  
 
 if  findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1  
for ii=1:length(div_cells_Vec)  
    set(handles.plot_list,'Value',ii)
      str=char(plot_list(ii));
  str=regexprep(str,'X is long axis','');
  str=regexprep(str,'Y is long axis','');
  str_index=findstr(str,'()');
 if isempty(str_index)~=1
   str=str(1:str_index-1);
 end  
 str(min(findstr(str,'-')):findstr(str,'--'))=[];  
 Vs=str(findstr(str,'Vs.')+4:end) ; 
   Cell_Montage_function(handles,ii,Vs);  
 ;wait_pause('Updating',10,0.1);
 Close
end 
  end
  end 
set(gcf,'colormap',jet);
handles.c=jet; 
guidata(hObject, handles); 
clc
 
   elseif   nargin ==8 % loading with handles.data_file  
 set(handles.start_panel1,'visible','on') ;set(handles.start_panel3,'visible','on');
  set(handles.Raw_listbox,'visible','on');
 handles.nargin_num=5; 
  data_file=varargin{1}; 
 handles.data_file=varargin{1}; 
 full_filename=varargin{2}; 
 TAC_Measurments_Module_Settings_filename=varargin{3}; 
 New_pathname=varargin{4};
 guidata(hObject, handles); 
  
   if  isempty(handles.data_file)==1
 handles.output = hObject;
 guidata(hObject, handles);
 return
   end
handles.output = hObject; 
 set(handles.edit_axes1,'String' ,char(data_file(1).cdata(1,1))); 
set(handles.showcurrentframe,'String',1);  
set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1) ) ;
set(handles.Raw_listbox,'Value', 1 ) ; 
set(handles.showcurrentframe,'String',1); 
TAC_Measurments_Module_Settings=importdata(TAC_Measurments_Module_Settings_filename) ; 
track_what_1=get(handles.track_what_1,'value'); 
track_what_2=get(handles.track_what_2,'value'); 
track_what_3=get(handles.track_what_3,'value');  
track_what_4=get(handles.track_what_4,'value');   
   guidata(hObject, handles); 
   set(handles.save_Fig_folder,'String',New_pathname); 
   set(handles.save_Fig_option,'Value',1);  
   set(handles.Current_Exp,'String',full_filename);
   
   Set_TAC_Measurments_Module_Settings(hObject, eventdata, handles,TAC_Measurments_Module_Settings,data_file) ;  
   ;wait_pause('Updating',10,0.3); 
  track_what=get(handles.track_by,'Value') ;
  track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ; 
  if  findstr(char(handles.data_file(7).cdata(track_what,1)),'Y')==1 
  Go_Callback(hObject, eventdata, handles) 
  end   
end
set(gcf,'colormap',jet);
handles.c=jet; 
guidata(hObject, handles); 
clc
guidata(hObject, handles);
tic
axis tight
h_TAC_Measurments_Module=handles;    
% --------------------------------------------------------------- 
function varargout = TAC_Measurments_Module_OutputFcn(hObject, ~, handles)  
%  setWindowState(hObject,'maximize','icon.gif'); % Undocumented feature!
 pause(0.05); drawnow; 
varargout{1} = handles.output;
if handles.nargin_num==3 ||  handles.nargin_num==4
  try
    replaceSlider(hObject,handles); 
  end
  try
  varargout{1}= handles.output;
  end
end
if handles.nargin_num>4
    varargout{1}= handles.output;
    wait_pause('Updating',10,0.05);
   close(TAC_Measurments_Module)
    Close
end
% --------------------------------------------------------------- 
function replaceSlider(hFig,handles)  
 sliderPos = getpixelposition(handles.slider20);
  delete(handles.slider20);
  handles.slider20 = javacomponent('javax.swing.JSlider',sliderPos,hFig);
  handles.slider20.setEnabled(false); 
  set(handles.slider20,'StateChangedCallback',{@slider20_Callback,handles});  
  guidata(hFig, handles); % update handles struct  
  if handles.nargin_num==4  
  numFiles =size(handles.data_file(1).cdata(:,1),1);
  set(handles.slider20, 'Value',1, 'Maximum',numFiles, 'Minimum',1); 
  try
 handles.slider20.setEnabled(true); % Java JSlider 
  catch
 set(handles.slider20, 'Enable','on', 'SliderStep',[1/numFiles, 0.1]); % Matlab scrollbar 
  end
  end 
% -----------------------
function handles = addPlabackControls(~, handles) 
 icons = load(fullfile(fileparts(mfilename), 'animatorIcons.mat'));  
function setWindowState(h,state,iconFilename)
  if ~usejava('jvm'), return; end
  drawnow; %need to make sure that the figures have been rendered or Java error can occur 
  %get the javaframes and desired operations
  % is h all figure handles
  if ~all(ishandle(h)) || ~isequal(length(h),length(findobj(h,'flat','Type','figure')))
 return;
  end %if 
  %check that the states are all valid
  if ~ismember(state,{'maximize','minimize','restore'}), return; end

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
%end %setWindowStateb
%   ---------------------------------------- 
function showcurrentframe_Callback(hObject, eventdata, handles)
  n=get( hObject,'string');
n=round(str2double(n));
set( handles.Raw_listbox,'value',n)
size_listbox=get( handles.Raw_listbox,'string');
if n>0 && n<size_listbox
  Raw_listbox_Callback(hObject, eventdata, handles)
end
 
function slider20_CreateFcn(hObject, ~, handles)
 hListener = handle.listener(hObject,'ActionEvent',{@slider20_Callback,handles});
  setappdata(hObject,'listener__',hListener);
function segmentation_type_3_Callback(hObject, eventdata, handles)
 Raw_listbox_Callback(hObject, eventdata, handles) ; 
%   ------------------------------------------------------- 
function Raw_listbox_Callback(~, ~, handles) 
box_Raw=get(handles.Raw_listbox,'string');
 if iscell(box_Raw)==0 
     return
 end
  if  toc<0.1  
            return
   end 
tic 
n=round(get(handles.Raw_listbox,'Value')) ;
N= str2num(get(handles.showcurrentframe,'String'));
 if N<n
      set(handles.forward_button,'Visible','on')
      set(handles.backward_button,'Visible','off') 
 elseif N>n
      set(handles.forward_button,'Visible','off')
      set(handles.backward_button,'Visible','on') 
 end  
try
    set(handles.slider20, 'Minimum',1, 'Maximum',size(box_Raw,1), 'Value',n);
end
  set(handles.showcurrentframe,'String',num2str(n));
try
    show_frame( handles,n)  ;  
end
 
function Back_to_TACTICS_Callback(~, ~, handles)
%  if isempty(handles.data_file)~=1 
%   Raw_listbox=get(handles.Raw_listbox,'String') ; 
%   handles.data_file(1).cdata(:,1)=Raw_listbox; 
%  end
if isempty(handles.data_file)~=1
run('TACTICS',handles.data_file) ;
else
run('TACTICS') ;
end 
% --------------------------------------------------------------------
function Exit_TACTICS_Callback(~, ~, ~)
 close all
% --------------------------------------------------------------------  
function popup3_Callback(~, ~, handles) 
 str=get(handles.popup2,'string');
 n=get(handles.popup2,'value');
 str_2=str(n); 
 if n==1
   return
 end 
   str=get(handles.popup3,'string');
   n=get(handles.popup3,'value');
 if n==1 
   set(handles.plot_edit,'string', str_2);  
   return
 end 
 str_3=str(n);   
 str=strcat(str_2, ' - ',str_3);
 set(handles.plot_edit,'string', str);  
% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, ~, handles)  
Current_Exp=get(handles.Current_Exp,'String'); 
[filename, pathname, filterindex] = uiputfile({ '*.dat','Dat-files (*.dat)';}, 'save session to a data file',Current_Exp);  

if isequal(filename,0) %$#1
  h = msgbox('User selected Cancel','Aborted');
  return;
end  
filename=regexprep(filename, 'TACTICS_EXP_','');
full_filename= strcat(pathname,'TACTICS_EXP_',filename) ;
full_filename=char(full_filename);
  
Raw_listbox=get(handles.Raw_listbox,'String') ;
 if iscell(Raw_listbox)~=0  
  handles.data_file(1).cdata(:,1)=Raw_listbox;
 end 
 track_what=get(handles.track_by,'Value') ;
 track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ;  
handles.data_file(10).cdata=full_filename; 
 guidata(hObject, handles);
temp=handles.data_file; 
 save(full_filename , 'temp') 
  pause(1) 
 msgbox('Experiment file was saved. Press OK to continue','Saved')
%   ----------------------------------------------------
function Load_exp_Callback(hObject, ~, handles)  
current_dir=get(handles.save_Fig_folder,'String'); 
 [filename, pathname, filterindex] = uigetfile({ '*.dat','dat-files (*.dat)';}, 'Please Choose Raw frames (that have complementary Segmented frames)',  current_dir)% handles.directory_name); %pick files to combine
if isequal(filename,0) %$#1
  h = msgbox('User selected Cancel','Aborted');
  return;
end 
full_filename= strcat(pathname,filename);
full_filename=char(full_filename);
set(handles.Current_Exp,'String',full_filename);
handles.data_file=importdata(full_filename);  
set(handles.figure1,'userdata',handles.data_file)
 
set(handles.Raw_listbox,'Value',1); 
set(handles.Raw_listbox,'String', handles.data_file(1).cdata(:,1)) ; 
set(handles.track_what_1,'value',5); 
set(handles.track_what_2,'value',5);
set(handles.track_what_3,'value',5); 
set(handles.track_what_4,'value',5); 
c=zeros(64,3);
dic=c;
dic(:,1)=0:0.0158:1;
dic(:,2)=0:0.0158:1;
dic(:,3)=0:0.0158:1;
rfp=c;
rfp(:,1)=0:0.0158:1;
gfp=c;
gfp(:,2)=0:0.0158:1;
cfp=c;
cfp(:,3)=0:0.0158:1;
yfp=c;
yfp(:,1)=0:0.0158:1;
yfp(:,2)=0:0.0158:1;
Cherry=c;
Cherry(:,1)=0:0.0158:1;
Cherry(:,2)= linspace(0,0.2,64)';
 handles.c1=dic; 
handles.c2=cfp;
handles.c3=gfp;
handles.c4=yfp;
handles.c5=Cherry;
handles.c6=rfp;  
guidata(hObject,handles);   
numFiles = size(handles.data_file(1).cdata(:,1),1); 
  set(handles.slider20, 'Value',1, 'Maximum',numFiles, 'Minimum',1);
  try
 handles.slider20.setEnabled(true); % Java JSlider 
  catch
 set(handles.slider20, 'Enable','on', 'SliderStep',[1/numFiles, 0.1]); % Matlab scrollbar 
  end
  set(handles.Raw_listbox, 'value',1, 'Enable','on'); 
  show_frame(handles,1)
   axis tight
  guidata(hObject, handles);
   set(handles.start_panel1,'visible','on') ;set(handles.start_panel3,'visible','on');
  set(handles.Raw_listbox,'visible','on');  
% ------------------------------------------------------
 function figResizeFcn(hFig,varargin)  
   handles = guidata(hFig);
function [MATRIX]= Find_Tracks(~, ~, handles,maxdisp,param,iii) 
centy1 = handles.data_file(4).cdata.Centroids(iii).cdata ; 
XYT=[]; jj=1;
for ii=1:size(centy1,2)
  XYT(jj:jj+size(centy1(ii).cdata,1)-1,:)=centy1(ii).cdata;
  jj=jj+size(centy1(ii).cdata,1);
end 
XYT(:,3)=round(XYT(:,3));
param.quiet=0; 
% perform multiple particle tracking using the list generated above
h=waitbar(0.5,'Tracking in Progress');
tracks=track_crocker(XYT,maxdisp,param) 
MATRIX = [] ; 
jj=1 ;
 for ii=1:tracks(end,4) ;
  index=find(ismember(tracks(:,4),ii)) ;
  index_min=min(index) ;
  index_max=max(index) ;
  MATRIX( tracks(index_min,3):tracks(index_min,3)+ index_max- index_min ,jj:jj+1) =tracks(index_min:index_max,1:2) ;
  jj=jj+2 ;
 end 
 close(h)  
% -------------------
function set_track(hObject, eventdata, handles,data_file)  
track_what= get(handles.track_by,'Value') ;
track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ;  
 if track_what<5
   str=handles.data_file(3).cdata(track_what,1) ;
 if str2double(str)<1
   set(handles.track_by,'Value',5)
   return
 end 
    try
       handles.C1=rand(size(handles.data_file(5).cdata.Tracks( track_what).cdata,2),3) ;
    end
  guidata(hObject,handles);   
 if  findstr(char(data_file(7).cdata(track_what,1)),'Y')==1 
% if get(handles.track_by,'Value')==1  
   MATRIX = handles.data_file(5).cdata.Tracks(track_what ).cdata ; 
   nn=1;
   last_cell =get_last_cell_index(MATRIX);div_cells=[];
   for iiii=1:size(handles.data_file(4).cdata.Centroids(track_what).cdata,2) 
  if isempty(handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata)~=1 
 centy2 = handles.data_file(4).cdata.Centroids(track_what).cdata(iiii).cdata;  % . Find the mark in centroids 
  for jj=1:size(centy2,1) % . 
  if str2num(num2str(centy2(jj,3)- iiii))==0.1
  for cell_index=2:2:(last_cell-2) 
   if MATRIX(iiii,cell_index-1)==centy2(jj,1) && MATRIX(iiii,cell_index)==centy2(jj,2)
  break
   end 
  end 
  div_cells(nn)=cell_index/2 ;  
  nn=nn+1; 
   end 
  end 
  end
   end  
   
  [all_cells,parental_cells]=TRYME(div_cells,MATRIX); 
  set(handles.Div_Cells,'value',1);%set(handles.Div_Cells,'min',0)
 if isempty(all_cells)~=1 
   set(handles.Div_Cells,'string',all_cells)
 else
 set(handles.Div_Cells,'string','')
 end
  set(handles.parental_num,'value',1);%set(handles.Div_Cells,'min',0)
  if isempty(parental_cells)~=1 
   set(handles.parental_num,'string',parental_cells) 
   parental_num_Callback(hObject, eventdata, handles)
   else
 set(handles.parental_num,'string','Choose dividing cell:')
 set(handles.Daughter1_edit,'string','')
 set(handles.Daughter2_edit,'string','') 
  end 
 else
  'Delete the small ID list: ' 
%   set(handles.Div_frame_index,'value',1)
  set(handles.Div_Cells,'value',1)
  set(handles.Div_Cells,'string','Cells list')
  set(handles.parental_num,'value',1) 
  set(handles.parental_num,'string','Choose dividing cell:')
  set(handles.Daughter1_edit,'string','')
  set(handles.Daughter2_edit,'string','')
 end 
 end 
% -------------------------------------------------------------------------
function track_what_1_Callback(hObject, eventdata, handles)  
track_what_1= get(handles.track_what_1,'Value') ;
  if track_what_1~=5
 try
  str=handles.data_file(3).cdata(track_what_1,1)  
  set(handles.show_tracks_1,'userdata',rand(size(handles.data_file(5).cdata.Tracks( track_what_1).cdata,2),3)  )
 end
 try 
  set_track(hObject, eventdata, handles,handles.data_file)  
 end
 try
  Raw_listbox_Callback(hObject, eventdata, handles) ; 
 end
  end 
% -------------------------------------------------------------------------
function track_what_2_Callback(hObject, eventdata, handles)  
track_what_2 = get(handles.track_what_2,'Value') ;
   if track_what_2~=5
  try
   str=handles.data_file(3).cdata(track_what_2,1) ; 
   set(handles.show_tracks_2,'userdata',rand(size(handles.data_file(5).cdata.Tracks( track_what_2).cdata,2),3)  ) 
  end
  try
   set_track(hObject, eventdata, handles,handles.data_file)  
   Raw_listbox_Callback(hObject, eventdata, handles) ; 
  end 
   end
% -------------------------------------------------- 
function track_what_3_Callback(hObject, eventdata, handles)  
track_what_3= get(handles.track_what_3,'Value') ;
  if track_what_3~=5
 try
 str=handles.data_file(3).cdata(track_what_3,1) ; 
 set(handles.show_tracks_3,'userdata',rand(size(handles.data_file(5).cdata.Tracks( track_what_3).cdata,2),3)  )
  
 end
 try
  set_track(hObject, eventdata, handles,handles.data_file)  
  Raw_listbox_Callback(hObject, eventdata, handles) ; 
 end
  end
% ------------------------------------------------------------------------
function track_what_4_Callback(hObject, eventdata, handles)
 track_what_4=get(handles.track_what_4,'Value') ; 
 set(handles.Use_DIC_Option,'value',1)
 if track_what_4~=5
   if (get( handles.Use_DIC_Option ,'Value') ~= get(handles.Use_DIC_Option,'Max')) 
 return
   end
  if track_what_4>0 
 try
 str_4=handles.data_file(3).cdata( track_what_4,1)   
 if char(str_4)~='1' 
 'This channel is not dic'
 Y=wavread('Error');
 h = errordlg('This channel is not DIC! Please select this channel as a DIC','Error');
 get(handles.track_what_3,'Value') ; 
 return
 end
  end  
  end
 else
   set(handles.Use_DIC_Option,'value',0) 
 end 
% MATRIX_4=handles.data_file(5).cdata.Tracks(track_what_4).cdata ;
% handles.C4=rand(size( MATRIX_4,2),3) ; 
 Raw_listbox_Callback(hObject, eventdata, handles) ;
   axes(handles.axes1) 
   axis tight
% --------------------------------------------------------------- 
function segmentation_type_1_Callback(hObject, eventdata, handles)
 Raw_listbox_Callback(hObject, eventdata, handles) ;
% -------------------------------------------------------------------------
function segmentation_type_2_Callback(hObject, eventdata, handles)
 Raw_listbox_Callback(hObject, eventdata, handles) ; 
% --------------------------------------------------------------------
function Untitled_21_Callback(hObject, ~, handles)
  uiwait(msg_box_1)
  h = imrect;
  position = wait(h)   
  handles.data_file(6).cdata= round([position(1) position(2) position(3) position(4)])  ; 
 guidata(hObject,handles);
 n=get(handles.Raw_listbox,'Value') ;  
 show_frame( handles,n) ;  
% -----------------------------------------------------------------------
%Section A. Popup selection
function popup1_Callback(~,~,handles) 
 track_what=get(handles.track_by,'Value') ;
 track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ; 
 Div_Cells_val= get(handles.Div_Cells,'Value') ;
Div_Cells_str= get(handles.Div_Cells,'string') ; 
cell_index= Div_Cells_str(Div_Cells_val) ;  
  if track_what==5
  Y=wavread('Error'); sound(Y,22000); 
  set(handles.track_what_1,'Value',1) ;
  h = msgbox('Please select the first channel first (button is at the left buttom corner of the screen)','Aborted');
  return
  end 
 MATRIX =  handles.data_file(5).cdata.Tracks(track_what).cdata; 
 if isempty(MATRIX)==1
   'no data at table'
   return
 end
 parental_num_val= get(handles.parental_num,'Value') ;
 parental_num_str= get(handles.parental_num,'string') ; 
 parental_num= parental_num_str(parental_num_val) 
 Daughter1= get(handles.Daughter1_edit,'string');  
 Daughter2= get(handles.Daughter2_edit,'string'); 
 cellnum=str2double(get(handles.Div_Cells,'String'));  
 tracksnum=str2double(get(handles.edit_tracks_num,'String')); 
 popup1=get(handles.popup1,'Value'); 
 popup2_str=set_popup2_str(cell_index,tracksnum,popup1,parental_num,Daughter1,Daughter2); 
 set(handles.popup2,'value', 1);
 set(handles.popup2,'string', popup2_str); 
 str=get(handles.popup1,'string');
 n=get(handles.popup1,'value');
 if n==1
   return
 end   
 set(handles.plot_edit,'string', str(n)); 
%---------------------------------------------------- For one cell:
function popup2_Callback(~, ~, handles) 
popup2=get(handles.popup2,'Value') 
popup2_str=get(handles.popup2,'String') 
popup3_str=get(handles.popup3,'String') 
popup2_str=char(popup2_str(popup2))  
popup3_str=set_popup3_str(popup2_str)   
set(handles.popup3,'value', 1);
set(handles.popup3,'string', popup3_str);
 str=get(handles.popup2,'string');
 n=get(handles.popup2,'value');
 if n==1
   return
 end 
 str=str(n); 
 set(handles.plot_edit,'string', str); 
 % -----------------------------------------------------------  
function [last_cell]=get_last_cell_index(MATRIX)
  for last_cell=2:2: size(MATRIX,2)
   X=MATRIX(:,last_cell) ;
   X(X==0)=[];
  if isempty(X)==1
 break
  end
  end 
function edit_axes1_Callback(~, ~, handles) 
n=round(get(handles.Raw_listbox,'Value')) ;
show_frame(handles,n,'figure') 
% --------------------------------------------------------
function Add_to_plotlist_Callback(~, ~, handles)
popup1=get(handles.popup1,'Value') ;
popup2=get(handles.popup2,'Value') ;
popup3=get(handles.popup3,'Value') ;
 if popup2==1
 return
 end
% popup2_str=get(handles.popup2,'String') ;
% popup2_str=popup2_str(popup2) ;
% popup2_str=char(popup2_str) ;
str=get(handles.plot_edit,'string');
n=get(handles.plot_list,'Value') ; 
plot_list=get(handles.plot_list,'string') ; 
plot_list_Matrix=get(handles.plot_list,'userdata'); 
 
  if isempty(plot_list)==1
   n=1 ;
   plot_list=cellstr(plot_list);
   plot_list(n)=cellstr(str) ;
   set(handles.plot_list,'string',plot_list); 
   plot_list_Matrix=[popup1  popup2  popup3];
    else
   n=size(plot_list,1)+1 ;
   plot_list=cellstr(plot_list);
   plot_list(n)=cellstr(str) ;
   set(handles.plot_list,'string',plot_list);
     plot_list_Matrix(:,:,end+1)=[popup1  popup2  popup3];
  end 
  set(handles.plot_list,'userdata', plot_list_Matrix)
%   -------------------------------------------------
function Delete_Selected_Callback(~, ~, handles)
% hObject  handle to Delete_Selected (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB

clc;
n=get(handles.plot_list,'Value') ;
plot_list=get(handles.plot_list,'string');
plot_list_Matrix=get(handles.plot_list,'userdata');
plot_list_Matrix(:,:,n)=[];
set(handles.plot_list,'userdata', plot_list_Matrix)
 if (n==1 && n==size(plot_list,1)) 
  set(handles.plot_list,'string','Selected plot:'); 
  return
end
if (n==1 && size(plot_list,1)>1)
 for ii=1:(size(plot_list,1)-1) 
   newplot_list(ii)=plot_list(ii+1); 
 end
  set(handles.plot_list,'string',newplot_list); 
  return
end
if (n>1 && size(plot_list,1)>1&&size(plot_list,1)>n)
 for  ii=1:(n-1)
 newplot_list(ii)=plot_list(ii); 
 end
 for ii=n:(size(plot_list,1)-1) 
   newplot_list(ii)=plot_list(ii+1); 
 end
  set(handles.plot_list,'string',newplot_list); 
 return
end
 if (n==size(plot_list,1) && n>1)
  for ii=1:(n-1)
  newplot_list(ii)=plot_list(ii); 
  end
 set(handles.plot_list,'Value',n-1);
 set(handles.plot_list,'string',newplot_list); 
 return
 end% handles  structure with handles and user data (see GUIDATA)
% -------------------------------------------------
function Delete_list_Callback(~, ~, handles) 
 set(handles.plot_list,'Value',1)
 set(handles.plot_list,'string',[]); 
% -------------------------------------------------------------------------
function alpha_slider_1_Callback(hObject, eventdata, handles)
track_what_1=get(handles.track_what_1,'value'); 
n=round(get(handles.Raw_listbox,'Value'));
if track_what_1>1
   temp_Segmention_1=double(show_frame(hObject, eventdata, handles,n,1)) ;
   alpha_slider=get(handles.axes1,'value');
end
% -------------------------------------------------------------------------
function edit_tracks_num_Callback(~, ~, handles) 
 tracksnum=str2double(get(handles.edit_tracks_num,'String')); 
 popup2_str=cell(10,1);
 popup2_str(1)= cellstr('Select:' );  
%  p 001d
  %Type 1:
  popup2_str(2)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' 2D Projection' ));  
  popup2_str(3)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_3' ));   
  popup2_str(4)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_4' ));   
  popup2_str(5)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_5' ));   
  popup2_str(6)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_6' ));   
  popup2_str(7)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_7' ));   
  popup2_str(8)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_8' ));   
  popup2_str(9)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_9' ));   
  popup2_str(10)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_10' ));   
  
   %Type 2:   
  popup2_str(11)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Intensity' )); 
  popup2_str(12)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Area' ));  
  popup2_str(13)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' I_per_A' ));  
  popup2_str(14)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' EquivDiameter' )); 
  popup2_str(15)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Circularity' ));  
  popup2_str(16)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Ellipticity' ));  
  popup2_str(17)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Polarisation' ));   
  popup2_str(18)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Eccentricity' )); 
  popup2_str(19)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Orientation' ));   
  popup2_str(20)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Velocity' ));  
  
  
  popup2_str(21)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_21' )); 
  popup2_str(22)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_22' ));  
  popup2_str(23)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_23' )); 
  popup2_str(24)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_24' )); 
  popup2_str(25)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_25' )); 
  popup2_str(26)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_26' ));  
  popup2_str(27)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_27' )); 
  popup2_str(28)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_28' )); 
  popup2_str(29)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_29' )); 
  popup2_str(30)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_30' ));  
  
  
   %Type 3:  
   popup2_str(31)=cellstr( 'Population- Trajectories' );  
   popup2_str(32)=cellstr( 'Population- MSD' ); 
   popup2_str(33)=cellstr( 'Population-number of cells' ); 
   popup2_str(34)=cellstr( 'Proximity_vector' );  
   popup2_str(35)=cellstr( 'Maximum_pixel' ); 
   popup2_str(36)=cellstr( 'Angle between MaxP and proximity' );
   popup2_str(37)=cellstr( 'type_3_Option_37' );  
   popup2_str(38)=cellstr( 'type_3_Option_38' ); 
   popup2_str(39)=cellstr( 'type_3_Option_39' );
   popup2_str(40)=cellstr( 'type_3_Option_40' );
   
   
 set(handles.popup2,'value', 1);
 set(handles.popup2,'string', popup2_str);
 
 str=get(handles.popup1,'string');
 n=get(handles.popup1,'value');
 if n==1
   return
 end 
 str=str(n); 
 set(handles.plot_edit,'string', str); 
 
% --------------------------------------------------------------- 
 function [MATRIX_out]=break_track(MATRIX_in,frame_index,cell_index,n,last_cell) 
 MATRIX_out=zeros(size(MATRIX_in,1),size(MATRIX_in,2)+2);
 % -----
 MATRIX_out(:,1:(cell_index*2-2))=MATRIX_in(:,1:(cell_index*2-2));%1
% -----
 MATRIX_out(1:frame_index, (cell_index*2-1):(cell_index*2)) = MATRIX_in(1:frame_index, (cell_index*2-1):(cell_index*2)) %2
% -----

 
 for ii=2:2:(last_cell-2+2*n) %find the place where to put the new track (ii)
 X=MATRIX_in(:,ii-1) ; 
 X2=X; 
 X(X==0)=[]; 
 start_X=find(ismember(X2,X(1))) ; start_X=start_X(1); 
 if frame_index<start_X 
   break
 end
 end 
 
  MATRIX_out(:,cell_index*2+1:ii-2)=MATRIX_in(:,cell_index*2+1:ii-2);%3 
  % -----
  
  V=MATRIX_in(:,cell_index*2-1) ; 
  index_X=find(ismember(V,0)); 
  V(index_X)=[] ; 
 if isempty(index_X)==1
   start_X=0;
 else
   start_X=length(index_X);
 end  
 end_X=length(V)+start_X; 
 MATRIX_out((frame_index+1):end_X, (ii-1):ii) = MATRIX_in((frame_index+1):end_X, (cell_index*2-1):(cell_index*2)); %4 
 MATRIX_out(:,(ii+1):end)= MATRIX_in(:,(ii-1):end);%5 
% ------------------------------------------------------------------
function parental_num_Callback(hObject, eventdata, handles) 
  parental_num_str=get(handles.parental_num,'string');
parental_num_val=get(handles.parental_num,'value');
parental_num=parental_num_str(parental_num_val);
div_cells_Vec =get(handles.Div_Cells,'string'); 
cell_index=find(strcmp(cellstr(parental_num), div_cells_Vec )); 
trackdivnum=cell_index ;
 track_what=get(handles.track_by,'Value') ;
% track_by=eval(strcat('get(handles.track_what_',num2str(track_by),',''Value',''' )')) ; 
 MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;  
% save MATRIX MATRIX 
 if isempty(MATRIX)==1
   'no data at table'
   return
 end
V=MATRIX(:,cell_index*2-1)  ;
V=V(find(V, 1 ):find(V, 1, 'last' )) ;
 for start_XY=1:size(MATRIX,1)
   if MATRIX(start_XY,cell_index*2-1)>0
  break
   end 
 end 
end_XY=length(V)+start_XY; % -1
% if end_XY>size(MATRIX,1)
%  h = msgbox('Can not find the divisions!. Have you broke the tracks in TACTICS_T??','Aborted'); 
%   return; 
% end
x=MATRIX(end_XY-1,cell_index*2-1) ;
y=MATRIX(end_XY-1,cell_index*2) ; 
sizee=size(MATRIX,2)/2;
matrix=repmat([1 NaN;NaN 1],1,sizee );
X=matrix(1,:).*MATRIX(end_XY,:); 
Y=matrix(2,:).*MATRIX(end_XY,:);
X(isnan(X))=[]; %take off all nans from X vector
Y(isnan(Y))=[]; %take off all nans from X vector
X(X==0)=NaN;
Y(Y==0)=NaN;
 XY= (X-x).^2+ (Y-y).^2 ;%PITAGORAS
 XY_min_index=find(ismember(XY,(min(XY)))) ; 
 if isempty(X(XY_min_index))~=1 || isempty(Y(XY_min_index))~=1  
   Daughter1=div_cells_Vec(XY_min_index);
   set(handles.Daughter1_edit,'string',Daughter1) ;
 end
 XY(XY_min_index)=nan;
 XY_min_index=find(ismember(XY,(min(XY))))
   if isempty(X(XY_min_index))~=1 || isempty(Y(XY_min_index))~=1 
  Daughter2 =div_cells_Vec(XY_min_index) ;
   set(handles.Daughter2_edit,'string',Daughter2) ;
   end
  set(handles.Raw_listbox,'Value',end_XY) 
   box_Raw=get(handles.Raw_listbox,'string') ; 
if iscell(box_Raw)==0 
  Y=wavread('Error');
  h = errordlg('No files in Raw Frame listbox','Error');
  return
end 

n=round(get(handles.Raw_listbox,'Value'));
size_boxlist=size(box_Raw,1); 
 set(handles.edit_axes1,'String',box_Raw(n)); 
 set(handles.showcurrentframe,'String',num2str(n));
 set(handles.Raw_listbox,'Value',n);
try
    show_frame( handles,n) ; 
end
   
 popup2_str=cell(10,1);
 popup2_str(1)= cellstr('Select:' );  
  if isempty(trackdivnum)~=1 
  %Type 1:
  %Keep space between ' and property. i.e: ' (space) Movie'
  %Type 1:
 popup2_str(2)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Movie' ));  
  popup2_str(3)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' 2D Projection' ));  
  popup2_str(4)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' 3D Projection' ));  
  popup2_str(5)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Edge' ));  
  popup2_str(6)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Montage' ));   
  popup2_str(7)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' SEQtage' )); 
  popup2_str(8)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_1_Option_8' )); 
  popup2_str(9)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_1_Option_9' )); 
  popup2_str(10)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_1_Option_10' )); 
   
   %Type 2:   
  popup2_str(11)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Intensity' )); 
  popup2_str(12)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Area' ));  
 popup2_str(13)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' I_per_A' ));  
  popup2_str(14)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Eccentricity' )); 
  popup2_str(15)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Orientation' ));   
  popup2_str(16)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' EquivDiameter' )); 
  popup2_str(17)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Circularity' ));   
  popup2_str(18)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Ellipticity' )); 
  popup2_str(19)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Polarisation' ));   
  popup2_str(20)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_20' )); 
  
  
 popup2_str(21)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_21' )); 
  popup2_str(22)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_22' ));  
 popup2_str(23)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_23' ));  
  popup2_str(24)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_24' )); 
  popup2_str(25)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_25' ));   
  popup2_str(26)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_26' )); 
  popup2_str(27)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --', 'type_2_Option_27' ));   
  popup2_str(28)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_28' )); 
  popup2_str(29)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_29' ));   
  popup2_str(30)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_30' )); 
  
  
   %Type 3:  
  popup2_str(31)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Velocity' ));  
  popup2_str(32)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Trajectories' )); 
  popup2_str(33)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' MSD' ));   
  popup2_str(34)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Proximity_vector' ));  
  popup2_str(35)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Maximum_pixel' )); 
  popup2_str(36)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Angle between MaxP and proximity' ));  
  popup2_str(37)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_3_Option_37' ));  
  popup2_str(38)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_3_Option_38' )); 
  popup2_str(39)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_3_Option_39' ));  
  popup2_str(40)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_3_Option_40' ));   
 
   %Add_functions_001c 
% popup2_str(15)=cellstr(strcat('Dividing- ',num2str(trackdivnum),' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Add_functions_004c' ));  

   
% set(handles.Dividing_cells_panel,'Visible','on')   
% set(handles.text_Cell,'Visible','off')
% set(handles.text_Track,'Visible','off') 
% set(handles.Div_Cells,'Visible','off')
% set(handles.edit_tracks_num,'Visible','off')  
%   popup2_Callback(hObject, eventdata, handles)
%  
% set(handles.popup2,'value', 1);
try
 set(handles.popup2,'string', popup2_str);
end
try
  popup2_Callback(hObject, eventdata, handles)
end
try
   popup3_Callback(hObject, eventdata, handles)
end
  end
% -------------------------------------------------------------------------
function Go_Callback(hObject, ~, handles)
 track_by=get(handles.track_by,'Value') ;
 track_what=eval(strcat('get(handles.track_what_',num2str(track_by),',''Value',''' )')) ; 
if track_what==5
  h = msgbox('First channel has to be defined fisrt','Aborted');
  return;
end 
Div_Cells_str=get(handles.Div_Cells,'string');  
plot_list=get(handles.plot_list,'String');
scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);

 if get(handles.subplot_on,'value')==1
 h_subplot=figure('color','w','units','pixels','position', scrsz) ;  
 hold on 
 end
     
 for ii=1:length(plot_list) 
  str=char(plot_list(ii));
  str=regexprep(str,'X is long axis','');
  str=regexprep(str,'Y is long axis','');
  str_index=findstr(str,'()');
 if isempty(str_index)~=1
   str=str(1:str_index-1);
 end 
  set(handles.plot_list,'Value',ii) 
  handles.current_plot=ii;
  guidata(hObject, handles); 
  
   if isempty(findstr(str,'Cell-'))~=1  %2 create 
 %to create the subplot dimensions
 handles.size_plot=length(plot_list); %need to split between single cell and population 
  cell_str= str(min(findstr(str,'-'))+1:findstr(str,'--')-1) ; 
  n=find(strcmp(cellstr(cell_str), Div_Cells_str )) ; 
 Vs=str(findstr(str,'Vs.')+4:end) ; 
 str(min(findstr(str,'-')):findstr(str,'--'))=[]; 
%  ;wait_pause('Updating',10,0.3); 
 %Type 1: 
  if findstr(str,'Cell- Movie')==1%2create
  Cell_Movie_function(handles,n,Vs);
  end
  if findstr(str,'Cell- Montage')==1%3create
  Cell_Montage_function(handles,n,Vs);
  end
  if findstr(str,'Cell- ShellProjection')==1%4create
  Cell_Shell_Projection_function(handles,n,Vs);
  end
  if findstr(str,'Cell- 2D Projection')==1%5create
  Cell_2D_Projection_function(handles,n,Vs);
  end
  if findstr(str,'Cell- 3D Projection')==1%6create
  Cell_3D_Projection_function(handles,n,Vs);
  end
  if findstr(str,'Cell- Edge')==1%7create
  Cell_Edge_function(handles,n,Vs);
  end
  if findstr(str,'Cell- Montage_watershed')==1%8create
  Cell_Montage_watershed_function(handles,n,Vs);
  end
  if findstr(str,'Cell- Montage_distance_transform')==1%9create
  Cell_Montage_distance_transform_function(handles,n,Vs);
  end
  if findstr(str,'Cell- Projection_watershed')==1%10create
  Cell_Projection_watershed_function(handles,n,Vs);
  end

 
 
  %Type2:
  if findstr(str,'Cell- Type2_Intensity')==1%1 
  Cell_plot_function(handles,n,'Intensity',Vs);
  end 
  if findstr(str,'Cell- Type2_Area')==1% 2  
  Cell_plot_function(handles,n,'Area',Vs);
  end
  if findstr(str,'Cell- Type2_I_per_A')==1% 3
  Cell_plot_function(handles,n,'I_per_A',Vs);
  end
  if findstr(str,'Cell- Type2_Eccentricity')==1% 4
  Cell_plot_function(handles,n,'Eccentricity',Vs);
  end
  if findstr(str,'Cell- Type2_Orientation')==1% 5
  Cell_plot_function(handles,n,'Orientation',Vs);
  end
  if findstr(str,'Cell- Type2_EquivDiameter')==1% 6
  Cell_plot_function(handles,n,'EquivDiameter',Vs);
  end
  if findstr(str,'Cell- Type2_Circularity')==1% 7
  Cell_plot_function(handles,n,'Circularity',Vs);
  end
  if findstr(str,'Cell- Type2_Ellipticity')==1% 8
  Cell_plot_function(handles,n,'Ellipticity',Vs);
  end
  if findstr(str,'Cell- Type2_Polarisation')==1% 9
  Cell_plot_function(handles,n,'Polarisation',Vs);
  end 

    if findstr(str,'Cell- Type2_Type2_Extent')==1% 10
  Cell_plot_function(handles,n,'Extent',Vs);
    end

    if findstr(str,'Cell- Type2_Perimeter')==1% 11
  Cell_plot_function(handles,n,'Perimeter',Vs);
    end

    if findstr(str,'Cell- Type2_Solidity')==1% 12
  Cell_plot_function(handles,n,'Solidity',Vs);
    end
  
if findstr(str,'Cell- Type2_graycoprops_Correlation')==1% 13 
  Cell_plot_function(handles,n,'graycoprops_Correlation',Vs);
end
    if findstr(str,'Cell- Type2_graycoprops_Contrast')==1% 14
  Cell_plot_function(handles,n,'graycoprops_Contrast',Vs);
    end
    if findstr(str,'Cell- Type2_graycoprops_Energy')==1%15
  Cell_plot_function(handles,n,'graycoprops_Energy',Vs);
    end
    if findstr(str,'Cell- Type2_graycoprops_Homogeneity')==1% 16
  Cell_plot_function(handles,n,'graycoprops_Homogeneity',Vs);
    end

    if findstr(str,'Cell- Type2_std2')==1% 17
  Cell_plot_function(handles,n,'std2',Vs);
    end

    if findstr(str,'Cell- Type2_number_of_peaks_X')==1% 18
  Cell_plot_function(handles,n,'number_of_peaks_X',Vs);
    end

    if findstr(str,'Cell- Type2_number_of_peaks_Y')==1% 19
  Cell_plot_function(handles,n,'number_of_peaks_Y',Vs);
    end

    if findstr(str,'Cell- Type2_number_of_disks')==1% 20
  Cell_plot_function(handles,n,'number_of_disks',Vs);
    end

  %Type3:
  if findstr(str,'Cell- Velocity')==1%21
  Cell_plot_function(handles,n,'Velocity',Vs);
  end
  if findstr(str,'Cell- MSD')==1%create%22
 Cell_MSD_function(handles,n)  %12 
  end
  if findstr(str,'Cell- Trajectories')==1%create%23
  Cell_Trajectories_function(handles,n)  %12 
  end
  if findstr(str,'Cell- Proximity_vector')==1%24
   Cell_Proximity_vector_function(handles,n)  %12 
  end 
  if findstr(str,'Cell- Maximum_pixel')==1%25
  Cell_Maximum_pixel_function(handles,n)  %12 
  end
  if findstr(str,'Cell- Angle between MaxP and proximity')==1%26 
  Cell_Angle_MaxP_proximity_function(handles,n)  %12 
  end
  if findstr(str,'Cell- distance_from_origion')==1%27
  Cell_distance_from_origion_function(handles,n);
  end
  if findstr(str,'Cell- brightest_Pixel_X')==1%28
  Cell_brightest_Pixel_X_function(handles,n);
  end
  if findstr(str,'Cell- brightest_Pixel_Y')==1%29
  Cell_brightest_Pixel_Y_function(handles,n);
  end
  if findstr(str,'Cell- turnng_angle')==1%30
  Cell_turnng_angle_function(handles,n);
  end
   end
  %---------------------------------------------------- For all Population: 
   if isempty(findstr(str,'Population-'))~=1  %2 create 
  %to create the subplot dimensions
   handles.size_plot=length(plot_list); 
   %to start to fill the subplot
   %plus to save the data as cdata  
   n= str2double(str(min(findstr(str,'-'))+1:findstr(str,'--')-1) );
   Vs=str(findstr(str,'Vs.')+4:end);
   str(min(findstr(str,'-')):findstr(str,'--'))=[];
   ;wait_pause('Updating',10,0.1);
   %Type 1:  
   if findstr(str,'Population- 2D Projection')==1%2create
   Population_2D_Projection_function(handles,Vs);
   end
   if findstr(str,'Population- type_1_Option_3')==1%3create
   Population_type_1_Option_3_function(handles,Vs);
   end
   if findstr(str,'Population- type_1_Option_4')==1%4create
   Population_type_1_Option_4_function(handles,Vs);
   end
   if findstr(str,'Population- type_1_Option_5')==1%5create
   Population_type_1_Option_5_function(handles,Vs);
   end
   if findstr(str,'Population- type_1_Option_6')==1%6create
   Population_type_1_Option_6_function(handles,Vs);
   end
   if findstr(str,'Population- type_1_Option_7')==1%7create
   Population_type_1_Option_7_function(handles,Vs);
   end
   if findstr(str,'Population- type_1_Option_8')==1%8create
   Population_type_1_Option_8_function(handles,Vs);
   end
   if findstr(str,'Population- type_1_Option_9')==1%9create
   Population_type_1_Option_9_function(handles,Vs);
   end
   if findstr(str,'Population- type_1_Option_10')==1%10create
   Population_type_1_Option_10_function(handles,Vs);
   end
   %Type2:
   if findstr(str,'Population- Intensity')==1%11
   Population_plot_function(handles,'Intensity',Vs,n);
   end
   if findstr(str,'Population- Area')==1%12
   Population_plot_function(handles,'Area',Vs,n);
   end
   if findstr(str,'Population- I_per_A')==1%13
   Population_plot_function(handles,'I_per_A',Vs,n);
   end
   if findstr(str,'Population- Eccentricity')==1%14
   Population_plot_function(handles,'Eccentricity',Vs,n);
   end
   if findstr(str,'Population- Orientation')==1%15
   Population_plot_function(handles,'Orientation',Vs,n);
   end
   if findstr(str,'Population- EquivDiameter')==1%16
   Population_plot_function(handles,'EquivDiameter',Vs,n);
   end
   if findstr(str,'Population- Circularity')==1%17
   Population_plot_function(handles,'Circularity',Vs,n);
   end 
   if findstr(str,'Population- Ellipticity')==1%18
   Population_plot_function(handles,'Ellipticity',Vs,n);
   end 
   if findstr(str,'Population- Polarisation')==1%19
   Population_plot_function(handles,'Polarisation',Vs,n);
   end 
   if findstr(str,'Population- Velocity')==1%20
   Population_plot_function(handles,'Velocity',Vs,n);
   end 
   %Type3: 
   if findstr(str,'Population- Trajectories')==1%21
   Population_Trajectories_function(handles);
   end
   if findstr(str,'Population- MSD')==1%22
   Population_MSD_function(handles);
   end 
   if findstr(str,'Population-Proximity_vector')==1%24
   Population_type_3_Option_24_function(handles,Vs);
   end
   if findstr(str,'Population- Maximum_pixel')==1%25
   Population_type_3_Option_25_function(handles,Vs);
   end
   if findstr(str,'Population- type_3_Option_26')==1%26
   Population_type_3_Option_26_function(handles,Vs);
   end
   if findstr(str,'Population- type_3_Option_27')==1%27
   Population_type_3_Option_27_function(handles,Vs);
   end
   if findstr(str,'Population- type_3_Option_28')==1%28
   Population_type_3_Option_28_function(handles,Vs);
   end
   if findstr(str,'Population- type_3_Option_29')==1%29
   Population_type_3_Option_29_function(handles,Vs);
   end
   if findstr(str,'Population- type_3_Option_30')==1%30
   Population_type_3_Option_30_function(handles,Vs);
   end 
   end 
   if isempty(findstr(str,'Dividing-'))~=1  %2 create 
 n= str(min(findstr(str,'-'))+1:findstr(str,'Daughters')-1);
 n=find(strcmp(cellstr(n), Div_Cells_str )) ;  
 D1= str(min(findstr(str,'*'))+1:findstr(str,'**')-1) ;
 D1=find(strcmp(cellstr(D1), Div_Cells_str )) ; 
 D2= str(max(findstr(str,'**'))+2:findstr(str,'--')-1);
 D2=find(strcmp(cellstr(D2), Div_Cells_str )) ;   
 
 Vs=str(findstr(str,'Vs.')+4:end)  ;
 
 str(min(findstr(str,'-')):findstr(str,'--'))=[] ;
 ;wait_pause('Updating',10,0.1); 
  %Type1:
  if findstr(str,'Dividing- Movie')==1%2create
  Dividing_Movie_function(handles,n,D1,D2,Vs);
  end
  if findstr(str,'Dividing- Montage')==1%3create 
  Dividing_Montage_function(handles,n,D1,D2,Vs);
  end
  
  if findstr(str,'Dividing- SEQtage')==1%3create
  Dividing_SEQtage_function(handles,n,D1,D2,Vs);
  end
  
  if findstr(str,'Dividing- 2D Projection')==1%4create
  Dividing_2D_Projection_function(handles,n,D1,D2,Vs);
  end
  if findstr(str,'Dividing- 3D Projection')==1%5create
  Dividing_3D_Projection_function(handles,n,D1,D2,Vs);
  end
  if findstr(str,'Dividing- Edge')==1%6create
  Dividing_Edge_function(handles,n,D1,D2,Vs);
  end 
  if findstr(str,'Dividing- type_1_Option_7')==1%7
  Population_type_3_Option_7_function(handles,Vs);
  end
  if findstr(str,'Dividing- type_1_Option_8')==1%8
  Population_type_3_Option_8_function(handles,Vs);
  end
  if findstr(str,'Dividing- type_1_Option_9')==1%9
  Population_type_3_Option_9_function(handles,Vs);
  end
  if findstr(str,'Dividing- type_1_Option_10')==1%10
  Population_type_3_Option_10_function(handles,Vs);
  end 
  %Type2: 
  if findstr(str,'Dividing- I_per_A')==1%11
  Dividing_plot_function(handles,n,D1,D2,Vs,'I_per_A');
  end 
  if findstr(str,'Dividing- Intensity')==1%12
  Dividing_plot_function(handles,n,D1,D2,Vs,'Intensity');
  end
  if findstr(str,'Dividing- Area')==1%13
  Dividing_plot_function(handles,n,D1,D2,Vs,'Area');
  end
  if findstr(str,'Dividing- Eccentricity')==1%14
  Dividing_plot_function(handles,n,D1,D2,Vs,'Eccentricity');
  end
  if findstr(str,'Dividing- EquivDiameter')==1%15
  Dividing_plot_function(handles,n,D1,D2,Vs,'EquivDiameter');
  end
  if findstr(str,'Dividing- Circularity')==1%16
  Dividing_plot_function(handles,n,D1,D2,Vs,'Circularity');
  end
  if findstr(str,'Dividing- Ellipticity')==1%17
  Dividing_plot_function(handles,n,D1,D2,Vs,'Ellipticity');
  end
  if findstr(str,'Dividing- Polarisation')==1%18
  Dividing_plot_function(handles,n,D1,D2,Vs,'Polarisation');
  end 
  if findstr(str,'Dividing- Orientation')==1%19
  Dividing_plot_function(handles,n,D1,D2,Vs,'Orientation');
  end 
  if findstr(str,'Dividing- Velocity')==1%20
  Dividing_plot_function(handles,n,D1,D2,Vs,'Velocity');
  end 
  %Type2: 
  if findstr(str,'Dividing- Trajectories')==1%create%21
  Dividing_Trajectories_function(handles,n,D1,D2);
  end
  if findstr(str,'Dividing- MSD')==1%create%22
  Dividing_MSD_function(handles,n,D1,D2);
  end 
  if findstr(str,'Dividing- Proximity_vector')==1%23
  Population_type_3_Option_23_function(handles,Vs);
  end
  if findstr(str,'Dividing- Maximum_pixe')==1%24
  Population_type_3_Option_24_function(handles,Vs);
  end
  if findstr(str,'Dividing- type_3_Option_25')==1%25
  Population_type_3_Option_25_function(handles,Vs);
  end
  if findstr(str,'Dividing- type_3_Option_26')==1%26
  Population_type_3_Option_26_function(handles,Vs);
  end
  if findstr(str,'Dividing- type_3_Option_27')==1%27
  Population_type_3_Option_27_function(handles,Vs);
  end
  if findstr(str,'Dividing- type_3_Option_28')==1%28
  Population_type_3_Option_28_function(handles,Vs);
  end
  if findstr(str,'Dividing- type_3_Option_29')==1%29
  Population_type_3_Option_29_function(handles,Vs);
  end
  if findstr(str,'Dividing- type_3_Option_30')==1%30
  Population_type_3_Option_30_function(handles,Vs);
  end 
   ;wait_pause('Updating',10,0.1);
   end
 end 


%   ---------------------------------------------------------------------
function quantify_by_Callback(~, ~, handles)
quantify_by=get(handles.track_by,'Value') ;
 quantify_by=eval(strcat('get(handles.track_what_',num2str(quantify_by),',''Value',''' )')) ; 
 if quantify_by==5
   Y=wavread('Error');
   set( handles.track_by ,'Value',1)
   h = errordlg('Please choose proper channel to be used for quantification first','Error');
 return
   
 end
% --------------------------------------------------------------------- 
function Merge_channels_Callback(~, ~, handles)
 if (get( handles.Merge_channels ,'Value') == get(handles.Merge_channels,'Max')) 
%  set(handles.text_ch3, 'Visible','on') 
%  set(handles.track_what_3, 'Visible','on') 
%  set(handles.segmentation_type_3, 'Visible','on') 
%  set(handles.show_tracks_3, 'Visible','on') 
%  set(handles.show_marks_3, 'Visible','on') 
%  set(handles.text_mergin, 'Visible','on')  
 else
% set(handles.text_ch3, 'Visible','off') 
%  set(handles.track_what_3, 'Visible','off') 
%  set(handles.segmentation_type_3, 'Visible','off') 
%  set(handles.show_tracks_3, 'Visible','off') 
%  set(handles.show_marks_3, 'Visible','off') 
%   set(handles.text_mergin, 'Visible','off')  
 end 
% --------------------------------------------
function show_tracks_1_Callback(hObject, eventdata, handles) 
 Raw_listbox_Callback(hObject, eventdata, handles) 
% --------------------------------------------
function show_tracks_2_Callback(hObject, eventdata, handles)
Raw_listbox_Callback(hObject, eventdata, handles)
% --------------------------------------------
function show_tracks_3_Callback(hObject, eventdata, handles)
Raw_listbox_Callback(hObject, eventdata, handles) 
% -------------------------------------------- 
function show_marks_1_Callback(hObject, eventdata, handles)
 Raw_listbox_Callback(hObject, eventdata, handles) 
% --------------------------------------------
function show_marks_2_Callback(hObject, eventdata, handles)
 Raw_listbox_Callback(hObject, eventdata, handles) 
 % --------------------------------------------
function show_marks_3_Callback(hObject, eventdata, handles)
Raw_listbox_Callback(hObject, eventdata, handles) 
% ------------------------------------------------------------------------
function Untitled_16_Callback(~, ~, handles)  
 %this function was ready but because a ,major construction and
 %development in TAC_Measurments_Module, major adjustments is required before be available again!
 [a,b,c,d]= Help_Quntification; 
set(handles.track_what_1,'Value',a);
set(handles.track_what_3,'Value',b);  
if a==c 
  set(handles.quantify_by_options,'Value',1);
  set(handles.track_what_2,'Value',1);
else
 set(handles.quantify_by_options,'Value',2);
 set(handles.track_what_2,'Value',c);
end
 
if b==1
  d=1
end


if d~=1 
   set(handles.Merge_channels,'Value',1); 
%  set(handles.text_ch3, 'Visible','on') 
%  set(handles.track_what_3, 'Visible','on') 
%  set(handles.segmentation_type_3, 'Visible','on') 
%  set(handles.show_tracks_3, 'Visible','on') 
%  set(handles.show_marks_3, 'Visible','on') 
else 
  set(handles.Merge_channels,'Value',0); 
% set(handles.text_ch3, 'Visible','off') 
%  set(handles.track_what_3, 'Visible','off') 
%  set(handles.segmentation_type_3, 'Visible','off') 
%  set(handles.show_tracks_3, 'Visible','off') 
%  set(handles.show_marks_3, 'Visible','off') 
end 
% ------------------------------------------------------------
function save_Fig_option_Callback(hObject, eventdata, handles)
if (get(handles.save_Fig_option,'Value') == get(handles.save_Fig_option,'Max')) 
  set(handles.save_Fig_folder, 'Visible','on') 
  save_Fig_folder_Callback(hObject, eventdata, handles) 
else
  set(handles.save_Fig_folder, 'Visible','off') 
end
% -------------------------------------------------------------
function save_Fig_folder_Callback(~, ~, handles) 
current_dir=get(handles.save_Fig_folder,'String') ;
new_dir=uigetdir(current_dir,'Current Directory');
if isequal(new_dir,0) %$#1
  h = msgbox('User selected Cancel','Aborted');
  return;
end
new_dir= strcat(new_dir,'\') ;
new_dir=char(new_dir)
 
set(handles.save_Fig_folder,'String',new_dir) ; 

% --------------------------------------------------------------------
function Untitled_02_Callback(~, ~, handles)
  
 
 %function read_plot convert plot list into numbers in the control panel
 
TAC_Measurments_Module_Settings(1).cdata=get(handles.track_what_1,'Value');
TAC_Measurments_Module_Settings(2).cdata=get(handles.track_what_2,'Value');
TAC_Measurments_Module_Settings(3).cdata=get(handles.track_what_3,'Value');
TAC_Measurments_Module_Settings(4).cdata=get(handles.track_what_4,'Value'); 
TAC_Measurments_Module_Settings(5).cdata=get(handles.segmentation_type_1,'Value');
TAC_Measurments_Module_Settings(6).cdata=get(handles.segmentation_type_2,'Value');
TAC_Measurments_Module_Settings(7).cdata=get(handles.segmentation_type_3,'Value');
TAC_Measurments_Module_Settings(8).cdata=get(handles.segmentation_type_4,'Value'); 
TAC_Measurments_Module_Settings(9).cdata=get(handles.Projected_by_1,'Value');
TAC_Measurments_Module_Settings(10).cdata=get(handles.Projected_by_2,'Value');
TAC_Measurments_Module_Settings(11).cdata=get(handles.Projected_by_3,'Value');
TAC_Measurments_Module_Settings(12).cdata=get(handles.Projected_by_4,'Value'); 
TAC_Measurments_Module_Settings(13).cdata=get(handles.Use_DIC_Option,'Value'); 
TAC_Measurments_Module_Settings(14).cdata=get(handles.Merge_channels,'Value');
TAC_Measurments_Module_Settings(15).cdata=get(handles.track_by,'Value'); 
TAC_Measurments_Module_Settings(16).cdata=get(handles.quantify_by,'Value'); 
TAC_Measurments_Module_Settings(17).cdata=get(handles.rotate_by,'Value'); 
TAC_Measurments_Module_Settings(18).cdata=get(handles.popup_spaces,'Value'); 
TAC_Measurments_Module_Settings(19).cdata=get(handles.popup_seg_ed,'Value'); 
TAC_Measurments_Module_Settings(20).cdata=get(handles.Get_8_option,'Value'); 
TAC_Measurments_Module_Settings(21).cdata=get(handles.plot_list,'userdata');  
 

[filename, pathname, filterindex] = uiputfile({ '*.dat','DAT-files (*.dat)';}, 'save optimal settings'); 
if isequal(filename,0) %$#1
  h = msgbox('User selected Cancel','Aborted');
  return;
end  
 filename=regexprep(filename, 'TAC_Measurments_Module_SET_','');
full_filename= strcat(pathname,'TAC_Measurments_Module_SET_',filename) ;
full_filename=char(full_filename);
save(full_filename, 'TAC_Measurments_Module_Settings') ; 
 pause(1) 
 msgbox('Settings file was saved. Press OK to continue','Saved')
% --------------------------------------------------------------------
function Untitled_03_Callback(hObject, eventdata, handles)
[filename, pathname, filterindex] = uigetfile({ '*.dat','DAT-files (*.dat)';}, 'Please Choose optimal setting file')% handles.directory_name); %pick files to combine
if isequal(filename,0) %$#1
  h = msgbox('User selected Cancel','Aborted');
  return;
end
 
full_filename= strcat(pathname,filename);
full_filename=char(full_filename);
TAC_Measurments_Module_Settings=importdata(full_filename)   
Set_TAC_Measurments_Module_Settings(hObject, eventdata, handles,TAC_Measurments_Module_Settings,handles.data_file) ;
% ------------------------------------------------------------------------
function Set_TAC_Measurments_Module_Settings(hObject, eventdata, handles,TAC_Measurments_Module_Settings,data_file) 
set(handles.plot_list,'value',1,'max',1) 
set(handles.plot_list,'string','')
TAC_Measurments_Module_Settings(1).cdata
set(handles.track_what_1,'Value', TAC_Measurments_Module_Settings(1).cdata ); 
set(handles.track_what_2,'Value', TAC_Measurments_Module_Settings(2).cdata )
set(handles.track_what_3,'Value', TAC_Measurments_Module_Settings(3).cdata ); 
% set(handles.track_what_4,'Value', TAC_Measurments_Module_Settings(4).cdata ); 
 
set(handles.segmentation_type_1,'Value',TAC_Measurments_Module_Settings(5).cdata);
set(handles.segmentation_type_2,'Value',TAC_Measurments_Module_Settings(6).cdata);
set(handles.segmentation_type_3,'Value',TAC_Measurments_Module_Settings(7).cdata);
set(handles.segmentation_type_4,'Value',TAC_Measurments_Module_Settings(8).cdata);
set(handles.Projected_by_1,'Value',TAC_Measurments_Module_Settings(9).cdata);
set(handles.Projected_by_2,'Value',TAC_Measurments_Module_Settings(10).cdata);
set(handles.Projected_by_3,'Value',TAC_Measurments_Module_Settings(11).cdata);
set(handles.Projected_by_4,'Value',TAC_Measurments_Module_Settings(12).cdata);
set(handles.Use_DIC_Option,'Value',TAC_Measurments_Module_Settings(13).cdata); 
 set(handles.Merge_channels,'Value',TAC_Measurments_Module_Settings(14).cdata); 
 set(handles.track_by,'Value',TAC_Measurments_Module_Settings(15).cdata); 
 set(handles.quantify_by,'Value',TAC_Measurments_Module_Settings(16).cdata);  
 set(handles.rotate_by,'Value',TAC_Measurments_Module_Settings(17).cdata); 
 set(handles.popup_spaces,'Value',TAC_Measurments_Module_Settings(18).cdata);  
 set(handles.popup_seg_ed,'Value',TAC_Measurments_Module_Settings(19).cdata);  
 set(handles.Get_8_option,'Value',TAC_Measurments_Module_Settings(20).cdata); 
 Matrix=TAC_Measurments_Module_Settings(21).cdata   ;
  
 iii=1;   
for ii=1:size(Matrix,3)
    vec=Matrix(:,:,ii);
    if  vec(1)~=1  &&  vec(1)~=0 && vec(1)~=0  && vec(1)~=0 
    else
        Index(iii)=ii; iii=iii+1; %#ok<SAGROW>
    end
end
try
 Matrix(:,:,Index)=[];  
end
  Matrix2=[1 1 1] ;
for ii=1:size(Matrix,3)
     vec=Matrix(:,:,ii);
     JJ=0;
     
     for jj=1:size(Matrix,3)
         if  vec(1)== Matrix(1,1,jj) && vec(2)== Matrix(1,2,jj) &&  vec(3)== Matrix(1,3,jj)
         JJ=1;
         end
     end 
     if JJ 
                Matrix2(:,:,end+1)=vec  ; %#ok<SAGROW>
    end
end
 
 iii=1;  
for ii=1:size(Matrix2,3)
    vec=Matrix2(:,:,ii);
    if  vec(1)~=1  &&  vec(1)~=0 && vec(1)~=0  && vec(1)~=0 
    else
        Index(iii)=ii; iii=iii+1; %#ok<SAGROW>
    end
end
try
 Matrix2(:,:,Index)=[];
end 
  
 track_what=get(handles.track_by,'Value') ;
 track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ; 
 set_track(hObject, eventdata, handles,data_file)  
 parental_num_str=get(handles.parental_num,'string'); % parental dividing cells 
 
for ii=1:size(Matrix2, 3) 
    Vec= Matrix2(:,:,ii) ;
     Close(10)
     set(handles.popup1,'Value',1); wait_pause('Updating',10,0.02)
     set(handles.popup1,'Value',1); wait_pause('Updating',10,0.02)
     set(handles.popup1,'Value',1);  wait_pause('Updating',10,0.02)
     set(handles.Div_Cells,'value',1); wait_pause('Updating',10,0.02)
     set(handles.parental_num,'value',1); wait_pause('Updating',10,0.02)
    
    
    set(handles.popup1,'Value',Vec(1)); 
    popup1_Callback(hObject, eventdata, handles);  
    wait_pause('Setting data type',10,0.25)
     
       if Vec(1)==2 
           set(handles.popup2,'Value',Vec(2));
           wait_pause('Updating',10,0.2)
           popup2_Callback(hObject, eventdata, handles); 
          wait_pause('Setting measurment cell list type',10,0.25) 
          set(handles.popup3,'Value',Vec(3)); 
          wait_pause('Updating',10,0.2)
          popup3_Callback(hObject, eventdata, handles);
          Add_to_plotlist_Callback(hObject, eventdata, handles);  
         Div_Cells=get(handles.Div_Cells,'string'); 
         length_Div_Cells=size(Div_Cells,1) ; 
         if  length_Div_Cells >1 %there are more dividing cells in the parental list   
             for iiii=2:length_Div_Cells %apply for all dividing cells
                   Close(10)
                   set(handles.Div_Cells,'value',iiii); Div_Cells_Callback(hObject, eventdata, handles);
                   wait_pause('Updating',10,0.2)
                   set(handles.popup3,'Value',Vec(3))  
                   wait_pause('Updating',10,0.2)
                   popup3_Callback(hObject, eventdata, handles);
                   Add_to_plotlist_Callback(hObject, eventdata, handles); 
             end
         end
       end 
  
    if Vec(1)==3   
       set(handles.popup2,'Value',Vec(2)); wait_pause('Updating',10,0.2)  
       popup2_Callback(hObject, eventdata, handles); 
       wait_pause('Setting measurment population list type',10,0.25)  
       set(handles.popup3,'Value',Vec(3)); wait_pause('Updating',10,0.2) ;popup3_Callback(hObject, eventdata, handles);
       Add_to_plotlist_Callback(hObject, eventdata, handles); 
    end 
   
  if Vec(1)==4 % for dividing cells
     parental_num=get(handles.parental_num,'string');  %apply only if a there is at least ne cell division
      if isnan(str2double(parental_num(1)))~=1 
           set(handles.popup2,'Value',Vec(2));wait_pause('Updating',10,0.2)
           popup2_Callback(hObject, eventdata, handles);    wait_pause('Updating',10,0.2) 
          set(handles.popup3,'Value',Vec(3)); 
          wait_pause('Updating',10,0.2)
          popup3_Callback(hObject, eventdata, handles);
          Add_to_plotlist_Callback(hObject, eventdata, handles); 
          
          length_parental_num=size(parental_num,1);
         
         if length_parental_num>1 %there are more dividing cells in the parental list   
             for iiii=2:length_parental_num %apply for all dividing cells
                   Close(10)
                   set(handles.parental_num,'value',iiii); parental_num_Callback(hObject, eventdata, handles); ;wait_pause('Updating',10,0.2);      
                   set(handles.popup3,'Value',Vec(3));wait_pause('Updating',10,0.2);popup3_Callback(hObject, eventdata, handles);
                   Add_to_plotlist_Callback(hObject, eventdata, handles); 
             end
         end
         
      end
  end
end 
% ------------------------------------------------------------------------------ 
function rotate_by_Callback(~, ~, handles)
rotate_by=get(handles.rotate_by,'Value') ;
rotate_by=eval(strcat('get(handles.track_what_',num2str(rotate_by),',''Value',''' )')) ; 
 if rotate_by==5
   Y=wavread('Error');
   set( handles.rotate_by ,'Value',1)
   h = errordlg('Please choose proper channel to be used for Rotate first','Error');
 return 
end
% ------------------------------------------------------------------------------   
function Green_factor_Callback(hObject, eventdata, handles)
Green_factor=get(handles.Green_factor,'value');
set(handles.Green_factor_edit,'string',num2str(Green_factor))
Raw_listbox_Callback(hObject, eventdata, handles) 
function Red_factor_Callback(hObject, eventdata, handles) 
Red_factor=get(handles.Red_factor,'value');
set(handles.Red_factor_edit,'string',num2str(Red_factor))
Raw_listbox_Callback(hObject, eventdata, handles) 
function Blue_factor_Callback(hObject, eventdata, handles)
  Blue_factor=get(handles.Blue_factor,'value');
set(handles.Blue_factor_edit,'string',num2str(Blue_factor))
Raw_listbox_Callback(hObject, eventdata, handles) 
% -----------------------------
function track_by_Callback(hObject, eventdata, handles)
index= get(handles.track_by,'Value');
if index==1
  track_what_1_Callback(hObject, eventdata, handles)  
  elseif index==2
  track_what_2_Callback(hObject, eventdata, handles)  
elseif index==3
  track_what_3_Callback(hObject, eventdata, handles)  
end 
% ----------------------------- 
 function [all_cells,parental_cells]=TRYME(div_cells,MATRIX) 
 all_cells=cell(size(MATRIX,2)/2,1) ;  
for ii=1:size(MATRIX,2)/2
  all_cells(ii) =cellstr(num2str(ii));
end 
 if isempty(div_cells)~=1  
   for zzz=1:length(div_cells) 
   cell_index=div_cells(zzz) ;
   PD1D2_matrix(zzz,1)=cell_index
   trackdivnum=cell_index ; 
   V=MATRIX(:,cell_index*2-1)  ;
   V=V(find(V, 1 ):find(V, 1, 'last' )); 
 for start_XY=1:size(MATRIX,1)
   if MATRIX(start_XY,cell_index*2-1)>0
  break
   end 
 end 
   end_XY=length(V)+start_XY  
   x=MATRIX(end_XY-1,cell_index*2-1) ;
   y=MATRIX(end_XY-1,cell_index*2) ; 
   sizee=size(MATRIX,2)/2;
   matrix=repmat([1 NaN;NaN 1],1,sizee );
   X=matrix(1,:).*MATRIX(end_XY,:); 
   Y=matrix(2,:).*MATRIX(end_XY,:);
   X(isnan(X))=[]; %take off all nans from X vector
   Y(isnan(Y))=[]; %take off all nans from X vector
   X(X==0)=NaN;
   Y(Y==0)=NaN;
 XY= (X-x).^2+ (Y-y).^2 ;%PITAGORAS
 XY_min_index=find(ismember(XY,(min(XY)))) ; 
 if isempty(X(XY_min_index))~=1 || isempty(Y(XY_min_index))~=1 
   PD1D2_matrix(zzz,2)=XY_min_index 
 end
 XY(XY_min_index)=nan;
 XY_min_index=find(ismember(XY,(min(XY))))
   if isempty(X(XY_min_index))~=1 || isempty(Y(XY_min_index))~=1 
   PD1D2_matrix(zzz,3)=XY_min_index 
   end 
   end 
 %second part:
%  save PD1D2_matrix PD1D2_matrix
%   for zzz=1:size(PD1D2_matrix,1)
%  if isempty(find(ismember(PD1D2_matrix(:,2:3),PD1D2_matrix(zzz,1))))~=1
% C(PD1D2_matrix(zzz,2)) =strcat(C(PD1D2_matrix(zzz,1)) ,'.1')
% C(PD1D2_matrix(zzz,3)) =strcat(C(PD1D2_matrix(zzz,1)) ,'.2')
%  else
%  C(PD1D2_matrix(zzz,2)) =strcat(num2str(PD1D2_matrix(zzz,1)),'.1')
%  C(PD1D2_matrix(zzz,3)) =strcat(num2str(PD1D2_matrix(zzz,1)),'.2')
%  end 
%   end
   for zzz=1:size(PD1D2_matrix,1) 
 if isempty(find(ismember(PD1D2_matrix(:,2:3),PD1D2_matrix(zzz,1)), 1))==1
   all_cells(PD1D2_matrix(zzz,1)) =cellstr(num2str(PD1D2_matrix(zzz,1)));
 end
 all_cells(PD1D2_matrix(zzz,2)) =cellstr(strcat(all_cells(PD1D2_matrix(zzz,1)) ,'.1'));
 all_cells(PD1D2_matrix(zzz,3)) =cellstr(strcat(all_cells(PD1D2_matrix(zzz,1)) ,'.2')) ;
   end
 end  
 
  
 parental_cells=cell(size(div_cells,2),1) ; 
for ii=1:size(div_cells,2)
 parental_cells(ii)=all_cells(div_cells(ii));
end
% -----------------------
function Projected_by_1_Callback(hObject, eventdata, handles)
 Raw_listbox_Callback(hObject, eventdata, handles) ; 
function Projected_by_2_Callback(hObject, eventdata, handles)
 Raw_listbox_Callback(hObject, eventdata, handles) ; 
function Projected_by_3_Callback(hObject, eventdata, handles)
 Raw_listbox_Callback(hObject, eventdata, handles) ;  
function Projected_by_4_Callback(hObject, eventdata, handles)
 Raw_listbox_Callback(hObject, eventdata, handles) ; 
function Div_Cells_Callback(hObject, eventdata, handles)
Div_Cells_val= get(handles.Div_Cells,'Value') ;
Div_Cells_str= get(handles.Div_Cells,'string') ; 
cell_index= Div_Cells_str(Div_Cells_val);
 
 track_what=get(handles.track_by,'Value') ;
 track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ; 
 MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;  
V=MATRIX(:,Div_Cells_val*2-1)   ;
V=V(find(V, 1 ):find(V, 1, 'last' )) ; 
 for start_XY=1:size(MATRIX,1)
   if MATRIX(start_XY,Div_Cells_val*2 -1)>0
  break
   end 
 end 
 
% end_XY=length(V)+start_XY  
 set(handles.Raw_listbox,'Value',+start_XY)  
 Raw_listbox_Callback(hObject, eventdata, handles) 

% -----------------------------
%  cellnum=cell_index;
 n2=get(handles.popup2,'value');
 popup2_str=cell(13,1);
 popup2_str(1)= cellstr('Select:' ); 
 
  %Type 1:
  popup2_str(2)=cellstr(strcat('Cell- ',cell_index,'--',' Movie' ));  
  popup2_str(3)=cellstr(strcat('Cell- ',cell_index,'--',' Montage' )); 
  popup2_str(4)=cellstr(strcat('Cell- ',cell_index,'--',' Shell Projection' )); 
  popup2_str(5)=cellstr(strcat('Cell- ',cell_index,'--',' 2D Projection' )); 
  popup2_str(6)=cellstr(strcat('Cell- ',cell_index,'--',' 3D Projection' )); 
  popup2_str(7)=cellstr(strcat('Cell- ',cell_index,'--',' Edge' )); 
  popup2_str(8)=cellstr(strcat('Cell- ',cell_index,'--',' Montage_watershed' )); 
  popup2_str(9)=cellstr(strcat('Cell- ',cell_index,'--',' Montage_distance_transform' )); 
  popup2_str(10)=cellstr(strcat('Cell- ',cell_index,'--',' Projection_watershed' )); 
 
   %Type 2: 
   popup2_str(11)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Intensity' )); 
  popup2_str(12)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Area' ));  
  popup2_str(13)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_I_per_A' )); 
  popup2_str(14)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Eccentricity' )); 
  popup2_str(15)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Orientation' )); 
  popup2_str(16)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_EquivDiameter' ));  
  popup2_str(17)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Circularity' )); 
  popup2_str(18)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Ellipticity' )); 
  popup2_str(19)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Polarisation' )); 
  popup2_str(20)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Extent' ));  
  
 popup2_str(21)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Perimeter' )); 
  popup2_str(22)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Solidity' ));  
  popup2_str(23)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_graycoprops_Contrast' )); 
  popup2_str(24)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_graycoprops_Correlation' )); 
  popup2_str(25)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_graycoprops_Energy' )); 
  popup2_str(26)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_graycoprops_Homogeneity' ));  
  popup2_str(27)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_std2' )); 
  popup2_str(28)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_number_of_peaks_X' )); 
  popup2_str(29)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_number_of_peaks_Y' )); 
  popup2_str(30)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_number_of_disks' ));   
  
 %Type 3:
 popup2_str(31)=cellstr(strcat('Cell- ',cell_index,'--',' Velocity' ));  
 popup2_str(32)=cellstr(strcat('Cell- ',cell_index,'--',' MSD' ));  
 popup2_str(33)=cellstr(strcat('Cell- ',cell_index,'--',' Trajectories' ));   
 popup2_str(34)=cellstr(strcat('Cell- ',cell_index,'--',' Proximity_vector' ));  
 popup2_str(35)=cellstr(strcat('Cell- ',cell_index,'--',' Maximum_pixel' ));  
 popup2_str(36)=cellstr(strcat('Cell- ',cell_index,'--',' Angle between MaxP and proximity' ));   
 popup2_str(37)=cellstr(strcat('Cell- ',cell_index,'--',' distance_from_origion' ));  
 popup2_str(38)=cellstr(strcat('Cell- ',cell_index,'--',' brightest_Pixel_X' ));  
 popup2_str(39)=cellstr(strcat('Cell- ',cell_index,'--',' brightest_Pixel_Y' ));   
 popup2_str(40)=cellstr(strcat('Cell- ',cell_index,'--',' turnng_angle' ));   
 
 
 
 
    
 
 
 
% popup2_str(16)=cellstr(strcat('Cell- ',num2str(cellnum),'--','Add_function_004a' )); 
 set(handles.popup2,'value', 1);
 set(handles.popup2,'string', popup2_str); 
 str=get(handles.popup1,'string');
 n=get(handles.popup1,'value');
   
 if n==1
   return
 end 
 set(handles.popup2,'value',n2);
 str=str(n); 
 set(handles.plot_edit,'string', str); 
 
 str=get(handles.popup2,'string');
 n=get(handles.popup2,'value');
 if n==1
   return
 end 
 str_2=str(n); 
 
 str=get(handles.popup3,'string');
 n=get(handles.popup3,'value');
 if n==1
   return
 end 
 str_3=str(n);   
 str=strcat(str_2, ' - ',str_3);
 set(handles.plot_edit,'string', str); 
%  -------
function axes1_ButtonDownFcn(hObject, ~, handles)
sel_typ = get(gcbf,'SelectionType') ;
if strcmp(sel_typ,'extend')==1
   track_what=get(handles.track_by,'Value') ; 
 n= get(handles.Raw_listbox,'value');
  point1 = get(hObject,'CurrentPoint') ; 
% ========================
 
% if get(handles.MODE,'value')==1  
% end
%  if get(handles.MODE,'value')==2  
% end
end
% =======================
% ======================= 
 if strcmp(sel_typ,'alt')==1  
 point1 = get(hObject,'CurrentPoint') ;
 fig = gcf;
 box_Raw=get(handles.Raw_listbox,'string') ; 
  if iscell(box_Raw)==0 
 Y=wavread('Error');
 h = errordlg('No files in Raw Frame listbox','Error');
 return
  end 
 n=round(get(handles.Raw_listbox,'Value'));
   if n>1 
 set(handles.Raw_listbox,'value',n-1);
 show_frame( handles,n-1) ; 
   end 
 end 
% ========================
if strcmp(sel_typ,'normal')==1 
   point1 = get(hObject,'CurrentPoint') ;
   fig = gcf;
   box_Raw=get(handles.Raw_listbox,'string') ; 
  if iscell(box_Raw)==0 
 Y=wavread('Error');
 h = errordlg('No files in Raw Frame listbox','Error');
 return
  end 
   n=round(get(handles.Raw_listbox,'Value')) ;
 if n<size(box_Raw,1) 
   set(handles.Raw_listbox,'value',n+1);
   show_frame( handles,n+1) ; 
 end 
end

% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(~, eventdata, handles) 
   if  toc<0.05  
            return
   end 
tic
box_Raw=get(handles.Raw_listbox,'string') ;  
n=round(get(handles.Raw_listbox,'Value')) ;
 N=n+eventdata.VerticalScrollCount;
 if N<1 ||  N>size(box_Raw,1)
     return
 end  
 
 point  = get(gcf,'CurrentPoint')   ;
 xy1  =get(handles.Raw_listbox, 'Position');   %loc =get([handles.coordinates,handles.coordinates2...], 'Position');   
     if (xy1(1)<point(1,1) && xy1(2)<point(1,2) && point(1,1)<(xy1(1)+xy1(3)) && point(1,2)<(xy1(2)+xy1(4)))  
         return
     end 
 set(handles.Raw_listbox,'value',N);   
 if eventdata.VerticalScrollCount==1 
 set(handles.forward_button,'Visible','on')
 set(handles.backward_button,'Visible','off')
 elseif eventdata.VerticalScrollCount==-1 
 set(handles.forward_button,'Visible','off')
 set(handles.backward_button,'Visible','on')
 end
  
  set(handles.slider20, 'Minimum',1, 'Maximum',size(box_Raw,1), 'Value',N) 
  set(handles.showcurrentframe,'String',num2str(N)); 
  show_frame( handles,N)    
function figure1_WindowButtonMotionFcn(~, ~, handles)
point = get(gcf,'CurrentPoint')  ;
 xy1 =get(handles.axes1, 'Position') ; %loc =get([handles.coordinates,handles.coordinates2...], 'Position');  
   if xy1(1)<point(1,1) && xy1(2)<point(1,2) && point(1,1)<(xy1(1)+xy1(3)) && point(1,2)<(xy1(2)+xy1(4)) 
  set(gcf,'Pointer','arrow')
   else 
   set(gcf,'Pointer','hand') 
   end  
function slider20_Callback(hObject, ~,handles)  
if  toc<0.1
    return
end  
tic   
n=round(get(hObject,'Value'));
show_frame( handles,n)  
m=str2num(get(handles.showcurrentframe,'string')) ;
set(handles.Raw_listbox,'Value',n)
if m>n
    set(handles.backward_button,'Visible','on')
    set(handles.forward_button,'Visible','off')
elseif n>m
      set(handles.forward_button,'Visible','on')
      set(handles.backward_button,'Visible','off')
else
    set(handles.forward_button,'Visible','off')
      set(handles.backward_button,'Visible','off')
end
 set(handles.showcurrentframe,'String',num2str(n)); 
  
function maximum_pixel_Callback(hObject, eventdata, handles) 
 Raw_listbox_Callback(hObject, eventdata, handles)  
function Show_proximity_vector_Callback(hObject, eventdata, handles) 
 Raw_listbox_Callback(hObject, eventdata, handles)  
function sliderframes2_Callback(hObject, ~, ~) 
   try
 if isnumeric(hObject), return; end % only process handle.listener events
 handles = guidata(hObject);
 inCallback = getappdata(hObject,'inCallback');
 if isempty(inCallback)
   setappdata(hObject,'inCallback',1);
 else
   return; % prevent re-entry...
 end
 
 %box_Raw=get(handles.Raw_listbox,'string');
 n=round(get(hObject,'value')) 
 
 if (n~=1 && n<8) 
   set(handles.Projected_by_1,'min',1,'max',10,'value',n)
   set(handles.Projected_by_2,'min',1,'max',10,'value',n)
   set(handles.Projected_by_3,'min',1,'max',10,'value',n)
   set(handles.Projected_by_4,'min',1,'max',10,'value',n) 
 show_frame( handles,get(handles.Raw_listbox,'Value')) ; 
 end
 
 % set(handles.sliderframes,'Max',size( box_Raw,1));
 % set(handles.Raw_listbox,'Min',1);
 % set(handles.Raw_listbox,'Value',n);
 % show_frame( handles,n);
  catch
 % never mind
 a=1; %debug point
  end
  setappdata(hObject,'inCallback',[]);
 
function sliderframes2_CreateFcn(hObject, ~, handles)
  hListener = handle.listener(hObject,'ActionEvent',{@sliderframes2_Callback,handles});
  setappdata(hObject,'listener__',hListener);  
 
% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
 Load_exp_Callback(hObject, eventdata, handles)   
function uipushtool6_ClickedCallback(~, ~, ~) 
% --------------------------------------------------------------------
function uipushtool8_ClickedCallback(hObject, eventdata, handles) 
 edit_axes1_Callback(hObject, eventdata, handles)  
% --------------------------------------------------------------------
function uipushtool16_ClickedCallback(~, ~, handles)
axes(handles.axes1)
axis tight 
 function show_frame(handles,n,MODE)   
 data_file=get(handles.figure1,'userdata');
 for ii=1:4%support up to 4 channels 
    Track_What(ii)=eval(strcat('get(handles.track_what_',num2str(ii),',''Value',''' )')) ; 
    show_tracks(ii)= eval(strcat('get(handles.show_tracks_',num2str(ii),',''Value',''' )')) ;
    show_marks(ii)= eval(strcat('get(handles.show_marks_',num2str(ii),',''Value',''' )')) ;  
 end 
 
 %%%%%%%%% 
if get(handles.stack_merged,'value')
try 
     global merged_stack
     matrix_out= merged_stack(n).cdata; 
end
else 
matrix_out=[]; 
box_Raw=get(handles.Raw_listbox,'string') ; 
filename=box_Raw(n) ;   set(handles.edit_axes1,'String',filename);
pathname= data_file(2).cdata; 
Projected_by_Str={'By max',  'By mean', 'z1', 'z2', 'z3', 'z4', 'z5', 'z6', 'z7', 'z7' , 'z9',  'z10'} ;   
Index=find(Track_What~=5)  ;
if length(Index)==1 
 segmentation_type =eval(strcat('get(handles.segmentation_type_',num2str(Index),',''Value',''' )'));  
 Projected_by_Value=eval(strcat('get(handles.Projected_by_',num2str(Index),',''Value',''' )'))    ;
 Projected_by = (Projected_by_Str(Projected_by_Value)) ; 
 matrix_out  =  read_image3(pathname,filename,Track_What(Index),segmentation_type(Index), Projected_by)  ;
else
    
Nbits=data_file(9).cdata ;
Xdim=data_file(6).cdata(4) ;
Ydim=data_file(6).cdata(3) ;
 
  for ii=1:4%support up to 4 channels  
 segmentation_type(ii)=eval(strcat('get(handles.segmentation_type_',num2str(ii),',''Value',''' )')); 
 Projected_by_Value=eval(strcat('get(handles.Projected_by_',num2str(ii),',''Value',''' )'))    ;
 Projected_by(ii)= (Projected_by_Str(Projected_by_Value)) ;
  end  
 
 Blue_factor=get(handles.Blue_factor,'value') ;
 Green_factor=get(handles.Green_factor,'value') ;
 Red_factor=get(handles.Red_factor,'value')  ; 
 DIC_temp=[]  ; Red=[]; Green=[]; Blue=[]; 
 if  Track_What(1)<5
 str_1=data_file(3).cdata( Track_What(1),1) ; 
 if char(str_1)~='0' && char(str_1)~='1' %  'first channel is active, and not DIC' 
  if char(str_1)=='2'  
 Blue = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Blue_factor);  
  elseif char(str_1)=='3' 
  Green = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Green_factor);    
 elseif char(str_1)=='4' 
  Green = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Green_factor);    
   elseif char(str_1)=='5' 
  Red = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Red_factor);    
   elseif char(str_1)=='6' 
Red = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Red_factor);   
  end 
 end 
 end 
 
  if Track_What(2)<5
 str_2=data_file(3).cdata( Track_What(2),1) ;
 if char(str_2)~='0' && char(str_2)~='1' %  'first channel is active, and not DIC' 
  if char(str_2)=='2'  
 Blue = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Blue_factor);  
  elseif char(str_2)=='3' 
  Green = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Green_factor);  
 elseif char(str_2)=='4' 
    Green = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Green_factor); 
   elseif char(str_2)=='5' 
   Red = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Red_factor);
   elseif char(str_2)=='6' 
    Red = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Red_factor);
  end
 end
  end 
 
  if Track_What(3)<5   
 str_3=data_file(3).cdata( Track_What(3),1) ;
 if char(str_3)~='0' && char(str_3)~='1'  
  if char(str_3)=='2'  
  Blue = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Blue_factor);   
  elseif char(str_3)=='3' 
  Green = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Green_factor);   
 elseif char(str_3)=='4' 
   Green = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Green_factor);   
   elseif char(str_3)=='5' 
  Red = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Red_factor);   
   elseif char(str_3)=='6' 
     Red = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Red_factor);   
  end 
 end 
  end 
 
 if Nbits==8   
   if isempty(Red)
       Red=uint8(zeros(Xdim,Ydim,1)); 
   else 
     Red=uint8((Red./(max(max(Red))))*255);
   end
  if isempty(Green)
       Green=uint8(zeros(Xdim,Ydim,1)); 
  else
       Green=uint8((Green./(max(max(Green))))*255) ;
  end
    if isempty(Blue)
       Blue=uint8(zeros(Xdim,Ydim,1)); 
    else
         Blue=uint8((Blue./(max(max(Blue))))*255);
    end 
 elseif  Nbits==16  
   if isempty(Red)
       Red=uint16(zeros(Xdim,Ydim,1)); 
   else 
     Red=uint16((Red./(max(max(Red))))*65535);
   end
  if isempty(Green)
       Green=uint16(zeros(Xdim,Ydim,1)); 
  else
       Green=uint16((Green./(max(max(Green))))*65535) ;
  end
    if isempty(Blue)
       Blue=uint16(zeros(Xdim,Ydim,1)); 
    else
         Blue=uint16((Blue./(max(max(Blue))))*65535);
    end 
 elseif  Nbits==32   
   if isempty(Red)
       Red=uint32(zeros(Xdim,Ydim,1)); 
   else 
     Red=uint32((Red./(max(max(Red))))*2^32);
   end
  if isempty(Green)
       Green=uint32(zeros(Xdim,Ydim,1)); 
  else
       Green=uint32((Green./(max(max(Green))))*2^32) ;
  end
    if isempty(Blue)
       Blue=uint32(zeros(Xdim,Ydim,1)); 
    else
         Blue=uint32((Blue./(max(max(Blue))))*2^32);
    end 
 end
 if Track_What(4)<5   
   str_4=data_file(3).cdata( Track_What(4),1)   ;
  Use_DIC_Option= get( handles.Use_DIC_Option ,'Value');
  
     if char(str_4)=='1' && Use_DIC_Option==1
          matrix_temp = double(read_image3(pathname,filename,Track_What(4),segmentation_type(4), Projected_by(4)));   
     if Nbits==8     
            I= uint8(~(Green./Green+Red./Red+Blue./Blue)).*uint8(( matrix_temp./(max(max( matrix_temp))))*255); 
        elseif Nbits==16  
            I= uint16(~(Green./Green+Red./Red+Blue./Blue)).*uint16(( matrix_temp./(max(max( matrix_temp))))*65535);   
        elseif Nbits==32  
            I= uint32(~(Green./Green+Red./Red+Blue./Blue)).*uint32(( matrix_temp./(max(max( matrix_temp))))*2^32);    
     end
   try
    matrix_out = cat(3, Red+I , Green+I, Blue+I ); 
   end 
   end 
 
 else  
    matrix_out = cat(3, Red , Green , Blue );  
 end
end
 end 
div_cells=[]; 
 
if nargin==3
 if strcmp(MODE,'figure')  
  framePos = getpixelposition(handles.axes1) 
  framePos(2)= framePos(2)*1.4;
  framePos(4)=framePos(4)*0.95;
  h=figure('color','w','units','pixels','position', framePos,'numbertitle','off', 'name',char(filename),'colormap',handles.c) ;  
  set(gca,'Ydir','reverse',  'units','normalize', 'Position',[0.05 0.05 1 1]) 
  xlabel('X','FontSize',12,'Color',[1 1 0]);
  ylabel('Y','FontSize',12,'Color',[1 1 0]); 
  filename=char(filename);
  title(filename) ;
  imagesc(matrix_out, 'Hittest','Off') ;  
  set(h,'userdata',matrix_out)
  index=1
 YLim=get(handles.axes1,'YLim') 
 set(get(h,'children'),'ylim',YLim);
 XLim=get(handles.axes1,'XLim') 
 set(get(h,'children'),'xlim',XLim);
 
  end
else 
axes(handles.axes1);
cla(handles.axes1);  
imagesc(matrix_out, 'Hittest','Off') ;  
end
hold on 
xy_border=data_file(6).cdata; 
rectangle('Position', xy_border,'LineWidth',5,'LineStyle','--','EdgeColor','m', 'Hittest','Off'); 
for track_what_index=1:3 %support up to 4 channels
    track_what=Track_What(track_what_index);
    if  findstr(char(data_file(7).cdata(track_what,2)),'Y')==1   
        str =data_file(3).cdata( track_what ,1) ;  
        centy = data_file(4).cdata.Centroids(track_what ).cdata(n).cdata; 
       if isempty(centy )~=1  
          for ii=1:size(data_file(4).cdata.L(track_what ).cdata(n).cdata,1) 
            if isempty(data_file(4).cdata.L(track_what ).cdata(n).cdata)~=1
              XY= data_file(4).cdata.L(track_what ).cdata(n).cdata(ii).BoundingBox ;
               if XY(1)>xy_border(1) && XY(2)>xy_border(2) && (xy_border(1)+xy_border(3))>(XY(1)+XY(3)) && (xy_border(1)+xy_border(4))>(XY(2)+XY(4)) && show_marks(track_what_index)==1
                if track_what_index==1
                 rectangle('Position', XY,'LineWidth',1 ,'EdgeColor','w', 'Hittest','Off'); %keep this one 
                end
                 if track_what_index==2
                  rectangle('Position', XY,'LineWidth',1 ,'EdgeColor','y', 'Hittest','Off'); %keep this one 
                 end
                 if track_what_index==3
                    rectangle('Position', XY,'LineWidth',1 ,'EdgeColor','m', 'Hittest','Off'); %keep this one 
                 end
               end 
             if get(handles.maximum_pixel,'value')==1
                plot(centy(ii,1),centy(ii,2),'m.', 'MarkerSize',20, 'Hittest','Off');
                % h_axes4_plot=plot(vec1(:,1),vec1(:,2),'m.', 'MarkerSize',30, 'Hittest','Off');  
                centroid=round(data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Centroid) ;
                vec1= round(data_file(4).cdata.L(track_what).cdata(n).cdata(ii).BrightestP_Ch_3) ; 
                for jjj=1:size(vec1,1) 
                   plot([centroid(jjj,1) vec1(jjj,1)], [ centroid(jjj,2) vec1(jjj,2)] ,'linewidth',2,'color',[1 0 0], 'Hittest','Off'); 
                end 
             end  
            if get(handles.Show_proximity_vector,'value')==1
                 vec = round(data_file(4).cdata.L(track_what).cdata(n).cdata(ii).Proximity_Ch_1)  ;
              if size(vec,2)>1
                 for jjj=1:size(vec ,1) 
                 startpoint= [vec(jjj,2) vec(jjj,1)];
                 x1= [vec(jjj,4) vec(jjj,3)]; 
                v1 = 0.2*(startpoint-x1) ; 
                theta = 22.5*pi/180 ;
                 x2 = x1 + v1* [cos(theta) -sin(theta) ; sin(theta) cos(theta)];
                 x3 = x1 + v1*[cos(theta) sin(theta) ; -sin(theta) cos(theta)] ; 
                 fill([x1(1) x2(1) x3(1)],[x1(2) x2(2) x3(2)],'y', 'Hittest','Off');   % this fills the arrowhead (black) 
                 plot([vec(jjj,4) vec(jjj,2)], [vec(jjj,3) vec(jjj,1)] ,'linewidth',2,'color','y', 'Hittest','Off');  
                 end
              end
            end
            end
          end
  if show_marks(track_what_index)==1  %cell divisions
   index_local=find(ismember(centy(:,3),n+0.1)); 
   index_local2 = find(ismember(centy(:,3),n+0.2)); 
            
              
 if track_what_index==1
   plot(centy(index_local,1),centy(index_local,2), 'wx','MarkerSize',30,'Hittest','Off') ; 
   plot(centy(index_local2,1),centy(index_local2,2), 'w+','MarkerSize',30,'linewidth',3,'Hittest','Off') ; 
   
 end 
 if track_what_index==2
   plot(centy(index_local,1),centy(index_local,2), 'yx','MarkerSize',30,'Hittest','Off')  
      plot(centy(index_local,1),centy(index_local,2), 'y+','MarkerSize',30,'linewidth',3,'Hittest','Off') 
 end 
  if track_what_index==3
   plot(centy(index_local,1),centy(index_local,2), 'mx','MarkerSize',30,'Hittest','Off')
    plot(centy(index_local,1),centy(index_local,2), 'm+','MarkerSize',30,'linewidth',2,'Hittest','Off')
  end 
  
   
 end 
 
  
   if  findstr(char(data_file(7).cdata(track_what,1)),'Y')==1
 MATRIX = data_file(5).cdata.Tracks(track_what ).cdata;  
 div_cells_Vec=get(handles.Div_Cells,'string');  
 sizee=size(MATRIX,2)/2;
 matrix=repmat([1 NaN;NaN 1],1,sizee );
 X=matrix(1,:).*MATRIX(n,:);
 Y=matrix(2,:).*MATRIX(n,:);
 X(isnan(X))=[]; %take off all nans from X vector
 Y(isnan(Y))=[]; %take off all nans from Y vector 
 x=find((X>0)) ; 
  xx=x*2-1;
  xxx=xx+1; 
 if show_tracks(track_what_index)==1  
 for ii=1:length(xx)  
 X2=MATRIX(:,xx(ii)); Y2=MATRIX(:,xxx(ii)); 
 X2=X2(X2>0); Y2=Y2(Y2>0);  
   C=eval(strcat('get(handles.show_tracks_',num2str(track_what_index),',''','userdata''',')'));  
  
%  scatter(X2,Y2 , (1:length(X2))./5 ,'filled' ,'MarkerFaceColor' ,C(x(ii),:) ,'Hittest','Off' );   
try
    plot(X2,Y2, '.-', 'color', C(x(ii),:), 'Hittest','Off');
end
 end
 
 String = repmat({[char(data_file(3).cdata(track_what,2)) '-']},sizee,1) ;
 if ~isempty(div_cells_Vec)
   String = strcat(String,div_cells_Vec) ;
 else
   String = strcat(String,arrayfun(@num2str,1:sizee,'un',0)') ;
 end
   if track_what_index==1 
  text(X(X>0)-10, Y(X>0)+20, String(X>0) , 'FontSize',10, 'Color','w', 'Hittest','Off');   
   end  
 if track_what_index==2 
  text(X(X>0)-10, Y(X>0)+20, String(X>0), 'FontSize',10, 'Color','y', 'Hittest','Off');   
 end 
   if track_what_index==3 
  text(X(X>0)-10, Y(X>0)+20, String(X>0), 'FontSize',10, 'Color','m', 'Hittest','Off');   
   end 
 end
   end 
       end 
    end 
end
  
 
 

function stack_merged_Callback(hObject, ~, handles)
if get(hObject,'value') 
box_Raw=get(handles.Raw_listbox,'string')   ;
data_file=get(handles.figure1,'userdata'); 
pathname= data_file(2).cdata; 
Projected_by_Str={'By max',  'By mean', 'z1', 'z2', 'z3', 'z4', 'z5', 'z6', 'z7', 'z7' , 'z9',  'z10'} ;  
 for ii=1:4%support up to 4 channels 
  Track_What(ii)=eval(strcat('get(handles.track_what_',num2str(ii),',''Value',''' )')) ;  
  segmentation_type(ii)=eval(strcat('get(handles.segmentation_type_',num2str(ii),',''Value',''' )')); 
  Projected_by_Value=eval(strcat('get(handles.Projected_by_',num2str(ii),',''Value',''' )'))    ;
  Projected_by(ii)= (Projected_by_Str(Projected_by_Value)) ;
 end 
  
    
Nbits=data_file(9).cdata ;
Xdim=data_file(6).cdata(4) ;
Ydim=data_file(6).cdata(3) ;
 
 
 
 Blue_factor=get(handles.Blue_factor,'value') ;
 Green_factor=get(handles.Green_factor,'value') ;
 Red_factor=get(handles.Red_factor,'value')  ; 

 
      h=waitbar(0,'reading stack file ....');
      set(h,'color','w');   
      N=size(box_Raw,1)   
   for ii=1:N
       waitbar(ii/N) 
       filename=box_Raw(ii) ; 
      DIC_temp=[]  ; Red=[]; Green=[]; Blue=[]; 
      if  Track_What(1)<5
        str_1=data_file(3).cdata( Track_What(1),1) ; 
        if char(str_1)~='0' && char(str_1)~='1' %  'first channel is active, and not DIC' 
          if char(str_1)=='2'  
             Blue = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Blue_factor);  
         elseif char(str_1)=='3' 
            Green = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Green_factor);    
         elseif char(str_1)=='4' 
           Green = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Green_factor);    
        elseif char(str_1)=='5' 
            Red = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Red_factor);    
        elseif char(str_1)=='6' 
            Red = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Red_factor);   
          end 
        end 
      end  
 if Track_What(2)<5
    str_2=data_file(3).cdata( Track_What(2),1) ;
   if char(str_2)~='0' && char(str_2)~='1' %  'first channel is active, and not DIC' 
    if char(str_2)=='2'  
     Blue = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Blue_factor);  
     elseif char(str_2)=='3' 
     Green = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Green_factor);  
      elseif char(str_2)=='4' 
    Green = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Green_factor); 
      elseif char(str_2)=='5' 
    Red = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Red_factor);
    elseif char(str_2)=='6' 
    Red = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Red_factor);
    end 
   end
 end 
  if Track_What(3)<5   
     str_3=data_file(3).cdata( Track_What(3),1) ;
    if char(str_3)~='0' && char(str_3)~='1'  
     if char(str_3)=='2'  
     Blue = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Blue_factor);   
     elseif char(str_3)=='3' 
     Green = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Green_factor);   
     elseif char(str_3)=='4' 
      Green = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Green_factor);   
      elseif char(str_3)=='5' 
        Red = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Red_factor);   
      elseif char(str_3)=='6' 
     Red = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Red_factor);   
     end 
   end 
  end  
 if Nbits==8   
   if isempty(Red)
       Red=uint8(zeros(Xdim,Ydim,1)); 
   else 
     Red=uint8((Red./(max(max(Red))))*255);
   end
  if isempty(Green)
       Green=uint8(zeros(Xdim,Ydim,1)); 
  else
       Green=uint8((Green./(max(max(Green))))*255) ;
  end
    if isempty(Blue)
       Blue=uint8(zeros(Xdim,Ydim,1)); 
    else
         Blue=uint8((Blue./(max(max(Blue))))*255);
    end 
 elseif  Nbits==16  
   if isempty(Red)
       Red=uint16(zeros(Xdim,Ydim,1)); 
   else 
     Red=uint16((Red./(max(max(Red))))*65535);
   end
  if isempty(Green)
       Green=uint16(zeros(Xdim,Ydim,1)); 
  else
       Green=uint16((Green./(max(max(Green))))*65535) ;
  end
    if isempty(Blue)
       Blue=uint16(zeros(Xdim,Ydim,1)); 
    else
         Blue=uint16((Blue./(max(max(Blue))))*65535);
    end 
 elseif  Nbits==32   
   if isempty(Red)
       Red=uint32(zeros(Xdim,Ydim,1)); 
   else 
     Red=uint32((Red./(max(max(Red))))*2^32);
   end
  if isempty(Green)
       Green=uint32(zeros(Xdim,Ydim,1)); 
  else
       Green=uint32((Green./(max(max(Green))))*2^32) ;
  end
    if isempty(Blue)
       Blue=uint32(zeros(Xdim,Ydim,1)); 
    else
         Blue=uint32((Blue./(max(max(Blue))))*2^32);
    end 
 end
 if Track_What(4)<5   
   str_4=data_file(3).cdata( Track_What(4),1)   ;
  Use_DIC_Option= get( handles.Use_DIC_Option ,'Value');
     if char(str_4)=='1' && Use_DIC_Option==1
          matrix_temp = double(read_image3(pathname,filename,Track_What(4),segmentation_type(4), Projected_by(4)));   
     if Nbits==8     
            I= uint8(~(Green./Green+Red./Red+Blue./Blue)).*uint8(( matrix_temp./(max(max( matrix_temp))))*255); 
        elseif Nbits==16  
            I= uint16(~(Green./Green+Red./Red+Blue./Blue)).*uint16(( matrix_temp./(max(max( matrix_temp))))*65535);   
        elseif Nbits==32  
            I= uint32(~(Green./Green+Red./Red+Blue./Blue)).*uint32(( matrix_temp./(max(max( matrix_temp))))*2^32);    
     end
  try  
   Stack(ii).cdata = cat(3, Red+I , Green+I, Blue+I ); 
   end 
   end  
 else  
    Stack(ii).cdata  = cat(3, Red , Green , Blue );  
 end
   end 
else wait_pause('Updating',10,0.1); 
      Stack=[]; 
      
end
global merged_stack
merged_stack=Stack;
close(h) 
function stack_1_Callback(hObject, eventdata, handles) 
read_stack(hObject, eventdata, handles,1,get(hObject,'value') )    
function stack_2_Callback(hObject, eventdata, handles)
read_stack(Object, eventdata, handles,2,get(hObject,'value') )     
function stack_3_Callback(hObject, eventdata, handles)
read_stack(Object, eventdata, handles,3,get(hObject,'value') )  
function stack_4_Callback(hObject, eventdata, handles)
read_stack(Object, eventdata, handles,4,get(hObject,'value') )  
 
function read_stack(hObject, ~, handles,I, Val) 
box_Raw=get(handles.Raw_listbox,'string')   ;
data_file=get(handles.figure1,'userdata'); 
track_what =eval(strcat('get(handles.track_what_',num2str(I),',''Value',''' )')) ;
pathname= data_file(2).cdata; 
Projected_by_Str={'By max',  'By mean', 'z1', 'z2', 'z3', 'z4', 'z5', 'z6', 'z7', 'z7' , 'z9',  'z10'} ;  
seg =eval(strcat('get(handles.segmentation_type_',num2str(I),',''Value',''' )'));  
 if Val
      h=waitbar(0,'reading stack file ....');
      set(h,'color','w');  
      Projected_by_Value=eval(strcat('get(handles.Projected_by_',num2str(I),',''Value',''' )'))    ;
      Projected_by = (Projected_by_Str(Projected_by_Value)) ;
      N=size(box_Raw,1)  
   if seg==3 
   for ii=1:N
      waitbar(ii/N) 
     filename=box_Raw(ii) ;
eval(strcat('stack(',num2str(3),').cdata(',num2str(ii),').cdata= read_image3(pathname,filename,track_what,',num2str(3),', Projected_by);')) 
   end
 eval(strcat('handles.stack',num2str(I),'=stack;'))  
   else
    for ii=1:N
      waitbar(ii/N) 
      filename=box_Raw(ii) ; 
eval(strcat('stack(',num2str(seg),').cdata(',num2str(ii),').cdata= read_image3(pathname,filename,track_what,',num2str(seg),', Projected_by);'))
eval(strcat('stack(',num2str(3),').cdata(',num2str(ii),').cdata= read_image3(pathname,filename,track_what,',num2str(3),', Projected_by);'))
    end
eval(strcat('handles.stack',num2str(I),'=stack;'))
   end
 else
      h=waitbar(0,'delete stack file ....');
      set(h,'color','w');  
     eval(strcat('handles.stack',num2str(I),'=[];'))
 end 
 guidata(hObject, handles);    ;wait_pause('Updating',10,0.1);
 close(h)
% --------------------------------------------------------------------
function Untitled_17_Callback(~, ~, ~)
% hObject    handle to Untitled_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   global merged_stack
      
for ii=1:100
    figure(1)
    imagesc( merged_stack(ii).cdata) 
end
function  matrix_out=Merged_image(n,handles)  
data_file=handles.data_file;
 for ii=1:4%support up to 4 channels 
    Track_What(ii)=eval(strcat('get(handles.track_what_',num2str(ii),',''Value',''' )')) ; 
    show_tracks(ii)= eval(strcat('get(handles.show_tracks_',num2str(ii),',''Value',''' )')) ;
    show_marks(ii)= eval(strcat('get(handles.show_marks_',num2str(ii),',''Value',''' )')) ;  
 end  
try
     global merged_stack
     matrix_out= merged_stack(n).cdata; 
catch
matrix_out=[]; 
box_Raw=get(handles.Raw_listbox,'string') ; 
filename=box_Raw(n) ; 
pathname= data_file(2).cdata; 
Projected_by_Str={'By max',  'By mean', 'z1', 'z2', 'z3', 'z4', 'z5', 'z6', 'z7', 'z7' , 'z9',  'z10'} ;  


Index=find(Track_What~=5) ; 
if length(Index)==1 
 
 segmentation_type =eval(strcat('get(handles.segmentation_type_',num2str(Index),',''Value',''' )'));  
 
 try
  eval(strcat('matrix_out  = handles.stack',num2str(Index),'(',num2str(segmentation_type),').cdata;'))
 catch
   Projected_by_Value=eval(strcat('get(handles.Projected_by_',num2str(Index),',''Value',''' )'))    ;
   Projected_by = (Projected_by_Str(Projected_by_Value)) ; 
   matrix_out  =  read_image3(pathname,filename,Track_What(Index),segmentation_type(Index), Projected_by)  ; 
 end
    
else
    
Nbits=data_file(9).cdata ;
Xdim=data_file(6).cdata(4) ;
Ydim=data_file(6).cdata(3) ;
 
  for ii=1:4%support up to 4 channels  
 segmentation_type(ii)=eval(strcat('get(handles.segmentation_type_',num2str(ii),',''Value',''' )')); 
 Projected_by_Value=eval(strcat('get(handles.Projected_by_',num2str(ii),',''Value',''' )'))    ;
 Projected_by(ii)= (Projected_by_Str(Projected_by_Value)) ;
  end  
 
 Blue_factor=get(handles.Blue_factor,'value') ;
 Green_factor=get(handles.Green_factor,'value') ;
 Red_factor=get(handles.Red_factor,'value')  ; 
 DIC_temp=[]  ; Red=[]; Green=[]; Blue=[]; 
 if  Track_What(1)<5
 str_1=data_file(3).cdata( Track_What(1),1) ; 
 if char(str_1)~='0' && char(str_1)~='1' %  'first channel is active, and not DIC' 
  if char(str_1)=='2'  
 Blue = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Blue_factor);  
  elseif char(str_1)=='3' 
  Green = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Green_factor);    
 elseif char(str_1)=='4' 
  Green = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Green_factor);    
   elseif char(str_1)=='5' 
  Red = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Red_factor);    
   elseif char(str_1)=='6' 
Red = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Red_factor);   
  end 
 end 
 end 
 
  if Track_What(2)<5
 str_2=data_file(3).cdata( Track_What(2),1) ;
 if char(str_2)~='0' && char(str_2)~='1' %  'first channel is active, and not DIC' 
  if char(str_2)=='2'  
 Blue = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Blue_factor);  
  elseif char(str_2)=='3' 
  Green = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Green_factor);  
 elseif char(str_2)=='4' 
    Green = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Green_factor); 
   elseif char(str_2)=='5' 
   Red = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Red_factor);
   elseif char(str_2)=='6' 
    Red = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Red_factor);
  end
 end
  end 
 
  if Track_What(3)<5   
 str_3=data_file(3).cdata( Track_What(3),1) ;
 if char(str_3)~='0' && char(str_3)~='1'  
  if char(str_3)=='2'  
  Blue = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Blue_factor);   
  elseif char(str_3)=='3' 
  Green = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Green_factor);   
 elseif char(str_3)=='4' 
   Green = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Green_factor);   
   elseif char(str_3)=='5' 
  Red = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Red_factor);   
   elseif char(str_3)=='6' 
     Red = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Red_factor);   
  end 
 end 
  end 
 
 if Nbits==8   
   if isempty(Red)
       Red=uint8(zeros(Xdim,Ydim,1)); 
   else 
     Red=uint8((Red./(max(max(Red))))*255);
   end
  if isempty(Green)
       Green=uint8(zeros(Xdim,Ydim,1)); 
  else
       Green=uint8((Green./(max(max(Green))))*255) ;
  end
    if isempty(Blue)
       Blue=uint8(zeros(Xdim,Ydim,1)); 
    else
         Blue=uint8((Blue./(max(max(Blue))))*255);
    end 
 elseif  Nbits==16  
   if isempty(Red)
       Red=uint16(zeros(Xdim,Ydim,1)); 
   else 
     Red=uint16((Red./(max(max(Red))))*65535);
   end
  if isempty(Green)
       Green=uint16(zeros(Xdim,Ydim,1)); 
  else
       Green=uint16((Green./(max(max(Green))))*65535) ;
  end
    if isempty(Blue)
       Blue=uint16(zeros(Xdim,Ydim,1)); 
    else
         Blue=uint16((Blue./(max(max(Blue))))*65535);
    end 
 elseif  Nbits==32   
   if isempty(Red)
       Red=uint32(zeros(Xdim,Ydim,1)); 
   else 
     Red=uint32((Red./(max(max(Red))))*2^32);
   end
  if isempty(Green)
       Green=uint32(zeros(Xdim,Ydim,1)); 
  else
       Green=uint32((Green./(max(max(Green))))*2^32) ;
  end
    if isempty(Blue)
       Blue=uint32(zeros(Xdim,Ydim,1)); 
    else
         Blue=uint32((Blue./(max(max(Blue))))*2^32);
    end 
 end
 if Track_What(4)<5   
   str_4=data_file(3).cdata( Track_What(4),1)   ;
  Use_DIC_Option= get( handles.Use_DIC_Option ,'Value');
  
     if char(str_4)=='1' && Use_DIC_Option==1
          matrix_temp = double(read_image3(pathname,filename,Track_What(4),segmentation_type(4), Projected_by(4)));   
     if Nbits==8     
            I= uint8(~(Green./Green+Red./Red+Blue./Blue)).*uint8(( matrix_temp./(max(max( matrix_temp))))*255); 
        elseif Nbits==16  
            I= uint16(~(Green./Green+Red./Red+Blue./Blue)).*uint16(( matrix_temp./(max(max( matrix_temp))))*65535);   
        elseif Nbits==32  
            I= uint32(~(Green./Green+Red./Red+Blue./Blue)).*uint32(( matrix_temp./(max(max( matrix_temp))))*2^32);    
     end 
   try
    matrix_out = cat(3, Red+I , Green+I, Blue+I ); 
   end 
   end  
 else  
    matrix_out = cat(3, Red , Green , Blue );  
 end
end
 end 
function edit_axes1_CreateFcn(~, ~, ~)  
function Raw_listbox_CreateFcn(~, ~, ~) 
function showcurrentframe_CreateFcn(~, ~, ~) 
function segmentation_type_4_CreateFcn(~, ~, ~) 
function Projected_by_4_CreateFcn(~, ~, ~) 
function track_what_4_CreateFcn(~, ~, ~) 
function segmentation_type_3_CreateFcn(~, ~, ~) 
function Projected_by_3_CreateFcn(~, ~, ~) 
function track_what_3_CreateFcn(~, ~, ~) 
function segmentation_type_2_CreateFcn(~, ~, ~) 
function Projected_by_2_CreateFcn(~, ~, ~) 
function track_what_2_CreateFcn(~, ~, ~) 
function segmentation_type_1_CreateFcn(~, ~, ~) 
function Projected_by_1_CreateFcn(~, ~, ~) 
function track_what_1_CreateFcn(~, ~, ~) 
function edit_tracks_num_CreateFcn(~, ~, ~) 
function Div_Cells_CreateFcn(~, ~, ~) 
function track_by_CreateFcn(~, ~, ~) 
function popup1_CreateFcn(~, ~, ~) 
function popup2_CreateFcn(~, ~, ~) 
function popup3_CreateFcn(~, ~, ~) 
function quantify_by_CreateFcn(~, ~, ~) 
function rotate_by_CreateFcn(~, ~, ~) 
function NETO_option_CreateFcn(~, ~, ~) 
function maximum_pixel_CreateFcn(~, ~, ~) 
function Show_proximity_vector_CreateFcn(~, ~, ~) 
function Red_factor_CreateFcn(~, ~, ~) 
function Green_factor_CreateFcn(~, ~, ~) 
function Blue_factor_CreateFcn(~, ~, ~) 
function Red_factor_edit_CreateFcn(~, ~, ~) 
function Green_factor_edit_CreateFcn(~, ~, ~) 
function Blue_factor_edit_CreateFcn(~, ~, ~) 
function popup_seg_ed_CreateFcn(~, ~, ~) 
function Get_8_option_CreateFcn(~, ~, ~) 
function popup_spaces_CreateFcn(~, ~, ~) 
function plot_list_CreateFcn(~, ~, ~) 
function parental_num_CreateFcn(~, ~, ~) 
function Daughter1_edit_CreateFcn(~, ~, ~) 
function Daughter2_edit_CreateFcn(~, ~, ~) 
function plot_edit_CreateFcn(~, ~, ~)  
function figure1_CloseRequestFcn(hObject, ~, ~) 
delete(hObject); 


% --- Executes on button press in Delete_List.
function Delete_List_Callback(hObject, eventdata, handles)
set(handles.plot_list,'Value',1)
set(handles.plot_list,'string','Raw Frame');  
set(handles.plot_list,'userdata',[]);   

% --------------------------------------------------------------------
function Untitled_18_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function Segmentation_module_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
run('TAC_Segmentation_Module',handles.data_file) ;
else
run('TAC_Segmentation_Module') ;
end
% --------------------------------------------------------------------
function Tracking_module_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
run('TAC_Cell_Tracking_Module',handles.data_file) ;
else
run('TAC_Cell_Tracking_Module') ;
end

% --------------------------------------------------------------------
function Measurments_module_Callback(~, ~, handles)
 if isempty(handles.data_file)~=1
run('TAC_Measurments_Module',handles.data_file) ;
else
run('TAC_Measurments_Module') ;
 end
% --------------------------------------------------------------------
function Robut_Module_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
run('TAC_Robust_Module',handles.data_file) ;
else
run('TAC_Robust_Module') ;
end

% --------------------------------------------------------------------
function Analysis_module_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
run('TAC_Analysis_Module',handles.data_file) ;
else
run('TAC_Analysis_Module') ;
end
 

% --------------------------------------------------------------------
function Polarization_module_Callback(~, ~, handles)
if isempty(handles.data_file)~=1
run('TAC_Polarization_Module',handles.data_file) ;
else
run('TAC_Polarization_Module') ;
end
 


% --------------------------------------------------------------------
function Untitled_25_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Color_editor_Callback(hObject, eventdata, handles)
 colormapeditor
 handles.c=  get(gcf,'colormap')
 guidata(hObject,handles) 


% --------------------------------------------------------------------
function Untitled_27_Callback(hObject, eventdata, handles)
if   handles.flag.axis1==-1
axes(handles.axes1)  
 colorbar
 set(handles.axes1,'Xcolor','y'); set(handles.axes1,'Ycolor','y')
else
 axes(handles.axes1) 
 colorbar('off')
 set(handles.axes1,'Xcolor','k'); set(handles.axes1,'Ycolor','k')
end
handles.flag.axis1=handles.flag.axis1*(-1);
     guidata(hObject, handles);

%      if   handles.flag.axis1==-1
% axes(handles.axes1)  
%  colorbar 
% else
%  axes(handles.axes1) 
%  colorbar('off')  
% end
% handles.flag.axis1=handles.flag.axis1*(-1);
%      guidata(hObject, handles);

     
% --------------------------------------------------------------------
function Untitled_28_Callback(hObject, eventdata, handles)
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
function Untitled_29_Callback(hObject, eventdata, handles)
axes(handles.axes1) 
imtool(gca)


% --------------------------------------------------------------------
function Untitled_30_Callback(hObject, eventdata, handles)
 axes(handles.axes1) 
imcontrast(gca)


% --------------------------------------------------------------------
function Untitled_31_Callback(hObject, eventdata, handles)
axes(handles.axes1) 
impixelregion(gca)


% --------------------------------------------------------------------
function Untitled_32_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_33_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  prompt = {'Please input Figurel number to be exported:'}; 
   dlg_title = 'Exporting';
   num_lines = 1;
   def = {' ' }; 
   answer = inputdlg(prompt,dlg_title,num_lines,def) ;
   if  isempty(answer)==1
  close(h)
  return
   else
   answer=str2double(answer); 
   end
   
   
 temp_data=get(answer,'userdata') ;
 
  ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z']; 
   
  if size(temp_data,1)~=1 && size(temp_data,2)~=1  
 MATRIX=temp_data ; 
   
   if size(MATRIX,2)>26 
  lastcell=strcat(ABC(floor(size(MATRIX,2)/26)),ABC(round(26*(size(MATRIX,2)/26-floor(size(MATRIX,2)/26)))));
   else
  lastcell= ABC(size(MATRIX,2)) ; 
   end 
 lastcell=strcat(lastcell,num2str(size(MATRIX,2))) ;
 Excel = actxserver('Excel.Application');
  set(Excel, 'Visible', 1);
  Workbooks = Excel.Workbooks;
  Workbook = invoke(Workbooks, 'Add');
  Activesheet = Excel.Activesheet;
  ActivesheetRange = get(Activesheet,'Range','A1',lastcell); 
  
  set(ActivesheetRange, 'Value',MATRIX); 
  ActivesheetRange.Font.Bold = 'True';
  ActivesheetRange.Font.Size = 10;
  ActivesheetRange.ColumnWidth = 11;
  ActivesheetRange.Borders.LineStyle = 1;
  ActivesheetRange.Borders.Weight = 2; 
  
  
  return
  end  
 
 if size(temp_data,1)~=1 ||  size(temp_data,2)~=1 
   'plot XY is on: a and c '
  if isstruct(temp_data)==0 
   MATRIX=temp_data' ;
   ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z']; 
   if size(MATRIX,2)>26 
  lastcell=strcat(ABC(floor(size(MATRIX,2)/26)),ABC(round(26*(size(MATRIX,2)/26-floor(size(MATRIX,2)/26)))));
   else
  lastcell= ABC(size(MATRIX,2)) ; 
   end 
   lastcell=strcat(lastcell,num2str(size(MATRIX,1))) ;
   Excel = actxserver('Excel.Application');
   set(Excel, 'Visible', 1);
   Workbooks = Excel.Workbooks;
   Workbook = invoke(Workbooks, 'Add');
   Activesheet = Excel.Activesheet;
   ActivesheetRange = get(Activesheet,'Range','A1',lastcell);
  else 
 for ii=1:size(temp_data,2)
   temp_vector=temp_data(ii).cdata 
   
   if size(temp_vector,1)<size(temp_vector,2)
   temp_vector= temp_vector' 
   end 
 if isempty(temp_vector )~=1
 MATRIX(:,ii)=temp_vector 
 end
 end 
   ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z']; 
  if size(MATRIX,2)>26 
 lastcell=strcat(ABC(floor(size(MATRIX,2)/26)),ABC(round(26*(size(MATRIX,2)/26-floor(size(MATRIX,2)/26)))));
  else
 lastcell= ABC(size(MATRIX,2)) ; 
  end 
   lastcell=strcat(lastcell,num2str(size(MATRIX,1))) ;
   Excel = actxserver('Excel.Application');
   set(Excel, 'Visible', 1);
   Workbooks = Excel.Workbooks;
   Workbook = invoke(Workbooks, 'Add');
   Activesheet = Excel.Activesheet;
   ActivesheetRange = get(Activesheet,'Range','A1',lastcell); 
  end
% else  'plot XY is off: b and d' 
 if isstruct(temp_data.Y_data)==1
  for ii=1:size(temp_data.Y_data,2)
 temp_vector=temp_data.Y_data(ii).cdata 
   if size(temp_vector,1)<size(temp_vector,2)
   temp_vector= temp_vector' 
   end
   if isempty(temp_vector )~=1
   MATRIX(:,ii)=temp_vector 
   end
  end
   
 
 ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
   if size(MATRIX,2)>26 
  lastcell=strcat(ABC(floor(size(MATRIX,2)/26)),ABC(round(26*(size(MATRIX,2)/26-floor(size(MATRIX,2)/26)))));
   else
  lastcell= ABC(size(MATRIX,2)) ; 
   end 
 lastcell=strcat(lastcell,num2str(size(MATRIX,1))) ;
 Excel = actxserver('Excel.Application');
 set(Excel, 'Visible', 1);
 Workbooks = Excel.Workbooks;
 Workbook = invoke(Workbooks, 'Add');
 Activesheet = Excel.Activesheet;
 ActivesheetRange = get(Activesheet,'Range','A1',lastcell);
 set(ActivesheetRange, 'Value',MATRIX); 
 ActivesheetRange.Font.Bold = 'True';
 ActivesheetRange.Font.Size = 10;
 ActivesheetRange.ColumnWidth = 11;
 ActivesheetRange.Borders.LineStyle = 1;
 ActivesheetRange.Borders.Weight = 2;
  for ii=1:size(temp_data.X_data,2)
  temp_vector=temp_data.X_data(ii).cdata 
   if size(temp_vector,1)<size(temp_vector,2)
 temp_vector= temp_vector' 
   end 
   if isempty(temp_vector )~=1
    MATRIX(:,ii)=temp_vector 
   end 
  end
  ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z']; 
 if size(MATRIX,2)>26 
   lastcell=strcat(ABC(floor(size(MATRIX,2)/26)),ABC(round(26*(size(MATRIX,2)/26-floor(size(MATRIX,2)/26)))));
 else
   lastcell= ABC(size(MATRIX,2)) ; 
 end 
  lastcell=strcat(lastcell,num2str(size(MATRIX,1))) ;
  Excel = actxserver('Excel.Application');
  set(Excel, 'Visible', 1);
  Workbooks = Excel.Workbooks;
  Workbook = invoke(Workbooks, 'Add');
  Activesheet = Excel.Activesheet;
  ActivesheetRange = get(Activesheet,'Range','A1',lastcell); 
 else 
   if size(temp_data.Y_data,1)<size(temp_data.Y_data,2)
   temp_data.Y_data=temp_data.Y_data' 
   end 
   if size(temp_data.X_data,1)<size(temp_data.X_data,2)
   temp_data.X_data=temp_data.X_data';
   end 
   MATRIX(:,1)=temp_data.Y_data;
   MATRIX(:,2)=temp_data.X_data; 
   ABC=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z']; 
 if size(MATRIX,2)>26 
   lastcell=strcat(ABC(floor(size(MATRIX,2)/26)),ABC(round(26*(size(MATRIX,2)/26-floor(size(MATRIX,2)/26)))));
 else
   lastcell= ABC(size(MATRIX,2)) ; 
 end 
  lastcell=strcat(lastcell,num2str(size(MATRIX,1))) ;
  Excel = actxserver('Excel.Application');
  set(Excel, 'Visible', 1);
  Workbooks = Excel.Workbooks;
  Workbook = invoke(Workbooks, 'Add');
  Activesheet = Excel.Activesheet;
  ActivesheetRange = get(Activesheet,'Range','A1',lastcell); 
 end
 end 
  set(ActivesheetRange, 'Value',MATRIX); 
  ActivesheetRange.Font.Bold = 'True';
  ActivesheetRange.Font.Size = 10;
  ActivesheetRange.ColumnWidth = 11;
  ActivesheetRange.Borders.LineStyle = 1;
  ActivesheetRange.Borders.Weight = 2; 


% --------------------------------------------------------------------
function Untitled_34_Callback(hObject, eventdata, handles)

 [filename2put, pathname2put, filterindex]=uiputfile('*.tif','name of multistack file'); 
 prompt = {'Enter first frame:','Enter last frame:'};
dlg_title = 'Input frames number';
num_lines = 1;
def = {'',''};
answer = inputdlg(prompt,dlg_title,num_lines,def); 
 start_export= str2num(char(answer(1))); %#ok<ST2NM>
 end_export=str2num(char(answer(2))); %#ok<ST2NM>
 box_Raw=get(handles.Raw_listbox,'string') ; 
 for track_what_index=1:4%support up to 4 channels 
 Track_What(track_what_index)=eval(strcat('get(handles.track_what_',num2str(track_what_index),',''Value',''' )')) ;
 show_tracks(track_what_index)= eval(strcat('get(handles.show_tracks_',num2str(track_what_index),',''Value',''' )')) ;
 show_marks(track_what_index)= eval(strcat('get(handles.show_marks_',num2str(track_what_index),',''Value',''' )')) ;
 end
 
% create movie:
for n= start_export:end_export  
  show_frame( handles,n) ;
  temp=getframe ;
  ;wait_pause('Updating',10,0.02);
   imwrite( temp(1).cdata ,[pathname2put filename2put],'WriteMode','append'); 
   ;wait_pause('Updating',10,0.2);
end 


% --------------------------------------------------------------------
function Untitled_35_Callback(hObject, eventdata, handles)
%track_by=get(handles.track_by,'Value') ;
 track_what=eval(strcat('get(handles.track_what_',num2str(track_by),',''Value',''' )')) ;  
 quantify_by=get(handles.quantify_by,'Value') ;
 quantify_what=eval(strcat('get(handles.track_what_',num2str(quantify_by),',''Value',''' )')) ;  
  if nargin==3
      segmentation_type =eval(strcat('get(handles.segmentation_type_',num2str(quantify_by),',''Value',''' )'));    
  end 
rotate_by=get(handles.rotate_by,'Value') ;
rotate_what=eval(strcat('get(handles.track_what_',num2str(rotate_by),',''Value',''' )')) ;  
Projected_by_Str={'By max',  'By mean', 'z1', 'z2', 'z3', 'z4', 'z5', 'z6', 'z7', 'z7' , 'z9',  'z10'} ;  
Projected_by_Value=eval(strcat('get(handles.Projected_by_',num2str(quantify_by),',''Value',''' )'))    ;
Projected_by = (Projected_by_Str(Projected_by_Value)) ;  
pathname= handles.data_file(2).cdata ;
box_Raw=get(handles.Raw_listbox,'string') ;  




n=get(handles.Div_Cells,'value') 
  
Data_out=[]; 
start_frame=2*n-1 
 MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;  
[vector, jj]=create_vector(MATRIX,handles,start_frame) ;  

 kk=1;
 for ii=1:size(vector,1)
 if isnan(vector(ii,3))~=1 
   full_command=strcat('handles.data_file(4).cdata.L(',num2str(track_what) ,').cdata(ii+jj-1).cdata(vector(ii,3)).PixelList');
 output(kk).cdata= eval(full_command)  ;
    kk=kk+1;
 end 
 end
 
 
 for ii=1:size(vector,1); 
   if  isnan(vector(ii,3)) ==0   
  filename=box_Raw(ii+jj-1) ; 
 try
  eval(strcat('temp  = handles.stack',num2str(quantify_what),'(',num2str(segmentation_type),').cdata(',num2str((ii+jj-1)),').cdata;'))
 catch  
  temp  =  read_image3(pathname,filename, quantify_what,segmentation_type, Projected_by)  ; 
 end 
 if segmentation_type~=3
  try
 eval(strcat('Segmention  = handles.stack',num2str(quantify_what),'(',num2str(3),').cdata(',num2str((ii+jj-1)),').cdata;'))
 catch  
   Segmention  =  read_image3(pathname,filename, quantify_what,3, Projected_by)  ; 
  end
 else
     Segmention  = temp; 
 end 
   if (get( handles.Merge_channels ,'Value') == get(handles.Merge_channels,'Max')) 
  temp=Merged_image(ii+jj-1,handles) ; 
   end  
        PixelList= output(ii).cdata;  
        PixelList = sub2ind([handles.data_file(6).cdata(4) handles.data_file(6).cdata(3)], PixelList(:,2),PixelList(:,1)) ; 
        PixelList= setdiff(1:handles.data_file(6).cdata(4)*handles.data_file(6).cdata(3),PixelList); 
axis(handles.axes1); cla;temp(PixelList)=0; 
 imagesc(temp)
  
 axis tight
;wait_pause('Updating',10,0.01);
   end
 end
 


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_01_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user d 
