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
function Cell_Proximity_vector_function(handles,n)   %13
start_frame=n*2-1 ;
track_what=get(handles.track_by,'Value') ;
track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )')) ;
quantify_by=get(handles.track_by,'Value') ;
% track_by=eval(strcat('get(handles.track_what_',num2str(track_by),'
% ,''Value',''' )')) ;
MATRIX = handles.data_file(5).cdata.Tracks(track_what).cdata;
[vector, jj]=create_vector(MATRIX,handles,start_frame) ;
centroid =Cell_data_function(vector,handles,jj,'Centroid',1);
str='Proximity_Ch_1'
output=[];
popup_spaces=get(handles.popup_spaces,'Value');
if popup_spaces==1
    for ii=1:size(vector,1)
        if isnan(vector(ii,3))~=1
            full_command=strcat('handles.data_file(4).cdata.L(',num2str(track_what) ,').cdata(ii+jj-1).cdata(vector(ii,3)).',str)
            temp_vec=eval(full_command) ;
            if size(temp_vec,2)==4
                output(ii,:)=  temp_vec ;
            end
        end
    end
elseif popup_spaces==2
    kk=1;
    for ii=1:size(vector,1)
        if isnan(vector(ii,3))~=1
            full_command=strcat('handles.data_file(4).cdata.L(',num2str(track_what) ,').cdata(ii+jj-1).cdata(vector(ii,3)).',str);
            output(kk,:)= eval(full_command) ; kk=kk+1;
        end
    end
end

% calculate the angle between centroid at time t and centroid at time t+1
for ii=1:length(centroid)-1
    if mean(output(ii,:))~=0
        
        
        p1 =[centroid(ii+1,1) centroid(ii+1,2)];  %centroid at time t+1
        p2 = [centroid(ii ,1) centroid(ii ,2)]; % centroid at time t
        p3 = [output(ii ,4) output(ii ,3)]; % proximity pixel (closest pixel in quantified channel to the cells in tracked channel)
        theta(ii)=ANGLE_DEG_2D_TACWrapper( p1, p2, p3 )
        x=p3(1)-p2(1); y=p3(2)-p2(2); R_Proximity(ii)=sqrt(x^2+y^2);
        x=p1(1)-p2(1); y=p1(2)-p2(2); R_velocity(ii)=sqrt(x^2+y^2);
    else
        theta(ii)=nan  ; R_Proximity(ii)=nan;R_velocity(ii)=nan;
    end
end
scrsz = get(0,'ScreenSize') ;
scrsz(1)=(scrsz(3)-scrsz(4))/2 ;
scrsz(4)=scrsz(4)/2 ;
scrsz(3)=scrsz(4);
scrsz(2)=scrsz(1);
Div_Cells_str=get(handles.Div_Cells,'string');
n_tag= char(Div_Cells_str(n));
% [u,v] = pol2cart(theta*pi/180,R_Proximity)


h1=figure('color','w','units','pixels','position', scrsz)
index_max=find(ismember(R_Proximity,max(max(R_Proximity))))
h_p2=polar(theta(index_max)*pi/180,R_Proximity(index_max))
set(h_p2,'lineStyle', 'none' ,'Marker', 'O','MarkerSize',7, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor' , [1 1 1])
axis tight
hold on
n=1:length(theta);
C=cool(length(theta));
n= n./20;
for ii=1:length(theta)
    h_p2=polar(theta(ii)*pi/180,R_Proximity(ii))
    set(h_p2,'lineStyle', 'none' ,'Marker', 'O','MarkerSize',7, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor' , C(ii,:))
end
set(h1 ,'colormap',C);
colorbar_location=colorbar('location','southoutside')
cbfreeze

%
% figure('color','w','units','pixels','position', scrsz)
% h_p=polar(theta*pi/180,R_Proximity)
% set(h_p,'lineStyle', 'none' ,'Marker', 'o','MarkerSize', 6, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor' ,'r')
title_str=strcat('Cell- Polar coordinate plot of Vs. Proximity: ',num2str(n_tag))
title(title_str ,'fontsize',14)
Data.theta=theta ; Data.R_Proximityy=R_Proximity;
set(gcf,'userdata',Data);
xlabel('Angles between cell and proximity vector')
ylabel('Proximity')

% -------------------
h2=figure('color','w','units','pixels','position', scrsz)
index_max=find(ismember(R_velocity,max(max(R_velocity))))
h_p2=polar(theta(index_max)*pi/180,R_velocity(index_max))
set(h_p2,'lineStyle', 'none' ,'Marker', 'O','MarkerSize',7, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor' , [1 1 1])
axis tight
hold on
n=1:length(theta);
C=cool(length(theta));
n= n./20;
for ii=1:length(theta)
    h_p2=polar(theta(ii)*pi/180,R_velocity(ii))
    set(h_p2,'lineStyle', 'none' ,'Marker', 'O','MarkerSize',7, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor' , C(ii,:))
end
set(h2 ,'colormap',C);
colorbar_location=colorbar('location','southoutside')
cbfreeze

% h_p=polar(theta*pi/180,R_velocity)
% set(h_p,'lineStyle', 'none' ,'Marker', 'o','MarkerSize', 6, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor' ,'g')
title_str=strcat('Cell- Polar coordinate plot of Vs. Velocity: ',num2str(n_tag))
title(title_str ,'fontsize',14)
Data.theta=theta ; Data.R_velocity=R_velocity;
set(gcf,'userdata',Data);
xlabel('Angles between cell and proximity vector')
ylabel('Velocity')


figure('color','w','units','pixels','position', scrsz) ;
hline = rose(theta*pi/180) ;
set(hline,'LineWidth',1.5)
title_str=strcat('Cell- histogram of angles between cell and proximity: ',num2str(n_tag))
title(title_str ,'fontsize',14)
set(gcf,'userdata',theta*pi/180);
xlabel('Angles between cell and proximity vector')



figure('color','w','units','pixels','position', scrsz) ;
scatter(R_Proximity,R_velocity ,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 0], 'Marker','square');
xlabel('Length of proximity vector (pixels)')
ylabel('Distance between centroids (pixels)')
title_str=strcat('Cell- Distance between centroids Vs. Proximity: ',num2str(n_tag))
title(title_str ,'fontsize',14)
Data.R_Proximity=R_Proximity; Data.R_velocity=R_velocity;
set(gcf,'userdata',Data);
