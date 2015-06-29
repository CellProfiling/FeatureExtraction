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
function varargout = TAC_Polarization_Module(varargin)
% TAC_Polarization_Module M-file for TAC_Polarization_Module.fig
%      TAC_Polarization_Module, by itself, creates a new TAC_Polarization_Module or raises the existing
%      singleton*.
%
%      H = TAC_Polarization_Module returns the handle to a new TAC_Polarization_Module or the handle to
%      the existing singleton*.
%
%      TAC_Polarization_Module('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TAC_Polarization_Module.M with the given input arguments.
%
%      TAC_Polarization_Module('Property','Value',...) creates a new TAC_Polarization_Module or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TAC_Polarization_Module_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TAC_Polarization_Module_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TAC_Polarization_Module

% Last Modified by GUIDE v2.5 25-Nov-2012 09:50:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TAC_Polarization_Module_OpeningFcn, ...
    'gui_OutputFcn',  @TAC_Polarization_Module_OutputFcn, ...
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


% --- Executes just before TAC_Polarization_Module is made visible.
function TAC_Polarization_Module_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TAC_Polarization_Module (see VARARGIN)

% Choose default command line output for TAC_Polarization_Module



tic
handles.output = hObject;


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
handles.c=gfp;
handles.xy=[];
handles.flag.Cross=0;
handles.c=gfp;

str=cell(34,1)
str(1)={'1. Uropod'}
str(2)={'2. Eccentricity'}
str(3)={'3. aspect  ratio'}
str(4)={'4. perimeter'}
str(5)={'5. Minoraxislength'}
str(6)={'6. Area'}
str(7)={'7. Majoraxislength'}
str(8)={'8. EquivDiameter'}
str(9)={'9. Orientation'}
str(10)={'10. Circularity'}
str(11)={'11.TI_poi_raw'}
str(12)={'12. TI_control_raw'}
str(13)={'13. TI_poi_unmix'}
str(14)={'14. TI_control_unmix'}
str(15)={'15. mean_poi_raw'}
str(16)={'16. mean_control_raw'}
str(17)={'17. mean_poi_unmix'}
str(18)={'18. mean_control_unmix'}
str(19)={'19. angle1'}
str(20)={'20. angle2'}
str(21)={'21. angle3'}
str(22)={'22. angle4'}
str(23)={'23. angle5'}
str(24)={'24. angle6'}
str(25)={'25. angle7'}
str(26)={'26. angle8'}
str(27)={'27. distance1'}
str(28)={'28. distance2'}
str(29)={'29. distance3'}
str(30)={'30. distance4'}
str(31)={'31. distance5'}
str(32)={'32. distance6'}
str(33)={'33. distance7'}
str(34)={'34. distance8'}

set(handles.uitable1, 'RowName',str)


[a,map]=imread('TACTICS.jpg');
[r,c,d]=size(a);
x=ceil(r/30);
y=ceil(c/30);
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.go,'CData',g);

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = TAC_Polarization_Module_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
handles.G=(ones(size(handles.p1)));

handles.xy=[];
guidata(hObject, handles);

%
%     guidata(hObject,handles)
% %   set(h_rectangle, 'Hittest','Off')   ;
Plot(hObject, eventdata, handles)
Plot4(hObject, eventdata, handles)



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


% --- Executes on selection change in popupmenu4.
function popupmenu2_Callback(hObject, eventdata, handles)
Plot4(hObject, eventdata, handles)
axes(handles.axes4); axis tight
show_boxplot_Callback(hObject, eventdata, handles)




% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)






if get(handles.radiobutton1,'value')==0
    handles.G=(ones(size(handles.p1)));
    handles.xy=[];
    guidata(hObject, handles);
    
end



Plot(hObject, eventdata, handles)
Plot4(hObject, eventdata, handles)



G=handles.G;
U=handles.U;


str=strcat(num2str(nansum(G)),'/',num2str(size(G,1))); set(handles.text1,'string',str)
str=strcat(num2str(nansum(G.*U)),'/',num2str(nansum(U))); set(handles.text2,'string',str)








% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)



if get(handles.radiobutton2,'value')==0
    handles.G=(ones(size(handles.p1)));
    handles.xy=[];
    guidata(hObject, handles);
end

Plot(hObject, eventdata, handles)
Plot4(hObject, eventdata, handles)


G=handles.G;
U=handles.U;
str=strcat(num2str(nansum(G)),'/',num2str(size(G,1))); set(handles.text1,'string',str)
str=strcat(num2str(nansum(G.*U)),'/',num2str(nansum(U))); set(handles.text2,'string',str)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)







index=1; %use axes1 at the moment


eval(strcat('axes(handles.axes',num2str(index),')'));

eval(strcat('point1 =get(handles.axes',num2str(index),',''Position'');'));
point1=point1./2  ;





try
    
    
    
    eval( strcat('Ylim(1)=str2num(get(handles.gate_y1,','''string''))'));
    eval( strcat('Ylim(2)=str2num(get(handles.gate_y2,','''string''))')) ;
    
    eval( strcat('Xlim(1)=str2num(get(handles.gate_x1,','''string''))'));
    eval( strcat('Xlim(2)=str2num(get(handles.gate_x2,','''string''))'));
    
    h_rectangle = imrect(gca,[Xlim(1) Ylim(1) Xlim(2)-Xlim(1) Ylim(2)-Ylim(1)]);
catch
    h_rectangle = imrect(gca);
end

setColor(h_rectangle,[0 0 1]);
xy = wait(h_rectangle) ;

%  WORKING GOOD WHEN GATE FOR VALUES LARGER THAN 1
%     handles.Y1=ceil(xy(1))
%     handles.X1=xy(2)
%     handles.Y=ceil(xy(3))
%     handles.X=xy(4)
xy=[xy(1) xy(2);  xy(1) xy(2)+xy(4);  xy(1)+xy(3) xy(2)+xy(4);   xy(1)+xy(3)  xy(2) ];
if isempty(handles.xy)==1
    handles.xy(1).cdata= xy;
else
    sizey=size(handles.xy,2);
    handles.xy(sizey+1).cdata=xy;
end



guidata(hObject, handles);


X=get(handles.popupmenu1,'value');
Y=get(handles.popupmenu3,'value');


eval(strcat('p_X=handles.p',num2str(X),';'))
eval(strcat('p_Y=handles.p',num2str(Y),';'))

for ii=1:size(handles.xy,2)
    xy=handles.xy(ii).cdata;
    in = inpolygon(p_X,p_Y,xy(:,1),xy(:,2)); in=double(in);
    in(in==0)=nan;
    in_matrix(ii,:)=in;
end

if size(in_matrix,1)>1
    
    in=   nansum(in_matrix);
    
end

in(in==0)=nan;


if size(in,2)>1
    handles.G=in';
else
    handles.G=in ;
end
guidata(hObject, handles);






Plot4(hObject, eventdata, handles); axes(handles.axes4);

Plot(hObject, eventdata, handles)

show_boxplot_Callback(hObject, eventdata, handles)




G=handles.G;
U=handles.U;
str=strcat(num2str(nansum(G)),'/',num2str(size(G,1))); set(handles.text1,'string',str)
str=strcat(num2str(nansum(G.*U)),'/',num2str(nansum(U))); set(handles.text2,'string',str)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)


% index=1
%
% eval(strcat('axes(handles.axes',num2str(index),')'));
%
%
% try
% h_rectangle = imrect(gca,[handles.Y1 handles.X1 handles.Y   handles.X]  );
%  setColor(h_rectangle,[0 0 1]);
%  xy = wait(h_rectangle)
%
%    y=xy(1,1)
%   x=xy(1,2)
%
%     xy=round(xy);
%     handles.Y1= (xy(1))
%     handles.X1=xy(2)
%     handles.Y= (xy(3))
%     handles.X=xy(4)
%    x=xy(1,2)
%
%     guidata(hObject,handles)
%   set(h_rectangle, 'Hittest','Off')   ;
%
%     Plot(hObject, eventdata, handles)
%
%     guidata(hObject, handles);
%   h_rectangle=rectangle('Position', xy,'LineWidth',5,'LineStyle','--','EdgeColor','m');
%
%   h_rectangle=rectangle('Position', xy,'LineWidth',5,'LineStyle','--','EdgeColor','m');
%   h_rectangle=  rectangle('Position',[handles.Y1 handles.X1 handles.Y   handles.X],'LineWidth',5,'LineStyle','-','EdgeColor','m');
%     set(h_rectangle, 'Hittest','Off')   ;
%
%
%   X_min=handles.Y1
%   X_max=handles.Y1+ handles.Y
%   Y_min=handles.X1
%   Y_max=handles.X1+ handles.X
%
%
%
%
%
%
% X=get(handles.popupmenu1,'value');
% Y=get(handles.popupmenu4,'value');
%
%
%
%
% X_min
% X_max
% Y_min
% Y_max
%
%
%
%    handles.wtp_one=ones( 1,468);
%    handles.wtp_one=ones( 1,435);
%    handles.wtpp_one=ones( 1,403);
%    handles.wtpp_one=ones(1,444);
%
%  guidata(hObject, handles);
%
% if get(handles.radiobutton1,'value')==1
%   eval(strcat('handles.wtp_one(handles.p',num2str(X),'_wt<X_min)=nan;'))
%   eval(strcat('handles.wtp_one(handles.p',num2str(X),'_wt>X_max)=nan;'))
%   eval(strcat('handles.wtp_one(handles.p',num2str(Y),'_wt<Y_min)=nan;'))
%   eval(strcat('handles.wtp_one(handles.p',num2str(Y),'_wt>Y_max)=nan;'))
%
% end
%
% if get(handles.radiobutton2,'value')==1
%    eval(strcat('handles.wtp_one(handles.p',num2str(X),'_wt<X_min)=nan;'))
%   eval(strcat('handles.wtp_one(handles.p',num2str(X),'_wt>X_max)=nan;'))
%   eval(strcat('handles.wtp_one(handles.p',num2str(Y),'_wt<Y_min)=nan;'))
%   eval(strcat('handles.wtp_one(handles.p',num2str(Y),'_wt>Y_max)=nan;'))
% end
%
% if get(handles.radiobutton3,'value')==1
%    eval(strcat('handles.wtpp_one(handles.pp',num2str(X),'_wt<X_min)=nan;'))
%   eval(strcat('handles.wtpp_one(handles.pp',num2str(X),'_wt>X_max)=nan;'))
%   eval(strcat('handles.wtpp_one(handles.pp',num2str(Y),'_wt<Y_min)=nan;'))
%   eval(strcat('handles.wtpp_one(handles.pp',num2str(Y),'_wt>Y_max)=nan;'))
% end
%
% if get(handles.radiobutton4,'value')==1
%    eval(strcat('handles.wtpp_one(handles.pp',num2str(X),'_wt<X_min)=nan;'))
%    eval(strcat('handles.wtpp_one(handles.pp',num2str(X),'_wt>X_max)=nan;'))
%    eval(strcat('handles.wtpp_one(handles.pp',num2str(Y),'_wt<Y_min)=nan;'))
%    eval(strcat('handles.wtpp_one(handles.pp',num2str(Y),'_wt>Y_max)=nan;'))
% end
%
%
%
%
%  guidata(hObject, handles);
%   show_boxplot_Callback(hObject, eventdata, handles)
%   Plot4(hObject, eventdata, handles)
%
%
%
%
%
% catch % if there was not gate open, just create new one
%      Untitled_2_Callback(hObject, eventdata, handles)
%     end
%


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3



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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu4.
function popupmenu3_Callback(hObject, eventdata, handles)


handles.G=(ones(size(handles.p1)));

handles.xy=[];
guidata(hObject, handles);

%
%     guidata(hObject,handles)
% %   set(h_rectangle, 'Hittest','Off')   ;
Plot(hObject, eventdata, handles)
Plot4(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
function axes1_ButtonDownFcn(hObject, eventdata, handles)
if  toc<0.5
    return
end

tic
sel_typ = get(gcbf,'SelectionType')  ;
point1 = get(hObject,'CurrentPoint')   ;
%1. Getting index of box
%2 getting data from the indexed box
%3 getting case: parentsl. d1 and d2, ratio of d1 and d2. each case
%different data case
%    4. getting minimum between mouse position and nearest point will give
%    the indexed data set for a population within the box.

if strcmp(sel_typ,'normal')==1
    'free option'
end

if strcmp(sel_typ,'alt')==1
    'free option'
end
if strcmp(sel_typ,'extend')==1
    'extend'
end


X=get(handles.popupmenu1,'value');
Y=get(handles.popupmenu3,'value');
G=handles.G;
U=handles.U;
if get(handles.radiobutton1,'value')==1
    XX=eval(strcat('handles.p',num2str(X)));
    YY=eval(strcat('handles.p',num2str(Y)));
else
    if get(handles.radiobutton2,'value')==1
        XX=eval(strcat('handles.p',num2str(X),'.*U'));
        YY=eval(strcat('handles.p',num2str(Y),'.*U'));
    end
end


if  size(YY,2)>size(YY,1)
    YY=YY';
end
if  size(XX,2)>size(XX,1)
    XX=XX';
end



index=1
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
eval(strcat('curr_lim2=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
Range1=abs(curr_lim1(1))+abs(curr_lim1(2));
Range2=abs(curr_lim2(1))+abs(curr_lim2(2));
Prop=Range1/Range2

XY=   (XX-point1(1)).^2+ Prop*(YY-point1(4)).^2;%PITAGORAS
Min =find(ismember(XY,nanmin(XY))) ;
set(handles.Cell,'string',num2str(Min))
Visual_Callback(hObject, eventdata, handles)
Plot(hObject, eventdata, handles)
Plot4(hObject, eventdata, handles)
set(gcf,'Colormap',handles.c);
guidata(hObject, handles);
cell_index =handles.cell_index ;
Index =find(ismember(cell_index , cell_index(Min)));
set(handles.param_edit1,'string',num2str(1));% 'points before selected
set(handles.param_edit2,'string',num2str(length(Index)));% 'points before selected

ii=1;
while ii<300 %up to 300 parameters (but can be changed to higer value)
    try
        eval(['stats(',num2str(ii),') =  {handles.p',num2str(ii),'( Min)};']);
    catch
        ii=300 ;
    end
    ii=ii+1;
end

set(handles.uitable1, 'Data' ,stats')


% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)

point  = get(hObject,'CurrentPoint')
xy  =get(handles.axes1, 'Position')
%loc =get([handles. coordinates,handles. coordinates2...], 'Position');
if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
    index=1;
else
    xy  =get(handles.axes4, 'Position') ;  %loc =get([handles. coordinates,handles. coordinates2...], 'Position');
    if xy(1)<point(1,1) && xy(2)<point(1,2) && point(1,1)<(xy(1)+xy(3)) && point(1,2)<(xy(2)+xy(4))
        index=4;
    else
        
        set(gcf,'Pointer','hand')
    end ;end

try
    
    if eventdata.VerticalScrollCount>0
        zoom_in(handles,index)
    else
        zoom_out(handles, index)
    end
end
%   ---------------------------
function zoom_in(handles, index,point1)
if nargin==2
    eval(strcat('point1 =get(handles.axes',num2str(index),',''CurrentPoint'');'));
end
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
eval(strcat('curr_lim2=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
range_data1 = abs(diff(curr_lim1)) ;
range_data2 = abs(diff(curr_lim2)) ;
range_data1 = range_data1+range_data1*0.1;
range_data2 = range_data2+range_data2*0.1 ;
Xlim=[point1(1)-range_data1/2  point1(1)+range_data1/2];
Ylim=[point1(4)-range_data2/2  point1(4)+range_data2/2];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Xlim);'))
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],Ylim);'))
%  --------------------------------------------------
function zoom_out(handles, index,point1)
if nargin==2
    eval(strcat('point1 =get(handles.axes',num2str(index),',''CurrentPoint'');'));
end
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
eval(strcat('curr_lim2=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
range_data1 = abs(diff(curr_lim1)) ;
range_data2 = abs(diff(curr_lim2)) ;
range_data1 = range_data1-range_data1*0.1;
range_data2 = range_data2-range_data2*0.1 ;
Xlim=[point1(1)-range_data1/2  point1(1)+range_data1/2];
Ylim=[point1(4)-range_data2/2  point1(4)+range_data2/2];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Xlim);'))
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],Ylim);'))
%  --------------------------------------------------

function Visual_CreateFcn(hObject, eventdata, handles)

function popupmenu4_Callback(hObject, eventdata, handles)
Plot4(hObject, eventdata, handles)
axes(handles.axes4); axis tight
show_boxplot_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function axes4_ButtonDownFcn(hObject, eventdata, handles)
if  toc<0.5
    return
end
tic

sel_typ = get(gcbf,'SelectionType') ;
point1 = get(hObject,'CurrentPoint') ;
%1. Getting index of box
%2 getting data from the indexed box
%3 getting case: parentsl. d1 and d2, ratio of d1 and d2. each case
%different data case
%    4. getting minimum between mouse position and nearest point will give
%    the indexed data set for a population within the box.


if strcmp(sel_typ,'normal')==1
    'free option'
end

if strcmp(sel_typ,'alt')==1
    'free option'
end
if strcmp(sel_typ,'extend')==1
    'extend'
end

G=handles.G;
U=handles.U;

X=get(handles.popupmenu2,'value');
Y=get(handles.popupmenu4,'value');



if get(handles.checkbox5,'value')==1
    
    if get(handles.radiobutton1,'value')==1
        XX=eval(strcat('handles.p',num2str(X)));
        YY=eval(strcat('handles.p',num2str(Y)));
    else
        if get(handles.radiobutton2,'value')==1
            XX=eval(strcat('handles.p',num2str(X),'.*U'));
            YY=eval(strcat('handles.p',num2str(Y),'.*U'));
        end
    end
else
    if get(handles.radiobutton1,'value')==1
        XX=eval(strcat('handles.p',num2str(X),'.*G'));
        YY=eval(strcat('handles.p',num2str(Y),'.*G'));
    else
        if get(handles.radiobutton2,'value')==1
            XX=eval(strcat('handles.p',num2str(X),'.*U.*G'));
            YY=eval(strcat('handles.p',num2str(Y),'.*U.*G'));
        end
    end
end

%
%   wtp_one(isnan(wtp_one))=0;  wtp_one(wtp_one==1)=nan;   wtp_one(wtp_one==0)=1;
%
% % % % %       if get(handles.radiobutton1,'value')==1
% % % % %           if get(handles.checkbox5,'value')==1
% % % % %           XX=data.X(1).cdata;
% % % % %           YY=data.Y(1).cdata;
% % % % %           else
% % % % %           XX=data.X(1).cdata.*G;
% % % % %           YY=data.Y(1).cdata.*G;
% % % % %           end
% % % % %       end
% % % % %
% % % % %          if get(handles.radiobutton2,'value')==1
% % % % %           if get(handles.checkbox5,'value')==1
% % % % %           XX=data.X(2).cdata;
% % % % %           YY=data.Y(2).cdata;
% % % % %           else
% % % % %           XX=data.X(2).cdata.*G;
% % % % %           YY=data.Y(2).cdata.*G;
% % % % %           end
% % % % %          end

%
%
%  if get(handles.radiobutton1,'value')==1
%         XX=eval(strcat('handles.p',num2str(X)));
%         YY=eval(strcat('handles.p',num2str(Y)));
%  else
%       if get(handles.radiobutton2,'value')==1
%           XX=eval(strcat('handles.p',num2str(X),'.*U'));
%           YY=eval(strcat('handles.p',num2str(Y),'.*U'));
%       end
%  end



if  size(YY,2)>size(YY,1)
    YY=YY';
end
if  size(XX,2)>size(XX,1)
    XX=XX';
end

index=2
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
eval(strcat('curr_lim2=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
Range1=abs(curr_lim1(1))+abs(curr_lim1(2));
Range2=abs(curr_lim2(1))+abs(curr_lim2(2));
Prop=Range1/Range2 ;
XY=   (XX-point1(1)).^2+ Prop*(YY-point1(4)).^2;%PITAGORAS
Min =find(ismember(XY,nanmin(XY))) ;

set(handles.Cell,'string',num2str(Min))
Plot4(hObject, eventdata, handles)
Plot(hObject, eventdata, handles)
Visual_Callback(hObject, eventdata, handles)
set(gcf,'Colormap',handles.c);
guidata(hObject, handles);
cell_index=handles.cell_index;
Index =find(ismember(cell_index, cell_index(Min)));
set(handles.param_edit1,'string',num2str(1));% 'points before selected
set(handles.param_edit2,'string',num2str(length(Index)));% 'points before selected
ii=1;
while ii<200
    try
        eval(['stats(',num2str(ii),') =  {handles.p',num2str(ii),'( Min)};']);
    catch
        ii=200 ;
    end
    ii=ii+1;
end

set(handles.uitable1, 'Data' ,stats')
% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)

Plot(hObject, eventdata, handles ,1)
hold on

X=get(handles.popupmenu1,'value');
Y=get(handles.popupmenu3,'value');




try
    xy= handles.xy;
    plot(xy(:,1),xy(:,2),'Color',[0 0 0],'LineWidth',2,'Hittest','Off');
    plot([xy(1,1) xy(end,1) ],[ xy(1,2) xy(end,2)],'Color',[0 0 0],'LineWidth',2,'Hittest','Off');
end


legend('All','only uropodic')
%     title('Cherry Tubulin MLA- gating');

x_str=get(handles.popupmenu1,'string');  x_str= char(x_str(X));  y_str=get(handles.popupmenu4,'string'); y_str=char(y_str(Y));
xlabel(x_str);  ylabel(y_str);
%

%
eval(strcat('X=handles.p',num2str(X)))
eval(strcat('Y=handles.p',num2str(Y)))

%
%  % This script includes a calculation of r-squared.
x = X;
y = Y;
pLinear = polyfit(x,y,1);

xLinear = min(x):0.1:max(x);
yLinear = pLinear(1)*xLinear+pLinear(2);
plot(  xLinear,yLinear,'k')
title('Linear fit')
% There is a polyvar function that helps with calculating J but it is
% pretty complicated to explain so I'll do J the long way.
JLinear = sum((pLinear(1)*x+pLinear(2)-y).^2);
disp(['J for a linear fit is: ' num2str(JLinear)])
yBar = mean(y);
S = sum((y-yBar).^2);
rSquaredLinear = 1-JLinear/S;
title(['r-Squared for linear fit: ' num2str(rSquaredLinear)])

% % %  yh=polyval(P,x)
% % % residuals=y-yh
% % % norm(residuals) %should be same as S.normr
% % % %and it is
% % %
% % %
% % % rss=sum((yh-mean(y)).^2)
% % % tss=sum((y -mean(y)).^2)
% %
% % % % My definition of R^2:
% % %
% % % Rsquared=rss/tss
% % % Rsquared=1-(rss/tss)
% % % r=corr(X,Y,'type','Spearman')
% % % n=length(X);
% % % r/((1-r^2)\(n-2)) ;
% % %
% % %

% % %


% --------------------------------------------------------------------
function uipushtool3_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Plot4(hObject, eventdata, handles ,1)



%%%%%%%%%%%%%%%%%%%%%
%
%
%   eval(strcat('data(1).cdata=handles.p',num2str(X),'_wt.*handles.wtp_one'))
%   eval(strcat('data(2).cdata=handles.p',num2str(Y),'_wt.*handles.wtp_one'))
%   eval(strcat('data(3).cdata=handles.p',num2str(X),'_wt.*handles.wtp_one'))
%   eval(strcat('data(4).cdata=handles.p',num2str(Y),'_wt.*handles.wtp_one'))
%   eval(strcat('data(5).cdata=handles.pp',num2str(X),'_wt.*handles.wtpp_one'))
%   eval(strcat('data(6).cdata=handles.pp',num2str(Y),'_wt.*handles.wtpp_one'))
%   eval(strcat('data(7).cdata=handles.pp',num2str(X),'_wt.*handles.wtpp_one'))
%   eval(strcat('data(8).cdata=handles.pp',num2str(Y),'_wt.*handles.wtpp_one'))
%
%
% set(gcf,'userdata',data)
%








hold on

X=get(handles.popupmenu2,'value');
Y=get(handles.popupmenu4,'value');

%
%
%
% try
%  xy= handles.xy;
%        plot(xy(:,1),xy(:,2),'Color',[0 0 0],'LineWidth',2,'Hittest','Off');
%     plot([xy(1,1) xy(end,1) ],[ xy(1,2) xy(end,2)],'Color',[0 0 0],'LineWidth',2,'Hittest','Off');
% end
%
%   eval(strcat('data(1).cdata=handles.p',num2str(X)))
%   eval(strcat('data(2).cdata=handles.p',num2str(Y)))
%   eval(strcat('data(3).cdata=handles.pp',num2str(X)))
%   eval(strcat('data(4).cdata=handles.pp',num2str(Y)))
%   eval(strcat('data(5).cdata=handles.ppp',num2str(X)))
%   eval(strcat('data(6).cdata=handles.ppp',num2str(Y)))
%

%
% set(gcf,'userdata',data)



%     title('Cherry Tubulin MLA- gating');

x_str=get(handles.popupmenu1,'string');  x_str= char(x_str(X));  y_str=get(handles.popupmenu4,'string'); y_str=char(y_str(Y));
xlabel(x_str);  ylabel(y_str);
%
hold on
try
    xy=handles.User_Selection
    if isempty(xy)~=1
        scatter(xy(1), xy(2),'Marker','+'    ,'CData',[0 0 0],'Hittest','Off')
    end
    
end



%
%
%
% if get(handles.checkbox5,'value')==1
%    %legend('WT gated','WT ungated','wt gated','wt ungated' )
title('Data back-gated');
%
% else
%      %  legend('WT gated','WT ungated','wt gated','wt ungated' )
%     title('Data back-gated');
%
%
% end


%     xlabel('GFP-Numb( U+L)');  ylabel('GFP-Numb Y rotaion (U_{i}^{2}-L_{i}^{2})/(U_{i}^{2}+L_{i}^{2})');
%
axis tight
%
%
%
%
%
%
% matrix=nan(468,2); matrix(1:length(h1),1)=h1; matrix(1:length(h2),2)=h2
%
%    xlswrite(  'MLA_data_ratio_gated.xls',matrix )

% --------------------------------------------------------------------
function uipushtool4_ClickedCallback(hObject, eventdata, handles)
Visual_Callback(hObject, eventdata, handles,1)




% --------------------------------------------------------------------
function uipushtool5_ClickedCallback(hObject, eventdata, handles)


%
% %
%   X=get(handles.popupmenu1,'value');
%   Y=get(handles.popupmenu4,'value');
% %
%
%
% % if get(handles.radiobutton1,'value')==1
%   eval(strcat('data3(1:468,1)=handles.p',num2str(X),'_wt.*handles.wtp_one'))
%   eval(strcat('data3(1:468,3)=handles.p',num2str(Y),'_wt.*handles.wtp_one'))
%
%     eval(strcat('data3(1:435,2)=handles.p',num2str(X),'_wt.*handles.wtp_one'))
%   eval(strcat('data3(1:435,4)=handles.p',num2str(Y),'_wt.*handles.wtp_one'))
%
%     eval(strcat('data3(1:403,5)=handles.pp',num2str(X),'_wt.*handles.wtpp_one'))
%   eval(strcat('data3(1:403,7)=handles.pp',num2str(Y),'_wt.*handles.wtpp_one'))
%
%     eval(strcat('data3(1:444,6)=handles.pp',num2str(X),'_wt.*handles.wtpp_one'))
%   eval(strcat('data3(1:444,8)=handles.pp',num2str(Y),'_wt.*handles.wtpp_one'))
%
%
%
%
%
% figure
% cla
%  hold on
%
%
%
%
show_boxplot_Callback(hObject, eventdata, handles,1)
%
% %
%
%    a=nanmean(data3); a=a(1:8);
%    b=nanstd(data3)   ; b=b(1:8);
%    aa=nan(size(a));  bb=nan(size(b));   aa(1)=a(1);   aa(3)=a(3);   bb(1)=b(1);   bb(3)=b(3);   errorbar(aa,bb,'xb')
%      aa=nan(size(a));  bb=nan(size(b)); aa(2)=a(2);   aa(4)=a(4);   bb(2)=b(2);   bb(4)=b(4);   errorbar(aa,bb,'xg')
%    aa=nan(size(a));  bb=nan(size(b));   aa(5)=a(5);   aa(7)=a(7);   bb(5)=b(5);   bb(7)=b(7);   errorbar(aa,bb,'xr')
%      aa=nan(size(a));  bb=nan(size(b)); aa(6)=a(6);   aa(8)=a(8);   bb(6)=b(6);   bb(8)=b(8);   errorbar(aa,bb,'xm')

% axis tight
% ylabel('(mean gated X and Y')
% set(gcf,'userdata',data3)



% --------------------------------------------------------------------
function uipushtool6_ClickedCallback(hObject, eventdata, handles)


index=1; %use axes1 at the moment


eval(strcat('point1 =get(handles.axes',num2str(index),',''Position'');'));
point1=point1./2;
eval(strcat('axes(handles.axes',num2str(index),')'));
h_rectangle = impoly(gca);




setColor(h_rectangle,[0 0.8 0.2]);
xy = wait(h_rectangle)


if isempty(handles.xy)==1
    handles.xy(1).cdata= xy;
else
    sizey=size(handles.xy,2);
    handles.xy(sizey+1).cdata=xy;
end







X=get(handles.popupmenu1,'value');
Y=get(handles.popupmenu3,'value');





eval(strcat('p_X=handles.p',num2str(X),';'))
eval(strcat('p_Y=handles.p',num2str(Y),';'))



for ii=1:size(handles.xy,2)
    xy=handles.xy(ii).cdata;
    in = inpolygon(p_X,p_Y,xy(:,1),xy(:,2)); in=double(in);
    in(in==0)=nan;
    in_matrix(ii,:)=in;
end

if size(in_matrix,1)>1
    
    in=   nansum(in_matrix);
    
end


in(in==0)=nan;

if size(in,2)>1
    handles.G=in';
else
    handles.G=in ;
end
guidata(hObject, handles);















Plot(hObject, eventdata, handles)
show_boxplot_Callback(hObject, eventdata, handles)
Plot4(hObject, eventdata, handles)
G=handles.G;
U=handles.U;
str=strcat(num2str(nansum(G)),'/',num2str(size(G,1))); set(handles.text1,'string',str)
str=strcat(num2str(nansum(G.*U)),'/',num2str(nansum(U))); set(handles.text2,'string',str)

% --------------------------------------------------------------------
function uipushtool7_ClickedCallback(hObject, eventdata, handles)
Untitled_2_Callback(hObject,eventdata,guidata(hObject))


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Plot4(hObject, eventdata, handles)
show_boxplot_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)



% --- Executes on button press in pushbutton19.




cell_index=handles.cell_index;
Min=str2num(get(handles.Cell,'string'))
Index =find(ismember(cell_index, cell_index(Min)));


Red_factor=get(handles.Red_factor,'value');
Green_factor=get(handles.Green_factor,'value')      ;
Div_start_at_frame=find(ismember(Index,Min));
start_at_frame=str2double(get(handles.param_edit1,'string'));% 'points before selected
end_at_frame=str2double(get(handles.param_edit2,'string')); % 'points after selected

Div_start_at_frame= Div_start_at_frame-start_at_frame;


Visual=   get(handles.Visual,'value');
switch Visual
    case 1
        for ii=1:length(Index)
            Data(ii).cdata=handles.poi_mean_projected(Index(ii)).cdata;
        end
        
        
    case 2
        for ii=1:length(Index)
            Data(ii).cdata=handles.control_mean_projected(Index(ii)).cdata;
        end
        
        
    case 3
        for ii=1:length(Index)
            Data(ii).cdata=handles.poi_unmixed(Index(ii)).cdata;
        end
        
    case 4
        for ii=1:length(Index)
            Data(ii).cdata=handles.control_unmixed(Index(ii)).cdata;
        end
    case  5
        
        
        for ii=1:length(Index)
            try
                a=   handles.control_mean_projected(Index(ii)).cdata ;
                b= handles.poi_mean_projected(Index(ii)).cdata  ;
                a=uint8(255*(a./max(max(a))))*Red_factor; b=uint8(255*(b./max(max(b)))).*Green_factor; c=uint8(0*a);
                Data(ii).cdata=cat(3,a,b,c);
            catch
                Data(ii).cdata=nan;
            end
            
        end
        
        
        
    case 6
        for ii=1:length(Index)
            try
                a=  handles.control_unmixed(Index(ii)).cdata;
                b=  handles.poi_unmixed(Index(ii)).cdata;
                a=uint8(255*(a./max(max(a))))*Red_factor; b=uint8(255*(b./max(max(b)))).*Green_factor; c=uint8(0*a);
                Data(ii).cdata=cat(3,a,b,c);
            catch
                Data(ii).cdata=nan;
            end
        end
        
        
        
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




if   Visual>4
    D= uint8(zeros(max_x,max_y,3,ii));  %uint8 or 8, can cause some bugs
    for ii=1:size(Data,2)
        D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,:,ii)= Data(ii).cdata  ;
    end
else
    D=zeros(max_x,max_y,1,ii);
    for ii=1:size(Data,2)
        D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,1,ii)=Data(ii).cdata(:,:) ;
    end
end








scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
figure('color','w','units','pixels','position', scrsz) ;



z=[start_at_frame, end_at_frame];







montage(D, 'DisplayRange', [],  'Size',[((start_at_frame+end_at_frame)/min(z))  min(z)]);
set(gcf,'Colormap',handles.c);

ylabel(['All gated cells  '   num2str(Div_start_at_frame)     '  frames in total'])

%
%
% cell_index=handles.cell_index
% Min=handles.Min
%  Index =find(ismember(cell_index, cell_index(Min)))
%
%
% %   Uropod=cumsum(Uropod)
%
%
%
% %
% %          Index1  =   Index1(1);  % global location of selected uropodic cell
% %          Index2= cell_index( Index1)  ;                 % global index of selected uropodic cell
% %          Index3= find(ismember( cell_index,Index2)); % global index of all locations of selected uropodic cell
% %          Index4=find(ismember(Index3,Index1));






function number_bins_Callback(hObject, eventdata, handles)
% hObject    handle to number_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number_bins as text
%        str2double(get(hObject,'String')) returns contents of number_bins as a double


% --- Executes during object creation, after setting all properties.
function number_bins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in smooth_on.
function smooth_on_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in plot_option.
function plot_option_Callback(hObject, eventdata, handles)
% hObject    handle to plot_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plot_option contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot_option
Plot(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function plot_option_CreateFcn(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function pushbutton22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in show_centroids.
function show_centroids_Callback(hObject, eventdata, handles)
% hObject    handle to show_centroids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
Visual_Callback(hObject, eventdata, handles)

% Hint: get(hObject,'Value') returns toggle state of show_centroids


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)

handles.c=change_LUT ;
guidata(hObject,handles);
set(gcf,'colormap',handles.c);








% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)



handles.G=(ones(size(handles.p1)));

handles.xy=[];
guidata(hObject, handles);

%
%     guidata(hObject,handles)
% %   set(h_rectangle, 'Hittest','Off')   ;
Plot(hObject, eventdata, handles)
Plot4(hObject, eventdata, handles)


function Red_factor_Callback(hObject, eventdata, handles)
% hObject    handle to Red_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Visual_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Red_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Red_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Green_factor_Callback(hObject, eventdata, handles)
% hObject    handle to Green_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Visual_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Green_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Green_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
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


% --- Executes on key press with focus on Y_lim_start1 and none of its controls.
function Y_lim_start1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Y_lim_start1 (see GCBO)



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



function X_lim1_Callback(hObject, eventdata, handles)
% hObject    handle to X_lim1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_lim1 as text
%        str2double(get(hObject,'String')) returns contents of X_lim1 as a double


% --- Executes during object creation, after setting all properties.
function X_lim1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_lim1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X_lim2_Callback(hObject, eventdata, handles)
% hObject    handle to X_lim2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_lim2 as text
%        str2double(get(hObject,'String')) returns contents of X_lim2 as a double


% --- Executes during object creation, after setting all properties.
function X_lim2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_lim2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on Y_lim_end1 and none of its controls.
function Y_lim_end1_KeyPressFcn(hObject, eventdata, handles)


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



function Y_lim_end2_Callback(hObject, eventdata, handles)
% hObject    handle to Y_lim_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_lim_end1 as text
%        str2double(get(hObject,'String')) returns contents of Y_lim_end1 as a double


% --- Executes during object creation, after setting all properties.
function Y_lim_end2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_lim_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_lim_start2_Callback(hObject, eventdata, handles)
% hObject    handle to Y_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_lim_start1 as text
%        str2double(get(hObject,'String')) returns contents of Y_lim_start1 as a double


% --- Executes during object creation, after setting all properties.
function Y_lim_start2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X_lim_start2_Callback(hObject, eventdata, handles)
% hObject    handle to X_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_lim_start1 as text
%        str2double(get(hObject,'String')) returns contents of X_lim_start1 as a double


% --- Executes during object creation, after setting all properties.
function X_lim_start2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X_lim_end2_Callback(hObject, eventdata, handles)
% hObject    handle to X_lim_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_lim_end1 as text
%        str2double(get(hObject,'String')) returns contents of X_lim_end1 as a double


% --- Executes during object creation, after setting all properties.
function X_lim_end2_CreateFcn(hObject, eventdata, handles)

% --- Executes on key press with focus on pushbutton26 and none of its controls.
function pushbutton26_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function param_edit1_Callback(hObject, eventdata, handles)
% hObject    handle to param_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param_edit1 as text
%        str2double(get(hObject,'String')) returns contents of param_edit1 as a double


% --- Executes during object creation, after setting all properties.
function param_edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param_edit2_Callback(hObject, eventdata, handles)
% hObject    handle to param_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param_edit2 as text
%        str2double(get(hObject,'String')) returns contents of param_edit2 as a double


% --- Executes during object creation, after setting all properties.
function param_edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)




in1= handles.wtp_one





Index = find(~isnan(in1))




Red_factor=get(handles.Red_factor,'value');
Green_factor=get(handles.Green_factor,'value')      ;

start_at_frame=str2double(get(handles.N,'string'));% 'points before selected
end_at_frame=str2double(get(handles.M,'string')); % 'points after selected



Visual=   get(handles.Visual,'value');
switch Visual
    case 1
        for ii=1:length(Index)
            Data(ii).cdata=handles.poi_mean_projected(Index(ii)).cdata;
        end
        
        
    case 2
        for ii=1:length(Index)
            Data(ii).cdata=handles.control_mean_projected(Index(ii)).cdata;
        end
        
        
    case 3
        for ii=1:length(Index)
            Data(ii).cdata=handles.poi_unmixed(Index(ii)).cdata;
        end
        
    case 4
        for ii=1:length(Index)
            Data(ii).cdata=handles.control_unmixed(Index(ii)).cdata;
        end
    case  5
        
        
        for ii=1:length(Index)
            try
                a=   handles.control_mean_projected(Index(ii)).cdata;
                b= handles.poi_mean_projected(Index(ii)).cdata;
                a=uint8(255*(a./max(max(a))))*Red_factor; b=uint8(255*(b./max(max(b)))).*Green_factor; c=uint8(0*a);
                Data(ii).cdata=cat(3,a,b,c);
            catch
                Data(ii).cdata=nan;
            end
            
        end
        
        
        
    case 6
        for ii=1:length(Index)
            try
                a=  handles.control_unmixed(Index(ii)).cdata;
                b=  handles.poi_unmixed(Index(ii)).cdata;
                a=uint8(255*(a./max(max(a))))*Red_factor; b=uint8(255*(b./max(max(b)))).*Green_factor; c=uint8(0*a);
                Data(ii).cdata=cat(3,a,b,c);
            catch
                Data(ii).cdata=nan;
            end
        end
        
        
        
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

save Data Data


if   Visual>4
    D= uint8(zeros(max_x,max_y,3,ii));  %uint8 or 8, can cause some bugs
    for ii=1:size(Data,2)
        D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,:,ii)= Data(ii).cdata  ;
    end
else
    D=zeros(max_x,max_y,1,ii);
    for ii=1:size(Data,2)
        D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,1,ii)=Data(ii).cdata(:,:) ;
    end
end








scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
figure('color','w','units','pixels','position', scrsz) ;


start_at_frame
end_at_frame
ii=rand(1,ii); [a1,ii]=sort(ii) ;






for jj=1:start_at_frame*end_at_frame
    D2(:,:,:,jj)=  D(:,:,:,ii(jj));
end

%


montage(D2, 'DisplayRange', [],  'Size',[ start_at_frame end_at_frame ]);
set(gcf,'Colormap',handles.c);


ylabel([' tracked gated cells  '   num2str(length(Index))     '  frames in total'])




% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)




% --- Executes on button press in Merge_histograms.
function Merge_histograms_Callback(hObject, eventdata, handles)

show_boxplot_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function uipushtool10_ClickedCallback(hObject, eventdata, handles)

if  handles.flag.Cross==1
    handles.flag.Cross=0;
    guidata(hObject, handles);
    show_boxplot_Callback(hObject, eventdata, handles )
    Plot(hObject, eventdata, handles)
    Plot4(hObject, eventdata, handles)
    Visual_Callback(hObject, eventdata, handles)
else
    handles.flag.Cross=1;
    index=1
    eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
    eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
    
    
    eval(strcat('axes(handles.axes',num2str(index),')'));
    hold on
    plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)],'Hittest','Off')
    plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ],'Hittest','Off')
    
    index=2
    eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
    eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
    
    
    eval(strcat('axes(handles.axes',num2str(index),')'));
    hold on
    plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)],'Hittest','Off')
    plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ],'Hittest','Off')
    
    index=4
    eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
    eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
    
    
    eval(strcat('axes(handles.axes',num2str(index),')'));
    hold on
    plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)],'Hittest','Off')
    plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ],'Hittest','Off')
    
    
    index=22
    eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
    eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
    
    
    eval(strcat('axes(handles.axes',num2str(index),')'));
    hold on
    plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)])
    plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ])
    
    
    index=3
    eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
    eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
    
    
    eval(strcat('axes(handles.axes',num2str(index),')'));
    hold on
    plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)],'Hittest','Off')
    plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ],'Hittest','Off')
    guidata(hObject, handles);
    
end



% -------------
% --- Executes on selection change in Visual.
function Visual_Callback(hObject, eventdata, handles,STAT)
Min=str2num(get(handles.Cell,'string'))

if nargin==3
    axes(handles.axes3)
    cla
elseif nargin==4
    h=  figure
end
hold on




try
    
    
    
    switch get(handles.Visual,'value')
        case 1
            handles.c = handles.c3;guidata(hObject, handles);
        case 2
            handles.c = handles.c5;guidata(hObject, handles);
        case 3
            handles.c = handles.c3;guidata(hObject, handles);
        case 4
            handles.c = handles.c5;guidata(hObject, handles);
    end
    
    
    guidata(hObject, handles);
    
    
    
    switch get(handles.Visual,'value')
        case 1
            imagesc(handles.poi_mean_projected(Min).cdata);
        case 2
            imagesc(handles.control_mean_projected(Min).cdata);
        case 3
            imagesc(handles.poi_unmixed(Min).cdata);
        case 4
            imagesc(handles.control_unmixed(Min).cdata);
            
        case 5
            Red_factor=get(handles.Red_factor,'value')
            Green_factor=get(handles.Green_factor,'value')
            a=   handles.control_mean_projected(Min).cdata;
            b= handles.poi_mean_projected(Min).cdata;
            a=uint8(255*(a./max(max(a))))*Red_factor; b=uint8(255*(b./max(max(b)))).*Green_factor; c=uint8(0*a);
            d=cat(3,a,b,c);
            imagesc(d)
            
        case 6
            Red_factor=get(handles.Red_factor,'value')
            Green_factor=get(handles.Green_factor,'value')
            a=  handles.control_unmixed(Min).cdata;
            b=  handles.poi_unmixed(Min).cdata;
            a=uint8(255*(a./max(max(a))))*Red_factor; b=uint8(255*(b./max(max(b)))).*Green_factor; c=uint8(0*a);
            d=cat(3,a,b,c);
            imagesc(d)
            
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    if get(handles.show_centroids,'value')==1
        
        
        
        try ;  p1=handles.trajectories(Min+1).cdata ;  end
        try ; p2=handles.trajectories(Min).cdata ;  end
        try ; p3=handles.trajectories(Min-1).cdata ;  end
        try ; p4=handles.Label(Min).cdata.BP_poi_unmixed;    end
        try ;  p5=handles.Label(Min).cdata.BP_control_unmixed;     end
        try ; p6=handles.Label(Min).cdata.Centroid ; end
        
        
        
        
        try
            
            
            plot(p4(1),p4(2),'MarkerFaceColor',[0 1 1],...
                'MarkerEdgeColor',[0.749019622802734 0 0.749019622802734],...
                'MarkerSize',25,...
                'Marker','pentagram',...
                'LineWidth',2,...
                'LineStyle','none',...
                'Color',[1 0 0]);
        end
        
        try
            
            plot(p5(1),p5(2),'MarkerFaceColor',[0 1 1],...
                'MarkerEdgeColor',[0.749019622802734 0 0.749019622802734],...
                'MarkerSize',20,...
                'Marker','o',...
                'LineWidth',2,...
                'LineStyle','none',...
                'Color',[1 0 0]);
        end
        
        try
            plot(p6(1),p6(2),'MarkerFaceColor',[0 1 1],...
                'MarkerEdgeColor',[0.749019622802734 0 0.749019622802734],...
                'MarkerSize',20,...
                'Marker','square',...
                'LineWidth',2,...
                'LineStyle','none',...
                'Color',[1 0 0]);
        end
        
        try
            text(p4(1)-2, p4(2)+2 ,'GFP BP', 'FontSize',10, 'Color','w', 'Hittest','Off');
        end
        try
            text(p5(1)-2, p5(2)+2 ,'Cherry BP', 'FontSize',10, 'Color','w', 'Hittest','Off');
        end
        try
            text(p6(1)-2, p6(2)+2 ,'Centroid', 'FontSize',10, 'Color','w', 'Hittest','Off');
        end
        
        
        try
            p1=p1-p2  ;
        end
        try
            p3=p3-p2 ;
        end
        
        
        
        try
            quiver(p6(1),p6(2),p1(1),p1(2),0,'LineWidth',3,'Color','c')
        end
        try
            quiver(p6(1),p6(2),p3(1),p3(2),0,'LineWidth',3,'Color','m','LineStyle' ,'--','ShowArrowHead','off')
        end
    end
    
    
    
    if  handles.flag.Cross==1
        
        index=3
        eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
        eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
        
        
        
        hold on
        plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)],'Hittest','Off')
        plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ],'Hittest','Off')
        
    end
    
    axis tight
    set(gcf,'Colormap',handles.c);
    
catch
    axes(handles.axes3); cla
    
end


if nargin== 4
    
    set(get(h,'children'),'YDir','reverse')
end






% --------------------------------------------------------------------
function Untitled_12_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_13_Callback(hObject, eventdata, handles)

[filename, pathname, filterindex] = uigetfile({ '*.dat','dat-files (*.dat)';}, 'Please Choose Raw frames (that have complementary Segmented frames)')
if isequal(filename,0) %$#1
    h = msgbox('User selected Cancel','Aborted');
    return;
end
full_filename= char(strcat(pathname,filename));
temp=importdata(full_filename)



handles.control_mean_projected  = temp.control_mean_projected  ;
handles.control_unmixed  = temp.control_unmixed  ;
handles.control_segmented  = temp.control_segmented ;

handles.poi_mean_projected  = temp.poi_mean_projected  ;
handles.poi_unmixed  = temp.poi_unmixed ;


handles.trajectories =temp.trajectories ;

handles.file_name  = temp.file_name ;
handles.internal_counter = temp.internal_counter ;
handles.cell_index   = temp.cell_index   ;



handles.Label = temp.Label ;

handles.G= ones(1, length(temp.cell_index));
handles.U= handles.G'; % U is vector for manual selection of uropodic cells
handles.C=distinguishable_colors_TACWrapper(max(handles.cell_index),'w') ;

% This is the dafult list. User can expand the list from the user interface:

% 1. Uropod
% 2. velocity
% 3. aspect  ratio
% 4. perimeter
% 5. mean_intensity
%   raw POI
% 6. Area
% 7. theta1
% 8. theta2
% 9. theta3
% 10. theta4
% 11. Radius 1
% 12. Radius 2
% 13. Radius 3
% 14. Radius 4
% 15. circularity
% 16. Total intensity POI
%  unmixed
% 17.  Total intensity control
%  unmixed
% 18. Xdata ratio 2 POI
% 19. Xdata ratio 2 control
% 20. Xdata ratio 2 POI absolute
% 21. Xdata ratio 2 control  absolute
% 22. Ydata sum POI
% 23. Ydata sum control
% 24. Ydata ratio 2 POI
% 25. Ydata ratio 2 control
% 26. Ydata ratio 2 POI  absolute
% 27. Ydata ratio 2 control  absolut




handles.p1=temp.p1';
handles.p2=temp.p2';
handles.p3=temp.p3';
handles.p4=temp.p4';
handles.p5=temp.p5';
handles.p6=temp.p6';
handles.p7=temp.p7';
handles.p8=temp.p8';
handles.p9=temp.p9';
handles.p10=temp.p10';
handles.p11=temp.p11';
handles.p12=temp.p12';
handles.p13=temp.p13';
handles.p14=temp.p14';
handles.p15=temp.p15';
handles.p16=temp.p16';
handles.p17=temp.p17';
handles.p18=temp.p18'
handles.p19=temp.p19'
handles.p20=temp.p20'
handles.p21=temp.p21'
handles.p22=temp.p22'
handles.p23=temp.p23'
handles.p24=temp.p24'
handles.p25=temp.p25'
handles.p26=temp.p26'
handles.p27=temp.p27'
handles.p28=temp.p28'
handles.p29=temp.p29'
handles.p30=temp.p30'
handles.p31=temp.p31'
handles.p32=temp.p32'
handles.p33=temp.p33'
handles.p34=temp.p34'

guidata(hObject, handles);
radiobutton1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function pushbutton25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called





% --- Executes on selection change in scatter_option.
function scatter_option_Callback(hObject, eventdata, handles)
if get(handles.scatter_option,'value')==4
    set(handles.scatter_option,'value',3)
    msgbox('This function is required position/experiment input  ')
end
% if get(handles.scatter_option,'value')==1
%      set(handles.scatter_option,'value',3)
%      msgbox('This function is still not supported but under development')
%
% end


% hObject    handle to scatter_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Plot4(hObject, eventdata, handles)
Plot(hObject, eventdata, handles)
show_boxplot_Callback(hObject, eventdata, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns scatter_option contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scatter_option


% --- Executes during object creation, after setting all properties.
function scatter_option_CreateFcn(hObject, eventdata, handles)
function Cell_Callback(hObject, eventdata, handles)
% hObject    handle to Cell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cell as text
%        str2double(get(hObject,'String')) returns contents of Cell as a double


% --- Executes during object creation, after setting all properties.
function Cell_CreateFcn(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in ratio_type1.
function ratio_type1_Callback(hObject, eventdata, handles)
% hObject    handle to ratio_type1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ratio_type1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ratio_type1


% --- Executes during object creation, after setting all properties.
function ratio_type1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio_type1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in ratio_type2.
function ratio_type2_Callback(hObject, eventdata, handles)

function ratio_type2_CreateFcn(hObject, eventdata, handles)

function pushbutton35_Callback(hObject, eventdata, handles)
function N_Callback(hObject, eventdata, handles)
function N_CreateFcn(hObject, eventdata, handles)
function M_Callback(hObject, eventdata, handles)
function M_CreateFcn(hObject, eventdata, handles)
function Untitled_16_Callback(hObject, eventdata, handles)
function Untitled_17_Callback(hObject, eventdata, handles)
function Untitled_18_Callback(hObject, eventdata, handles)
function Untitled_19_Callback(hObject, eventdata, handles)
function axes1_CreateFcn(hObject, eventdata, handles)
function axes4_DeleteFcn(hObject, eventdata, handles)
function Plot4(hObject, eventdata, handles ,PLOT_type)


if nargin==3
    axes(handles.axes4)
    cla
elseif  nargin==4
    figure
end
hold on


G=handles.G;
U=handles.U;


X=get(handles.popupmenu2,'value');
Y=get(handles.popupmenu4,'value');



%       data.X(1).cdata= data.X(1).cdata'; data.Y(1).cdata= data.Y(1).cdata';

if get(handles.radiobutton1,'value')==1
    data.X(1).cdata=eval(strcat('handles.p',num2str(X)));
    data.Y(1).cdata=eval(strcat('handles.p',num2str(Y)));
end
if get(handles.radiobutton2,'value')==1
    data.X(2).cdata=eval(strcat('handles.p',num2str(X),'.*U'));
    data.Y(2).cdata=eval(strcat('handles.p',num2str(Y),'.*U'));
end







switch get(handles.scatter_option,'value')
    case 1
        if get(handles.radiobutton1,'value')==1
            if get(handles.checkbox5,'value')==1
                plot(data.X(1).cdata,data.Y(1).cdata,'MarkerEdgeColor',[0.8 0.8 0.8],'Marker','X','LineStyle','none','Hittest','Off')
            end
            
            plot(data.X(1).cdata.*G,data.Y(1).cdata.*G,'MarkerEdgeColor',[0 0 0],'Marker','.','LineStyle','none','Hittest','Off')
        end
        
        if get(handles.radiobutton2,'value')==1
            if get(handles.checkbox5,'value')==1
                plot(data.X(2).cdata,data.Y(2).cdata,'MarkerEdgeColor',[0.8 0.8 0.8],'Marker','X','LineStyle','none','Hittest','Off')
            end
            plot(data.X(2).cdata.*G,data.Y(2).cdata.*G,'MarkerEdgeColor',[0 0 1],'Marker','.','LineStyle','none','Hittest','Off')
        end
        
        
    case 3
        if get(handles.radiobutton1,'value')==1
            if get(handles.checkbox5,'value')==1
                plot(data.X(1).cdata,data.Y(1).cdata,'MarkerEdgeColor',[0.8 0.8 0.8],'Marker','X','LineStyle','none','Hittest','Off')
            end
            
            plot(data.X(1).cdata.*G,data.Y(1).cdata.*G,'MarkerEdgeColor',[0 0 0],'Marker','.','LineStyle','none','Hittest','Off')
        end
        
        if get(handles.radiobutton2,'value')==1
            if get(handles.checkbox5,'value')==1
                plot(data.X(2).cdata,data.Y(2).cdata,'MarkerEdgeColor',[0.8 0.8 0.8],'Marker','X','LineStyle','none','Hittest','Off')
            end
            plot(data.X(2).cdata.*G,data.Y(2).cdata.*G,'MarkerEdgeColor',[0 0 1],'Marker','.','LineStyle','none','Hittest','Off')
        end
        
    case 2
        cell_index=handles.cell_index;
        C=handles.C;
        for ii=1:max( cell_index)
            Index=find(ismember(cell_index,ii));
            
            
            
            
            if get(handles.radiobutton1,'value')==1
                if get(handles.checkbox5,'value')==1
                    XXX=data.X(1).cdata; XXX=XXX(Index);
                    YYY=data.Y(1).cdata; YYY=YYY(Index);
                    plot(XXX,YYY,'MarkerEdgeColor',[0.8 0.8 0.8],'Marker','X','LineStyle','none','Hittest','Off')
                end
                
                XXXX=data.X(1).cdata.*G;XXXX=XXXX(Index);
                YYYY=data.Y(1).cdata.*G;YYYY=YYYY(Index);
                plot(XXXX,YYYY,'MarkerEdgeColor',C(ii,:),'Marker','.','LineStyle','none','Hittest','Off')
            end
            
            if get(handles.radiobutton2,'value')==1
                if get(handles.checkbox5,'value')==1
                    XXX=data.X(2).cdata;XXX=XXX(Index);
                    YYY=data.Y(2).cdata;YYY=YYY(Index);
                    plot(XXX,YYY,'MarkerEdgeColor',[0.8 0.8 0.8],'Marker','X','LineStyle','none','Hittest','Off')
                end
                XXXX=data.X(2).cdata.*G;XXXX=XXXX(Index);
                YYYY=data.Y(2).cdata.*G;YYYY=YYYY(Index);
                
                plot(XXXX,YYYY,'MarkerEdgeColor',C(ii,:),'Marker','.','LineStyle','none','Hittest','Off')
            end
        end
    case 4
        cell_index=handles.cell_index_exp;
        C=handles.C_exp;
        for ii=1:max( cell_index)
            Index=find(ismember(cell_index,ii));
            
            
            
            
            if get(handles.radiobutton1,'value')==1
                if get(handles.checkbox5,'value')==1
                    XXX=data.X(1).cdata; XXX=XXX(Index);
                    YYY=data.Y(1).cdata; YYY=YYY(Index);
                    plot(XXX,YYY,'MarkerEdgeColor',[0.8 0.8 0.8],'Marker','X','LineStyle','none','Hittest','Off')
                end
                
                XXXX=data.X(1).cdata.*G;XXXX=XXXX(Index);
                YYYY=data.Y(1).cdata.*G;YYYY=YYYY(Index);
                plot(XXXX,YYYY,'MarkerEdgeColor',C(ii,:),'Marker','.','LineStyle','none','Hittest','Off')
            end
            
            if get(handles.radiobutton2,'value')==1
                if get(handles.checkbox5,'value')==1
                    XXX=data.X(2).cdata;XXX=XXX(Index);
                    YYY=data.Y(2).cdata;YYY=YYY(Index);
                    plot(XXX,YYY,'MarkerEdgeColor',[0.8 0.8 0.8],'Marker','X','LineStyle','none','Hittest','Off')
                end
                XXXX=data.X(2).cdata.*G;XXXX=XXXX(Index);
                YYYY=data.Y(2).cdata.*G;YYYY=YYYY(Index);
                
                plot(XXXX,YYYY,'MarkerEdgeColor',C(ii,:),'Marker','.','LineStyle','none','Hittest','Off')
            end
        end
        
end








if  handles.flag.Cross==1
    
    index=4
    eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
    eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
    
    
    
    %  hold on
    plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)],'Hittest','Off')
    plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ],'Hittest','Off')
    
end
data.xy=handles.xy;
data.flag.Cross=handles.flag.Cross;
try
    Min=str2num(get(handles.Cell,'string'))
    scatter(data.X(1).cdata(Min),data.Y(1).cdata(Min),600,'Marker','+','CData',[0.9 0.2 0],'linewidth',3,'Hittest','Off')
    data.Min=Min;
end

axis tight
if  nargin==4
    
    
    
    
    
    
    
    set(gcf,'userdata',data)
    
end


% ___________________
function Plot(hObject, eventdata, handles ,PLOT_type)




if nargin==3
    axes(handles.axes1)
    cla
elseif  nargin==4
    figure
    hold on
end

X=get(handles.popupmenu1,'value')
Y=get(handles.popupmenu3,'value')



if get(handles.radiobutton1,'value')==1
    data.X(1).cdata=eval(strcat('handles.p',num2str(X)))
    data.Y(1).cdata=eval(strcat('handles.p',num2str(Y)))
end


if get(handles.radiobutton2,'value')==1
    data.X(2).cdata=eval(strcat('handles.p',num2str(X),'.*handles.U'));
    data.Y(2).cdata=eval(strcat('handles.p',num2str(Y),'.*handles.U'));
end
switch get(handles.scatter_option,'value')
    
    
    
    case 1 %facs pseudocolors
        %
        if get(handles.radiobutton1,'value')==1
            [Y,X,msize,col,marker]=dscatter2_TACWrapper( data.X(1).cdata, data.Y(1).cdata ) ;
            h1=scatter(Y,X,msize,col,  'Hittest','Off')
        end
        
        if get(handles.radiobutton2,'value')==1
            [Y,X,msize,col,marker]=dscatter2_TACWrapper( data.X(2).cdata, data.Y(2).cdata ) ;
            h1=scatter(Y,X,msize,col,  'Hittest','Off')
        end
        
        
        
        
        
        
        
        
        
        
    case 3 %black
        if get(handles.radiobutton1,'value')==1
            plot(data.X(1).cdata,data.Y(1).cdata,'MarkerEdgeColor',[0 0 0],'Marker','.','LineStyle','none','Hittest','Off')
        end
        if get(handles.radiobutton2,'value')==1
            plot(data.X(2).cdata,data.Y(2).cdata,'MarkerEdgeColor',[0 0 1],'Marker','.','LineStyle','none','Hittest','Off')
        end
        
    case 2
        cell_index=handles.cell_index;
        C=handles.C;
        for ii=1:max( cell_index)
            Index=find(ismember(cell_index,ii));
            if get(handles.radiobutton1,'value')==1
                plot(data.X(1).cdata(Index),data.Y(1).cdata(Index),'MarkerEdgeColor',  C(ii,:),'Marker','.','LineStyle','none','Hittest','Off')
            end
            if get(handles.radiobutton2,'value')==1
                plot(data.X(2).cdata(Index),data.Y(2).cdata(Index),'MarkerEdgeColor',  C(ii,:),'Marker','o','LineStyle','none','Hittest','Off')
            end
        end;
        
        
        
        
        
    case 4 %on experiment base
        
        cell_index_exp=handles.cell_index_exp;
        C=handles.C_exp;
        for ii=1:max( cell_index_exp)
            Index=find(ismember(cell_index_exp,ii));
            if get(handles.radiobutton1,'value')==1
                plot(data.X(1).cdata(Index),data.Y(1).cdata(Index),'MarkerEdgeColor',  C(ii,:),'Marker','.','LineStyle','none','Hittest','Off')
            end
            if get(handles.radiobutton2,'value')==1
                plot(data.X(2).cdata(Index),data.Y(2).cdata(Index),'MarkerEdgeColor',  C(ii,:),'Marker','o','LineStyle','none','Hittest','Off')
            end
        end;
        
        
        
        
end
hold on


% plot(xy(:,1),xy(:,2),p_wtX(in),p_wtY(in),'r+',p_wtX(~in),p_wtY(~in),'bo')


if isempty(handles.xy)~=1
    for ii=1:size(handles.xy,2)
        xy=handles.xy(ii).cdata;
        
        plot(xy(:,1),xy(:,2),'Color',[0 0.8 0.2],'LineWidth',2,'Hittest','Off');
        plot([xy(1,1) xy(end,1) ],[ xy(1,2) xy(end,2)],'Color',[0 0.8 0.2],'LineWidth',2,'Hittest','Off');
    end
end
if  handles.flag.Cross==1
    
    index=1
    eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
    eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
    
    
    
    hold on
    plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)],'Hittest','Off')
    plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ],'Hittest','Off')
    
end
if get(handles.axis_tight,'value')==1
    axis tight
end
try
    Min=str2num(get(handles.Cell,'string'))
    scatter(data.X(1).cdata(Min),data.Y(1).cdata(Min),600,'Marker','+','CData',[0.9 0.2 0],'linewidth',3,'Hittest','Off')
    data.Min=Min;
    
end

data.xy=handles.xy;
data.flag.Cross=handles.flag.Cross;

if  nargin==4
    
    set(gcf,'userdata',data)
    
end


% ___________
% --- Executes on button press in show_boxplot.
function show_boxplot_Callback(hObject, eventdata, handles,STAT)
% hObject    handle to show_boxplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)








G=handles.G;
U=handles.U;



X=get(handles.popupmenu2,'value');
Y=get(handles.popupmenu4,'value');


%       data.X(1).cdata= data.X(1).cdata'; data.Y(1).cdata= data.Y(1).cdata';

if get(handles.radiobutton1,'value')==1
    if get(handles.checkbox5,'value')~=1
        data.X(1).cdata=eval(strcat('handles.p',num2str(X),'.*G'));
        data.Y(1).cdata=eval(strcat('handles.p',num2str(Y),'.*G'));
    else
        data.X(1).cdata=eval(strcat('handles.p',num2str(X)));
        data.Y(1).cdata=eval(strcat('handles.p',num2str(Y)));
    end
end
if get(handles.radiobutton2,'value')==1
    if get(handles.checkbox5,'value')~=1
        data.X(2).cdata=eval(strcat('handles.p',num2str(X),'.*U.*G'));
        data.Y(2).cdata=eval(strcat('handles.p',num2str(Y),'.*U.*G'));
    else
        data.X(2).cdata=eval(strcat('handles.p',num2str(X),'.*U'));
        data.Y(2).cdata=eval(strcat('handles.p',num2str(Y),'.*U'));
    end
end


if get(handles.radiobutton1,'value')==1   &&  get(handles.radiobutton2,'value')==1
    ABX=  {  data.X(1).cdata,  data.X(2).cdata}  ;   ABY=  {  data.Y(1).cdata,  data.Y(2).cdata}  ;
end
if get(handles.radiobutton1,'value')~=1   &&  get(handles.radiobutton2,'value')==1
    ABX=  {   data.X(2).cdata}  ;   ABY=  {     data.Y(2).cdata}  ;
end
if get(handles.radiobutton1,'value')==1   &&  get(handles.radiobutton2,'value')~=1
    ABX=  {  data.X(1).cdata}  ;   ABY=  {  data.Y(1).cdata}  ;
end





%
hold on


if get(handles.Merge_histograms,'value')==1
    switch  size(ABX,2)
        case 1
            ABX{2}=ABY{1};
        case 2
            ABX{3}=ABY{1}; ABX{4}=ABY{2};
        case 3
            ABX{4}=ABY{1}; ABX{5}=ABY{2}; ABX{6}=ABY{3};
    end
    
end

if nargin==3
    axes(handles.axes2)
    cla
elseif nargin==4
    figure
end

if nargin==4
    data.ABX=ABX;
    set(gcf,'userdata',data)
end




if get(handles.smooth_on,'value')==1
    nhist_TACWrapper(ABX ,'minbins',str2num(get(handles.number_bins,'string')) ,'smooth');
else
    nhist_TACWrapper(ABX ,'minbins',str2num(get(handles.number_bins,'string'))  );
end

if  handles.flag.Cross==1
    
    index=2
    eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
    eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
    
    
    
    hold on
    plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)],'Hittest','Off')
    plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ],'Hittest','Off')
    
end


x_str=get(handles.popupmenu1,'string');  x_str= char(x_str(X));     xlabel(x_str);   ylabel('normalized counts')



if nargin==3
    axes(handles.axes22)
    cla
elseif nargin==4
    figure
end

hold on



if get(handles.smooth_on,'value')==1
    nhist_TACWrapper(ABY ,'minbins',str2num(get(handles.number_bins,'string')) ,'smooth');
else
    nhist_TACWrapper(ABY ,'minbins',str2num(get(handles.number_bins,'string'))  ) ;
end



if  handles.flag.Cross==1
    
    index=22
    eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
    eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
    
    
    
    hold on
    plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)],'Hittest','Off')
    plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ],'Hittest','Off')
    
end



%    a=nanmean(data3); a=a(1:8);
%    b=nanstd(data3)   ; b=b(1:8);
%    aa=nan(size(a));  bb=nan(size(b));   aa(1)=a(1);   aa(3)=a(3);   bb(1)=b(1);   bb(3)=b(3);   errorbar(aa,bb,'xb')
%      aa=nan(size(a));  bb=nan(size(b)); aa(2)=a(2);   aa(4)=a(4);   bb(2)=b(2);   bb(4)=b(4);   errorbar(aa,bb,'xg')
%    aa=nan(size(a));  bb=nan(size(b));   aa(5)=a(5);   aa(7)=a(7);   bb(5)=b(5);   bb(7)=b(7);   errorbar(aa,bb,'xr')
%      aa=nan(size(a));  bb=nan(size(b)); aa(6)=a(6);   aa(8)=a(8);   bb(6)=b(6);   bb(8)=b(8);   errorbar(aa,bb,'xm')
%
% axis tight
ylabel('normalized counts')
x_str=get(handles.popupmenu1,'string');  x_str= char(x_str(Y));   xlabel(x_str);




%



function gate_y2_Callback(hObject, eventdata, handles)
% hObject    handle to gate_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gate_y2 as text
%        str2double(get(hObject,'String')) returns contents of gate_y2 as a double


% --- Executes during object creation, after setting all properties.
function gate_y2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gate_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gate_y1_Callback(hObject, eventdata, handles)
% hObject    handle to gate_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gate_y1 as text
%        str2double(get(hObject,'String')) returns contents of gate_y1 as a double


% --- Executes during object creation, after setting all properties.
function gate_y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gate_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gate_x1_Callback(hObject, eventdata, handles)
% hObject    handle to gate_x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gate_x1 as text
%        str2double(get(hObject,'String')) returns contents of gate_x1 as a double


% --- Executes during object creation, after setting all properties.
function gate_x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gate_x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gate_x2_Callback(hObject, eventdata, handles)
% hObject    handle to gate_x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gate_x2 as text
%        str2double(get(hObject,'String')) returns contents of gate_x2 as a double


% --- Executes during object creation, after setting all properties.
function gate_x2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gate_x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
Untitled_2_Callback(hObject, eventdata, handles)


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
Untitled_3_Callback(hObject, eventdata, handles)


% --- Executes on button press in axis_tight.
function axis_tight_Callback(hObject, eventdata, handles)
% hObject    handle to axis_tight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function radiobutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function Untitled_20_Callback(hObject, eventdata, handles)
% Currently user need to adjust the code according the data,
% Future work will include more user-friendly interface for this option
% %   jj=1;
%   temp=handles(1).cdata;
%       for ii=1:size(temp.file_name,2)
%
%              file_name_wt_vector(jj)= cellstr(temp.file_name(ii).cdata);
%              filename=file_name_wt_vector(jj); filename=char(filename);
%              Pos=filename(findstr(filename,'_Pos')+4:findstr(filename,'_div')-1) ;
%               Pos=str2num(Pos);
%                Ex=[1 8 ; 9 16; 17 24; 25 32; 33 40; 41 48;  49 56;  57 64;  65 72]
%
%
%               if Pos>Ex(1,1)-1 && Pos< Ex(1,2)+1
%                  Experiment(jj)=1 ;
%               end
%                 if Pos> Ex(2,1)-1 && Pos< Ex(2,2)+1
%                     Experiment(jj)=2;
%                end
%                 if Pos> Ex(3,1)-1 && Pos< Ex(3,2)+1
%                     Experiment(jj)=3;
%                end
%                  if Pos>Ex(4,1)-1  && Pos<Ex(4,2)+1
%                     Experiment(jj)=4;
%                end
%                   if Pos>Ex(5,1)-1  && Pos<Ex(5,2)+1
%                    Experiment(jj)=5;
%                end
%                 if Pos>Ex(6,1)-1  && Pos<Ex(6,2)+1
%                    Experiment(jj)=6;
%                end
%                     if Pos>Ex(7,1)-1  && Pos<Ex(7,2)+1
%                   Experiment(jj)=7;
%                     end
%                  if Pos>Ex(8,1)-1  && Pos<Ex(8,2)+1
%                    Experiment(jj)=8;
%                  end
%
%                  if Pos>Ex(9,1)-1  && Pos<Ex(9,2)+1
%                   Experiment(jj)=9;
%                  end
%
%
%               jj=jj+1 ;
%
%       end
%  handles.cell_index_exp=Experiment;
%
%   handles.C_exp=distinguishable_colors_TACWrapper(max(Experiment),'k') ;
% guidata(hObject, handles);

% --------------------------------------------------------------------
function uipushtool9_ClickedCallback(hObject, eventdata, handles)
% handles.c=change_LUT ;
%  guidata(hObject,handles);
%  set(gcf,'colormap',handles.c);






G=handles.G;
U=handles.U;



X=get(handles.popupmenu2,'value');
Y=get(handles.popupmenu4,'value');


%       data.X(1).cdata= data.X(1).cdata'; data.Y(1).cdata= data.Y(1).cdata';

if get(handles.radiobutton1,'value')==1
    if get(handles.checkbox5,'value')~=1
        data.X(1).cdata=eval(strcat('handles.p',num2str(X),'.*G'));
        data.Y(1).cdata=eval(strcat('handles.p',num2str(Y),'.*G'));
    else
        data.X(1).cdata=eval(strcat('handles.p',num2str(X)));
        data.Y(1).cdata=eval(strcat('handles.p',num2str(Y)));
    end
end
%  if get(handles.radiobutton2,'value')==1
%       if get(handles.checkbox5,'value')~=1
%       data.X(2).cdata=eval(strcat('handles.p',num2str(X),'.*U.*G'));
%       data.Y(2).cdata=eval(strcat('handles.p',num2str(Y),'.*U.*G'));
%       else
%       data.X(2).cdata=eval(strcat('handles.p',num2str(X),'.*U'));
%       data.Y(2).cdata=eval(strcat('handles.p',num2str(Y),'.*U'));
%      end
%  end


cell_index_exp= handles.cell_index_exp ;

for ii=1:max(cell_index_exp)
    ii
    Index=find(ismember(cell_index_exp,ii));
    ABX(ii)=  {data.X(1).cdata(Index)};
    ABY(ii)=  {data.Y(1).cdata(Index)};
end

%   ABX=  {  data.X(1).cdata,  data.X(2).cdata}  ;
%   ABY=  {  data.Y(1).cdata,  data.Y(2).cdata}  ;
%  ABX=  {  data.X(1).cdata};
%      ABY=  {  data.Y(1).cdata};
%%%%%

figure
data.ABX=ABX;
set(gcf,'userdata',data)





if get(handles.smooth_on,'value')==1
    nhist_TACWrapper(ABX ,'minbins',str2num(get(handles.number_bins,'string')) ,'smooth');
else
    nhist_TACWrapper(ABX ,'minbins',str2num(get(handles.number_bins,'string'))  );
end
hold on
if  handles.flag.Cross==1
    index=2
    eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
    eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
    hold on
    plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)],'Hittest','Off')
    plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ],'Hittest','Off')
end

x_str=get(handles.popupmenu1,'string');  x_str= char(x_str(X));     xlabel(x_str);   ylabel('normalized counts')


%%%%
figure
data.ABY=ABY;
set(gcf,'userdata',data)





if get(handles.smooth_on,'value')==1
    nhist_TACWrapper(ABY ,'minbins',str2num(get(handles.number_bins,'string')) ,'smooth');
else
    nhist_TACWrapper(ABY ,'minbins',str2num(get(handles.number_bins,'string'))  ) ;
end


hold on
if  handles.flag.Cross==1
    index=22
    eval(strcat('Xlim=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
    eval(strcat('Ylim=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
    plot([Xlim(1) Xlim(2)  ],[ (Ylim(2)-Ylim(1))/2+Ylim(1)  (Ylim(2)-Ylim(1))/2+Ylim(1)],'Hittest','Off')
    plot([ (Xlim(2)-Xlim(1))/2+Xlim(1)  (Xlim(2)-Xlim(1))/2+Xlim(1)],[Ylim(1)  Ylim(2)  ],'Hittest','Off')
end
ylabel('normalized counts')
x_str=get(handles.popupmenu1,'string');  x_str= char(x_str(Y));   xlabel(x_str);



%    a=nanmean(data3); a=a(1:8);
%    b=nanstd(data3)   ; b=b(1:8);
%    aa=nan(size(a));  bb=nan(size(b));   aa(1)=a(1);   aa(3)=a(3);   bb(1)=b(1);   bb(3)=b(3);   errorbar(aa,bb,'xb')
%      aa=nan(size(a));  bb=nan(size(b)); aa(2)=a(2);   aa(4)=a(4);   bb(2)=b(2);   bb(4)=b(4);   errorbar(aa,bb,'xg')
%    aa=nan(size(a));  bb=nan(size(b));   aa(5)=a(5);   aa(7)=a(7);   bb(5)=b(5);   bb(7)=b(7);   errorbar(aa,bb,'xr')
%      aa=nan(size(a));  bb=nan(size(b)); aa(6)=a(6);   aa(8)=a(8);   bb(6)=b(6);   bb(8)=b(8);   errorbar(aa,bb,'xm')
%
% axis tight






% --------------------------------------------------------------------
function Untitled_21_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% Under develpment. Will be included in next version of TACTICS


% --- Executes on selection change in popupmenu14.
function popupmenu14_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu14


% --- Executes during object creation, after setting all properties.
function popupmenu14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_22_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_23_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_28_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function set_scale2_Callback(hObject, eventdata, handles)
index=4
eval( strcat('Ylim(1)=str2num(get(handles.Y_lim_start2,','''string''))'))
eval( strcat('Ylim(2)=str2num(get(handles.Y_lim_end2,','''string''))'))
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],Ylim);'))
eval( strcat('Xlim(1)=str2num(get(handles.X_lim_start2,','''string''))'))
eval( strcat('Xlim(2)=str2num(get(handles.X_lim_end2,','''string''))'))
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Xlim);'))
index=2
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Xlim);'))
index=22
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Ylim);'))


% --------------------------------------------------------------------
function Yscale_up2_Callback(hObject, eventdata, handles)
index=4;
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
ylim=[curr_lim1(1)  curr_lim1(2)-curr_lim1(2)*0.1 ];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],ylim);'))

% --------------------------------------------------------------------
function Yscale_down2_Callback(hObject, eventdata, handles)
index=4;
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
ylim=[curr_lim1(1)  curr_lim1(2)+curr_lim1(2)*0.1 ];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],ylim);'))



% --------------------------------------------------------------------
function Xscale_up2_Callback(hObject, eventdata, handles)
index=4;
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
Xlim=[curr_lim1(1)  curr_lim1(2)+curr_lim1(2)*0.1 ];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Xlim);'))


% --------------------------------------------------------------------
function Xscale_down2_Callback(hObject, eventdata, handles)
index=4;
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
Xlim=[curr_lim1(1)  curr_lim1(2)-curr_lim1(2)*0.1 ];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Xlim);'))


% --------------------------------------------------------------------
function Axes_tight2_Callback(hObject, eventdata, handles)
axes(handles.axes4)
axis tight
% --------------------------------------------------------------------
function set_scale1_Callback(hObject, eventdata, handles)
index=1
eval( strcat('Ylim(1)=str2num(get(handles.Y_lim_start1,','''string''))'))
eval( strcat('Ylim(2)=str2num(get(handles.Y_lim_end1,','''string''))'))
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],Ylim);'))
eval( strcat('Xlim(1)=str2num(get(handles.X_lim_start1,','''string''))'))
eval( strcat('Xlim(2)=str2num(get(handles.X_lim_end1,','''string''))'))
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Xlim);'))





% --------------------------------------------------------------------
function Yscale_up1_Callback(hObject, eventdata, handles)
index=1
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
ylim=[curr_lim1(1)  curr_lim1(2)-curr_lim1(2)*0.1 ];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],ylim);'))


% --------------------------------------------------------------------
function Yscale_down1_Callback(hObject, eventdata, handles)
index=1
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''',']);'))
ylim=[curr_lim1(1)  curr_lim1(2)+curr_lim1(2)*0.1 ];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],ylim);'))



% --------------------------------------------------------------------
function Xscale_up1_Callback(hObject, eventdata, handles)
index=1
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
Xlim=[curr_lim1(1)  curr_lim1(2)+curr_lim1(2)*0.1 ];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Xlim);'))


% --------------------------------------------------------------------
function Xscale_down1_Callback(hObject, eventdata, handles)
index=1
eval(strcat('curr_lim1=get(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''',']);'))
Xlim=[curr_lim1(1)  curr_lim1(2)-curr_lim1(2)*0.1 ];
eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','x','''',',','''','lim','''','],Xlim);'))


% --------------------------------------------------------------------
function Axes_tight1_Callback(hObject, eventdata, handles)
axes(handles.axes1)
axis tight


% --------------------------------------------------------------------
function Untitled_29_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_30_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_31_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function Untitled_33_Callback(hObject, eventdata, handles)

A=handles.poi_unmixed
B=handles.control_unmixed


for ii=1:size( A,2)
    try
        a(ii).cdata=  A(ii).cdata ;
    catch
        a(ii).cdata=nan;
        
    end
end

for ii=1:size( B,2)
    try
        b(ii).cdata=  B(ii).cdata ;
    catch
        b(ii).cdata=nan;
        
    end
end



Data_in=a;
Yprojection_matrix_sorted=[];

n=size(Data_in,2)
max_x=0;
max_y=0;

for ii=1:n
    if max_x<size(Data_in(ii).cdata,1)
        max_x=size(Data_in(ii).cdata,1);
    end
    if max_y<size(Data_in(ii).cdata,2)
        max_y=size(Data_in(ii).cdata,2);
    end
end
Yprojection_matrix=zeros(max_y,n) ;
Xprojection_matrix=zeros(max_x,n);

jj=1;
for ii=1:n
    
    tempy=Data_in(ii).cdata;
    if isempty(tempy)~=1
        tempy(tempy==0)=nan;
        tempy=nanmean(tempy');
        tempy(isnan(tempy))=[];
        Yprojection_matrix(:,jj)= imresize( tempy, [1 max_y]);
        
        jj=jj+1;
    end
end



sort_vec=rand(size(Yprojection_matrix,2),1)
[aaa,Rand_order]=sort( sort_vec)


size(Rand_order)
size(Yprojection_matrix)
Yprojection_matrix=Yprojection_matrix(:,Rand_order )


figure
imagesc( medfilt2( Yprojection_matrix))
set(gcf,'Colormap',jet);   ylabel([' data points  '   num2str(length(A))     ' projection'])
set(gcf,'userdata',Yprojection_matrix);      title('Y projection of GFP channel')

jj=1;
for ii=1:n
    
    tempx=Data_in(ii).cdata';
    if isempty(tempx)~=1
        tempx(tempx==0)=nan;
        tempx=nanmean(tempx');
        tempx(isnan(tempx))=[];
        Xprojection_matrix(:,jj)= imresize( tempx, [1 max_x]);
        
        jj=jj+1;
    end
end



sort_vec=rand(size(Xprojection_matrix,2),1)
[aaa,Rand_order]=sort( sort_vec);
Xprojection_matrix=Xprojection_matrix(:,Rand_order);


figure
imagesc( medfilt2( Xprojection_matrix))

%
set(gcf,'Colormap',jet);   ylabel([' data points  '   num2str(length(A))     ' projection'])
set(gcf,'userdata',Xprojection_matrix);
title('X projection of GFP channel')
%%%%%%%%%%%
Data_in=b;
Yprojection_matrix_sorted=[];

n=size(Data_in,2)
max_x=0;
max_y=0;

for ii=1:n
    if max_x<size(Data_in(ii).cdata,1)
        max_x=size(Data_in(ii).cdata,1);
    end
    if max_y<size(Data_in(ii).cdata,2)
        max_y=size(Data_in(ii).cdata,2);
    end
end
Yprojection_matrix=zeros(max_y,n) ;
Xprojection_matrix=zeros(max_x,n);

jj=1;
for ii=1:n
    
    tempy=Data_in(ii).cdata;
    if isempty(tempy)~=1
        tempy(tempy==0)=nan;
        tempy=nanmean(tempy');
        tempy(isnan(tempy))=[];
        Yprojection_matrix(:,jj)= imresize( tempy, [1 max_y]);
        
        jj=jj+1;
    end
end

sort_vec=rand(size(Yprojection_matrix,2),1)
[aaa,Rand_order]=sort( sort_vec);
Yprojection_matrix=Yprojection_matrix(:,Rand_order);


figure
imagesc( medfilt2( Yprojection_matrix))
set(gcf,'Colormap',jet);   ylabel([' data points  '   num2str(length(A))     ' projection'])
set(gcf,'userdata',Yprojection_matrix);     title('Y projection of Cherry channel')
jj=1;
for ii=1:n
    
    tempx=Data_in(ii).cdata';
    if isempty(tempx)~=1
        tempx(tempx==0)=nan;
        tempx=nanmean(tempx');
        tempx(isnan(tempx))=[];
        Xprojection_matrix(:,jj)= imresize( tempx, [1 max_x]);
        
        jj=jj+1;
    end
end


sort_vec=rand(size(Xprojection_matrix,2),1)
[aaa,Rand_order]=sort( sort_vec);
Xprojection_matrix=Xprojection_matrix(:,Rand_order );

figure
imagesc( medfilt2( Xprojection_matrix))

%
set(gcf,'Colormap',jet);   ylabel([' data points  '   num2str(length(A))     ' projection'])
set(gcf,'userdata',Xprojection_matrix);     title('X projection of Cherry channel')


% --------------------------------------------------------------------
function Untitled_34_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_35_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_36_Callback(hObject, eventdata, handles)
cell_index=handles.cell_index;
Min=str2num(get(handles.Cell,'string'))
axes(handles.axes3); cla
scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
Index =find(ismember(cell_index, cell_index(Min)))
figure(1);
Red_factor=get(handles.Red_factor,'value')
Green_factor=get(handles.Green_factor,'value')
switch get(handles.Visual,'value')
    case 1
        for ii=1:length(Index)
            matrix=zeros(512,512);
            small_matrix=handles.poi_mean_projected(Index(ii)).cdata;
            p2= handles.trajectories(Index(ii)).cdata  ;
            p=(p2- handles.Label(Index(ii)).cdata.Centroid)    ;
            p=round(p);
            X_dim=size(small_matrix,1);
            Y_dim=size(small_matrix,2);
            matrix(p(2):p(2)+X_dim-1,p(1):p(1)+Y_dim-1)=small_matrix;
            
            imagesc(  matrix);          title(char(['frame=' num2str(ii)])); set(gcf,'Colormap',handles.c); pause(0.05);
            
        end
        
        
    case 2
        for ii=1:length(Index)
            matrix=zeros(512,512);
            small_matrix= handles.control_mean_projected(Index(ii)).cdata;
            p2= handles.trajectories(Index(ii)).cdata  ;
            p=(p2- handles.Label(Index(ii)).cdata.Centroid)    ;
            p=round(p);
            X_dim=size(small_matrix,1);
            Y_dim=size(small_matrix,2);
            matrix(p(2):p(2)+X_dim-1,p(1):p(1)+Y_dim-1)=small_matrix;
            imagesc(  matrix);          title(char(['frame=' num2str(ii)])); set(gcf,'Colormap',handles.c); pause(0.05);
        end
        
        
    case 3
        for ii=1:length(Index)
            matrix=zeros(512,512);
            small_matrix=handles.poi_unmixed(Index(ii)).cdata;
            p2= handles.trajectories(Index(ii)).cdata  ;
            p=(p2- handles.Label(Index(ii)).cdata.Centroid)    ;
            p=round(p);
            X_dim=size(small_matrix,1);
            Y_dim=size(small_matrix,2);
            matrix(p(2):p(2)+X_dim-1,p(1):p(1)+Y_dim-1)=small_matrix;
            imagesc(  matrix);          title(char(['frame=' num2str(ii)])); set(gcf,'Colormap',handles.c); pause(0.05);
        end
        
    case 4
        for ii=1:length(Index)
            matrix=zeros(512,512);
            small_matrix=handles.control_unmixed(Index(ii)).cdata;
            p2= handles.trajectories(Index(ii)).cdata  ;
            p=(p2- handles.Label(Index(ii)).cdata.Centroid)    ;
            p=round(p);
            X_dim=size(small_matrix,1);
            Y_dim=size(small_matrix,2);
            matrix(p(2):p(2)+X_dim-1,p(1):p(1)+Y_dim-1)=small_matrix;
            imagesc(  matrix);          title(char(['frame=' num2str(ii)])); set(gcf,'Colormap',handles.c); pause(0.05);
        end
    case 6
        for ii=1:length(Index)
            'will work too slow, function is disabeled'
        end
        
        
        
end


% --------------------------------------------------------------------
function Untitled_39_Callback(hObject, eventdata, handles)

cell_index=handles.cell_index;
Min=str2num(get(handles.Cell,'string'))
guidata(hObject, handles);
axes(handles.axes3); cla

Red_factor=get(handles.Red_factor,'value');
Green_factor=get(handles.Green_factor,'value')      ;

Index =find(ismember(cell_index, cell_index(Min)))

scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
figure('color','w','units','pixels','position', scrsz) ;
set(gcf,'Colormap',handles.c);

switch get(handles.Visual,'value')
    case 1
        for ii=1:length(Index)
            %                      figure(1);   set(1,'color','w','units','pixels','position', scrsz) ;
            matrix=handles.poi_mean_projected(Index(ii)).cdata;
            imagesc(  matrix);          title(char(['frame=' num2str(ii)])); set(gcf,'Colormap',handles.c); pause(0.05);
            
        end
        
        
    case 2
        for ii=1:length(Index)
            %                       figure(1);   set(1,'color','w','units','pixels','position', scrsz) ;
            matrix=handles.control_mean_projected(Index(ii)).cdata;
            imagesc(  matrix);          title(char(['frame=' num2str(ii)])); set(gcf,'Colormap',handles.c); pause(0.05);
        end
        
        
    case 3
        for ii=1:length(Index)
            %                             figure(1);   set(1,'color','w','units','pixels','position', scrsz) ;
            matrix=handles.poi_unmixed(Index(ii)).cdata;
            imagesc(  matrix);          title(char(['frame=' num2str(ii)])); set(gcf,'Colormap',handles.c); pause(0.05);
        end
        
    case 4
        for ii=1:length(Index)
            %                        figure(1);   set(1,'color','w','units','pixels','position', scrsz) ;
            matrix=handles.control_unmixed(Index(ii)).cdata;
            imagesc(  matrix);          title(char(['frame=' num2str(ii)])); set(gcf,'Colormap',handles.c); pause(0.05);
        end
    case 6
        for ii=1:length(Index)
            figure(1);
            a=  handles.control_unmixed(Index(ii)).cdata;
            b=  handles.poi_unmixed(Index(ii)).cdata;
            a=uint8(255*(a./max(max(a))))*Red_factor; b=uint8(255*(b./max(max(b)))).*Green_factor; c=uint8(0*a);
            matrix=cat(3,a,b,c);
            imagesc(  matrix);          title(char(['frame=' num2str(ii)])); set(gcf,'Colormap',handles.c); pause(0.05);
        end
        
end

% --------------------------------------------------------------------
function Untitled_38_Callback(hObject, eventdata, handles)




cell_index=handles.cell_index;
Min=str2num(get(handles.Cell,'string'))


guidata(hObject, handles);


axes(handles.axes3); cla


Red_factor=get(handles.Red_factor,'value');
Green_factor=get(handles.Green_factor,'value')      ;

%          Uropod= handles.p1_wt ;



%          Uropod=cumsum(Uropod)
Index =find(ismember(cell_index, cell_index(Min)))


%
%          Index1  =   Index1(1);  % global location of selected uropodic cell
%          Index2= cell_index( Index1)  ;                 % global index of selected uropodic cell
%          Index3= find(ismember( cell_index,Index2)); % global index of all locations of selected uropodic cell
%          Index4=find(ismember(Index3,Index1));


%
scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
figure('color','w','units','pixels','position', scrsz) ;
set(gcf,'Colormap',handles.c);


for ii=1:length(Index)
    
    a(ii).cdata=  handles.control_unmixed(Index(ii)).cdata;
    b(ii).cdata=  handles.poi_unmixed(Index(ii)).cdata;
    
end



%%%%%%%%%%%
Data_in=a;
Yprojection_matrix_sorted=[];

n=size(Data_in,2)
max_x=0;
max_y=0;

for ii=1:n
    if max_x<size(Data_in(ii).cdata,1)
        max_x=size(Data_in(ii).cdata,1);
    end
    if max_y<size(Data_in(ii).cdata,2)
        max_y=size(Data_in(ii).cdata,2);
    end
end
Yprojection_matrix=zeros(max_y,n) ;
Xprojection_matrix=zeros(max_x,n);

jj=1;
for ii=1:n
    
    tempy=Data_in(ii).cdata;
    if isempty(tempy)~=1
        tempy(tempy==0)=nan;
        tempy=nanmean(tempy');
        tempy(isnan(tempy))=[];
        Yprojection_matrix(:,jj)= imresize( tempy, [1 max_y]);
        
        jj=jj+1;
    end
end



figure
imagesc( medfilt2( Yprojection_matrix))

%
set(gcf,'Colormap',jet);   ylabel([' data points  '   num2str(length(Index))     ' projection'])
title('control_unmixed')

%%%%%%%%%%%
Data_in=b;
Yprojection_matrix_sorted=[];

n=size(Data_in,2)
max_x=0;
max_y=0;

for ii=1:n
    if max_x<size(Data_in(ii).cdata,1)
        max_x=size(Data_in(ii).cdata,1);
    end
    if max_y<size(Data_in(ii).cdata,2)
        max_y=size(Data_in(ii).cdata,2);
    end
end
Yprojection_matrix=zeros(max_y,n) ;
Xprojection_matrix=zeros(max_x,n);

jj=1;
for ii=1:n
    
    tempy=Data_in(ii).cdata;
    if isempty(tempy)~=1
        tempy(tempy==0)=nan;
        tempy=nanmean(tempy');
        tempy(isnan(tempy))=[];
        Yprojection_matrix(:,jj)= imresize( tempy, [1 max_y]);
        
        jj=jj+1;
    end
end



figure
imagesc( medfilt2( Yprojection_matrix))
%
%
%




set(gcf,'Colormap',jet);   ylabel([' data points  '   num2str(length(Index))     ' projection'])
title('POI_unmixed')
%  set(gcf,'Colormap',handles.c);



% --------------------------------------------------------------------
function Untitled_37_Callback(hObject, eventdata, handles)
cell_index=handles.cell_index;
Min=str2num(get(handles.Cell,'string'))


guidata(hObject, handles);


axes(handles.axes3); cla


Red_factor=get(handles.Red_factor,'value');
Green_factor=get(handles.Green_factor,'value')      ;


Index =find(ismember(cell_index, cell_index(Min)))


%
scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
figure('color','w','units','pixels','position', scrsz) ;
set(gcf,'Colormap',handles.c);

for ii=1:length(Index)
    a(ii).cdata=  handles.control_unmixed(Index(ii)).cdata;
    b(ii).cdata=  handles.poi_unmixed(Index(ii)).cdata;
end

Data_in=a;
Yprojection_matrix_sorted=[];

n=size(Data_in,2)
max_x=0;
max_y=0;

for ii=1:n
    if max_x<size(Data_in(ii).cdata,1)
        max_x=size(Data_in(ii).cdata,1);
    end
    if max_y<size(Data_in(ii).cdata,2)
        max_y=size(Data_in(ii).cdata,2);
    end
end
Yprojection_matrix=zeros(max_y,n) ;
Xprojection_matrix=zeros(max_x,n);

jj=1;SQUARE=[]
for ii=1:n
    tempy=Data_in(ii).cdata;
    try
        if isempty(tempy)~=1
            %  tempy(tempy==0)=nan;
            %  tempy=nanmean(tempy');
            %  tempy(isnan(tempy))=[];
            SQUARE(:,:,jj)= imresize( tempy, [max_x max_y]);
            
            jj=jj+1;
        end
    end
end

figure; imagesc(mean(SQUARE,3)); title('averaged image for unmixed control')

Data_in=b;



Yprojection_matrix_sorted=[];

n=size(Data_in,2)
max_x=0;
max_y=0;

for ii=1:n
    if max_x<size(Data_in(ii).cdata,1)
        max_x=size(Data_in(ii).cdata,1);
    end
    if max_y<size(Data_in(ii).cdata,2)
        max_y=size(Data_in(ii).cdata,2);
    end
end
Yprojection_matrix=zeros(max_y,n) ;
Xprojection_matrix=zeros(max_x,n);

jj=1;SQUARE=[]
for ii=1:n
    tempy=Data_in(ii).cdata;
    try
        if isempty(tempy)~=1
            %  tempy(tempy==0)=nan;
            %  tempy=nanmean(tempy');
            %  tempy(isnan(tempy))=[];
            SQUARE(:,:,jj)= imresize( tempy, [max_x max_y]);
            
            jj=jj+1;
        end
    end
end

figure; imagesc(mean(SQUARE,3)); title('averaged image for unmixed POI')
% %
% --------------------------------------------------------------------
function Untitled_40_Callback(hObject, eventdata, handles)
% --- Executes on selection change in polarization_type.
function polarization_type_Callback(hObject, eventdata, handles)
% hObject    handle to polarization_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns polarization_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from polarization_type


% --- Executes during object creation, after setting all properties.
function polarization_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to polarization_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu19_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu20_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu21_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu22_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in go.
function go_Callback(hObject, eventdata, handles)


a=handles.track_what

Cell=str2num(get(handles.Cell,'string'))

file_name=handles.file_name(Cell).cdata  ;
internal_counter=handles.internal_counter(Cell)


cell_index =str2num(file_name(findstr(file_name,'_div_')+5:findstr(file_name,'.fig')-1))









pathname=handles.pathname_pos


Index=findstr(file_name,'_')
Index2= find(ismember(Index, findstr(file_name,'_Pos')))
Pos=file_name(Index(Index2)+4:Index(Index2+1)-1)

pathname=strcat(pathname,'Pos',Pos)
filename=dir(strcat(pathname,'\*.dat'))
filename= filename(1)
filename=filename.name
fullfilename=strcat(pathname,'\',filename)



data_file=importdata(fullfilename)



Visual=get(handles.Visual,'value');
switch Visual
    case 1
        track_what=2
    case 2
        track_what=1
    case 3
        track_what=2
    case 4
        track_what=1
    case 5
        track_what =   handles.track_what ;
    case 6
        track_what =   handles.track_what ;
end


%  TAC_Cell_Tracking_Module(data_file,   handles.track_what,  handles.Projected_by, cell_index,internal_counter,track_what )
%
%  run('TAC_Cell_Tracking_Module(data_file,   handles.track_what,  handles.Projected_by, cell_index,internal_counter,track_what )
% run('TAC_Cell_Tracking_Module',data_file,   handles.track_what,  handles.Projected_by, cell_index,internal_counter,track_what )
%     eval(char(strcat('h=',str_gui,'(','data1,data2,data3,data4,data5,data6,data7,data8,data9,data10',')')));
h=TAC_Cell_Tracking_Module(data_file,   handles.track_what,  handles.Projected_by, cell_index,internal_counter,track_what )    ;
drawnow;

jframe = getjframe_TACWrapper(h); %%undocumented
set(getjframe_TACWrapper,'Maximized',1);%maximizes the window, 0 to minimize
set(getjframe_TACWrapper,'AlwaysOnTop',0);%places window on top, 0 to disable
set(getjframe_TACWrapper,'Title','TACTICS_v2.2');%places window on top, 0 to disable



% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
Min=str2num(char(get(handles.Cell,'string')))
Visual_Callback(hObject, eventdata, handles )
Plot(hObject, eventdata, handles)
Plot4(hObject, eventdata, handles)
X=get(handles.popupmenu4,'value');
Y=get(handles.popupmenu3,'value');

XX= eval(strcat('handles.p',num2str(X)))  ;
YY= eval(strcat('handles.p',num2str(Y))) ;

if  size(YY,2)>size(YY,1)
    YY=YY';
end
if  size(XX,2)>size(XX,1)
    XX=XX';
end

scatter(XX(Min),YY(Min),100,'Marker','+','CData',[1 0 0],'Hittest','Off')















% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
Add_polarization_measure_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function Add_polarization_measure_Callback(hObject, eventdata, handles)
% hObject    handle to Add_polarization_measure (see GCBO)



choice = questdlg('Please select input data for ratios:', ...
    'Input data', ...
    'Raw images','filtered/unmixed images','Raw images');
switch choice
    case 'Raw images'
        Ans=1
    case 'filtered/unmixed images'
        Ans=2
end



val=get(handles.polarization_type,'value')
str=get(handles.polarization_type,'string')
str=char(str(val))
str=str(findstr(str,'.')+1:end);



plot_list=get(handles.popupmenu1,'string')
n=size(plot_list,1)+1




if Ans==1
    
    
    
    [P1,P2]=add_polarization_vector(handles,handles.poi_mean_projected , handles.control_mean_projected,handles.control_segmented,val);  P3=abs(P1);P4=abs(P2);
    
    
    eval(char(strcat('handles.p',num2str(n),'=P1','''')));
    eval(char(strcat('handles.p',num2str(n+1),'=P2','''')));
    eval(char(strcat('handles.p',num2str(n+2),'=P3','''')));
    eval(char(strcat('handles.p',num2str(n+3),'=P4','''')));
    
    
    str1=char([num2str(n) '. Raw POI' str])
    str2=char([num2str(n+1) '. Raw control' str])
    str3=char([num2str(n+2) '. Raw POI Abs' str])
    str4=char([num2str(n+3) '. Raw control Abs' str])
    
    plot_list=cellstr(plot_list);
    plot_list(n)=cellstr(str1) ; plot_list(n+1)=cellstr(str2) ; plot_list(n+2)=cellstr(str3) ; plot_list(n+3)=cellstr(str4) ;
    
    
end


if Ans==2
    [P1,P2]=add_polarization_vector(handles,handles.poi_unmixed,handles.control_unmixed,handles.control_segmented,val);  P3=abs(P1);P4=abs(P2);
    eval(char(strcat('handles.p',num2str(n),'=P1','''')));
    eval(char(strcat('handles.p',num2str(n+1),'=P2','''')));
    eval(char(strcat('handles.p',num2str(n+2),'=P3','''')));
    eval(char(strcat('handles.p',num2str(n+3),'=P4','''')));
    str1=char([num2str(n) '. Unmixed POI' str])
    str2=char([num2str(n+1) '. Unmixed control' str])
    str3=char([num2str(n+2) '. Unmixed POI Abs' str])
    str4=char([num2str(n+3) '. Unmixed control Abs' str])
    
    plot_list=cellstr(plot_list);
    plot_list(n)=cellstr(str1) ; plot_list(n+1)=cellstr(str2) ; plot_list(n+2)=cellstr(str3) ; plot_list(n+3)=cellstr(str4) ;
    
end



set(handles.popupmenu1,'string',plot_list);
set(handles.popupmenu2,'string',plot_list);
set(handles.popupmenu3,'string',plot_list);
set(handles.popupmenu4,'string',plot_list);

guidata(hObject,handles) ;


% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
[track_what,Projected_by,pathname_pos]=Path_selection_GUI;
handles.track_what=track_what;
handles.Projected_by=Projected_by;
handles.pathname_pos=pathname_pos;
guidata(hObject,handles) ;



% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)



% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
set_scale2_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
set_scale1_Callback(hObject, eventdata, handles)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Y_lim_start1.
function Y_lim_start1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Y_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uitoggletool4_ClickedCallback(hObject, eventdata, handles)
axes(handles.axes1); axis tight;
axes(handles.axes4); axis tight;
axes(handles.axes3); axis tight;
