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
function[temp_Threshold]=cutter_function2(temp_Threshold2,x,y,X,Y)

% function to split one 2-D object into two halves with the same area by a defined axis (so called
% "axis of polarity").
% If the objects cannot be splittled evenly (i.e. uneven number of pixels),
% some pixels are randomly eliminated to achieve that criteria.



temp_Threshold=[];
for ii=1:200
    for jj=1:200
        Try=[ii jj]   ;
        ONE=1; TWO=2; %#ok<*NASGU>
        try
            [temp_Threshold,ONE,TWO]=cutter_function(temp_Threshold2,x,y,X,Y,Try  )  ;
            if abs(ONE-TWO)<10 &&  max(max(temp_Threshold))>1 &&  ONE+TWO>sum(sum(temp_Threshold2))*0.8
                return;
            end
        end
        
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[L,ONE,TWO]=cutter_function(LL,x,y,X,Y,TRY )

[~,JJ]=  sort((X-x(1)).^2+ (Y-y(1)).^2) ;
x(1)=X(JJ(TRY(1)));  y(1)=Y(JJ(TRY(1)));  %$$
[~,JJ]=  sort((X-x(3)).^2+ (Y-y(3)).^2) ;
x(3)=X(JJ(TRY(2)));  y(3)=Y(JJ(TRY(2))); %$$

position_in=[x(1) y(1) ; x(3) y(3)] ;
[~,~,LL,X,Y] = bresenham_TACWrapper(LL, position_in ,0);
LL=bwlabel(LL,4);

%      figure
%      imagesc(LL)
%      pause
%
for ii=1:max(max(LL))
    Hist(ii)=length(find(ismember(LL,ii))); %#ok<*AGROW>
end

[~,b]=sort(Hist,'descend');


L=zeros(size(LL));


L(LL==b(1))=1;
L(LL==b(2))=2;
try
    if   b(3)~=0
        L(LL==b(3))=2;
    end
end
try
    if   b(4)~=0
        L(LL==b(4))=2;
    end
end

%     if  nargin==7
%      L(LL==b(3))=2;
%     end
%        if  nargin==8
%      L(LL==b(4))=2;
%     end


ONE=length((find(ismember(L,1))));
TWO=length((find(ismember(L,2))));

IND = sub2ind(size(L),X,Y);
try
    if ONE==TWO
        if length(X)==length(Y)
            IND(1)=[];
        end
        Len_IND=length(IND)/2;
        if  Len_IND -floor(Len_IND)==0.5
            Len_IND=Len_IND-0.5;
        end
        
        
        L(IND(1:Len_IND))=1;
        L(IND(Len_IND+1:end))=2;
    end
    
    
    if (ONE+TWO+length(IND))/2-round((ONE+TWO+length(IND))/2)~=0
        IND(1)=[];
    end
    
    if ONE>TWO
        addtoONE=(ONE-TWO)+(length(IND)-(ONE-TWO))/2 ;
        L(IND(1:addtoONE))=2;
        L(IND(addtoONE+1:end))=1;
    end
    
    if ONE<TWO
        addtoTWO=(TWO-ONE)+(length(IND)-(TWO-ONE))/2 ;
        L(IND(1:addtoTWO))=1;
        L(IND(addtoTWO+1:end))=2;
    end
end
ONE=length((find(ismember(L,1)))) ;
TWO=length((find(ismember(L,2)))) ;
% --------------
