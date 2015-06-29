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
function [all_cells,parental_cells]=TRYME(div_cells,MATRIX)
all_cells=cell(size(MATRIX,2)/2,1);
for ii=1:size(MATRIX,2)/2
    all_cells(ii) =cellstr(num2str(ii));
end
try
    if isempty(div_cells)~=1
        for zzz=1:length(div_cells)
            cell_index=div_cells(zzz);
            PD1D2_matrix(zzz,1)=cell_index;
            trackdivnum=cell_index;
            V=MATRIX(:,cell_index*2-1);
            V=V(find(V, 1 ):find(V, 1, 'last' ));
            for start_XY=1:size(MATRIX,1)
                if MATRIX(start_XY,cell_index*2-1)>0
                    break
                end
            end
            end_XY=length(V)+start_XY;
            %         start_XY and  end_XY are frames when the parental cell start and
            %         daughter start. To eliminate all cells that start in frame
            %         diffrent than end_XY:
            
            vv=[]
            vv(:,1)=MATRIX(end_XY-1,:);
            vv(:,2)=MATRIX(end_XY,:);
            vv=vv./vv;
            vv(vv(:,1)==1)=-1;
            vv=nansum(vv');
            vv(vv~=1)=nan;
            vvv=find(ismember(vv,1));
            vvvv=(vvv(2:2:end))/2;
            
            
            x=MATRIX(end_XY-1,cell_index*2-1);
            y=MATRIX(end_XY-1,cell_index*2);
            %         x and y are coordinates f the parental cell just before the division
            sizee=size(MATRIX,2)/2;
            matrix=repmat([1 NaN;NaN 1],1,sizee );
            X=matrix(1,:).*MATRIX(end_XY,:);
            Y=matrix(2,:).*MATRIX(end_XY,:);
            
            %
            X(isnan(X))=[]; %take off all nans from X vector
            Y(isnan(Y))=[]; %take off all nans from X vector
            
            
            X(X==0)=NaN;
            Y(Y==0)=NaN;
            
            
            
            XY= (X-x).^2+ (Y-y).^2;%PITAGORAS
            
            XY2=nan(size(XY))
            for kk=1:length(vvvv)
                XY2(vvvv(kk))=1;
            end
            XY=XY.*  XY2;
            [~,XY_sort]=sort(XY);
            
            PD1D2_matrix(zzz,2)=XY_sort(1);
            PD1D2_matrix(zzz,3)=XY_sort(2);
        end
        
        
        %     PD1D2_matrix is the matrix of all (and only) diving cells i.e:
        
        % P   D1  D2
        % -----------
        % 1   2    3
        % 2   4    5
        % 3   6    7
        
        
        for zzz=1:size(PD1D2_matrix,1)
            if  isempty(find(ismember(PD1D2_matrix(:,2:3),PD1D2_matrix(zzz,1)), 1))==1
                all_cells(PD1D2_matrix(zzz,1)) =cellstr(num2str(PD1D2_matrix(zzz,1)));
            end
            all_cells(PD1D2_matrix(zzz,2)) =cellstr(strcat(all_cells(PD1D2_matrix(zzz,1)) ,'.1'));
            all_cells(PD1D2_matrix(zzz,3)) =cellstr(strcat(all_cells(PD1D2_matrix(zzz,1)) ,'.2'));
        end
    end
    parental_cells=cell(size(div_cells,2),1);
    for ii=1:size(div_cells,2)
        parental_cells(ii)=all_cells(div_cells(ii));
    end
catch
    parental_cells= all_cells  ;
end