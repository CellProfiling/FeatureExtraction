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
function plot_Cell_Lineage(n1,data)
% plot_Cell_Lineage(n1,data)

Cell2=char(data.Cell(n1).cdata);
Point=findstr(Cell2,'.') ;
if isempty(Point)~=1
    Cell=str2num(Cell2(1:Point-1));
else
    Cell=str2num(Cell2);
end

% So we are going to create lineage tree based on Cell
% Next, to create matrix of all relevant cells to the lineage and to count
% number of generations

Lineage_data= data.Data(n1).cdata.Lineage_data ;
max_Points=0;Lineage_vector=[]
for ii=1: size(Lineage_data,1)
    temp_Lineage=char(Lineage_data(ii,1)) ; % only the relevant cells
    Point=findstr(temp_Lineage,'.') ;
    if max_Points<length(Point)
        max_Points=length(Point);
    end
    for iii=1:size(data.Data,2);
        temp_data=data.Cell(iii).cdata  ;
        if  strcmp(temp_Lineage, temp_data)
            Lineage_vector(ii)=iii ;
            % vector of locations of relevant cells within data
            Lineage_relevant_data(ii).cdata.X_data=data.Data(iii).cdata.X_data;
            try
                Lineage_relevant_data(ii).cdata.Y1_data=data.Data(iii).cdata.Y1_data;
                Lineage_relevant_data(ii).cdata.Y2_data=data.Data(iii).cdata.Y2_data;
            catch
                Lineage_relevant_data(ii).cdata.Y1_data=data.Data(iii).cdata.Y_data;
            end
            break
        end
    end
end
%  Lineage(max_Points,Cell, Lineage_data,Lineage_relevant_data)
new_Div_Cells=Lineage_data ;
n=max_Points;
% Generations=generate_Generations
% %%%
% function generate_Generations
temp=1; vector1(1)=1
for ii=2:n
    temp=temp*2+1;
    vector1(ii)=temp;
end

temp=1; vector2(1)=1
for ii=1:n
    temp=temp*2+1;
    vector2(ii)=temp;
end

for ii=1:n
    seq=ones(vector1(ii),1);
    seq(end+1)=0;
    seq(end+1:end+length(seq))=seq*2;
    try
        matrix(:,ii)= repmat(seq,[ 0.5*(vector2(end)+1)/(vector1(ii)+1) 1]) ;
    catch
        matrix(:,ii)= repmat(seq',[ 0.5*(vector2(end)+1)/(vector1(ii)+1) 1]);
    end
end

if isempty( matrix)==1
    'not a lineage tree data'
    return
end

matrix=rot90(matrix)';
matrix2=ones(size(matrix,1) ,size(matrix,2)+1)*Cell;
matrix2(:,2:end)=matrix;
jjj=1;
for ii=1:size(matrix2,1)
    matrix2_temp=num2str(matrix2(ii,:)) ;
    matrix2_temp=regexprep(matrix2_temp, ' ', '') ;
    matrix2_temp=regexprep(matrix2_temp, '0', '') ;
    if   isempty(str2num(matrix2_temp))~=1
        Generations(jjj)=str2num(matrix2_temp)  ; jjj=jjj+1;
    end
end
Generations(end)=[];
%%%
% 2.a. create matrix of lineage
%
% a b c
% a is where is start
% b is where its end (add a square)
% c is the location by generation vector, c must be covered by generation

matrix=[];
for ii=1:size(new_Div_Cells,1)
    temp=char(new_Div_Cells(ii,1));
    temp(findstr(temp,'.'))=[];
    matrix(ii,3)=str2num(temp);
    matrix(ii,1)=str2num(char(new_Div_Cells(ii,2)));
    matrix(ii,2)=str2num(char(new_Div_Cells(ii,3)));
    matrix(ii,5)=str2num(char(new_Div_Cells(ii,4)));
end

% 2.b. sort the matrix of lineage according the order of generations
V=matrix(:,3);
for ii=1:length(V)
    Index(ii)=find(ismember(Generations,V(ii)));
end
matrix(:,4)=Index;
matrix=sortrows(matrix,4);


new_matrix=zeros(max(matrix(:,2))-min(matrix(:,1)),size(matrix,1));
[a,b]=sort(Index) ;
for ii=1:size(matrix,1)
    %   I= find(ismember(Index, matrix(ii,4))) ;
    vec=  Lineage_relevant_data(b(ii)).cdata.Y1_data  ;
    try
        new_matrix(matrix(ii,1):matrix(ii,2),ii)=vec'  ;
    end
    
    imagesc(new_matrix)
end
jet_b=jet;jet_b(1,:)=1;
colormap(gcf,jet_b)
%  figure


hold on
% 3.a. add the horizontal line of division
V=matrix(:,3);
for ii=1:length(V)
    a=num2str(V(ii));
    for jj=(ii+1):length(V)
        b=  num2str(V(jj));
        if strcmp(a(1:end-1),b(1:end-1))
            if matrix(ii,1)==matrix(jj,1)
                plot( ii:jj,ones(1,jj-ii+1)*matrix(ii,1),'linewidth',3,'color',[1 0 0])
            end
        end
    end
end
%  3.b. add text at the buttom
%            clear  new_V
for iii=1:length(V)
    temp_num=num2str(V(iii)) ;
    new_num=  temp_num(1) ;
    for kk=2:length(temp_num)
        new_num=strcat(new_num,'.',temp_num(kk));
    end
    new_V(iii)={new_num};
end

V_frames=min(matrix(:,1)):max(matrix(:,2));
set(gca, 'XTick', 0: size(new_V,2)) ; set(gca, 'YTick',1:length(V_frames)) ;
set(gca,'XTickLabel',{ ;'';char(new_V)  ;'';})  ; set(gca,'YTickLabel',{ ;'';V_frames  ;'';})  ;
str=char(strcat('Linage tree of cell-',num2str(Cell)));
xlabel(str); ylabel('Time points (points where cell a5pear)')
ylim([1 max(matrix(:,2))+20])
xlim([0 length(V)+1])
set(gca,'Ydir','reverse' )
% new_matrix=zeros(max(matrix(:,2))-min(matrix(:,1)),size(matrix,1));
[a,b]=sort(Index);
max_vec=0;
for ii=1:size(matrix,1)
    try
        try
            vec=  Lineage_relevant_data(b(ii)).cdata.Y2_data ;
        catch
            vec=  Lineage_relevant_data(b(ii)).cdata.Y1_data ;
        end
    catch
        'error: Please check if all lineage parts are in data list!'
        cla
        return
    end
    if max(vec)>  max_vec
        max_vec=max(vec);
    end
end

for ii=1:size(matrix,1)
    try
        vec=  Lineage_relevant_data(b(ii)).cdata.Y2_data ;
    catch
        vec=  Lineage_relevant_data(b(ii)).cdata.Y1_data ;
    end
    
    vec_jet=vec./max_vec; vec_jet= round(vec_jet*64)+1;
    J=jet(64);
    for iii=1:matrix(ii,2)-matrix(ii,1)
        try
            vec_jet(iii)
            plot([1 1]*ii, matrix(ii,1)+iii-1:matrix(ii,1)+iii,'linewidth',10,'color',J(vec_jet(iii),:))
        end
    end
end
for ii=1:size(matrix,1)
    if matrix(ii,5)==0
        plot( ii,  matrix(ii,2)+0.5,'bv',     'MarkerSize',10 ,'Marker','square','LineStyle','none', 'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[1 0 1])
    else
        plot( ii,  matrix(ii,2)+0.5,'bv',     'MarkerSize',12,'Marker','+','LineStyle','none','LineWidth',3, 'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[1 0 1])
    end
end
