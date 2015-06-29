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
function save_segmentaion_setup(data_file,EXP_filename,track_what,SET_filename)


box_Raw=data_file(1).cdata(:,1);
end_filter_at=  size(box_Raw,1)  ;
imfo= data_file(9).cdata;
DATA=importdata(SET_filename)  ;

for ii=1:end_filter_at
    data_file(8).cdata(track_what).Frame(ii).DATA=  DATA   ;
end
%
%
%
pause(3)
%IF SAUTOMATED THRESHOLD IS ON:
for ii=1:end_filter_at
    filename=  char(box_Raw(ii));
    full_filename = char(strcat( data_file(2).cdata(track_what,2),filename,'_ch0',num2str(track_what-1),'_Filtered.tif')) ;
    matrix_out=imread(full_filename ,1) ;
    
    if  data_file(9).cdata==8
        matrix_outd(1)=255 ;
        matrix_outd=uint8(matrix_out);
    elseif  data_file(9).cdata==16
        if max(max(matrix_out))<256
            matrix_out(1)=  255;
            matrix_out=uint8(matrix_out);
        end
    elseif  data_file(9).cdata==32
        'think about a new solution here!!!!'
        matrix_out=uint32(matrix_out);
        return
    end
    thresh_level = graythresh(matrix_out);
    thresh_level =thresh_level * 0.5 ;  %
    
    
    data_file(8).cdata(track_what).Frame(ii).DATA(1).vector(16)=thresh_level  ;
    data_file(8).cdata(track_what).Frame(ii).DATA(2).vector(6)=thresh_level   ;
    
    ii
    
end


save(char(EXP_filename) ,  'data_file')
clc