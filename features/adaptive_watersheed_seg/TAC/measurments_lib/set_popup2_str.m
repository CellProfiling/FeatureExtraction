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
function popup2_str=set_popup2_str(cell_index,tracksnum,popup1,parental_num,Daughter1,Daughter2)


switch popup1
    case 1 % selected cell
        popup2_str=cell(1,1);
        popup2_str(1)= cellstr('Select:' );
        % set(handles.Dividing_cells_panel,'Visible','off')
        % set(handles.text_Track,'Visible','off')
        % set(handles. edit_tracks_num,'Visible','off')
        % set(handles.text_Cell,'Visible','off')
        % set(handles. Div_Cells,'Visible','off')
        %
    case 2 % selected cell
        %  popup2_str=cell(13,1);
        popup2_str(1)= cellstr('Select:' );
        
        %Type 1:
        popup2_str(2)=cellstr(strcat('Cell- ',cell_index,'--',' Movie' ));
        popup2_str(3)=cellstr(strcat('Cell- ',cell_index,'--',' Montage' ));
        popup2_str(4)=cellstr(strcat('Cell- ',cell_index,'--',' Shell Projection' ));
        popup2_str(5)=cellstr(strcat('Cell- ',cell_index,'--',' 2D Projection' ));
        popup2_str(6)=cellstr(strcat('Cell- ',cell_index,'--',' 3D Projection' ));
        popup2_str(7)=cellstr(strcat('Cell- ',cell_index,'--',' Edge' ));
        popup2_str(8)=cellstr(strcat('Cell- ',cell_index,'--',' Montage_watershed' ));
        popup2_str(9)=cellstr(strcat('Cell- ',cell_index,'--',' Montage_distance_transform' ));
        popup2_str(10)=cellstr(strcat('Cell- ',cell_index,'--',' Projection_watershed' ));
        
        %Type 2:
        popup2_str(11)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Intensity' ));
        popup2_str(12)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Area' ));
        popup2_str(13)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_I_per_A' ));
        popup2_str(14)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Eccentricity' ));
        popup2_str(15)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Orientation' ));
        popup2_str(16)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_EquivDiameter' ));
        popup2_str(17)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Circularity' ));
        popup2_str(18)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Ellipticity' ));
        popup2_str(19)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Polarisation' ));
        popup2_str(20)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Extent' ));
        
        popup2_str(21)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Perimeter' ));
        popup2_str(22)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_Solidity' ));
        popup2_str(23)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_graycoprops_Contrast' ));
        popup2_str(24)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_graycoprops_Correlation' ));
        popup2_str(25)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_graycoprops_Energy' ));
        popup2_str(26)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_graycoprops_Homogeneity' ));
        popup2_str(27)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_std2' ));
        popup2_str(28)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_number_of_peaks_X' ));
        popup2_str(29)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_number_of_peaks_Y' ));
        popup2_str(30)=cellstr(strcat('Cell- ',cell_index,'--',' Type2_number_of_disks' ));
        
        %Type 3:
        popup2_str(31)=cellstr(strcat('Cell- ',cell_index,'--',' Velocity' ));
        popup2_str(32)=cellstr(strcat('Cell- ',cell_index,'--',' MSD' ));
        popup2_str(33)=cellstr(strcat('Cell- ',cell_index,'--',' Trajectories' ));
        popup2_str(34)=cellstr(strcat('Cell- ',cell_index,'--',' Proximity_vector' ));
        popup2_str(35)=cellstr(strcat('Cell- ',cell_index,'--',' Maximum_pixel' ));
        popup2_str(36)=cellstr(strcat('Cell- ',cell_index,'--',' Angle between MaxP and proximity' ));
        popup2_str(37)=cellstr(strcat('Cell- ',cell_index,'--',' distance_from_origion' ));
        popup2_str(38)=cellstr(strcat('Cell- ',cell_index,'--',' brightest_Pixel_X' ));
        popup2_str(39)=cellstr(strcat('Cell- ',cell_index,'--',' brightest_Pixel_Y' ));
        popup2_str(40)=cellstr(strcat('Cell- ',cell_index,'--',' turnng_angle' ));
        
        %1. Add_functions_001a
        % determine the type
        % add function: popup2_str(16)=cellstr(strcat('Cell- ',num2str(cellnum),'--','Add_function_001a' ));
        
        % i.e: I want to add maximum pixel vector ans Proximity_vector functions which are type 3
        % so, add to all popup2_str (search with ctr+f) the Proximity_vector and
        % Maximum_pixel (cell, population, dividing,etc)
        
        % set(handles.Dividing_cells_panel,'Visible','off')
        % set(handles.text_Cell,'Visible','on')
        % set(handles.text_Track,'Visible','off')
        % set(handles. Div_Cells,'Visible','on')
        % set(handles. edit_tracks_num,'Visible','off')
        
        
    case 3 % all Population
        %  popup2_str=cell(10,1);
        popup2_str(1)= cellstr('Select:' );
        
        %Type 1:
        popup2_str(2)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' 2D Projection' ));
        popup2_str(3)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_3' ));
        popup2_str(4)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_4' ));
        popup2_str(5)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_5' ));
        popup2_str(6)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_6' ));
        popup2_str(7)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_7' ));
        popup2_str(8)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_8' ));
        popup2_str(9)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_9' ));
        popup2_str(10)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_1_Option_10' ));
        
        %Type 2:
        popup2_str(11)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Intensity' ));
        popup2_str(12)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Area' ));
        popup2_str(13)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' I_per_A' ));
        popup2_str(14)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' EquivDiameter' ));
        popup2_str(15)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Circularity' ));
        popup2_str(16)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Ellipticity' ));
        popup2_str(17)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Polarisation' ));
        popup2_str(18)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Eccentricity' ));
        popup2_str(19)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Orientation' ));
        popup2_str(20)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Velocity' ));
        
        
        popup2_str(21)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_21' ));
        popup2_str(22)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_22' ));
        popup2_str(23)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_23' ));
        popup2_str(24)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_24' ));
        popup2_str(25)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_25' ));
        popup2_str(26)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_26' ));
        popup2_str(27)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_27' ));
        popup2_str(28)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_28' ));
        popup2_str(29)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_29' ));
        popup2_str(30)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' type_2_Option_30' ));
        
        
        %Type 3:
        popup2_str(31)=cellstr( 'Population- Trajectories' );
        popup2_str(32)=cellstr( 'Population- MSD' );
        popup2_str(33)=cellstr( 'Population-number of cells' );
        popup2_str(34)=cellstr( 'Proximity_vector' );
        popup2_str(35)=cellstr( 'Maximum_pixel' );
        popup2_str(36)=cellstr( 'Angle between MaxP and proximity' );
        popup2_str(37)=cellstr( 'type_3_Option_37' );
        popup2_str(38)=cellstr( 'type_3_Option_38' );
        popup2_str(39)=cellstr( 'type_3_Option_39' );
        popup2_str(40)=cellstr( 'type_3_Option_40' );
        %Add_functions_001b
        %  popup2_str(12)=cellstr(strcat('Population- ',num2str(tracksnum),'--',' Add_function_001b' ));
        
        % set(handles.Dividing_cells_panel,'Visible','off')
        % set(handles.text_Cell,'Visible','off')
        % set(handles.text_Track,'Visible','on')
        % set(handles. Div_Cells,'Visible','off')
        % set(handles. edit_tracks_num,'Visible','on')
        %
    case 4 % find all dividing cells:
        
        %   popup2_str=cell(10,1);
        popup2_str(1)= cellstr('Select:' );
        
        %Type 1:
        popup2_str(2)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Movie' ));
        popup2_str(3)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' 2D Projection' ));
        popup2_str(4)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' 3D Projection' ));
        popup2_str(5)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Edge' ));
        popup2_str(6)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Montage' ));
        popup2_str(7)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' SEQtage' ));
        popup2_str(8)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_1_Option_8' ));
        popup2_str(9)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_1_Option_9' ));
        popup2_str(10)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_1_Option_10' ));
        
        %Type 2:
        popup2_str(11)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Intensity' ));
        popup2_str(12)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Area' ));
        popup2_str(13)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' I_per_A' ));
        popup2_str(14)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Eccentricity' ));
        popup2_str(15)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Orientation' ));
        popup2_str(16)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' EquivDiameter' ));
        popup2_str(17)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Circularity' ));
        popup2_str(18)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Ellipticity' ));
        popup2_str(19)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Polarisation' ));
        popup2_str(20)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_20' ));
        
        
        popup2_str(21)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_21' ));
        popup2_str(22)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_22' ));
        popup2_str(23)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_23' ));
        popup2_str(24)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_24' ));
        popup2_str(25)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_25' ));
        popup2_str(26)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_26' ));
        popup2_str(27)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --', 'type_2_Option_27' ));
        popup2_str(28)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_28' ));
        popup2_str(29)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_29' ));
        popup2_str(30)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_2_Option_30' ));
        
        
        %Type 3:
        popup2_str(31)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Velocity' ));
        popup2_str(32)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Trajectories' ));
        popup2_str(33)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' MSD' ));
        popup2_str(34)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Proximity_vector' ));
        popup2_str(35)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Maximum_pixel' ));
        popup2_str(36)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Angle between MaxP and proximity' ));
        popup2_str(37)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_3_Option_37' ));
        popup2_str(38)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_3_Option_38' ));
        popup2_str(39)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_3_Option_39' ));
        popup2_str(40)=cellstr(strcat('Dividing- ',parental_num,' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' type_3_Option_40' ));
        %Add_functions_001c
        % popup2_str(15)=cellstr(strcat('Dividing- ',num2str(trackdivnum),' Daughters:',' * ',Daughter1,' ** ',Daughter2, ' --',' Add_functions_001c' ));
        
        
        % set(handles.Dividing_cells_panel,'Visible','on')
        % set(handles.text_Cell,'Visible','off')
        % set(handles.text_Track,'Visible','off')
        % set(handles. Div_Cells,'Visible','off')
        % set(handles. edit_tracks_num,'Visible','off')
end