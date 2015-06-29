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
function[matrix1,matrix2,matrix11,matrix22]=Rotate_by_Tubulin(matrix1,matrix2,matrix11,matrix22)

%function to align a cell by using the MTOC as was published by our lab
if size(matrix1,1)>2 && size(matrix1,2)>2
    SE = strel('square',5) ;
    matrix3  = imsubtract(imadd(matrix1,imtophat(matrix1,SE)), imbothat(matrix1,SE));
    temp_matrix2=imfill(matrix2,'holes') ;
    matrix3 = wiener2(matrix3,5) ;
    f = @(x) max(x(:));
    matrix3  = nlfilter( matrix3,[2 2],f);
    matrix4=double(matrix3).*double(matrix2);
    matrix4=ismember(matrix4,max(max(matrix4)));
    L = logical(matrix4);
    stats1 = regionprops(L,'Area','Centroid')  ;
    for iii=1:size(stats1,1)
        idx(iii) =   stats1(iii).Area ;   %#ok<*AGROW>
    end
    [idx,order]=sort(idx,'descend');
    temp_Centroid_spot=round(stats1(order(1)).Centroid);
    L = logical( temp_matrix2);
    stats1 = regionprops(L,'Area','Centroid')  ;
    for iii=1:size(stats1,1)
        idx(iii) =   stats1(iii).Area ;
    end
    [~,order]=sort(idx,'descend');
    
    temp_Centroid=round(stats1(order(1)).Centroid);
    x=temp_Centroid(1)- temp_Centroid_spot(1);
    y=temp_Centroid(2)- temp_Centroid_spot(2);
    teta=asind(y/sqrt(x^2+y^2));
    
    %          figure(3)
    %                  imagesc(matrix1)
    if isnan(teta)~=1
        if x<0
            if teta>=0 && teta<=90
                matrix1=     flipdim( imrotate( matrix1,-teta +90   ),1);
                matrix2=     flipdim( imrotate( matrix2,-teta +90   ),1);
            elseif teta<0 && teta>=-90
                
                
                matrix1=     flipdim( imrotate( matrix1,-teta +90   ),1);
                matrix2=     flipdim( imrotate( matrix2,-teta +90   ),1);
            end
            
        else
            if teta>=0 && teta<=90
                matrix1=     flipdim( imrotate( matrix1,teta -90   ),1);
                matrix2=     flipdim( imrotate( matrix2,teta -90   ),1);
            elseif teta<0 && teta>=-90
                matrix1=     flipdim( imrotate( matrix1,teta -90   ),1);
                matrix2=     flipdim( imrotate( matrix2,teta -90   ),1);
            end
            
        end
    end
else
    disp('matrix is too small to rotate!');
end


matrix1=rot90(matrix1);
matrix2=rot90(matrix2);