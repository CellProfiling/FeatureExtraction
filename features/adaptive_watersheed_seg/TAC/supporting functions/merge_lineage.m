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
function data=merge_lineage(data1,data2,start1,start2)
Lineage_data1 =data1.Data(1).cdata.Lineage_data;
Lineage_data2=data2.Data(1).cdata.Lineage_data;


for ii=1:size(Lineage_data1 ,1)
    Lineage_data(ii,1)={char(strcat('1.',Lineage_data1(ii,1)))} ;
    Lineage_data(ii,2)=  { num2str(start1+str2num(char(Lineage_data1(ii,2))))};
    Lineage_data(ii,3)=  { num2str(start1+str2num(char(Lineage_data1(ii,3))))};
    Lineage_data(ii,4)=   Lineage_data1(ii,4);
    
end
for jj=1:size(Lineage_data2 ,1)
    str=char(Lineage_data2(jj,1));
    str(1)='2';
    Lineage_data(ii+jj,1)={char((strcat('1.',str)))} ;
    Lineage_data(ii+jj,2)=  { num2str(start2+str2num(char(Lineage_data2(jj,2))))};
    Lineage_data(ii+jj,3)= { num2str(start2+str2num(char(Lineage_data2(jj,3))))};
    Lineage_data(ii+jj,4)=   Lineage_data2(jj,4);
    
end

Lineage_data(1,2)={'1'} ;
Lineage_data(size(Lineage_data1 ,1)+1,2)={'1'}  ;
Lineage_data(end+1,1)={'1'} ;
Lineage_data(end,2)={'1'}  ;
Lineage_data(end,3)={'1'};
Lineage_data(end,4)={'0'};
Length=str2num(char(Lineage_data(1,3)));

for ii=1:size(data1.Cell,2)
    data.Cell(ii).cdata=   {char(strcat('1.',data1.Cell(ii).cdata))};
end
for jj=1:size(data2.Cell,2)
    str=char(data2.Cell(jj).cdata);
    str(1)='2';
    data.Cell(jj+ii).cdata=  {char((strcat('1.',str)))} ;
    
end

data.Cell(jj+ii+1).cdata={'1'} ;



%   %%%%%%%%
for ii=1:size(data1.Cell,2)
    if ii==1
        data.Data(ii).cdata.X_data=  1:Length;
        %        temp=nan(1,Length);
        temp=zeros(1,Length);
        temp(start1+1:end)= data1.Data(ii).cdata.Y_data;
        data.Data(ii).cdata.Y_data=  temp;
        data.Data(ii).cdata.Lineage_data=Lineage_data;
    else
        data.Data(ii).cdata.X_data=  data1.Data(ii).cdata.X_data;
        data.Data(ii).cdata.Y_data=  data1.Data(ii).cdata.Y_data;
        data.Data(ii).cdata.Lineage_data=Lineage_data;
    end
end
for jj=1:size(data2.Cell,2)
    if jj==1
        data.Data(jj+ii).cdata.X_data=  1:Length;
        %        temp=nan(1,Length);
        temp=zeros(1,Length);
        temp(start2+1:end)= data2.Data(jj).cdata.Y_data;
        data.Data(jj+ii).cdata.Y_data=  temp;
        data.Data(jj+ii).cdata.Lineage_data=Lineage_data;
        
    else
        data.Data(jj+ii).cdata.X_data=  data2.Data(jj).cdata.X_data;
        data.Data(jj+ii).cdata.Y_data=  data2.Data(jj).cdata.Y_data;
        data.Data(jj+ii).cdata.Lineage_data=Lineage_data;
    end
end


data.Data(jj+ii+1).cdata.X_data=  1;
data.Data(jj+ii+1).cdata.Y_data=  nan;
data.Data(jj+ii+1).cdata.Lineage_data=Lineage_data;
