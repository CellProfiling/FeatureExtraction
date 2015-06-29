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
function popup3_str=set_popup3_str(popup2_str)
if isempty(findstr('Movie',popup2_str))~=1 || isempty(findstr('Montage',popup2_str))~=1 ||   isempty(findstr('SEQtage',popup2_str))~=1 || ...
        isempty(findstr('Projection',popup2_str))~=1  || isempty(findstr('Edge',popup2_str))~=1 || isempty(findstr('type_1',popup2_str))~=1
    popup3_str=cell(5,1);
    popup3_str(1)= cellstr('Select:' );
    popup3_str(2)=cellstr( 'Vs. Normal' );
    popup3_str(3)=cellstr( 'Vs. X_Rotation (X is long axis)' );
    popup3_str(4)=cellstr( 'Vs. Y_Rotation (Y is long axis)' );
    popup3_str(5)=cellstr( 'Vs. Rotate_by_maximum_pixel' );
end


% GROUP 2: parameter vs parameter

if isempty(findstr('Intensity',popup2_str))~=1 || isempty(findstr('Area',popup2_str))~=1 || isempty(findstr('type_2',popup2_str))~=1 || ...
        isempty(findstr('Eccentricity',popup2_str))~=1 || isempty(findstr('Orientation',popup2_str))~=1 || isempty(findstr('Velocity',popup2_str))~=1
    
    popup3_str=cell(23,1);
    popup3_str(1)= cellstr('Select:' );
    popup3_str(2)= cellstr('Vs. Time' );
    popup3_str(3)= cellstr('Vs. Intensity' );
    popup3_str(4)=cellstr( 'Vs. Area' );
    popup3_str(5)=cellstr( 'Vs. I_per_A' );
    popup3_str(6)=cellstr( 'Vs. Eccentricity' );
    popup3_str(7)=cellstr( 'Vs. Orientation' );
    popup3_str(8)=cellstr( 'Vs. Velocity' );
    popup3_str(9)=cellstr( 'Vs. EquivDiameter' );
    popup3_str(10)=cellstr( 'Vs. Circularity' );
    popup3_str(11)=cellstr( 'Vs. Ellipticity' );
    popup3_str(12)=cellstr( 'Vs. Polarisation' );
    popup3_str(13)= cellstr('Vs. Extent' );
    popup3_str(14)=cellstr( 'Vs. Perimeter' );
    popup3_str(15)=cellstr( 'Vs. Solidity' );
    popup3_str(16)=cellstr( 'Vs. graycoprops_Contrast' );
    popup3_str(17)=cellstr( 'Vs. graycoprops_Correlation' );
    popup3_str(18)=cellstr( 'Vs. graycoprops_Energy' );
    popup3_str(19)=cellstr( 'Vs. graycoprops_Homogeneity' );
    popup3_str(20)=cellstr( 'Vs. std2' );
    popup3_str(21)=cellstr( 'Vs. number_of_peaks_X' );
    popup3_str(22)=cellstr( 'Vs. number_of_peaks_Y' );
    popup3_str(23)=cellstr( 'Vs. number_of_disks' );
end


%  I splitted the list because of memory issues!
if isempty(findstr('I_per_A',popup2_str))~=1 ||  isempty(findstr('EquivDiameter',popup2_str))~=1  || isempty(findstr('Circularity',popup2_str))~=1 ||...
        isempty(findstr('Ellipticity',popup2_str))~=1 || isempty(findstr('Polarisation',popup2_str))~=1
    popup3_str=cell(23,1);
    popup3_str(1)= cellstr('Select:' );
    popup3_str(2)= cellstr('Vs. Time' );
    popup3_str(3)= cellstr('Vs. Intensity' );
    popup3_str(4)=cellstr( 'Vs. Area' );
    popup3_str(5)=cellstr( 'Vs. I_per_A' );
    popup3_str(6)=cellstr( 'Vs. Eccentricity' );
    popup3_str(7)=cellstr( 'Vs. Orientation' );
    popup3_str(8)=cellstr( 'Vs. Velocity' );
    popup3_str(9)=cellstr( 'Vs. EquivDiameter' );
    popup3_str(10)=cellstr( 'Vs. Circularity' );
    popup3_str(11)=cellstr( 'Vs. Ellipticity' );
    popup3_str(12)=cellstr( 'Vs. Polarisation' );
    popup3_str(13)= cellstr('Vs. Extent' );
    popup3_str(14)=cellstr( 'Vs. Perimeter' );
    popup3_str(15)=cellstr( 'Vs. Solidity' );
    popup3_str(16)=cellstr( 'Vs. graycoprops_Contrast' );
    popup3_str(17)=cellstr( 'Vs. graycoprops_Correlation' );
    popup3_str(18)=cellstr( 'Vs. graycoprops_Energy' );
    popup3_str(19)=cellstr( 'Vs. graycoprops_Homogeneity' );
    popup3_str(20)=cellstr( 'Vs. std2' );
    popup3_str(21)=cellstr( 'Vs. number_of_peaks_X' );
    popup3_str(22)=cellstr( 'Vs. number_of_peaks_Y' );
    popup3_str(23)=cellstr( 'Vs. number_of_disks' );
end
if isempty(findstr('Type2_',popup2_str))~=1
    popup3_str=cell(23,1);
    popup3_str(1)= cellstr('Select:' );
    popup3_str(2)= cellstr('Vs. Time' );
    popup3_str(3)= cellstr('Vs. Intensity' );
    popup3_str(4)=cellstr( 'Vs. Area' );
    popup3_str(5)=cellstr( 'Vs. I_per_A' );
    popup3_str(6)=cellstr( 'Vs. Eccentricity' );
    popup3_str(7)=cellstr( 'Vs. Orientation' );
    popup3_str(8)=cellstr( 'Vs. Velocity' );
    popup3_str(9)=cellstr( 'Vs. EquivDiameter' );
    popup3_str(10)=cellstr( 'Vs. Circularity' );
    popup3_str(11)=cellstr( 'Vs. Ellipticity' );
    popup3_str(12)=cellstr( 'Vs. Polarisation' );
    popup3_str(13)= cellstr('Vs. Extent' );
    popup3_str(14)=cellstr( 'Vs. Perimeter' );
    popup3_str(15)=cellstr( 'Vs. Solidity' );
    popup3_str(16)=cellstr( 'Vs. graycoprops_Contrast' );
    popup3_str(17)=cellstr( 'Vs. graycoprops_Correlation' );
    popup3_str(18)=cellstr( 'Vs. graycoprops_Energy' );
    popup3_str(19)=cellstr( 'Vs. graycoprops_Homogeneity' );
    popup3_str(20)=cellstr( 'Vs. std2' );
    popup3_str(21)=cellstr( 'Vs. number_of_peaks_X' );
    popup3_str(22)=cellstr( 'Vs. number_of_peaks_Y' );
    popup3_str(23)=cellstr( 'Vs. number_of_disks' );
end


%type 3: vs nothing...
if isempty(findstr('MSD',popup2_str))~=1 || isempty(findstr('Trajectories',popup2_str))~=1  ||...
        isempty(findstr('type_3',popup2_str))~=1   || isempty(findstr('Proximity_vector',popup2_str))~=1  ||  isempty(findstr('Maximum_pixel',popup2_str))~=1 ||...
        isempty(findstr('Angle between MaxP and proximity',popup2_str))~=1  ||  isempty(findstr('number of cells',popup2_str))~=1
    popup3_str=cell(1,1);
    popup3_str(1)= cellstr('Select:' );
end
% Add_functions_002-
% This is an option to add. For example- If projection is the chosen function- use:
% Normal, X_Rotation,Y_Rotation, and maximum pixel roation.

%group1: vs rotation aspect: