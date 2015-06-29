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
function plot_lineage(handles,n,Cell,new_Div_Cells,Mode,View)


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
        matrix(:,ii)= repmat(seq',[ 0.5*(vector2(end)+1)/(vector1(ii)+1) 1]) ;
        
    end
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
matrix=[];
% matrix(:,3)=sort(Generations);
%
%
% for ii=1:size(matrix,1)
% matrix(ii,1)=(length(num2str((matrix(ii,3))))-1)*10+1;
% matrix(ii,2)=(length(num2str((matrix(ii,3)))))*10;
% end
%


for ii=1:size(new_Div_Cells,1)
    temp=char(new_Div_Cells(ii,1));
    temp(findstr(temp,'.'))=[];
    matrix(ii,3)=str2num(temp);
    matrix(ii,1)=str2num(char(new_Div_Cells(ii,2)));
    matrix(ii,2)=str2num(char(new_Div_Cells(ii,3)));
end
V=matrix(:,3);

for ii=1:length(V)
    Index(ii)=find(ismember(Generations,V(ii)));
end

matrix(:,4)=Index;
matrix=sortrows(matrix,4);
if Mode==1
    axes(handles.axes1)
    cla
    
else
    figure
end


set(gca,'XTickLabel',{''}) ;set(gca,'YTickLabel',{''}) ;
set(gca, 'XTick', zeros(1,0)) ; set(gca, 'YTick', zeros(1,0)) ;
hold on

if View==1
    
    V=matrix(:,3);
    for ii=1:length(V)
        a=num2str(V(ii));
        for jj=(ii+1):length(V)
            b=  num2str(V(jj));
            if strcmp(a(1:end-1),b(1:end-1))
                if matrix(ii,1)==matrix(jj,1)
                    plot( ii:jj,ones(1,jj-ii+1)*matrix(ii,1),'linewidth',3,'color',[1 0 0],'Hittest','Off');
                end
            end
        end
        
    end
    set(gca,'Ydir','reverse' )
    for ii=1:size(matrix,1)
        plot(ones(1,matrix(ii,2)-matrix(ii,1)+1)*ii, matrix(ii,1):matrix(ii,2),'linewidth',3,'color',[1 0 0],'Hittest','Off');
        plot( ii,  matrix(ii,2),'bv',     'MarkerSize',10,'Marker','square','LineStyle','none', 'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[1 0 1],'Hittest','Off');
    end
    
    ylim([1 max(matrix(:,2))+20])
    xlim([0 length(V)+1])
    
    %            clear  new_V
    for iii=1:length(V)
        temp_num=num2str(V(iii))
        new_num=  temp_num(1)
        for kk=2:length(temp_num)
            new_num=strcat(new_num,'.',temp_num(kk))
        end
        new_V(iii)={new_num}
    end
    
    
    V_frames=min(matrix(:,1)):max(matrix(:,2));
    
    set(gca, 'XTick', 0: size(new_V,2)) ; set(gca, 'YTick',1:length(V_frames)) ;
    set(gca,'XTickLabel',{ ;'';char(new_V)  ;'';})  ; set(gca,'YTickLabel',{ ;'';V_frames  ;'';})  ;
    str=char(strcat('Linage tree of cell-',num2str(Cell)));
    xlabel(str); ylabel('Time points (points where cell apear)')
    
    
elseif View==2
    V=matrix(:,3);
    for ii=1:length(V)
        a=num2str(V(ii));
        for jj=(ii+1):length(V)
            b=  num2str(V(jj));
            if strcmp(a(1:end-1),b(1:end-1))
                if matrix(ii,1)==matrix(jj,1)
                    plot( ones(1,jj-ii+1)*matrix(ii,1), ii:jj,'linewidth',3,'color',[1 0 0],'Hittest','Off');
                end
            end
        end
        
    end
    set(gca,'Xdir','reverse' )
    for ii=1:size(matrix,1)
        plot( matrix(ii,1):matrix(ii,2),ones(1,matrix(ii,2)-matrix(ii,1)+1)*ii,'linewidth',3,'color',[1 0 0],'Hittest','Off');
        plot( matrix(ii,2),ii,    'bv',     'MarkerSize',10,'Marker','square','LineStyle','none', 'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[1 0 1],'Hittest','Off');
    end
    
    
    xlim([1 max(matrix(:,2))+20])
    ylim([0 length(V)+1])
    
    %            clear  new_V
    for iii=1:length(V)
        temp_num=num2str(V(iii))
        new_num=  temp_num(1)
        for kk=2:length(temp_num)
            new_num=strcat(new_num,'.',temp_num(kk))
        end
        new_V(iii)={new_num}
    end
    
    
    V_frames=min(matrix(:,1)):max(matrix(:,2));
    
    set(gca, 'YTick', 0: size(new_V,2)) ; set(gca, 'XTick',1:length(V_frames)) ;
    set(gca,'YTickLabel',{ ;'';char(new_V)  ;'';})  ; set(gca,'XTickLabel',{ ;'';V_frames  ;'';})  ;
    str=char(strcat('Linage tree of cell-',num2str(Cell)));
    ylabel(str); xlabel('Time points (points where cell a5pear)')
    
    
end


%
%
%
%
%
%
% tic
%   MATRIX(:,1:2:end)=[];  MATRIX=MATRIX./MATRIX;
%   [a,start_XY]=nanmin(MATRIX);
%    length_XY=nansum(MATRIX);
%    end_XY=start_XY+length_XY-1;
%     toc
%
%     hold on
%     for ii=1:length(Div_Cells)
%     plot(start_XY(ii):end_XY(ii),ones(1,length_XY(ii))*ii,'linewidth',3,'color',[ii/length(Div_Cells)   1-ii/length(Div_Cells) 0],'Hittest','Off');
%     end
%     plot(start_XY,1:ii,    '.b','Hittest','Off');
%     plot(end_XY,1:ii,    '.m','Hittest','Off');
%     a=get(handles.axes1)
%     save a a
%         set(handles.axes1, 'YTick', 1:length(Div_Cells)) ;
%
%       set(handles.axes1,'YTickLabel',  Div_Cells  )
%
%
% %
