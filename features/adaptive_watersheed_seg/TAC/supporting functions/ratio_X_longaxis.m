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
function [Ratio]=ratio_X_longaxis(Data_in,Data_in_control,Type )

try
    matrix_temp =  Data_in_control ;
    matrix =zeros(size(matrix_temp,1)+4,size(matrix_temp,2)+4);
    matrix (2:end-3,2:end-3)=matrix_temp;
    
    temp_Threshold2=matrix./matrix;
    temp_Threshold2=im2bw(temp_Threshold2);
    temp_Threshold2=imfill(temp_Threshold2,'holes');
    temp_Threshold3=bwlabel_max(temp_Threshold2,4);
    data= regionprops(temp_Threshold3,'Centroid',  'Orientation','Majoraxislength','Minoraxislength');
    D = bwdist(~temp_Threshold3);
    XY=find(ismember(D,1)) ;
    [Y,X] = ind2sub(size(temp_Threshold3),XY);
    
    MaxlineLength = data.MajorAxisLength;
    % teta =  rand(1)*360;
    teta=data.Orientation ;
    x(2)  =      data.Centroid(1);
    y(2)  =      data.Centroid(2) ;
    
    if teta>=0 && teta<=90
        angle2=     -teta    ;
    elseif teta<0 && teta>=-90
        angle2=     -teta    ;
    end
    
    %   angle2=     -teta ;
    angle3=    angle2-180;
    
    
    r=round(1:data.MajorAxisLength+1);
    
    xx1 = x(2) + r * cosd(angle2);
    yy1 = y(2) + r * sind(angle2);
    xx3 = x(2) + r * cosd(angle3);
    yy3 = y(2) + r * sind(angle3);
    
    a1=zeros(1,length(r)); a3=a1;
    for ii=1:length(r)
        [a1(ii),JJ1(ii)]=  min((X-xx1(ii)).^2+ (Y-yy1(ii)).^2)  ;
        [a3(ii),JJ3(ii)]=  min((X-xx3(ii)).^2+ (Y-yy3(ii)).^2)   ;
    end
    
    [ EMPTY,lineLength1 ]=  min(a1);
    [ EMPTY,lineLength3 ]=  min(a3);
    
    
    %      ---------------
    x(1) = x(2) + lineLength1 * cosd(angle2);
    y(1) = y(2) + lineLength1 * sind(angle2);
    x(3) = x(2) + lineLength3 * cosd(angle3);
    y(3) = y(2) + lineLength3 * sind(angle3);
    
    [temp_Threshold3]=cutter_function2(temp_Threshold3,x,y,X,Y )  ;
    
    U=zeros(size(temp_Threshold3));   L=U;
    U(temp_Threshold3==1)= 1;
    L(temp_Threshold3==2)= 1;
    
    
    matrix_in_temp=Data_in ;
    matrix_in =zeros(size(matrix_in_temp,1)+4,size(matrix_in_temp,2)+4);
    matrix_in(2:end-3,2:end-3)=matrix_in_temp;
    
    U=U.* matrix_in;
    L=L.* matrix_in;
    
    
    temp_aa=U(:) ;
    temp_bb=L(:) ;
    
    temp_aa(isnan(temp_aa))=[];
    temp_bb(isnan(temp_bb))=[];
    
    
    while length(temp_aa)>length(temp_bb)
        Ran_val=ceil(rand(1,1)*length(temp_aa));
        if  Ran_val>length(temp_aa)
            Ran_val=length(temp_aa);
        end
        
        temp_aa(Ran_val)=[];
    end
    
    
    while length(temp_bb)>length(temp_aa)
        Ran_val=ceil(rand(1,1)*length(temp_bb));
        if  Ran_val>length(temp_bb)
            Ran_val=length(temp_bb);
        end
        
        temp_bb(Ran_val)=[];
    end
    
    %%%%%%%%%%%%%%%
    
    
    
    
    sort_vec=rand(size(temp_aa));
    [a,Rand_order]=sort( sort_vec);
    
    U=temp_aa(Rand_order);
    
    sort_vec=rand(size(temp_bb));
    [a,Rand_order]=sort( sort_vec);
    
    L=temp_bb(Rand_order);
    
    
    U=U';
    L=L';
    
    
    
    
    U(U==0)=[];
    L(L==0)=[];
    
    
    
    %    two sides need to be at the same size, otherwise randomaly eliminate pixels
    %%%%%%%%%%
    while length(U)>length(L)
        Ran_val=ceil(rand(1,1)*length(U));
        if  Ran_val>length(U)
            Ran_val=length(U);
        end
        
        U(Ran_val)=[];
    end
    
    
    while length(L)>length(U)
        Ran_val=ceil(rand(1,1)*length(L));
        if  Ran_val>length(L)
            Ran_val=length(L);
        end
        
        L(Ran_val)=[];
    end
    
    switch Type
        case 1
            Ratio= log2(sum(U)/sum(L));
        case 2
            Ratio=  (sum(U)-sum(L))/(sum(U)+sum(L));
        case 3
            Ratio=  sum((U.^2-L.^2)) /sum((U.^2+L.^2)) ;
        case 4
            Ratio= sum(log2(U./L))/length(L) ;
    end
catch
    Ratio= nan;
end


