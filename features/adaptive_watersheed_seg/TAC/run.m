% ----------------------------------------------------------------------------------------------------------
% Created as part of TACTICS v2.0 Toolbox under BSD License
% TACTICS (Totally Automated Cell Tracking In Confinement Systems) is a Matlab toolbox for High Content Analysis (HCA) of fluorescence tagged proteins organization within tracked cells. It designed to provide a platform for analysis of Multi-Channel Single-Cell Tracking and High-Trough Output Quantification of Imaged lymphocytes in Microfabricated grids arrays.
% We wish to make TACTICS V2.0 available, in executable form, free for academic research use distributed under BSD License.
% IN ADDITION, SINCE TACTICS USE THIRD OPEN-CODE LIBRARY (I.E TRACKING ALGORITHEMS, FILTERS, GUI TOOLS, ETC) APPLICABLE ACKNOLEDMENTS HAVE TO BE SAVED TO ITS AUTHORS.
% ----------------------------------------------------------------------------------------------------------
% Copyright (c) 2010-2012, Raz Shimoni
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

% Code starts here:

function run(str_gui,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10)



CD=cd;
eval(strcat('addpath(','''',CD,'''',')')) 
eval(strcat('addpath(','''',CD,'\supporting media''',')'))
eval(strcat('addpath(','''',CD,'\supporting functions''',')'))
eval(strcat('addpath(','''',CD,'\modules''',')'))
eval(strcat('addpath(','''',CD,'\open_code_lib''',')'))
eval(strcat('addpath(','''',CD,'\supporting tools''',')'))
eval(strcat('addpath(','''',CD,'\measurments_lib''',')'))
eval(strcat('addpath(','''',CD,'\MATLAB wrapper''',')'))
  

close
if nargin==0
    h=TACTICS;
  elseif nargin==1
    eval(char(strcat('h=',str_gui)));
     elseif  nargin==2
       eval(char(strcat('h=',str_gui,'(','data1',')')));
     elseif  nargin==3
       eval(char(strcat('h=',str_gui,'(','data1,data2',')')));
     elseif  nargin==4
          eval(char(strcat('h=',str_gui,'(','data1,data2,data3',')')));
        elseif  nargin==5
          eval(char(strcat('h=',str_gui,'(','data1,data2,data3,data4',')')));
        elseif  nargin==6
          eval(char(strcat('h=',str_gui,'(','data1,data2,data3,data4,data5',')')));
        elseif  nargin==7
          eval(char(strcat('h=',str_gui,'(','data1,data2,data3,data4,data5,data6',')')));
        elseif  nargin==8
         eval(char(strcat('h=',str_gui,'(','data1,data2,data3,data4,data5,data6,data7',')')));
         elseif  nargin==9 
         eval(char(strcat('h=',str_gui,'(','data1,data2,data3,data4,data5,data6,data7,data8',')')));
         elseif  nargin==10
         eval(char(strcat('h=',str_gui,'(','data1,data2,data3,data4,data5,data6,data7,data8,data9',')'))); 
         elseif  nargin==11
         eval(char(strcat('h=',str_gui,'(','data1,data2,data3,data4,data5,data6,data7,data8,data9,data10',')'))); 
end
      drawnow;  
      
      
      
      
jframe = getjframe_TACWrapper(h); %%undocumented
 set(getjframe_TACWrapper,'Maximized',1);%maximizes the window, 0 to minimize 
set(getjframe_TACWrapper,'AlwaysOnTop',0);%places window on top, 0 to disable
set(getjframe_TACWrapper,'Title','TACTICS_v2.21');%places window on top, 0 to disable




 



a(1)=  exist('hungarianlinker_TACWrapper') ;
a(2)=  exist('kmeans_TACWrapper') ;
a(3)=  exist('Munkres_TACWrapper') ;
a(4)=  exist('ANGLE_DEG_2D_TACWrapper') ;
a(5)=  exist('vol3d_TACWrapper') ;
a(6)=  exist('track_crocker_TACWrapper') ;
a(7)=  exist('timebar_TACWrapper') ; 
a(8)=  exist('speaker_TACWrapper') ;
a(9)=  exist('noisecomp_TACWrapper') ;
a(10)=  exist('canny_TACWrapper') ;
a(11)=  exist('nhist_TACWrapper') ;
a(12)=  exist('magnify_TACWrapper') ;
a(13)=  exist('Level_Set_Evolution_TACWrapper') ;
a(14)=  exist('smoothn_TACWrapper') ;
a(15)=  exist('IDCTN_TACWrapper') ;
a(16)=  exist('DCTN_TACWrapper') ;
a(17)=  exist('houghcircles_TACWrapper') ;
a(18)=  exist('getjframe_TACWrapper') ;
a(19)=  exist('bresenham_TACWrapper') ;
a(20)=  exist('distinguishable_colors_TACWrapper'); 
a(21)=  exist('imrotate2_TACWrapper'); 
a(22)=  exist('dscatter_TACWrapper');  
a(23)=  exist('drlse_edge_TACWrapper'); 
 


 
if mean(a)~=2
    msgbox('open-code functions are missing')
end