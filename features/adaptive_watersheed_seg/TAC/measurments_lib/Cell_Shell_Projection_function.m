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
function Cell_Shell_Projection_function(handles,n,Vs) %4
segmentation_type_1=get(handles.segmentation_type_1,'value');
set(handles.segmentation_type_1,'value',3);
Data_Segmention=Get_Cell_stack(handles,n,Vs) ;
set(handles.segmentation_type_1,'value',segmentation_type_1);
Data_temp=Get_Cell_stack(handles,n,Vs) ;
scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
figure('color','w','units','pixels','position', scrsz) ;
Segmention_matrix=Data_Segmention(1).cdata;
h=imagesc(Data_temp(1).cdata);
h = imline(gca,[size(Segmention_matrix,1)/2 size(Segmention_matrix,2)/2 ; size(Segmention_matrix,1)/2+4 size(Segmention_matrix,2)/2+4]);
setColor(h,'m');
position_in = wait(h) ;
api = iptgetapi(h)
api.delete()
close(gcf)
x1=round(position_in(1))
y1=round(position_in(3))
x2=round(position_in(2))
y2=round(position_in(4))
XY1=sub2ind(size(Segmention_matrix),x1 ,y1);
XY2=sub2ind(size(Segmention_matrix),x2 ,y2);
n1=[]; n2=[];
L = bwlabel(Segmention_matrix,4); %take the largest particle:
stats = regionprops(L,'Area') ;
idx=0;
for iii=1:size(stats,1)
    if idx < stats(iii).Area
        idx =  stats(iii).Area ;
        iii_index=iii;
    end
end

Segmention_matrix=ismember(L,iii_index);
ii=1;
while max(max( Segmention_matrix))>0
    Segmention_vector= bwboundaries(Segmention_matrix,'noholes') ;
    boundary = Segmention_vector{1} ;
    XY=sub2ind(size(Segmention_matrix),boundary(:,1),boundary(:,2));
    if isempty(find(ismember(XY,XY1), 1))~=1
        n1=ii;
    end
    if isempty(find(ismember(XY,XY2), 1))~=1
        n2=ii;
    end
    
    Segmention_matrix(XY)=0;
    ii=ii+1;
end
if isempty(n1)==1
    n1=1
end
if isempty(n2)==1
    n2=ii-1
end

if n1>n2
    nn=n1;   n1=n2;   n2=nn;
end

if n2-n2>ii-1
    n1=1;   n2=ii-1
end
for jjj=1: size(Data_Segmention,2)
    temp_matrix=Data_temp(jjj).cdata;
    Segmention_matrix= Data_Segmention(jjj).cdata;
    Segmention_vector= bwboundaries(Segmention_matrix,'noholes') ;
    max_Segmention_vector=0;
    for jj=1:size(Segmention_vector,1)
        if size(Segmention_vector{jj},1)>max_Segmention_vector
            max_Segmention_vector=jj;
        end
    end
    boundary = Segmention_vector{jj}  ;
    XY=sub2ind(size(Segmention_matrix),boundary(:,1),boundary(:,2));
    temp_vector=temp_matrix(XY);
    x=length(temp_vector);
    new_matrix=zeros(x,x);
    ii=1;
    while max(max( Segmention_matrix))>0
        Segmention_vector= bwboundaries(Segmention_matrix,'noholes') ;
        max_Segmention_vector=0;
        for jj=1:size(Segmention_vector,1)
            if size(Segmention_vector{jj},1)>max_Segmention_vector
                max_Segmention_vector=jj;
            end
        end
        boundary = Segmention_vector{jj} ;
        XY=sub2ind(size(Segmention_matrix),boundary(:,1),boundary(:,2));
        temp_vector=temp_matrix(XY);
        temp_vector=imresize(temp_vector,[x 1]); % option is on.
        new_matrix(1:length(temp_vector),ii)=temp_vector;
        Segmention_matrix(XY)=0;
        ii=ii+1;
    end
    Data_out(jjj).cdata=new_matrix;
end
n=n2-n1 ;
for ii=1: size(Data_out,2)
    size_y(ii)=size(Data_out(ii).cdata,2);
end
max_size_y=max(size_y);
new_matrix=zeros(max_size_y,size(Data_out,2)*n);
for ii=1: size(Data_out,2)
    temp_matrix= Data_out(ii).cdata(:,n1:n2) ;
    temp_matrix=imresize(temp_matrix,[max_size_y n]);
    new_matrix(:,(1+(ii-1)*n):ii*n)=temp_matrix;
end

figure(2)
imagesc(new_matrix)
set(gcf,'userdata',new_matrix)