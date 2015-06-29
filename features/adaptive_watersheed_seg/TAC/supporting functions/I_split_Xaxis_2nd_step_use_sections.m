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
function [matrix_out] =I_split_Xaxis_2nd_step_use_sections( pathname_Raw,Raw_filename,track_what,temp_Threshold,min_mean)

% 1. label segments again:
L=bwlabel(temp_Threshold,4);
XY_data= regionprops(L, 'BoundingBox' );

% 2.  reading  raw .tif files
try
    Raw_full_filename = char(strcat(pathname_Raw,Raw_filename,'_ch0',num2str(track_what-1),'.tif')) ;   temp=imread(Raw_full_filename);
catch
    Raw_full_filename = char(strcat(pathname_Raw,Raw_filename)) ;   temp=imread(Raw_full_filename);
end

%   reading sections :
for kk=1:5
    z_full_filename =    char(strcat(pathname_Raw,'z\',Raw_filename,'_z0',num2str(kk),'_ch0',num2str(track_what-1),'.tif')) ;
    temp_Raw(:,:,kk)= double(imread( z_full_filename));
end

% 3. Second segmentation
try
    for iii=1:size(XY_data,1)
        try
            ROI=[];jj=1;
            XY=  double(XY_data(iii).BoundingBox);
            
            STAT=0;
            
            if (XY(1)+XY(3))>512
                XY(1)=floor(XY(1));
            end
            if (XY(2)+XY(4))>512
                XY(2)=floor(XY(2));
            end
            X1=round(XY(2)) ;
            Y1=round(XY(1));
            X2=round(XY(2)+XY(4));
            Y2=round(XY(1)+XY(3));
            matrix_intensity=double(temp(X1:X2,Y1:Y2));
            matrix_bw=double(temp_Threshold(X1:X2,Y1:Y2));
            
            %  ---------------- Auto
            %   ------------------------ Threshold
            %   ------------------------------START here:
            for kk=1:5 %if useing 5 sections
                roi=double(temp_Raw(X1:X2,Y1:Y2,kk)).*double(matrix_bw);
                vector_mean_roi(kk)=mean(mean(roi));
            end
            [~,bb]=sort(vector_mean_roi,'descend');
            %      Reconstruct ROI based on best 3 sections (can be adjusted)
            ROI= (temp_Raw(X1:X2,Y1:Y2 ,bb(1))+temp_Raw(X1:X2,Y1:Y2 ,bb(2))+temp_Raw(X1:X2,Y1:Y2 ,bb(3)));
            ROI = uint8(256*(ROI ./(max(max(ROI ))))) ;    %norm matrix
            
            %  4. segmentation method:
            ROI2= I_split_Xaxis(temp_Threshold(X1:X2,Y1:Y2), ROI)  ;
            %Critiria: 0. minimum size of segment larger than critical area 1. must
            %be only one segment. 2. Circularity higher than 0.45
            %3. Less than 0.4 percatet of border line is filled. 4. new threshold is at least 0.6 percent from the original matrix_bw!
            
            if mean(ROI2(:,1))<0.4 || mean(ROI2(:,end))<0.4 || mean(ROI2(:,1))<0.4 || mean(ROI2(:,end))<0.4
                temp_Threshold(X1:X2,Y1:Y2)  =    ROI2  ;
            else
                temp_Threshold(X1:X2,Y1:Y2)  =   0
            end
            
        end
    end
end
matrix_out=255*temp_Threshold ;


