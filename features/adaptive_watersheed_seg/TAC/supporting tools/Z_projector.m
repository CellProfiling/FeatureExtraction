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
function varargout = Z_projector(varargin)

% Z_PROJECTOR M-file for Z_projector.fig
%      Z_PROJECTOR, by itself, creates a new Z_PROJECTOR or raises the existing
%      singleton*.
%
%      H = Z_PROJECTOR returns the handle to a new Z_PROJECTOR or the handle to
%      the existing singleton*.
%
%      Z_PROJECTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Z_PROJECTOR.M with the given input arguments.
%
%      Z_PROJECTOR('Property','Value',...) creates a new Z_PROJECTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Z_projector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Z_projector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Z_projector

% Last Modified by GUIDE v2.5 05-Jul-2011 04:42:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Z_projector_OpeningFcn, ...
    'gui_OutputFcn',  @Z_projector_OutputFcn, ...
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


% --- Executes just before Z_projector is made visible.
function Z_projector_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Z_projector (see VARARGIN)

% Choose default command line output for Z_projector
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Z_projector wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Z_projector_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% -------------------------------------------
function edit1_CreateFcn(hObject, eventdata, handles)
function Start_z_at_CreateFcn(hObject, eventdata, handles)
function End_z_at_CreateFcn(hObject, eventdata, handles)
function Start_channel_CreateFcn(hObject, eventdata, handles)
function End_channel_CreateFcn(hObject, eventdata, handles)
function Backbone_filename_CreateFcn(hObject, eventdata, handles)
function listbox1_Callback(hObject, eventdata, handles)
function End_z_at_Callback(hObject, eventdata, handles)
function Start_z_at_Callback(hObject, eventdata, handles)
function Start_channel_Callback(hObject, eventdata, handles)
function End_channel_Callback(hObject, eventdata, handles)
function listbox1_CreateFcn(hObject, eventdata, handles)
% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
close(Z_projector)
close
h = TACTICS ;
drawnow;
% pause(1);
j = get(h,'javaframe');
jfig = j.fFigureClient.getWindow; %undocumented
jfig.setAlwaysOnTop(0);%places window on top, 0 to disable
jfig.setMaximized(1); %maximizes the window, 0 to minimize
% --------------------------------------------
% function pushbutton6_Callback(hObject, eventdata, handles)
%   pathfolder=get(handles.listbox1,'String');
%
%
% n=size(pathfolder ,1);
% h1=timebar_TACWrapper('Save new path for all batch ....');
% set(h1,'color','w');
% Backbone_filename=get(handles.Backbone_filename,'string');
% Start_channel=get(handles.Start_channel,'Value')-1 ;
% start_pos=str2double(get(handles.start_pos_at,'String'))-1 ;
% End_channel=get(handles.End_channel,'Value')-1 ;
% Start_z_at =get(handles.Start_z_at,'value')-1;
% End_z_at =get(handles.End_z_at,'value')-1;
% Start_frame_at =str2double(get(handles.Start_frame_at,'string'));
% End_frame_at =str2double(get(handles.End_frame_at,'string'));
% Delete_on=get(handles.Delete_on,'value');
% Transfer_on=get(handles.Transfer_on,'value');
% Type_of_projection=get(handles.Type_of_projection,'Value');
%
%
%
%
%
%
% for jjj=1:1
%      for iii=Start_channel:Start_channel
%                %we dont care about channels- only care about the Z_projector!!
%                %FOR EACH POSITION- MANUALLY
%                    for  ii=Start_frame_at:Start_frame_at
%
%                          if ii<10
%                               part_1_filename=strcat(pathfolder(jjj) ,'\', Backbone_filename,'_t00',num2str(ii));
%                          end
%                          if ii>9 && ii<100
%                                part_1_filename=strcat(pathfolder(jjj),'\' , Backbone_filename,'_t0',num2str(ii));
%                          end
%                          if ii>99
%                               part_1_filename=strcat(pathfolder(jjj) ,'\', Backbone_filename,'_t',num2str(ii));
%                          end
%
%
%                         avg=double(zeros(512,512));
%                               for jj=Start_z_at:Start_z_at
%                                          part_2_filename =strcat('_z',num2str(jj),'_ch0',num2str(iii),'.tif') ;
%                                          full_filename=char(strcat(part_1_filename,part_2_filename))  ;
%                                          full_filename=regexprep(full_filename, '\\\','\') ;
%                                           STAT=dir(full_filename);
%                               end
%                    end
%      end
% end
%
%
%
% % option 1 : Normal projection (saved into original folder!)
% %____________________________________________
% if size(STAT,1)==1
%     for jjj=1:n
%           timebar_TACWrapper(h1,(jjj-0.5)/n)
%           set(handles.listbox1,'value',jjj)
%          for iii=Start_channel:End_channel
%                  if Transfer_on==1
%                   mkdir(char(strcat(pathfolder(jjj) ,'\z')));
%                  end
%                    %we dont care about channels- only care about the Z_projector!!
%                    %FOR EACH POSITION- MANUALLY
%                         second_h  =waitbar(0,'processing. please wait....');
%                         Position=get(second_h,'Position');
%                         Position(2)=Position(2)+100;
%                         set(second_h,'Position',Position)
%                        for  ii=Start_frame_at:End_frame_at
%                              waitbar((ii-Start_frame_at+1)/(End_frame_at-Start_frame_at))
%
%
%
%                              if ii<10
%                                   part_1_filename=strcat(pathfolder(jjj) ,'\', Backbone_filename,'_t00',num2str(ii));
%                              end
%                              if ii>9 && ii<100
%                                    part_1_filename=strcat(pathfolder(jjj),'\' , Backbone_filename,'_t0',num2str(ii));
%                              end
%                              if ii>99
%                                   part_1_filename=strcat(pathfolder(jjj) ,'\', Backbone_filename,'_t',num2str(ii));
%                              end
%
%
%                             avg=double(zeros(512,512));
%                                   for jj=Start_z_at:End_z_at
%                                              part_2_filename =strcat('_z',num2str(jj),'_ch0',num2str(iii),'.tif') ;
%                                              full_filename=char(strcat(part_1_filename,part_2_filename))  ;
%                                              full_filename=regexprep(full_filename, '\\\','\') ;
%                                              temp=imread( full_filename);
% %                                                     -----
%                                                     if Transfer_on==1
%                                                           if ii<10
%                                                               part_1_filename_Transfer=strcat(pathfolder(jjj) ,'\z\', Backbone_filename,'_t00',num2str(ii));
%                                                          end
%                                                          if ii>9 && ii<100
%                                                                part_1_filename_Transfer=strcat(pathfolder(jjj),'\z\' , Backbone_filename,'_t0',num2str(ii));
%                                                          end
%                                                          if ii>99
%                                                               part_1_filename_Transfer=strcat(pathfolder(jjj) ,'\z\', Backbone_filename,'_t',num2str(ii)) ;
%                                                               pause
%                                                          end
%                                                          full_filename_Transfer=char(strcat(part_1_filename_Transfer,part_2_filename))   ;
%                                                          full_filename_Transfer=regexprep(full_filename_Transfer, '\\\','\')  ;
%                                                          imwrite(uint16(temp),   full_filename_Transfer );
%                                                     end
% %                                                     -----
%                                                     if Delete_on==1
%                                                          delete(full_filename);
%                                                     end
%                                             avg= avg  + double(temp);
%                                   end
%                              avg=avg/jj; avg=uint16(avg);
%                              full_filename_new=strcat(part_1_filename,'_ch0',num2str(iii),'.tif')    ;
%                              full_filename_new=char(regexprep(full_filename_new, '\\\','\')  );
%                              imwrite(avg,  full_filename_new );
%                        end
%                        close(second_h)
%                        pause(3)
%          end
%     end
%
%
% elseif size(STAT,1)==0 %more complicated situation
%     for jjj=1:n
%         if (jjj+start_pos)<10
%             Pos='_Pos0';
%         else
%             Pos='_Pos';
%         end
%
%           timebar_TACWrapper(h1,(jjj-0.5)/n)
%           set(handles.listbox1,'value',jjj)
%
%          for iii=Start_channel:End_channel
%                   if Transfer_on==1
%                   mkdir(char(strcat(pathfolder(jjj) ,'\z')));
%                  end
%                    %we dont care about channels- only care about the Z_projector!!
%                    %FOR EACH POSITION- MANUALLY
%                         second_h  =waitbar(0,'processing. please wait....');
%                         Position=get(second_h,'Position');
%                         Position(2)=Position(2)+100;
%                         set(second_h,'Position',Position)
%                        for  ii=Start_frame_at:End_frame_at
%                              waitbar((ii-Start_frame_at+1)/(End_frame_at-Start_frame_at))
%
%
%
%                             avg=double(zeros(512,512));
%                                   for jj=Start_z_at:End_z_at
% %                                       RRRRRRRRRRRRR
% % RRRRRRR
%                                              if ii<10
%                                                  full_filename=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_ch0',num2str(iii),'_z0',num2str(jj),'_t00',num2str(ii),'.tif'));
%                                              end
%                                              if ii>9 && ii<100
%                                                  full_filename=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_ch0',num2str(iii),'_z0',num2str(jj),'_t0',num2str(ii),'.tif'));
%                                              end
%                                              if ii>99
%                                                  full_filename=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_ch0',num2str(iii),'_z0',num2str(jj),'_t',num2str(ii),'.tif'));
%                                              end
%
%                                              full_filename=regexprep(full_filename, '\\\','\') ;
%
%                                               temp=imread( full_filename);
%                                               if Transfer_on==1
%                                                           if ii<10
%                                                              full_filename_Transfer=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos), '_t00',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii),'.tif'));
%                                                          end
%                                                          if ii>9 && ii<100
%                                                              full_filename_Transfer=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos), '_t0',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii),'.tif'));
%                                                          end
%                                                          if ii>99
%                                                              full_filename_Transfer=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos), '_t',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii),'.tif'));
%                                                          end
%
%                                                          full_filename_Transfer=regexprep(full_filename_Transfer, '\\\','\')  ;
%
%                                                          imwrite(uint16(temp),   full_filename_Transfer );
%                                                  end
% %                                                     -----
%                                                     if Delete_on==1
%                                                          delete(full_filename);
%                                                     end
%                                                avg= avg  + double(temp);
%                                   end
%                              avg=avg/jj; avg=uint16(avg);
%                                  if ii<10
%                                        full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t00',num2str(ii),'_ch0',num2str(iii),'.tif'));
%                                  end
%                                  if ii>9 && ii<100
%                                        full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t0',num2str(ii),'_ch0',num2str(iii),'.tif'));
%                                  end
%                                  if ii>99
%                                     full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t',num2str(ii),'_ch0',num2str(iii),'.tif'));
%                                  end
%
%                              full_filename_new=char(regexprep(full_filename_new, '\\\','\')  );
%                              imwrite(avg,  full_filename_new );
%                        end
%                        close(second_h)
%                        pause(3)
%          end
%     end
% end
%
% % End of option 1 : Normal projection (saved into original folder!)
% % %____________________________________________
%
% close(h1)
% --------------------------------------------
function del_selected_Callback(hObject, eventdata, handles)
n=get(handles.listbox1,'Value') ;
listbox=get(handles.listbox1,'string')  ;

pathname_Raw= get(handles.edit1,'string' );

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
    filename= strcat(pathname_Raw,filename);
    filename=char(filename);
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
    filename= strcat(pathname_Raw,filename);
    filename=char(filename);
    set(handles.listbox1,'string',new_listbox);
    return
end
if   (n==size(listbox,1) && n>1)
    for  ii=1:(n-1)
        new_listbox(ii)=listbox(ii);
    end
    set(handles.listbox1,'Value',n-1);
    set(handles.listbox1,'string',new_listbox);
    return
end
% --------------------------------------------







function End_frame_at_Callback(hObject, eventdata, handles)
% hObject    handle to End_frame_at (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_frame_at as text
%        str2double(get(hObject,'String')) returns contents of End_frame_at as a double


% --- Executes during object creation, after setting all properties.
function End_frame_at_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_frame_at (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Start_frame_at_Callback(hObject, eventdata, handles)
% hObject    handle to Start_frame_at (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_frame_at as text
%        str2double(get(hObject,'String')) returns contents of Start_frame_at as a double


% --- Executes during object creation, after setting all properties.
function Start_frame_at_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_frame_at (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Delete_on.
function Delete_on_Callback(hObject, eventdata, handles)
choice = questdlg('Have you created the z folder yet?', ...
    'Hello User', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        answer = 0;
    case 'No'
        answer = 1;
end

if answer
    return
end
choice = questdlg('This operation will discard un-projected images files. Do you wish to abort?', ...
    'Hello User', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        answer = 1;
    case 'No'
        answer = 0;
end

if answer
    return
end





pathfolder= get(handles.listbox1,'string');

n=size(pathfolder ,1);
h1=timebar_TACWrapper('Save new path for all batch ....');
set(h1,'color','w');



for jjj=1:n
    set(handles.listbox1,'value',jjj);
    timebar_TACWrapper(h1, jjj/n)
    dir_name = char(pathfolder(jjj))   ;
    cd(dir_name)
    delete *_ch*_z*_t*.tif
    % 100310_T24-02_GFP Ch-AP2A2 DN3 on cless DL1_01_Pos01_t005_ch00.tif
    
    %        ch   Ch  capital or small letter no difference
    pause(2)
end
close(h1)




% --- Executes on button press in Transfer_on.
function Transfer_on_Callback(hObject, eventdata, handles)
% hObject    handle to Transfer_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Transfer_on


% --- Executes on selection change in Type_of_projection.
function Type_of_projection_Callback(hObject, eventdata, handles)
% hObject    handle to Type_of_projection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Type_of_projection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Type_of_projection


% --- Executes during object creation, after setting all properties.
function Type_of_projection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Type_of_projection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function start_pos_Callback(hObject, eventdata, handles)
% hObject    handle to start_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of start_pos as text
%        str2double(get(hObject,'String')) returns contents of start_pos as a double


% --- Executes during object creation, after setting all properties.
function start_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
% function Untitled_2_Callback(hObject, eventdata, handles)
%   new_dir=uigetdir('Current Directory','Please select folder containing the subfolders of the positions');
%   if isequal(new_dir,0)  %$#1
%       h = msgbox('User selected Cancel','Aborted');
%     return;
%   end
%  set(handles.edit1,'string',new_dir)
% pathname=strcat(new_dir,'\');
% dir_filename=dir(new_dir);
% jj=1;
% clear filename_str
% % ###1
%
% n=size(dir_filename,1) %loop 1
% h =timebar_TACWrapper('Save new path for all batch ....');
% set(h ,'color','w');
%
%   for ii=1:size(dir_filename,1) %loop 1
%        timebar_TACWrapper(h ,ii/n)
%         temp=cellstr(dir_filename(ii).name)  ;
%         temp=(strcat(pathname,temp))  ;
%               if  isdir(char(temp))==1 && length(dir_filename(ii).name)>2
%                           filename_str(jj)= temp ; jj=jj+1;
%              end
%
%   end
%    filename_str
%  save  filename_str  filename_str
%  %command error if there is only one position here
%       set(handles.listbox1,'string',filename_str);
%       set(handles.listbox1,'Max',size(filename_str,1)) ;
%       set(handles.listbox1,'Value',1) ;
%       set(handles.listbox1,'Min',0);
%      set(handles.listbox1,'value',1)
%      close(h)
%      --------------------------------------------------------------------


% --- Executes during object creation, after setting all properties.
function start_pos_at_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_pos_at (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
new_dir=uigetdir('Current Directory','Please select folder containing the subfolders of the positions');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
set(handles.edit1,'string',new_dir)
pathname=strcat(new_dir,'\');
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

function [list_of_folders]=read_list_of_folders(folder_name)
list_of_folders=cellstr({});
dir_folder_name=dir(folder_name); jj=1;
for ii=1:size(dir_folder_name,1) %loop 1
    if  dir_folder_name(ii).isdir==1
        if length(dir_folder_name(ii).name)>2
            list_of_folders(jj)=cellstr(strcat(folder_name,'\',dir_folder_name(ii).name))  ; jj=jj+1;
        end
    end
end



% --------------------------------------------------------

function pushbutton8_Callback(hObject, eventdata, handles)

Ignore_last_frame_option=get(handles.Ignore_last_frame_option,'value');
last_frame_option=str2double(get(handles.Ignore_last_frame,'string'));

pathfolder= get(handles.listbox1,'string');
n=size(pathfolder ,1);
h1=timebar_TACWrapper('Save new path for all batch ....');
set(h1,'color','w');
% Backbone_filename=get(handles.Backbone_filename,'string');
Start_channel=get(handles.Start_channel,'Value')-1  ;
start_pos=str2double(get(handles.start_pos_at,'String'))-1 ;
End_channel=get(handles.End_channel,'Value')-1  ;

Start_z_at =get(handles.Start_z_at,'value')-1;
End_z_at =get(handles.End_z_at,'value')-1;
Start_frame_at =str2double(get(handles.Start_frame_at,'string')) ;
End_frame_at =str2double(get(handles.End_frame_at,'string'))-last_frame_option;

Transfer_on=get(handles.Transfer_on,'value');
Type_of_projection=get(handles.Type_of_projection,'Value');
Choose_position=get(handles.Choose_position,'value');




if    Choose_position==1
    for jjj=1:n
        
        
        
        dir_names=dir(char(pathfolder(jjj)))  ;
        temp_filename=dir_names(end-1).name ;
        Backbone_filename=temp_filename(1:strfind(temp_filename,'Pos')-2)  ;
        if get(handles.Frame_selection_option,'value')==2
            End_frame_at= round((size(dir_names,1)-2)/((End_channel-Start_channel+1)*(End_z_at-Start_z_at+1 ))) -last_frame_option;
            Start_frame_at = 1  ;
        end
        
        
        if (jjj+start_pos)<10
            Pos='_Pos0';
        else
            Pos='_Pos';
        end
        
        timebar_TACWrapper(h1,(jjj-0.5)/n)
        set(handles.listbox1,'value',jjj)
        
        for iii=Start_channel:End_channel
            if Transfer_on==1
                mkdir(char(strcat(pathfolder(jjj) ,'\z')));
            end
            %we dont care about channels- only care about the Z_projector!!
            %FOR EACH POSITION- MANUALLY
            second_h  =waitbar(0,'processing. please wait....');
            Position=get(second_h,'Position');
            Position(2)=Position(2)+100;
            set(second_h,'Position',Position)
            for  ii=Start_frame_at:End_frame_at
                
                waitbar((ii-Start_frame_at+1)/(End_frame_at-Start_frame_at))
                
                
                
                avg=double(zeros(512,512));
                for jj=Start_z_at:End_z_at
                    %                                       RRRRRRRRRRRRR
                    % RRRRRRR
                    if ii<10
                        full_filename=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_ch0',num2str(iii),'_z0',num2str(jj),'_t00',num2str(ii),'.tif'));
                    end
                    if ii>9 && ii<100
                        full_filename=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_ch0',num2str(iii),'_z0',num2str(jj),'_t0',num2str(ii),'.tif'));
                    end
                    if ii>99
                        full_filename=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_ch0',num2str(iii),'_z0',num2str(jj),'_t',num2str(ii),'.tif'));
                    end
                    
                    full_filename=regexprep(full_filename, '\\\','\') ;
                    
                    temp=imread( full_filename);
                    if Transfer_on==1
                        if ii<10
                            full_filename_Transfer=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos), '_t00',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii),'.tif'));
                        end
                        if ii>9 && ii<100
                            full_filename_Transfer=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos), '_t0',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii),'.tif'));
                        end
                        if ii>99
                            full_filename_Transfer=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos), '_t',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii),'.tif'));
                        end
                        
                        full_filename_Transfer=regexprep(full_filename_Transfer, '\\\','\')  ;
                        if Ignore_last_frame_option~=1
                            imwrite(uint16(temp),   full_filename_Transfer );
                        end
                        if Ignore_last_frame_option==1
                            if ii<  End_frame_at+1
                                imwrite(uint16(temp),   full_filename_Transfer );
                            end
                        end
                        
                        
                    end
                    %                                                     -----
                    
                    avg= avg  + double(temp);
                end
                avg=avg/jj; avg=uint16(avg);
                if ii<10
                    full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t00',num2str(ii),'_ch0',num2str(iii),'.tif'));
                end
                if ii>9 && ii<100
                    full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t0',num2str(ii),'_ch0',num2str(iii),'.tif'));
                end
                if ii>99
                    full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t',num2str(ii),'_ch0',num2str(iii),'.tif'));
                end
                
                full_filename_new=char(regexprep(full_filename_new, '\\\','\')  );
                
                if Ignore_last_frame_option~=1
                    imwrite(avg,  full_filename_new );
                end
                if Ignore_last_frame_option==1
                    if ii<  End_frame_at+1
                        imwrite(uint16(temp),   full_filename_new );
                    end
                end
            end
            close(second_h)
            pause(3)
        end
    end
else%position automated
    listbox1=get(handles.listbox1,'string')
    
    for jjj=1:n
        current_pos=char(listbox1(jjj));
        current_pos=current_pos(strfind(current_pos,'Pos')+3:end)
        
        
        
        
        
        dir_names=dir(char(pathfolder(jjj)))  ;
        temp_filename=dir_names(end-1).name ;
        Backbone_filename=temp_filename(1:strfind(temp_filename,'Pos')-2)
        pause
        if get(handles.Frame_selection_option,'value')==2
            End_frame_at= round((size(dir_names,1)-2)/((End_channel-Start_channel+1)*(End_z_at-Start_z_at+1 )))- last_frame_option ;
            Start_frame_at = 1  ;
        end
        
        
        
        
        
        timebar_TACWrapper(h1,(jjj-0.5)/n)
        set(handles.listbox1,'value',jjj)
        
        for iii=Start_channel:End_channel
            if Transfer_on==1
                mkdir(char(strcat(pathfolder(jjj) ,'\z')));
            end
            %we dont care about channels- only care about the Z_projector!!
            %FOR EACH POSITION- MANUALLY
            second_h  =waitbar(0,'processing. please wait....');
            Position=get(second_h,'Position');
            Position(2)=Position(2)+100;
            set(second_h,'Position',Position)
            
            for  ii=Start_frame_at:End_frame_at
                
                waitbar((ii-Start_frame_at+1)/(End_frame_at-Start_frame_at))
                
                
                
                avg=double(zeros(512,512));
                for jj=Start_z_at:End_z_at
                    %                                       RRRRRRRRRRRRR
                    % RRRRRRR
                    if ii<10
                        full_filename=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,'_Pos', num2str(current_pos),'_ch0',num2str(iii),'_z0',num2str(jj),'_t00',num2str(ii),'.tif'));
                    end
                    if ii>9 && ii<100
                        full_filename=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,'_Pos', num2str(current_pos),'_ch0',num2str(iii),'_z0',num2str(jj),'_t0',num2str(ii),'.tif'));
                    end
                    if ii>99
                        full_filename=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,'_Pos', num2str(current_pos),'_ch0',num2str(iii),'_z0',num2str(jj),'_t',num2str(ii),'.tif'));
                    end
                    
                    full_filename=regexprep(full_filename, '\\\','\') ;
                    
                    temp=imread( full_filename);
                    if Transfer_on==1
                        if ii<10
                            full_filename_Transfer=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,'_Pos', num2str(current_pos), '_t00',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii),'.tif'));
                        end
                        if ii>9 && ii<100
                            full_filename_Transfer=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,'_Pos', num2str(current_pos), '_t0',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii),'.tif'));
                        end
                        if ii>99
                            full_filename_Transfer=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,'_Pos', num2str(current_pos), '_t',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii),'.tif'));
                        end
                        
                        full_filename_Transfer=regexprep(full_filename_Transfer, '\\\','\')  ;
                        if Ignore_last_frame_option~=1
                            imwrite(uint16(temp),   full_filename_Transfer );
                        end
                        if Ignore_last_frame_option==1
                            if ii<  End_frame_at+1
                                imwrite(uint16(temp),   full_filename_Transfer );
                            end
                        end
                        
                        
                    end
                    %                                                     -----
                    
                    avg= avg  + double(temp);
                end
                avg=avg/jj; avg=uint16(avg);
                if ii<10
                    full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,'_Pos', num2str(current_pos),'_t00',num2str(ii),'_ch0',num2str(iii),'.tif'));
                end
                if ii>9 && ii<100
                    full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,'_Pos', num2str(current_pos),'_t0',num2str(ii),'_ch0',num2str(iii),'.tif'));
                end
                if ii>99
                    full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,'_Pos', num2str(current_pos),'_t',num2str(ii),'_ch0',num2str(iii),'.tif'));
                end
                
                full_filename_new=char(regexprep(full_filename_new, '\\\','\')  );
                
                if Ignore_last_frame_option~=1
                    imwrite(avg,  full_filename_new );
                end
                if Ignore_last_frame_option==1
                    if ii<  End_frame_at+1
                        imwrite(uint16(temp),   full_filename_new );
                    end
                end
            end
            close(second_h)
            pause(3)
        end
    end
end
close(h1)





% --- Executes on selection change in Frame_selection_option.
function Frame_selection_option_Callback(hObject, eventdata, handles)
if get(handles.Frame_selection_option,'value')==2
    set(handles.uipanel7,'Visible','off')
elseif get(handles.Frame_selection_option,'value')==1
    set(handles.uipanel7,'Visible','on')
end



% --- Executes during object creation, after setting all properties.
function Frame_selection_option_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Frame_selection_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Ignore_last_frame_option.
function Ignore_last_frame_option_Callback(hObject, eventdata, handles)


if get(hObject,'Value') ==1
    set(handles.Ignore_last_frame,'Visible','on')
else
    set(handles.Ignore_last_frame,'Visible','off')
end


% --------------------------------------------------------------------


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
new_dir=uigetdir('Current Directory','Please select folder containing the subfolders of the positions');
if isequal(new_dir,0)  %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
set(handles.edit1,'string',new_dir)
pathname=strcat(new_dir,'\');
jj=1;


[list_of_folders]=read_list_of_folders(pathname); %maybe 1, maybe more

if isempty(list_of_folders)==1
    return
end


%command error if there is only one position here
set(handles.listbox1,'string',list_of_folders);
set(handles.listbox1,'Max',size(list_of_folders,1)) ;
set(handles.listbox1,'Value',1) ;
set(handles.listbox1,'Min',0);
set(handles.listbox1,'value',1)




% --- Executes on button press in End_channel_at.
function End_channel_at_Callback(hObject, eventdata, handles)
% hObject    handle to End_channel_at (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function End_channel_at_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_channel_at (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in Choose_position.
function Choose_position_Callback(hObject, eventdata, handles)
if get(hObject,'value')==1
    set(handles.text60,'visible','on')
    set(handles.start_pos_at,'visible','on')
else
    set(handles.text60,'visible','off')
    set(handles.start_pos_at,'visible','off')
end

if get(hObject,'value')==2
    set(handles.uipanel8,'Visible','off')
else
    set(handles.uipanel8,'Visible','on')
end

% --- Executes during object creation, after setting all properties.
function Choose_position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Choose_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ignore_last_frame_Callback(hObject, eventdata, handles)
% hObject    handle to Ignore_last_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ignore_last_frame as text
%        str2double(get(hObject,'String')) returns contents of Ignore_last_frame as a double


% --- Executes during object creation, after setting all properties.
function Ignore_last_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ignore_last_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathfolder= get(handles.listbox1,'string');

n=size(pathfolder ,1);
%  h1=timebar_TACWrapper('Save new path for all batch ....');
%  set(h1,'color','w');

for jjj=1:n
    set(handles.listbox1,'value',jjj);
    
    dir_name = char(pathfolder(jjj))   ;
    cd(dir_name) ;
    dir_filename=dir ;
    
    max=0;
    
    
    
    for ii=1:size(dir_filename,1) %loop 1
        temp=char(cellstr(dir_filename(ii).name)) ;
        x=str2num(temp(findstr(temp,'_t')+2:findstr(temp,'_t')+4)) ;
        if max <x
            max=x ;
        end
        
    end
    
    max=num2str(max)
    for ii=1:size(dir_filename,1) %loop 1
        temp=char(cellstr(dir_filename(ii).name))   ;
        if  isempty(strfind(temp,max))~=1
            delete(temp);
        end
    end
    
end





% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ignore_last_frame_option=get(handles.Ignore_last_frame_option,'value');
last_frame_option=str2double(get(handles.Ignore_last_frame,'string'));

pathfolder= get(handles.listbox1,'string');
n=size(pathfolder ,1);
h1=timebar_TACWrapper('Save new path for all batch ....');
set(h1,'color','w');
% Backbone_filename=get(handles.Backbone_filename,'string');
Start_channel=get(handles.Start_channel,'Value')-1  ;
start_pos=str2double(get(handles.start_pos_at,'String'))-1 ;
End_channel=get(handles.End_channel,'Value')-1  ;

Start_z_at =get(handles.Start_z_at,'value')-1;
End_z_at =get(handles.End_z_at,'value')-1;
Start_frame_at =str2double(get(handles.Start_frame_at,'string')) ;
End_frame_at =str2double(get(handles.End_frame_at,'string'))-last_frame_option;


Type_of_projection=get(handles.Type_of_projection,'Value');


for jjj=1:n
    
    
    
    dir_names=dir(char(strcat(pathfolder(jjj)  ,'/z/'))) ;
    temp_filename=dir_names(end-1).name
    Backbone_filename=temp_filename(1:strfind(temp_filename,'Pos')-2)
    if get(handles.Frame_selection_option,'value')==2
        %          End_frame_at= round((size(dir_names,1)-2)/((End_channel-Start_channel+1)*(End_z_at-Start_z_at+1 )));
        End_frame_at= round((size(dir_names,1)-2)/((3)*(End_z_at-Start_z_at+1 )));
        Start_frame_at = 1  ;
    end
    
    
    if (jjj+start_pos)<10
        Pos='_Pos0';
    else
        Pos='_Pos';
    end
    
    timebar_TACWrapper(h1,(jjj-0.5)/n)
    set(handles.listbox1,'value',jjj)
    
    for iii=Start_channel:End_channel
        
        %we dont care about channels- only care about the Z_projector!!
        %FOR EACH POSITION- MANUALLY
        second_h  =waitbar(0,'processing. please wait....');
        Position=get(second_h,'Position');
        Position(2)=Position(2)+100;
        set(second_h,'Position',Position)
        for  ii=Start_frame_at:End_frame_at-3
            
            waitbar((ii-Start_frame_at+1)/(End_frame_at-Start_frame_at))
            
            
            kk=1;
            avg=double(zeros(512,512));
            for jj=Start_z_at:End_z_at
                %                                       RRRRRRRRRRRRR
                
                % 100622_T09-06_Ch GFP-NB2a DN3 on cless DL1_01_Pos06_t001_z01_ch00.tif
                % RRRRRRR
                if ii<10
                    full_filename=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t00',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii) ,'.tif'));
                end
                if ii>9 && ii<100
                    full_filename=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t0',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii) ,'.tif'));
                end
                if ii>99
                    full_filename=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii) ,'.tif'));
                end
                
                full_filename=regexprep(full_filename, '\\\','\') ;
                
                temp=imread( full_filename);
                
                %                                                     -----
                avg = ((avg*(kk-1)+double(temp)))/kk;
                kk = kk+1;
                
            end
            avg=avg/jj; avg=uint16(avg);
            
            
            
            
            
            if ii<10
                full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t00',num2str(ii),'_ch0',num2str(iii),'.tif')) ;
            end
            if ii>9 && ii<100
                full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t0',num2str(ii),'_ch0',num2str(iii),'.tif'));
            end
            if ii>99
                full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t',num2str(ii),'_ch0',num2str(iii),'.tif'));
            end
            
            full_filename_new=char(regexprep(full_filename_new, '\\\','\') ) ;
            
            imwrite(uint16(avg),   full_filename_new );
            
        end
        
        
        
        
        
        
        
        
        
        
        
        close(second_h)
        pause(3)
    end
end
close(h1)

% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Ignore_last_frame_option=get(handles.Ignore_last_frame_option,'value');
last_frame_option=str2double(get(handles.Ignore_last_frame,'string'));

pathfolder= get(handles.listbox1,'string');
n=size(pathfolder ,1);
h1=timebar_TACWrapper('Save new path for all batch ....');
set(h1,'color','w');
% Backbone_filename=get(handles.Backbone_filename,'string');
Start_channel=get(handles.Start_channel,'Value')-1  ;
start_pos=str2double(get(handles.start_pos_at,'String'))-1 ;
End_channel=get(handles.End_channel,'Value')-1  ;

Start_z_at =get(handles.Start_z_at,'value')-1;
End_z_at =get(handles.End_z_at,'value')-1;
Start_frame_at =str2double(get(handles.Start_frame_at,'string')) ;
End_frame_at =str2double(get(handles.End_frame_at,'string'))-last_frame_option;


Type_of_projection=get(handles.Type_of_projection,'Value');


for jjj=1:n
    
    
    
    dir_names=dir(char(strcat(pathfolder(jjj)  ,'/z/'))) ;
    temp_filename=dir_names(end-1).name
    Backbone_filename=temp_filename(1:strfind(temp_filename,'Pos')-2)
    if get(handles.Frame_selection_option,'value')==2
        End_frame_at= round((size(dir_names,1)-2)/((End_channel-Start_channel+1)*(End_z_at-Start_z_at+1 )));
        Start_frame_at = 1  ;
    end
    
    
    if (jjj+start_pos)<10
        Pos='_Pos0';
    else
        Pos='_Pos';
    end
    
    timebar_TACWrapper(h1,(jjj-0.5)/n)
    set(handles.listbox1,'value',jjj)
    
    for iii=Start_channel:End_channel
        
        %we dont care about channels- only care about the Z_projector!!
        %FOR EACH POSITION- MANUALLY
        second_h  =waitbar(0,'processing. please wait....');
        Position=get(second_h,'Position');
        Position(2)=Position(2)+100;
        set(second_h,'Position',Position)
        for  ii=Start_frame_at:End_frame_at-3
            
            waitbar((ii-Start_frame_at+1)/(End_frame_at-Start_frame_at))
            
            
            
            avg=double(zeros(512,512));
            for jj=Start_z_at:End_z_at
                %                                       RRRRRRRRRRRRR
                
                % 100622_T09-06_Ch GFP-NB2a DN3 on cless DL1_01_Pos06_t001_z01_ch00.tif
                % RRRRRRR
                if ii<10
                    full_filename=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t00',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii) ,'.tif'));
                end
                if ii>9 && ii<100
                    full_filename=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t0',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii) ,'.tif'));
                end
                if ii>99
                    full_filename=char(strcat(pathfolder(jjj) ,'\z\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t',num2str(ii),'_z0',num2str(jj),'_ch0',num2str(iii) ,'.tif'));
                end
                
                full_filename=regexprep(full_filename, '\\\','\') ;
                
                temp=imread( full_filename);
                
                %                                                     -----
                
                avg= avg  + double(temp);
            end
            avg=avg/jj; avg=uint16(avg);
            
            
            
            
            
            if ii<10
                full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t00',num2str(ii),'_ch0',num2str(iii),'.tif')) ;
            end
            if ii>9 && ii<100
                full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t0',num2str(ii),'_ch0',num2str(iii),'.tif'));
            end
            if ii>99
                full_filename_new=char(strcat(pathfolder(jjj) ,'\', Backbone_filename,Pos, num2str(jjj+start_pos),'_t',num2str(ii),'_ch0',num2str(iii),'.tif'));
            end
            
            full_filename_new=char(regexprep(full_filename_new, '\\\','\') ) ;
            
            imwrite(uint16(avg),   full_filename_new );
            
        end
        
        
        
        
        
        
        
        
        
        
        
        close(second_h)
        pause(3)
    end
end
close(h1)
