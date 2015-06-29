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
function varargout = change_LUT(varargin)

% CHANGE_LUT M-file for change_LUT.fig
%      CHANGE_LUT, by itself, creates a new CHANGE_LUT or raises the existing
%      singleton*.
%
%      H = CHANGE_LUT returns the handle to a new CHANGE_LUT or the handle to
%      the existing singleton*.
%
%      CHANGE_LUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHANGE_LUT.M with the given input arguments.
%
%      CHANGE_LUT('Property','Value',...) creates a new CHANGE_LUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before change_LUT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to change_LUT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help change_LUT

% Last Modified by GUIDE v2.5 26-Sep-2012 19:01:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @change_LUT_OpeningFcn, ...
    'gui_OutputFcn',  @change_LUT_OutputFcn, ...
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


% --- Executes just before change_LUT is made visible.
function change_LUT_OpeningFcn(hObject, eventdata, handles, varargin)


if nargin <4
    handles.output = hObject;
    guidata(hObject, handles);
end
imagesc(rand(50,50));     axis off
handles.c =get(gcf,'Colormap');     guidata(hObject, handles);
uiwait


% --- Outputs from this function are returned to the command line.
function varargout = change_LUT_OutputFcn(hObject, eventdata, handles)

varargout{1}=    get(gcf,'colormap');

guidata(hObject, handles);
close


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
SELECTION=get(hObject, 'Value');
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

switch SELECTION
    case 2
        handles.c=dic;  imagesc(rand(50,50)); axis off ; set(gcf,'Colormap',handles.c)
    case 3
        handles.c=cfp; imagesc(rand(50,50)); axis off ; set(gcf,'Colormap',handles.c)
    case 4
        handles.c=gfp; imagesc(rand(50,50)); axis off ; set(gcf,'Colormap',handles.c)
    case 5
        handles.c=yfp; imagesc(rand(50,50)); axis off;  set(gcf,'Colormap',handles.c)
    case 6
        handles.c=Cherry;
        imagesc(rand(50,50)); axis off ; set(gcf,'Colormap',handles.c);
        
    case 7
        handles.c=rfp; imagesc(rand(50,50)); axis off;  set(gcf,'Colormap',handles.c)
    case 8
        c=jet;
        c(1,:)=[0,0,0];
        handles.c=c; imagesc(rand(50,50)); axis off ; set(gcf,'Colormap',handles.c)
    case 9
        c=jet;
        c(1,:)=[1,1,1];
        handles.c=c; imagesc(rand(50,50)); axis off ; set(gcf,'Colormap',handles.c)
    case 10
        handles.c=[  1.0000    1.0000    1.0000
            0.9444    0.9444    0.9444
            0.8889    0.8889    0.8889
            0.8333    0.8333    0.8333
            0.7778    0.7778    0.7778
            0.7222    0.7222    0.7222
            0.6667    0.6667    0.6667
            0.6111    0.6111    0.6111
            0.5556    0.5556    0.5556
            0.5000    0.5000    0.5000
            0.4444    0.4444    0.4444
            0.3889    0.3889    0.3889
            0.3333    0.3333    0.3333
            0.2778    0.2778    0.2778
            0.2222    0.2222    0.2222
            0.1667    0.1667    0.1667
            0.1111    0.1111    0.1111
            0.0556    0.0556    0.0556
            0         0         0
            0    0.0222         0
            0    0.0444         0
            0    0.0667         0
            0    0.0889         0
            0    0.1111         0
            0    0.1333         0
            0    0.1556         0
            0    0.1778         0
            0    0.2000         0
            0    0.2222         0
            0    0.2444         0
            0    0.2667         0
            0    0.2889         0
            0    0.3111         0
            0    0.3333         0
            0    0.3556         0
            0    0.3778         0
            0    0.4000         0
            0    0.4222         0
            0    0.4444         0
            0    0.4667         0
            0    0.4889         0
            0    0.5111         0
            0    0.5333         0
            0    0.5556         0
            0    0.5778         0
            0    0.6000         0
            0    0.6222         0
            0    0.6444         0
            0    0.6667         0
            0    0.6889         0
            0    0.7111         0
            0    0.7333         0
            0    0.7556         0
            0    0.7778         0
            0    0.8000         0
            0    0.8222         0
            0    0.8444         0
            0    0.8667         0
            0    0.8889         0
            0    0.9111         0
            0    0.9333         0
            0    0.9556         0
            0    0.9778         0
            0    1.0000         0];
        imagesc(rand(50,50)); axis off ; set(gcf,'Colormap',handles.c);
        
    case 11
        colormapeditor
        
end
guidata(hObject,handles);


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
uiresume



% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)

%

