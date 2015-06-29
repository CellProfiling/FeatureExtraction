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
function  plot_function_gen(Data_in, temp_folder_str, current_filename)


Vs='Time';str_in='Intensity'; temp_str=Data_in.upper_cell ;
n=temp_str(strfind(temp_str,':')+1:strfind(temp_str,'.')-1);
D1=strcat( n,'.', num2str(1))   ;
D2=strcat( n,'.', num2str(2));




scrsz = get(0,'ScreenSize') ;
scrsz(4)=scrsz(4)/2.5;
scrsz(1)=scrsz(4)/3;
scrsz(2)=scrsz(1)*2;
scrsz(3)=scrsz(3)/2 ;
figure('color','w','units','pixels','position', scrsz) ;
%  VV=[n D1 D2 D1 D2];
vec=[1 Data_in.Div_start_at_frame Data_in.D2_start_at_frame  size(Data_in.Montage,2)] ;


for jj=1:3
    clear Y
    clear X
    
    
    switch jj
        case 1
            vec_start=vec(1);   vec_end=vec(2);
        case 2
            vec_start=vec(2);   vec_end=vec(3);
        case 3
            vec_start=vec(3);   vec_end=vec(4);
    end
    
    
    
    jjj=1;
    for ii=vec_start:vec_end
        Y(jjj)=(sum(sum(Data_in.Montage(ii).cdata))) ;jjj=jjj+1  %#ok<AGROW>
    end
    
    
    Y=Y';
    X=1:length(Y) ;
    
    % -------
    Data.X_data(jj).cdata=X ;
    Data.Y_data(jj).cdata=Y ;
end


subplot( 1 ,2,1);
plot(Data.X_data(1).cdata, Data.Y_data(1).cdata, 'MarkerFaceColor','b','MarkerEdgeColor','b','Marker','square', 'LineStyle','none');
xlabel(Vs)
ylabel(str_in)

str_legend=strcat('Parental- Cell :  ', n) ;
legend(str_legend, 1','Location','NorthOutside');
title('Before division')
axis tight
subplot( 1 ,2,2);
plot(Data.X_data(2).cdata, Data.Y_data(2).cdata ,'MarkerFaceColor','g','MarkerEdgeColor','g','Marker','square', 'LineStyle','none');
xlabel(Vs)
ylabel(str_in)
hold on
plot(Data.X_data(3).cdata, Data.Y_data(3).cdata, 'MarkerFaceColor','r','MarkerEdgeColor','r','Marker','square', 'LineStyle','none');
title('After division')
axis tight
str_legend_D1=strcat('Parental- Cell :  ',D1) ;
str_legend_D2=strcat('Parental- Cell :  ',D2) ;
legend(str_legend_D1,str_legend_D2 ,2','Location','NorthOutside');
set(gcf,'Userdata',Data)
Name=char(strcat(str_in,'_Vs_',Vs) )
set(gcf,'Name',Name)



track_what=temp_folder_str(findstr(temp_folder_str,'Tby')+4:findstr(temp_folder_str,'Qby')-2)
Quantify_by=temp_folder_str(findstr(temp_folder_str,'Qby')+4:findstr(temp_folder_str,'Sby')-2)
Segmented_by=temp_folder_str(findstr(temp_folder_str,'Sby')+4:end); v=findstr(Segmented_by,'_'); Segmented_by=Segmented_by(1:v(1)-1);
backbone_str=char(strcat('Tby_',track_what,'_Qby_', Quantify_by,'_Sby_', Segmented_by));
%          newstr=char(strcat(save_Fig_folder,'Dividing_Montage_', backbone_str,'_',Vs,'\') );
%          if isdir(newstr)==0
%            mkdir(newstr)
%

STR= char(strcat('Dividing_',str_in,'_Vs_',Vs))
current_filename =regexprep(current_filename, 'Dividing_SEQtage',   STR);
v=findstr(temp_folder_str,'\'); temp_folder_str=char(strcat(temp_folder_str(1:v(end-1)),STR))
temp_folder_str=char(strcat(temp_folder_str,'_Tby_',track_what,'_Qby_', Quantify_by,'_Sby_', Segmented_by,'\'));

if isdir(temp_folder_str)==0
    mkdir(temp_folder_str)
end
newstr_plotfilename=char(strcat(temp_folder_str,current_filename))
saveas(gcf,newstr_plotfilename)
pause(1)
Close