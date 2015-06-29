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
function [P1,P2]=add_polarization_vector(handles,POI,Control,Control_segmented,val)
%  Currently this is the setup, but it can be easiily edited
% ----------------------------------------------
% handles.23  angle between x axis and C(t+1)
% handles.24  angle between x axis and C(t-1)
% handles.25 angle between x axis and  brightest pixels in POI
% handles.26  angle between x axis and  brightest pixels in control

% 1. Uropodic log2(U/L)
% 2. Uropodic (U-L)/(U+L)
% 3. Uropoid (Ui^2-Li^2)/(Ui^2+Li)^2
% 4. Uropodic log2(Ui/Li)
% 5. Rand log2(U/L)
% 6. Rand (U-L)/(U+L)
% 7. Rand (Ui^2-Li^2)/(Ui^2+Li)^2
% 8. Rand log2(Ui/Li)
% 9. Y by elongation log2(U/L)
% 10. Y by elongation (U-L)/(U+L)
% 11. Y by elongation (Ui^2-Li^2)/(Ui^2+Li)^2
% 12. Y by elongation log2(Ui/Li)
% 13. X by elongation log2(U/L)
% 14. X by elongation (U-L)/(U+L)
% 15. X by elongation (Ui^2-Li^2)/(Ui^2+Li)^2
% 16. X by elongation log2(Ui/Li)
% 17. Y angle between x axis and C(t+1) log2(U/L)
% 18. Y angle between x axis and C(t+1) (U-L)/(U+L)
% 19. Y angle between x axis and C(t+1) (Ui^2-Li^2)/(Ui^2+Li)^2
% 20. Y angle between x axis and C(t+1) log2(Ui/Li)
% 21. X angle between x axis and C(t+1) log2(U/L)
% 22. X angle between x axis and C(t+1) (U-L)/(U+L)
% 23. X angle between x axis and C(t+1) (Ui^2-Li^2)/(Ui^2+Li)^2
% 24. X angle between x axis and C(t+1) log2(Ui/Li)
% 25. Y angle between x axis and C(t-1)  log2(U/L)
% 26. Y angle between x axis and C(t-1) (U-L)/(U+L)
% 27. Y angle between x axis and C(t-1) (Ui^2-Li^2)/(Ui^2+Li)^2
% 28. Y angle between x axis and C(t-1) log2(Ui/Li)
% 29. Y angle between x axis and C(t-1)  log2(U/L)
% 30. Y angle between x axis and C(t-1) (U-L)/(U+L)
% 31. Y angle between x axis and C(t-1) (Ui^2-Li^2)/(Ui^2+Li)^2
% 32. Y angle between x axis and C(t-1) log2(Ui/Li)
% 33. Y angle between x axis and brightest pixels in POI log2(U/L)
% 34. Y angle between x axis and brightest pixels in POI (U-L)/(U+L)
% 35. Y angle between x axis and brightest pixels in POI (Ui^2-Li^2)/(Ui^2+Li)^2
% 36. Y angle between x axis and brightest pixels in POI log2(Ui/Li)
% 37. X angle between x axis and brightest pixels in POI log2(U/L)
% 38. X angle between x axis and brightest pixels in POI (U-L)/(U+L)
% 39. X angle between x axis and brightest pixels in POI (Ui^2-Li^2)/(Ui^2+Li)^2
% 40. X angle between x axis and brightest pixels in POI log2(Ui/Li)
% 41. Y angle between x axis and brightest pixels in control  log2(U/L)
% 42. Y angle between x axis and brightest pixels in control (U-L)/(U+L)
% 43. Y angle between x axis and brightest pixels in control (Ui^2-Li^2)/(Ui^2+Li)^2
% 44. Y angle between x axis and brightest pixels in control log2(Ui/Li)
% 45. Y angle between x axis and brightest pixels in control  log2(U/L)
% 46. Y angle between x axis and brightest pixels in control (U-L)/(U+L)
% 47. Y angle between x axis and brightest pixels in control (Ui^2-Li^2)/(Ui^2+Li)^2
% 48. Y angle between x axis and brightest pixels in control log2(Ui/Li)
if val<5 % 1. Uropodic
    P1  =   ratio_manual_stack(POI,Control_segmented,val);
    P2 =   ratio_manual_stack(Control,Control_segmented,val);
    %
elseif (val>4 && val<9)%  5. Rand
    Rand_vec=rand(1,length(handles.p1),'double')*360;
    P1  =   ratio_rand_stack(POI,Control_segmented,Rand_vec ,val-4);
    P2 =   ratio_rand_stack(Control,Control_segmented,Rand_vec ,val-4);
    
    
elseif (val>8 && val<13)% 9. Y by elongation
    P1  =   ratio_X_longaxis_stack(POI,Control_segmented,val-8);
    P2 =   ratio_X_longaxis_stack(Control,Control_segmented,val-8);
    
elseif (val>12 && val<17)% 13. X by elongation
    P1  =   ratio_Y_longaxis_stack(POI,Control_segmented,val-12);
    P2 =   ratio_Y_longaxis_stack(Control,Control_segmented,val-12);
    
    %
elseif (val>16 && val<21)%  17 Y MIGRATION
    P1  =  ratio_Y_stack(POI,Control_segmented,handles.p23,val-16);
    P2 =   ratio_Y_stack(Control,Control_segmented,handles.p23,val-16);
    
elseif (val>20 && val<25)% 21 X MIGRATION
    P1  =  ratio_X_stack(POI,Control_segmented,handles.p23,val-20);
    P2 =   ratio_X_stack(Control,Control_segmented,handles.p23,val-20);
    
elseif (val>24 && val<29)%25 Y BP
    P1  =  ratio_Y_stack(POI,Control_segmented,handles.p24,val-24);
    P2 =   ratio_Y_stack(Control,Control_segmented,handles.p24,val-24);
    
elseif (val>28 && val<33)% 29 X BP
    P1  =  ratio_X_stack(POI,Control_segmented,handles.p24,val-28);
    P2 =   ratio_X_stack(Control,Control_segmented,handles.p24,val-28);
elseif (val>32 && val<37)%  17 Y MIGRATION
    P1  =  ratio_Y_stack(POI,Control_segmented,handles.p25,val-32);
    P2 =   ratio_Y_stack(Control,Control_segmented,handles.p25,val-32);
    
elseif (val>36 && val<41)% 21 X MIGRATION
    P1  =  ratio_X_stack(POI,Control_segmented,handles.p25,val-36);
    P2 =   ratio_X_stack(Control,Control_segmented,handles.p25,val-36);
    
elseif (val>40 && val<45)%25 Y BP
    P1  =  ratio_Y_stack(POI,Control_segmented,handles.p26,val-40);
    P2 =   ratio_Y_stack(Control,Control_segmented,handles.p26,val-40);
    
elseif (val>44 && val<49)% 29 X BP
    P1  =  ratio_X_stack(POI,Control_segmented,handles.p26,val-44);
    P2 =   ratio_X_stack(Control,Control_segmented,handles.p26,val-44);
    
end

