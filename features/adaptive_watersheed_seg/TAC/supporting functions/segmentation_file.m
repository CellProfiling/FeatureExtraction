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
function [matrix]=segmentation_file(matrix,strel_value,strel_type, bwareaopen_value,bwareaopen_type,ii,X,pathname_Raw,Raw_filename,track_what)

% Matlab user can easily  add more segmentation and binary operations options upon demand. Instructions are as the following:
% Open segmentation_file.m located in supporting functions library with Matlab editor.
%  Add indexed case. For instance, if there are 10 cases, add case 11.
% For this case add the next format:
% case 11
%  if nargin==0
%                  matrix(11)={  ‘user given name for the operation'}
%         else
%             matrix=operation added by the user
%          end
% %Example:
% %case 7
%         %    if nargin==0
%         %         matrix(7)={   'imfill holes'}
%         %    else
%         %             matrix=imfill(matrix,'holes');
%         %    end
%
% Whereas nargin==0 is used to give the function name,
% matrix is the input and returned output  image
% 7  is the case index
% imfill is the function used on input matrix
% matrix can be only in 2-D format
% 4. Save and exit the segmentation_file.m .
% 5. Open TACTICS_F.m with Matlab editor.
% 6. Add to the indexed case under  T_popup_function slider setting. This settings are depended on the  maximum  input value. i.e.:
%             eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
%              eval( strcat ('set(handles.T_edit_',num2str(ii), ',','''String''', ',0)'));
%              eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Visible''', ',', '''on''', ')'));
%              eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Max''', ',1)'));
%              eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Min''', ',0)'));
%              eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Value''', ',0)'));
%              eval( strcat ('set(handles.T_Slider_',num2str(ii), ',','''Sliderstep''', ',[0.005 0.05])'))
% 7. Save and exit TACTICS_F.m .
%
%
















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
                matrix(2)={'bwmorph'}
            else
                
                bwareaopen_type=regexprep( bwareaopen_type,' ','')
                eval(strcat('matrix=bwmorph(matrix',',','''',bwareaopen_type,'''',');'))
            end
        case 3
            if nargin==0
                matrix(3)={'bwareaopen-threshsold smallest objects'}
            else
                matrix=bwareaopen(matrix,strel_value,4);
                
            end
            
        case 4
            if nargin==0
                matrix(4)={ 'bwareaopen- threshsold largest objects'}  ;
            else
                L = bwlabel(matrix,4);
                stats = regionprops(L,'Area');
                idx = find([stats.Area] < strel_value);
                matrix = ismember(L,idx);
                
            end
        case 5
            if nargin==0
                matrix(5)={ 'imclose spaces and gaps'}  ;
            else
                
                SE = strel(strel_type,strel_value ) ;
                matrix = imclose(matrix,SE) ;
                
                
            end
            
        case 6
            if nargin==0
                matrix(6)={ 'imclearborder'}  ;
            else
                
                
                matrix=imclearborder(matrix,strel_value);
                
                
                
            end
            
        case 7
            if nargin==0
                matrix(7)={   'imfill holes'}  ;
            else
                matrix=imfill(matrix,'holes');
            end
            
            
            
            
            
        case 8
            if nargin==0
                matrix(8)={    'circularity- segmentation round objects'}  ;
            else
                
                circularity=[];
                [B,L]=bwboundaries(matrix,'noholes');
                stats=regionprops(L,'all');
                for jj=1:length(stats)
                    boundary = B{jj};
                    % compute a simple estimate of the object's perimeter
                    delta_sq = diff(boundary).^2;
                    area(jj)=stats(jj).Area;
                    perimeter = sum(sqrt(sum(delta_sq,2)));
                    circumference(jj)=perimeter;
                    circularity(jj)=4*pi*area(jj)/perimeter^2;
                end
                if isempty( circularity)~=1
                    idx = find( circularity  >strel_value) ;
                    if isempty(idx)==1
                        matrix=zeros(size(matrix));
                    else
                        matrix = ismember(L,idx) ;
                    end
                end
                
                
            end
            
            
        case 9
            if nargin==0
                matrix(9)={   'circularity- threshold non-round objects'}  ;
            else
                
                [B,L]=bwboundaries(matrix,'noholes');
                stats=regionprops(L,'all');
                for jj=1:length(stats)
                    boundary = B{jj};
                    % compute a simple estimate of the object's perimeter
                    delta_sq = diff(boundary).^2;
                    area(jj)=stats(jj).Area;
                    perimeter = sum(sqrt(sum(delta_sq,2)));
                    circumference(jj)=perimeter;
                    circularity(jj)=4*pi*area(jj)/perimeter^2;
                end
                
                idx = find( circularity  <strel_value);
                if isempty(idx)==1
                    matrix=zeros(size(matrix));
                else
                    matrix = ismember(L,idx) ;
                end
            end
            
            
            
            
        case 10
            if nargin==0
                matrix(10)={  'Shape to round function'}  ;
            else
                matrix=make2round(matrix,strel_value)   ;
            end
            
            
            
        case 11
            if nargin==0
                matrix(11)={  'Watershed'}
            else
                
                SE = strel(strel_type,strel_value );
                mask_em = imerode(matrix,SE) ;
                mask_em = imfill( mask_em, 'holes');
                mask_em = bwareaopen(mask_em, 20);
                
                bw=matrix;
                D = bwdist(bw);
                DL = watershed(D);
                bgm = DL == 0;
                
                hy = fspecial('sobel');
                hx = hy';
                Iy = imfilter(double(matrix), hy, 'replicate');
                Ix = imfilter(double(matrix), hx, 'replicate');
                gradmag = sqrt(Ix.^2 + Iy.^2);
                
                gradmag2 = imimposemin(gradmag, bgm | mask_em);
                L = watershed(gradmag2);
                matrix(L<3)=0;
            end
            
        case 12
            if nargin==0
                matrix(12)={  'imerode'}  ;
            else
                SE = strel(strel_type,strel_value ) ;
                matrix = imerode(matrix,SE) ;
            end
            
        case 13
            if nargin==0
                matrix(13)={  'Otsu- 2nd step-use sections'}  ;
            else
                matrix =Otsu_2nd_step_use_sections( pathname_Raw,Raw_filename,track_what,matrix,strel_value,bwareaopen_value);
            end
        case 14
            if nargin==0
                matrix(14)={  'Otsu- 2nd step- without sections'}  ;
            else
                matrix =Otsu_2nd_step_without_sections( pathname_Raw,Raw_filename,track_what,matrix);
            end
        case 15
            if nargin==0
                matrix(15)={  'Watershed- 2nd step-use sections'}  ;
            else
                matrix =Watershed_2nd_step_use_sections( pathname_Raw,Raw_filename,track_what,matrix,strel_value,bwareaopen_value);
            end
        case 16
            if nargin==0
                matrix(16)={  'Watershed- 2nd step- without sections'} ;
            else
                matrix =Watershed_2nd_step_without_sections( pathname_Raw,Raw_filename,track_what,matrix);
            end
        case 17
            if nargin==0
                matrix(17)={  'Intensity split trough Xaxis - 2nd step-use sections'}  ;
            else
                matrix =I_split_Xaxis_2nd_step_use_sections( pathname_Raw,Raw_filename,track_what,matrix,strel_value);
            end
        case 18
            if nargin==0
                matrix(18)={  'Intensity split trough Xaxis- 2nd step- without sections'}  ;
            else
                matrix =I_split_Xaxis_2nd_step_without_sections( pathname_Raw,Raw_filename,track_what,matrix);
            end
        case 19
            if nargin==0
                matrix(19)={  'Inverse intensity'}  ;
            else
                matrix=~matrix;
            end
            %
    end
end