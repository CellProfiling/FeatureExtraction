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
function [MATRIX]= Find_Tracks_Crocker(maxdisp,param,centy1)

XYT=[]; jj=1;
for ii=1:size(centy1,2)
    if isempty(centy1(ii).cdata)~=1
        XYT(jj:jj+size(centy1(ii).cdata,1)-1,:)=centy1(ii).cdata(:,1:3)  ;
        jj=jj+size(centy1(ii).cdata,1);
    end
end
XYT(:,3)=round(XYT(:,3))    ;

param.quiet=0;
% perform multiple particle tracking using the list generated above
h=waitbar(0.5,'Tracking in Progress');
% save XYT XYT
% save maxdisp maxdisp
% save param param
tracks=track_crocker_TACWrapper(XYT,maxdisp,param)  ;



for ii=1:max(tracks(:,4))
    temp_vec=tracks(:,4);
    vec_index=find(ismember(temp_vec,ii)) ; %index of cell start event.  min(vec_index) is the index when the cell apear
    temp_vec2= tracks(min(vec_index):max(vec_index),3); %frames where cell ii apear
    temp_vec3=diff(temp_vec2); % difference between each frame
    if max(temp_vec3)>1 % find steps larger than 1
        %        do
        %  Stop_here_frame=find(ismember( temp_vec3,max(temp_vec3)))+ min(temp_vec2) %frame where to stop
        Stop_here_index=find(ismember( temp_vec3,max(temp_vec3)))+ min(vec_index) %frame where to stop
        if length( Stop_here_index)==1
            tracks(Stop_here_index:end,4)=  tracks(Stop_here_index:end,4)+1;
        end
    end
end





%    tracks
%    pause
%    return
tracks2=zeros(1,4);
counter_ii=0;
counter_jj=0;
for ii=1:tracks(end,4) ;
    index=find(ismember(tracks(:,4),ii)) ;
    counter=tracks(max(index),3)-tracks(min(index),3);
    sizey=size(tracks2,1)+1;
    tracks2(sizey:sizey+counter,1:2)=0;
    tracks2(sizey:sizey+counter,3)=(tracks(min(index),3):tracks(max(index),3))'  ;
    tracks2(sizey:sizey+counter,4)=ii ;
end
tracks2(1,:)=[];

for iii=1:tracks2(end,4) ;
    index_tracks=find(ismember(tracks(:,4),iii)) ;    index_tracks2=find(ismember(tracks2(:,4),iii)) ;
    vec_tracks=(tracks(min( index_tracks):max( index_tracks),3))' ;
    vec_tracks2=tracks2(min( index_tracks2),3):tracks2(max( index_tracks2),3)  ;
    
    for ii=1:size(vec_tracks2,2)
        for jj=1:size(vec_tracks,2)
            if vec_tracks2(ii)==vec_tracks(jj)
                tracks2(ii+counter_ii,1:2)=tracks(jj+counter_jj,1:2) ;
            end
        end
    end
    counter_ii=counter_ii+length(vec_tracks2);
    counter_jj=counter_jj+length(vec_tracks);
end





MATRIX = [] ;
jj=1 ;
for ii=1:tracks2(end,4) ;
    index=find(ismember(tracks2(:,4),ii)) ;
    index_min=min(index) ;
    index_max=max(index) ;
    MATRIX( tracks2(index_min,3):tracks2(index_min,3)+ index_max- index_min  ,jj:jj+1) =tracks2(index_min:index_max,1:2) ;
    jj=jj+2 ;
end
close(h)