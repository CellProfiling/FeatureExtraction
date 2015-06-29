function varargout = select_label_parameter(varargin)
% SELECT_LABEL_PARAMETER M-file for select_label_parameter.fig
%      SELECT_LABEL_PARAMETER, by itself, creates a new SELECT_LABEL_PARAMETER or raises the existing
%      singleton*.
%
%      H = SELECT_LABEL_PARAMETER returns the handle to a new SELECT_LABEL_PARAMETER or the handle to
%      the existing singleton*.
%
%      SELECT_LABEL_PARAMETER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECT_LABEL_PARAMETER.M with the given input arguments.
%
%      SELECT_LABEL_PARAMETER('Property','Value',...) creates a new SELECT_LABEL_PARAMETER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before select_label_parameter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to select_label_parameter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help select_label_parameter

% Last Modified by GUIDE v2.5 01-Feb-2013 10:39:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @select_label_parameter_OpeningFcn, ...
                   'gui_OutputFcn',  @select_label_parameter_OutputFcn, ...
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


% --- Executes just before select_label_parameter is made visible.
function select_label_parameter_OpeningFcn(hObject, eventdata, handles, varargin)

  
      handles.output = hObject;   
      guidata(hObject, handles);
 
    
    uiwait
 
 
% --- Outputs from this function are returned to the command line.
function varargout = select_label_parameter_OutputFcn(hObject, eventdata, handles) 
 
try
 
 str=get(handles.listbox1,'String');
 
 
 for ii=1:size(str,1)
     
      temp_str=str(ii);
     
      
     if ii==1
          new_str=strcat('''',temp_str,'''');
     end
     
     new_str=strcat(new_str,',''',temp_str,'''');
     
 end
 
varargout{1}= new_str;
 guidata(hObject, handles);
end
 close 
 

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles) 
function popupmenu1_CreateFcn(hObject, eventdata, handles)
 

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles) 
 uiresume
 


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
  n=get(handles.listbox1,'Value') ;
 listbox=get(handles.listbox1,'string')  ; 
 
 if  n==1  
      msgbox('BoundingBox must be labeled!')
       return
 end
 if (n==1 &&  size(listbox,1)>1)
          for ii=1:(size(listbox,1)-1)
               new_listbox(ii)=listbox(ii+1); 
          end
      filename=new_listbox(1);
      filename= strcat(pathname,filename);
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
      filename=char(filename); 
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
