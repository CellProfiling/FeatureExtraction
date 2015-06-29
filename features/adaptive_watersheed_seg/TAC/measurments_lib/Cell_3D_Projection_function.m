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
function Cell_3D_Projection_function(handles,n,Vs) %5
 Data=Get_Cell_stack(handles,n,Vs) 
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
 
scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
figure('color','w','units','pixels','position', scrsz) ; 
 
 

  if (get( handles.Merge_channels ,'Value') == get(handles.Merge_channels,'Max')) 
  D=im2uint8(zeros(max_x,max_y,3,ii)); 
  for ii=1:size(Data,2)  
 D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,:,ii)= Data(ii).cdata ;
  end
  else
   D=zeros(max_x,max_y,1,ii);
for ii=1:size(Data,2)  
 D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,1,ii)=Data(ii).cdata(:,:) ; 
end
  end
 
 
  
 
h = vol3d_TACWrapper('cdata',D ,'texture','3D');
vol3d_TACWrapper(h); z=0.1% z parameter for length into Z direction
axis tight; daspect([1 1 z]);
alphamap('increase');
alphamap(0.3 .* alphamap);
colormap jet(64);
set(gca,'XDir','normal');
set(gca,'YDir','normal');
set(gcf,'color','black');
axis off;
Div_Cells_str=get(handles.Div_Cells,'string');  n=find(strcmp(cellstr(n), Div_Cells_str )) ; 
str =strcat(Vs, ' 3D_Projection of : ', num2str(n));   title(str); 
set(gcf,'Userdata',Data);

