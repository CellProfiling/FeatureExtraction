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
function [matrix]=Filter_file(matrix,strel_value,strel_type, fspecial_value,fspecial_type,ii,X)

% Matlab user can easily  add more filter options upon demand. Instructions are as the following:
% Open Filter_file.m located in supporting functions library with Matlab editor.
%  Add indexed case. For instance, if there are 20 cases, add case 21.
% For this case add the next format:
% case 21
%  if nargin==0
%                  matrix(11)={  ‘user given name for the operation'}
%         else
%             matrix(:,:,1)=operation added by the user
%          end
% %Example:
% %case 11
%        %    if   nargin==0
%        %       matrix(11)={  'Canny edge detection'}
%        %   else
%        %        matrix(:,:,1)=Canny(matrix(:,:,1));
%        %   end
% Whereas nargin==0 is used to give the function name,
% matrix(:,:,1) is the returned output  (filtered image),
% 11 is the case index
% Canny is the function used on input matrix
% matrix can be in 3-D format
% 4. Save and exit the Filter_file.m .
% 5. Open TACTICS_F.m with Matlab editor.
% 6. Add to the indexed case under  F_popup_function slider setting. This settings are depended on the  maximum  input value. i.e.:
%             eval( strcat ('set(handles.F_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
%             eval( strcat ('set(handles.F_edit_',num2str(ii), ',','''String''', ',0)'));
%              eval( strcat ('set(handles.F_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
%              eval( strcat ('set(handles.F_Slider_',num2str(ii), ',','''Max''', ',100)'));
%              eval( strcat ('set(handles.F_Slider_',num2str(ii), ',','''Min''', ',0)'));
%              eval( strcat ('set(handles.F_Slider_',num2str(ii), ',','''Value''', ',0)'));
%              eval( strcat ('set(handles.F_Slider_',num2str(ii), ',','''Sliderstep''', ',[0.005 0.1])'));
% 7. Save and exit TACTICS_F.m .


if nargin==0
    a=1;
    b=30; % 30 estamted as the limit for the last case
    matrix= {
        'Select:'
        }
else
    a=X;
    b=X;
    
end


for iii=a:b
    switch iii
        case 2
            if nargin==0
                matrix(2)={'imclose- morphological closing operation (dilation followed by a erosion)'}
            else
                SE = strel(strel_type,strel_value) ;
                matrix(:,:,1) = imclose(matrix(:,:,1),SE) ;
            end
        case 3
            if nargin==0
                matrix(3)={'imopen- morphological openning operation (erosion followed by a dilation)'}
            else
                SE = strel(strel_type,strel_value) ;
                matrix(:,:,1) = imopen(matrix(:,:,1),SE) ;
            end
            
        case 4
            if nargin==0
                matrix(4)={ 'Top Hat filter- to remove background'}
            else
                SE = strel(strel_type,strel_value) ;
                matrix(:,:,1)=imtophat(matrix(:,:,1),SE);
            end
        case 5
            if nargin==0
                matrix(5)={ 'imclearborder- to clear border)'}
            else
                matrix(:,:,1) = imclearborder(matrix(:,:,1)) ;
            end
            
        case 6
            if nargin==0
                matrix(6)={ 'noisecomp- noise diffusion correction algorithm'}
            else
                a=floor( strel_value/10);
                b=round(5*( strel_value/10-floor(strel_value/10)));
                matrix(:,:,1) =  noisecomp_TACWrapper(matrix(:,:,1) ,a,b);
            end
            
        case 7
            if nargin==0
                matrix(7)={   'rangefilt'}
            else
                matrix(:,:,1)= rangefilt(matrix(:,:,1)) ;
            end
            
            
            
            
            
        case 8
            if nargin==0
                matrix(8)={    'stdfilt'}
            else
                matrix(:,:,1) = stdfilt(matrix(:,:,1));
            end
            
            
        case 9
            if nargin==0
                matrix(9)={   'wiener2 deconvolution-    lowpass filter'}
            else
                matrix(:,:,1) = wiener2(matrix(:,:,1),[strel_value,strel_value]) ;
            end
            
            
            
            
        case 10
            if nargin==0
                matrix(10)={  'imfilter'}
            else
                if fspecial_value~=0
                    H = fspecial(fspecial_type,fspecial_value);
                    matrix(:,:,1) = imfilter(matrix(:,:,1),H,'replicate');
                end
            end
            
            
            
            
            
            
        case 11
            if nargin==0
                matrix(11)={  'Canny edge detection'}
            else
                matrix(:,:,1)=canny_TACWrapper(matrix(:,:,1));
            end
        case 12
            if nargin==0
                matrix(12)={  'convolution filter'}
            else
                
                if fspecial_value~=0
                    try
                        H = fspecial(fspecial_type,strel_value,fspecial_value);
                    catch
                        if strel_value==0
                            strel_value=1;
                        end
                        H = fspecial(fspecial_type,strel_value);
                    end
                    matrix(:,:,1) = conv2(matrix(:,:,1),H,'same'); %convolution
                end
            end
            
        case 13
            if nargin==0
                matrix(13)={     'Smoothing using median filter-  reduce noise and preserve edges' }
            else
                %     to add smooting:
                matrix(:,:,1) =medfilt2(matrix(:,:,1));
                
            end
            
            
            
        case 14
            if nargin==0
                matrix(14)={     'Bottom-hat filtering- enhance contrast'   }
            else
                %     to add smooting:
                
                SE = strel(strel_type,strel_value) ;
                matrix(:,:,1)  = imsubtract(imadd(matrix(:,:,1),imtophat(matrix(:,:,1),SE)), imbothat(matrix(:,:,1),SE));
            end
            
        case 15
            if nargin==0
                matrix(15)={    'matrix-mean(mean(matrix))'     }
            else
                %     to add smooting:
                
                
                matrix(:,:,1)=matrix(:,:,1)-mean(mean(matrix(:,:,1)));
            end
            
            
            
        case 16
            
            
            if nargin==0
                matrix(16)={    'Channel unmiximg'     }
            else
                
                
                
                
                temp=uint8(double(matrix(:,:,1))./(double(matrix(:,:,2))).*fspecial_value) ;
                temp(temp<0)==0;
                matrix(:,:,1)=temp;
            end
        case 17
            if nargin==0
                matrix(17)={    'Channel_1\Channel_2'     }
            else
                
                
                
                
                
                matrix=my_unmix(matrix, strel_value/100);
                
            end
            
        case 18
            
            %           if   nargin==0
            %              matrix(18)={  'mask XY section'}
            %           else
            %                temp=matrix(:,:,1);
            %               temp(matrix(:,:,2)==0) =0;
            %                matrix(:,:,1)=temp;
            %          end
            %         case 19
            if   nargin==0
                matrix(18)={  'DIC and fluo to graysacle'}
            else
                Close
                temp1 =  noisecomp_TACWrapper(matrix(:,:,1) ,2,20);
                temp0=temp1;
                
                
                temp2=matrix(:,:,2);
                
                
                
                temp= temp2 ./temp1;
                %                temp(temp==0)=nan ;
                temp(temp==inf)=0;
                temp(temp<0)=0;temp(temp>strel_value)=0;
                %               temp=~temp;
                %                   temp3=-temp
                %                   ;temp3=temp3./temp3;
                
                %                  temp=temp  ;
                
                
                
                %               temp= temp-mean(mean(temp));
                %
                %                figure(1)
                %                imagesc(temp )
                
                %                return
                %               temp(matrix(:,:,2)==0) =0;
                matrix(:,:,1)=temp;
            end
            
    end
end