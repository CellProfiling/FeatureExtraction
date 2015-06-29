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
function [Ratio]=ratio_manual_stack(Data_in,Data_in_control,Type )

%
h2=timebar_TACWrapper('ratio_manual_stack in process. Please wait....');
set(h2,'color','w');
for ii=1:size(Data_in,2)
    timebar_TACWrapper(h2,ii/size(Data_in,2))
    try
        temp_matrix_cotrol=rot90(Data_in_control(ii).cdata./Data_in_control(ii).cdata) ;% nan for non values, 1 for segmentation
        
        temp_matrix_cotrol = double(bwlabel_max(temp_matrix_cotrol,1,4));
        
        
        if  nanmean(nanmean(temp_matrix_cotrol))==1
            
            temp_matrix_cotrol=rot90(Data_in_control(ii).cdata./Data_in_control(ii).cdata) ;% nan for non values, 1 for segmentation
            temp_matrix_cotrol((isnan(temp_matrix_cotrol)))=0;
            temp_matrix_cotrol = double(bwlabel_max(temp_matrix_cotrol,1,4));
        end
        
        
        
        
        
        
        
        N= temp_matrix_cotrol;      S=temp_matrix_cotrol;
        NN= rot90(Data_in(ii).cdata);  SS= rot90(Data_in(ii).cdata);
        
        temp_matrix_cotrol(isnan(temp_matrix_cotrol))= 0;
        
        
        Cumsum=cumsum(temp_matrix_cotrol(:));
        Half_Cumsum=round(max(Cumsum)/2);
        Index=find(ismember(Cumsum,Half_Cumsum));
        Index=Index(1);
        
        S(1:Index)=nan;
        N(Index:end)=nan;
        
        
        
        
        
        SS(1:Index)=0;
        NN(Index:end)=0;
        
        
        
        
        
        
        
        
        
        temp_aa=SS(:) ;
        temp_bb=NN(:) ;
        
        
        
        
        %    two sides need to be at the same size, otherwise randomaly eliminate pixels
        %%%%%%%%%%
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
        %%%%%%%%%%%%%%%
        
        
        
        
        %%%%%%%%%%%%%%%
        switch Type
            case 1
                Ratio(ii)= log2(sum(U)/sum(L));
            case 2
                Ratio(ii)=  (sum(U)-sum(L))/(sum(U)+sum(L));
            case 3
                Ratio(ii)=  sum((U.^2-L.^2)) /sum((U.^2+L.^2)) ;
            case 4
                Ratio(ii)= sum(log2(U./L))/length(L) ;
        end
        
    catch
        Ratio(ii)=nan;
        
    end
end

close(h2)









