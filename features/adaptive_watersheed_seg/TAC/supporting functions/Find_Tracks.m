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
function MATRIX = Find_Tracks(centy1,start_track, end_track,original_MATRIX,min_length,MODE)





if isempty(original_MATRIX)==1 % need to define MATRIX
    for Start=start_track:end_track -1
        if ~isempty(centy1(Start).cdata)
            break
        end
    end
    
    %    1.define first row as a base to expand on
    MATRIX=[];
    jj=1;
    for ii=1:size(centy1(Start).cdata,1)
        MATRIX(1,jj)=centy1(Start).cdata(ii,1);
        MATRIX(1,jj+1)=centy1(Start).cdata(ii,2) ;
        jj=jj+2 ;
    end
    
    
    
    % try%2. expanding in a loop
    ii=1;
    h=waitbar(0,'linker is in process')
    for jjj=Start+1:end_track
        waitbar(jjj/(end_track-Start))
        ii=ii+1;  %expand ii for new time point
        MATRIX(end+1,:)=0;
        for jj=1:size(centy1(jjj).cdata,1)
            try
                centy1(jjj).cdata(jj,4)
            catch
                errordlg('Association not found','Error');
            end
            if centy1(jjj).cdata(jj,4)==-1 %expand jj for new merging particle
                MATRIX(ii,end+1)=0; MATRIX(ii,end+1)=0;
                MATRIX(ii,end-1)=centy1(jjj).cdata(jj,1); %Xjj
                MATRIX(ii,end)=centy1(jjj).cdata(jj,2); %Yjj
            else  %search for existing particle
                Tjj=centy1(jjj).cdata(jj,4);  %Tjj
                Xjj_1=centy1(jjj-1).cdata(Tjj,1);  %Xjj_1
                Yjj_1=centy1(jjj-1).cdata(Tjj,2);
                sizee=size(MATRIX,2)/2;
                matrix=repmat([1 NaN;NaN 1],1,sizee );
                X=matrix(1,:).*MATRIX(ii-1,:);
                Y=matrix(2,:).*MATRIX(ii-1,:);
                X(isnan(X))=[];
                Y(isnan(Y))=[];
                [~,I]=nanmin((abs(X- Xjj_1)+abs(Y- Yjj_1)));
                MATRIX(ii,I*2-1)=centy1(jjj).cdata(jj,1) ; %Xjj
                MATRIX(ii,I*2)=centy1(jjj).cdata(jj,2) ;  %Yjj
            end
            if MODE==1 % good for debugging
                figure(1)
                imagesc(MATRIX)
            end
        end
    end
    % end
    MATRIX2=zeros(Start-1,size(MATRIX,2));
    MATRIX2(end+1:end_track,:)=MATRIX;
    MATRIX=MATRIX2;
    MATRIX(end+1:size(centy1,2),:)=0 ;
    %
else
    %   there are two cases-
    %   a. we tracked from
    
    if mean(original_MATRIX(start_track,:) )>0
        MATRIX=original_MATRIX(1:start_track,:) ;
        try
            h=waitbar(0,'linker is in process')
            for ii=start_track+1:end_track
                waitbar(ii/(end_track-start_track))
                %expand ii for new time point
                MATRIX(end+1,:)=0;%zeros(size(MARIX,1);
                for jj=1:size(centy1(ii).cdata,1)
                    if centy1(ii).cdata(jj,4)==-1 %expand jj for new merging particle       'expand';
                        MATRIX(ii,end+1)=0; MATRIX(ii,end+1)=0;
                        MATRIX(ii,end-1)=centy1(ii).cdata(jj,1); %Xjj
                        MATRIX(ii,end)=centy1(ii).cdata(jj,2); %Yjj
                    else  %search for existing particle
                        Tjj=centy1(ii).cdata(jj,4);  %Tjj
                        Xjj_1=centy1(ii-1).cdata(Tjj,1);  %Xjj_1
                        Yjj_1=centy1(ii-1).cdata(Tjj,2);
                        sizee=size(MATRIX,2)/2;
                        matrix=repmat([1 NaN;NaN 1],1,sizee );
                        X=matrix(1,:).*MATRIX(ii-1,:);
                        Y=matrix(2,:).*MATRIX(ii-1,:);
                        X(isnan(X))=[];
                        Y(isnan(Y))=[];
                        [~,I]=nanmin((abs(X- Xjj_1)+abs(Y- Yjj_1)));
                        
                        MATRIX(ii,I*2-1)=centy1(ii).cdata(jj,1) ; %Xjj
                        MATRIX(ii,I*2)=centy1(ii).cdata(jj,2) ;  %Yjj
                    end
                    if MODE==1 % good for debugging
                        figure(1)
                        imagesc(MATRIX)
                    end
                end
            end
        end
        
        
        MATRIX(end+1:size(centy1,2),:)=0 ;
    else
        
        for Start=start_track:end_track -1
            if ~isempty(centy1(Start).cdata)
                break
            end
        end
        %    1.define first row as a base to expand on
        MATRIX=[];
        jj=1;
        for ii=1:size(centy1(Start).cdata,1)
            MATRIX(1,jj)=centy1(Start).cdata(ii,1);
            MATRIX(1,jj+1)=centy1(Start).cdata(ii,2) ;
            jj=jj+2 ;
            if MODE==1 % good for debugging
                figure(1)
                imagesc(MATRIX)
            end
        end
        try%2. expanding in a loop
            ii=1
            h=waitbar(0,'linker is in process')
            for jjj=Start+1:end_track
                waitbar(jjj/(end_track-Start))
                
                ii=ii+1;  %expand ii for new time point
                MATRIX(end+1,:)=0;
                for jj=1:size(centy1(jjj).cdata,1)
                    if centy1(jjj).cdata(jj,4)==-1 %expand jj for new merging particle
                        MATRIX(ii,end+1)=0; MATRIX(ii,end+1)=0;
                        MATRIX(ii,end-1)=centy1(jjj).cdata(jj,1); %Xjj
                        MATRIX(ii,end)=centy1(jjj).cdata(jj,2); %Yjj
                    else  %search for existing particle
                        Tjj=centy1(jjj).cdata(jj,4);  %Tjj
                        Xjj_1=centy1(jjj-1).cdata(Tjj,1);  %Xjj_1
                        Yjj_1=centy1(jjj-1).cdata(Tjj,2);
                        sizee=size(MATRIX,2)/2;
                        matrix=repmat([1 NaN;NaN 1],1,sizee );
                        X=matrix(1,:).*MATRIX(ii-1,:);
                        Y=matrix(2,:).*MATRIX(ii-1,:);
                        X(isnan(X))=[];
                        Y(isnan(Y))=[];
                        [~,I]=nanmin((abs(X- Xjj_1)+abs(Y- Yjj_1)));
                        MATRIX(ii,I*2-1)=centy1(jjj).cdata(jj,1) ; %Xjj
                        MATRIX(ii,I*2)=centy1(jjj).cdata(jj,2) ;  %Yjj
                    end
                    if MODE==1 % good for debugging
                        figure(1)
                        imagesc(MATRIX)
                    end
                end
            end
        end
        
        MATRIX2=zeros(end_track,size(MATRIX,2)+size(original_MATRIX,2));
        MATRIX2(1:start_track,1:+size(original_MATRIX,2))=original_MATRIX(1:start_track,:);
        MATRIX2(Start:end,size(original_MATRIX,2)+1:end)= MATRIX;
        MATRIX2( end_track :size(centy1,2),:)=0;
        MATRIX =MATRIX2 ;
    end
end
try
    % max_velocity=max_velocity %100  %(pix/frame
    %threshold short tracks
    for ii=1:size(MATRIX,2)
        X=MATRIX(:, ii);
        X=X(X~=0);
        track_length=length(X);
        if  track_length<min_length
            list_of_delete(ii)=ii;
        end
        if MODE==1 % good for debugging
            figure(1)
            imagesc(MATRIX)
        end
    end
    list_of_delete= list_of_delete( list_of_delete~=0) ;
    MATRIX(:,list_of_delete)=[];
    if MODE==1 % good for debugging
        figure(1)
        imagesc(MATRIX)
    end
end

close(h)
end





