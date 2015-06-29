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
function  matrix_out = read_image3(pathname,filename,track_what,segmentation_type, Projected_by)
matrix_out=[];
Projected_by2=str2double(regexprep(Projected_by, 'z', '')) ;
if isempty(Projected_by2)~=1 && isnan(Projected_by2)~=1
    switch segmentation_type
        case 1
            full_filename = char(strcat(pathname(track_what,1),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'.tif'))
            try
                matrix_out=imread(full_filename ,1) ;
            end
        case 2
            full_filename = char(strcat(pathname(track_what,2),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Filtered.tif'))  ;
            try
                matrix_out=imread(full_filename ,1);
            end
        case 3
            full_filename = char(strcat(pathname(track_what,3),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif')) ;
            try
                temp=imread(full_filename ,1);
                matrix_out=flipdim(temp,1);
            end
            
        case 4
            full_filename_Filtered = char(strcat(pathname(track_what,2),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Filtered.tif')) ;
            
            try
                temp_Filtered=imread(full_filename_Filtered ,1);
                temp_Filtered=double(temp_Filtered);
            end
            full_filename_Segmention = char(strcat(pathname(track_what,3),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif'))  ;
            try
                temp_Segmention=imread(full_filename_Segmention ,1);
                temp_Segmention=flipdim(temp_Segmention,1);
                temp_Segmention=double(temp_Segmention);
                matrix_out=temp_Filtered.* temp_Segmention;
            end
        case 5
            full_filename_Raw = char(strcat(pathname(track_what,1),'z\',filename,'_ch0',num2str(track_what-1),'.tif'))  ;
            try
                temp_Raw=imread(full_filename_Raw ,1);
                temp_Raw=double(temp_Raw);
            end
            full_filename_Segmention = char(strcat(pathname(track_what,3),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif')) ;
            try
                temp_Segmention=imread(full_filename_Segmention ,1);
                temp_Segmention=flipdim(temp_Segmention,1);
                temp_Segmention=double(temp_Segmention);
                matrix_out=temp_Raw.* temp_Segmention;
            end
    end
    full_filename = char(strcat(pathname(track_what,3),'z\',filename,'_z0',num2str(Projected_by2),'_ch0',num2str(track_what-1),'_Segmented.tif')) ;
    try
        temp=imread(full_filename ,1);
        Segmention_out=flipdim(temp,1);
    end
end

if findstr('By mean',char(Projected_by) )
    save  segmentation_type segmentation_type
    switch segmentation_type
        case 1
            full_filename = char(strcat(pathname(track_what,1),filename,'_ch0',num2str(track_what-1),'.tif'))  ;
            try
                matrix_out=imread(full_filename ,1);
            end
        case 2
            full_filename = char(strcat(pathname(track_what,2),filename,'_ch0',num2str(track_what-1),'_Filtered.tif')) ;
            try
                matrix_out=imread(full_filename ,1);
            end
        case 3
            full_filename = char(strcat(pathname(track_what,3),filename,'_ch0',num2str(track_what-1),'_Segmented.tif')) ;
            try
                temp=imread(full_filename ,1);
                matrix_out=flipdim(temp,1);
            end
        case 4
            full_filename = char(strcat(pathname(track_what,2),filename,'_ch0',num2str(track_what-1),'_Filtered.tif')) ;
            try
                temp_Filtered=imread(full_filename ,1);
                temp_Filtered=double(temp_Filtered);
            end
            full_filename = char(strcat(pathname(track_what,3),filename,'_ch0',num2str(track_what-1),'_Segmented.tif')) ;
            try
                temp_Segmention=imread(full_filename ,1);
                temp_Segmention=flipdim(temp_Segmention,1);
                temp_Segmention=double(temp_Segmention);
                matrix_out=temp_Filtered.* temp_Segmention;
            end
        case 5
            full_filename = char(strcat(pathname(track_what,1),filename,'_ch0',num2str(track_what-1),'.tif')) ;
            try
                temp_Raw=imread(full_filename ,1);
                temp_Raw=double(temp_Raw);
            end
            full_filename = char(strcat(pathname(track_what,3),filename,'_ch0',num2str(track_what-1),'_Segmented.tif'))  ;
            try
                temp_Segmention=imread(full_filename ,1);
                temp_Segmention=flipdim(temp_Segmention,1);
                temp_Segmention=double(temp_Segmention);
                matrix_out=temp_Raw.* temp_Segmention;
            end
    end
    full_filename = char(strcat(pathname(track_what,3),filename,'_ch0',num2str(track_what-1),'_Segmented.tif'));
    try
        temp=imread(full_filename ,1);
        Segmention_out=flipdim(temp,1);
    end
end