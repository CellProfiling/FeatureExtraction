function magnify_TACWrapper(varargin) 
%DO NOT EDIT_________________________________________________________________ 
% This file is located in TACTICS open code library.
% All rights reserved to its original authors.
% Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
% Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
% Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer 
% in the documentation and/or other materials provided with the distribution.  
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
% THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
% INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
% OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
% THE POSSIBILITY OF SUCH DAMAGE. 
% Important: This file may include some code editing to enable incorporation with TACTICS Toolbox
% ___________________________________________________________________________ 

% NOTE 
% >Code was directly lifted from magnify_not_symetricrecttofig.m by Andrew Diamond, EnVision Systems LLC, 3/27/05.
% >Code was directly lifted from magnify_not_symetric.m by Rich Hindman. 
% Thanks.
load val
nin = nargin;
moptionpos = find(strncmpi(varargin,'m',1));
bMaxTargetAxisSize=0;
if(length(moptionpos)== 1)
    bMaxTargetAxisSize = 1;
    varargin = varargin([1:moptionpos-1,moptionpos+1:end]);
    nin = nin - 1;
end
if(nin > 0)
    f1 = varargin{1};
    if(~isfigure(f1))
        error('source is not a figure');
    end
else
    f1 = gcf;
end

if(nin > 1)
    hTargetWindow = varargin{2};
    if(~isfigure(hTargetWindow))
        error('target is not a figure');
    end
else
    hTargetWindow = [];
end
% [1,1] is ration between the squere and number of pixels
UserDataInfo = struct('TargetWindow',hTargetWindow,'RectFrac',val, 'bMaxTargetAxisSize',bMaxTargetAxisSize,'ready',0);
UserDataInfo.f1Info.hRect=-1;
set(f1, ...
    'WindowButtonDownFcn',  @ButtonDownCallback, ...
    'WindowButtonUpFcn', @ButtonUpCallback, ...
    'WindowButtonMotionFcn', @ButtonMotionCallback, ...
    'KeyPressFcn', @KeyPressCallback,...
    'UserData', UserDataInfo);
return;


function ButtonDownCallback(f1,eventdata)
if(~strcmpi(get(f1,'SelectionType'),'Normal')) % allow left click only 
close (1)
close(2)
 return 
 end
UserDataInfo = get(f1,'UserData');
a1 = get(f1,'CurrentAxes');
if(~isfigure(UserDataInfo.TargetWindow))
    UserDataInfo.TargetWindow=figure;
    set(0,'CurrentFigure',f1); % figure(f1);
    f1pos = get(f1,'Position');
    set(UserDataInfo.TargetWindow,'Position',[f1pos(1)+f1pos(3), f1pos(2),f1pos(3:4)])
end
set(0,'CurrentFigure',UserDataInfo.TargetWindow); % figure(UserDataInfo.TargetWindow); 
clf; 
set(0,'CurrentFigure',f1); % figure(f1); % for backwards compatibility.
set(UserDataInfo.TargetWindow, 'Colormap',get(f1, 'Colormap'));
copyobj(a1,UserDataInfo.TargetWindow);
hRect=rectangle('Position',[1,1,1,1],'visible', 'on','EraseMode','xor');
a2 = get(UserDataInfo.TargetWindow,'CurrentAxes');
if(UserDataInfo.bMaxTargetAxisSize)
    set(a2,'Position',[0,0,1,1]) % Using OuterPosition might be better but that's not backward compatible.  Debatable anyway.
end
    
RectFrac=UserDataInfo.RectFrac; % default if not already overridden
if(isfield(UserDataInfo,'f1Info'))
    if(isfield(UserDataInfo.f1Info,'RectFrac'))
        RectFrac = UserDataInfo.f1Info.RectFrac; % previously set.
    end
end
UserDataInfo.f1Info = struct('hfig',f1,'hax',a1,'hRect',hRect,'RectFrac',RectFrac);
UserDataInfo.f2Info = struct('hfig',UserDataInfo.TargetWindow,'hax',a2);
UserDataInfo.ready=1;
set(f1,'UserData',UserDataInfo);
figure(f1);
% set(0,'CurrentFigure',f1);  % for backwards compatibility.
set(f1, 'CurrentAxes',a1);
set(2,'Toolbar','none'); %better
return;

function ButtonUpCallback(src,eventdata)
% get(src,'SelectionType')
UserDataInfo = get(src,'UserData');
if isempty(UserDataInfo); return; end;
if UserDataInfo.ready == 0; return; end;
UserDataInfo.ready=0;
delete(UserDataInfo.f1Info.hRect);
UserDataInfo.f1Info.hRect=-1;
set(src,'UserData',UserDataInfo);
set(2,'Toolbar','none'); %better
return;

function ButtonMotionCallback(src,eventdata)
UserDataInfo = get(src,'UserData');
if isempty(UserDataInfo); return; end;
if UserDataInfo.ready == 0; return; end;

f1 = UserDataInfo.f1Info.hfig;
a1 = UserDataInfo.f1Info.hax;
a2 = UserDataInfo.f2Info.hax;
[f_cp, a1_cp] = pointer2d(f1,a1);
axisa1 = axis(UserDataInfo.f1Info.hax);
rectdxdy = UserDataInfo.f1Info.RectFrac .* (axisa1([2,4])-axisa1([1,3]));
rectsxsy = a1_cp(1:2)  - rectdxdy ./ 2;
RectanglePosInfo = [rectsxsy,rectdxdy];
set(UserDataInfo.f1Info.hRect,'Position',RectanglePosInfo); % ,'visible', 'on');
a2axistoset=[rectsxsy(1),rectsxsy(1)+rectdxdy(1), rectsxsy(2),rectsxsy(2)+rectdxdy(2)];
axis(a2,a2axistoset);
save a2axistoset a2axistoset
set(2,'Toolbar','none'); %better
drawnow;
return;

function KeyPressCallback(src,eventdata)
UserDataInfo = get(gcf,'UserData');
if isempty(UserDataInfo) 
    return; 
end;
if UserDataInfo.ready == 0 
    return; 
end;
    cc = get(UserDataInfo.f1Info.hfig,'CurrentCharacter');
    switch(cc)
        case {'<',','}
            UserDataInfo.f1Info.RectFrac = min(1,UserDataInfo.f1Info.RectFrac .* 2);
        case {'>','.'}
            UserDataInfo.f1Info.RectFrac = min(1,UserDataInfo.f1Info.RectFrac ./ 2);
            
            
        case {28} % left arrow - make rect wider which decreases horiz mag in target in 50% 512-256-128-64-32-16-8-4-2-1
            UserDataInfo.f1Info.RectFrac(1) = min(1,UserDataInfo.f1Info.RectFrac(1) .* 2);
            
        case {29} % right arrow - make rect narrower which increases horiz mag in target
            UserDataInfo.f1Info.RectFrac(1) = min(1,UserDataInfo.f1Info.RectFrac(1) ./ 2);
            
        case {30} % up arrow - make rect taller which decreases vert mag in target
            UserDataInfo.f1Info.RectFrac(2) = min(1,UserDataInfo.f1Info.RectFrac(2) .* 2);
            
        case {31} % right arrow - make rect shorter which increases vert mag in target
            UserDataInfo.f1Info.RectFrac(2) = min(1,UserDataInfo.f1Info.RectFrac(2) ./ 2);
            
            
        case {'r','R'}
            UserDataInfo.f1Info.RectFrac = UserDataInfo.RectFrac;
        case {'m','M'}
            UserDataInfo.bMaxTargetAxisSize = 1-UserDataInfo.bMaxTargetAxisSize;
            if(UserDataInfo.bMaxTargetAxisSize)
                set(UserDataInfo.f2Info.hax,'Position',[0,0,1,1]);
            else
                set(UserDataInfo.f2Info.hax,'Position',get(UserDataInfo.f1Info.hax,'Position'));
            end
        otherwise
            fprintf(1,'Other char input (char="%c", int=%d, hex=%x)\n',cc,cc,cc);
    end
    set(gcf,'UserData',UserDataInfo);
    ButtonMotionCallback(src);
return; 

 
function [fig_pointer_pos, axes_pointer_val] = pointer2d(fig_hndl,axes_hndl)

if (nargin == 0), fig_hndl = gcf; axes_hndl = gca; end;
if (nargin == 1), axes_hndl = get(fig_hndl,'CurrentAxes'); end;

set(fig_hndl,'Units','pixels');

pointer_pos = get(0,'PointerLocation');	%pixels {0,0} absolute screen coord of mouse.
fig_pos = get(fig_hndl,'Position');	%pixels {l,b,w,h} absolute screen coord of figure

fig_pointer_pos = pointer_pos - fig_pos([1,2]); % relative screen coord of mouse w/r to figure
set(fig_hndl,'CurrentPoint',fig_pointer_pos); % sets the currenpoint to relative screen coord?

if (isempty(axes_hndl)),
    axes_pointer_val = [];
elseif (nargout == 2),
    axes_pointer_line = get(axes_hndl,'CurrentPoint');
    axes_pointer_val = sum(axes_pointer_line)/2;
end;

function b=isfigure(h)
b=0;
if(isempty(h))
    return;
end
b=zeros(size(h));
hb = ishandle(h);
b(hb) = strcmpi(get(h(hb),'type'), 'figure');
