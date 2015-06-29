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
function Dividing_plot_function(handles,n,D1,D2,Vs,str_in) %%4-7

scrsz = get(0,'ScreenSize') ;
scrsz(4)=scrsz(4)/2.5;
scrsz(1)=scrsz(4)/3;
scrsz(2)=scrsz(1)*2;
scrsz(3)=scrsz(3)/2 ;
figure('color','w','units','pixels','position', scrsz) ;
VV=[n D1 D2 D1 D2];
% close(thinking)
Get_8_option= get(handles.Get_8_option,'Value');
if Get_8_option ==1
    if isempty(Vs)==1 % show boxplot statistic for all points over the trajectory of each cell
        for jj=1:3
            start_frame=VV(jj);
            Y=eval(strcat('Get_Cell_',str_in,'(handles,start_frame,Vs)') )'   ;
            subplot( 1 ,3,jj);
            boxplot(Y ,'plotstyle','compact')
            if jj==1
                Div_Cells_str=get(handles.Div_Cells,'string');   n_tag= char(Div_Cells_str(n));
                str_y=strcat('Parental: ', num2str(n_tag),' ');  ylabel(str_in ) ; xlabel('')
                title(str_y,'fontsize',12,'BackgroundColor','b' )
            elseif jj==2
                Div_Cells_str=get(handles.Div_Cells,'string');  D1_tag= char(Div_Cells_str(D1)) ;  D2_tag= char(Div_Cells_str(D2));
                str_y=strcat('D1: ', num2str(D1_tag),' ');  ylabel(str_in ) ; xlabel('')
                title(str_y,'fontsize',12,'BackgroundColor','g' )
            elseif jj==3
                Div_Cells_str=get(handles.Div_Cells,'string'); D2_tag= char(Div_Cells_str(D2));
                str_y=strcat('D2: ', num2str(D2_tag),' ');  ylabel(str_in ) ; xlabel('')
                title(str_y,'fontsize',12,'BackgroundColor','r' )
            end
            Y_data(jj).cdata=Y;
        end
        set(gcf,'Userdata',Y_data)
    else %show vs selected parameter:
        for jj=1:3
            start_frame=VV(jj);
            Y=eval(strcat('Get_Cell_',str_in,'(handles,start_frame,Vs)') )'
            %  ------
            if findstr(Vs,'Time')
                X=1:length(Y) ;
            end
            % p005 for type 2
            if findstr(Vs,'Intensity')
                X=Get_Cell_Intensity(handles,start_frame,Vs) ;
            end
            
            if findstr(Vs,'Area')
                X=Get_Cell_Area(handles,start_frame,Vs) ;
            end
            
            if findstr(Vs,'EquivDiameter')
                X=Get_Cell_EquivDiameter(handles,start_frame,Vs) ;
            end
            
            if findstr(Vs,'Circularity')
                X=Get_Cell_Circularity(handles,start_frame,Vs)
            end
            
            if findstr(Vs,'Ellipticity')
                X=Get_Cell_Ellipticity(handles,start_frame,Vs) ;
            end
            
            if findstr(Vs,'Polarisation')
                X=Get_Cell_Polarisation(handles,start_frame,Vs) ;
            end
            
            if findstr(Vs,'Eccentricity')
                X=Get_Cell_Eccentricity(handles,start_frame,Vs) ;
            end
            
            
            if findstr(Vs,'Orientation')
                X=Get_Cell_Orientation(handles,start_frame,Vs) ;
            end
            
            if findstr(Vs,'Velocity')
                X=Get_Cell_Velocity(handles,start_frame,Vs) ;
            end
            if findstr(Vs,'I_per_A') %need to validate!!!!
                X =Get_Cell_I_per_A(handles,start_frame,Vs) ;
            end
            
            if length(X)>length(Y)
                X=X(1:length(Y));
            elseif length(Y)>length(X)
                Y=Y(1:length(X));
            end
            % -------
            Data.X_data(jj).cdata=X ;
            Data.Y_data(jj).cdata=Y ;
        end
        subplot( 1 ,2,1);
        plot(Data.X_data(1).cdata, Data.Y_data(1).cdata, 'MarkerFaceColor','b','MarkerEdgeColor','b','Marker','square', 'LineStyle','none');
        xlabel(Vs)
        ylabel(str_in)
        
        
        Div_Cells_str=get(handles.Div_Cells,'string');
        n_tag= char(Div_Cells_str(n));
        D1_tag= char(Div_Cells_str(D1));
        D2_tag= char(Div_Cells_str(D2));
        str_legend=strcat('Parental- Cell :  ', num2str( n_tag)) ;
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
        str_legend_D1=strcat('Parental- Cell :  ', num2str(D1_tag)) ;
        str_legend_D2=strcat('Parental- Cell :  ', num2str(D2_tag)) ;
        legend(str_legend_D1,str_legend_D2 ,2','Location','NorthOutside');
        set(gcf,'Userdata',Data)
        Name=char(strcat('Dividing_',str_in,'_Vs_',Vs) )
        
        set(gcf,'Name',Name)
        
        
        
        if (get(handles.save_Fig_option,'Value') == get(handles.save_Fig_option,'Max'))
            track_what=get(handles.track_by,'Value')
            track_what=eval(strcat('get(handles.track_what_',num2str(track_what),',''Value',''' )'))
            quantify_by=get(handles.track_by,'Value')
            quantify_by2=eval(strcat('get(handles.track_what_',num2str(quantify_by),',''Value',''' )'))
            plot_list=get(handles.Raw_listbox,'String')
            pos=plot_list(1);
            pos=char(pos)  ;
            pos=pos(min(findstr(pos,'Pos'))+3:findstr(pos,'_t')-1)
            save_Fig_folder=get(handles.save_Fig_folder,'String');
            newstr=char(strcat(save_Fig_folder,handles.data_file(3).cdata(track_what,2),'_',handles.data_file(3).cdata(quantify_by2,2),'_Dividing_',str_in,'_Vs_',Vs,'\') )
            if isdir(newstr)==0
                mkdir(newstr)
            end
            filename=char(get(handles.edit_axes1,'string')) ;
            filename=filename(1:max(strfind(filename, '_t'))) ;
            newstr=char(strcat(newstr,handles.data_file(3).cdata(track_what,2),'_',handles.data_file(3).cdata(quantify_by2,2),'_Dividing_',str_in,'_Vs_',Vs,'_',filename,'div_',num2str(n)))
            saveas(gcf,newstr)
        end
        
    end
end
if Get_8_option ~=1
    if isempty(Vs)==1 % show boxplot statistic for all points over the trajectory of each cell
        if findstr(str_in,'Orientation')~=1
            h = msgbox('Function 8 is not supporting Orientation. Please disable the get 8 function data.','Aborted');
            return;
        elseif findstr(str_in,'Velocity')~=1
            h = msgbox('Function 8 is not supporting Velocity. Please disable the get 8 function data.','Aborted');
            return;
        elseif findstr(str_in,'Eccentricity')~=1
            h = msgbox('Function 8 is not supporting Eccentricity. Please disable the get 8 function data.','Aborted');
            return;
        end
        
        [~,~, ~, ~,Stat]=Get_division_8(handles,n,D1,D2,str_in)  ;
        str_plot=Consider_8_GUI ;
        
        for ii=1:size(str_plot,1)
            temp_str=str_plot(ii) ;
            temp_str=char(temp_str)
            temp_str= regexprep(temp_str, 'x', '(X_L+X_R)');
            temp_str= regexprep(temp_str, 'y', '(Y_L+Y_R)');
            temp_vector=eval(temp_str)  ;
            subplot( 1 , size(str_plot,1)+2,ii) ;
            if isempty(temp_vector)~=1
                temp_vector(temp_vector==0)=[];
            end
            boxplot(temp_vector ,'plotstyle','compact') ;
            str_y=strcat(temp_str,': Cell- ', num2str(n),' ');  ylabel(str_in ) ;
            xlabel(str_y,'fontsize',12,'BackgroundColor','cyan' )
        end
        if findstr(Stat,'D1 on top')==1
            start_frame=D1;
            Y=eval(strcat('Get_Cell_',str_in,'(handles,start_frame,Vs)') )'   ;
            Y_data(ii+1).cdata=Y;
            subplot( 1 , size(str_plot,1)+2,ii+1);
            boxplot(Y ,'plotstyle','compact')
            str_y=strcat('D1 upper cell: ', num2str(D1),' ');  ylabel(str_in ) ;
            xlabel(str_y,'fontsize',12,'BackgroundColor','g' )
            start_frame=D2;
            Y=eval(strcat('Get_Cell_',str_in,'(handles,start_frame,Vs)') )'  ;
            Y_data(ii+2).cdata=Y;
            %   if get(handles.subplot_on,'value')==1
            subplot( 1 , size(str_plot,1)+2,ii+2);
            %   end
            boxplot(Y ,'plotstyle','compact')
            str_y=strcat('D2 buttom cell: ', num2str(D2),' ');  ylabel(str_in ) ;
            xlabel(str_y,'fontsize',12,'BackgroundColor','r' )
        end
        if findstr(Stat,'D2 on top')==1
            start_frame= D2;
            Y=eval(strcat('Get_Cell_',str_in,'(handles,start_frame,Vs)') )'   ;
            Y_data(ii+1).cdata=Y;
            %  if get(handles.subplot_on,'value')==1
            subplot( 1 , size(str_plot,1)+2,ii+1);
            %  end
            boxplot(Y ,'plotstyle','compact')
            str_y=strcat('D2 upper cell: ', num2str(D2),' ');  ylabel(str_in ) ;
            xlabel(str_y,'fontsize',12,'BackgroundColor','g' )
            start_frame= D1;
            Y=eval(strcat('Get_Cell_',str_in,'(handles,start_frame,Vs)') )' ;
            Y_data(ii+2).cdata=Y;
            %   if get(handles.subplot_on,'value')==1
            subplot( 1 , size(str_plot,1)+2,ii+2);
            %   end
            boxplot(Y ,'plotstyle','compact')
            str_y=strcat('D1 buttom cell: ', num2str(D1),' ');  ylabel(str_in ) ;
            xlabel(str_y,'fontsize',12,'BackgroundColor','r' )
        end
    end
    
    
    if findstr(Vs,'Time')==2 % show boxplot statistic for all points over the trajectory of each cell
        
        if findstr(str_in,'Orientation')~=1
            h = msgbox('Function 8 is not supporting Orientation. Please disable the get 8 function data.','Aborted');
            return;
        elseif findstr(str_in,'Velocity')~=1
            h = msgbox('Function 8 is not supporting Velocity. Please disable the get 8 function data.','Aborted');
            return;
        elseif findstr(str_in,'Eccentricity')~=1
            h = msgbox('Function 8 is not supporting Eccentricity. Please disable the get 8 function data.','Aborted');
            return;
            
        end
        
        [~,~, ~, ~,Stat]=Get_division_8(handles,n,D1,D2,str_in)  ;
        str_plot=Consider_8_GUI ;
        for ii=1:size(str_plot,1)
            temp_str=str_plot(ii) ;
            
            temp_str= regexprep(temp_str, 'x', '(X_L+X_R)')
            temp_str= regexprep(temp_str, 'y', '(Y_L+Y_R)')
            temp_str=char(temp_str)
            temp_vector=eval(temp_str)  ;
            if isempty(temp_vector)~=1
                temp_vector(temp_vector==0)=[];
            end
            %  if
            %  get(handles.subplot_on,'value')==1
            subplot( 1 , size(str_plot,1)+1,ii);
            %  end
            plot(1:length( temp_vector) , temp_vector ,'MarkerFaceColor','b','MarkerEdgeColor','b','Marker','square', 'LineStyle','none');
            xlabel(Vs); ylabel(str_in);
            Div_Cells_str=get(handles.Div_Cells,'string');  n_tag= char(Div_Cells_str(n));
            str_y=strcat(temp_str,': Cell - ', num2str(n_tag),' ');
            title(str_y,'fontsize',12,'BackgroundColor','cyan' )
            axis tight
            Y_data(ii).cdata=temp_vector;
        end
        
        
        start_frame=D1;
        Y=eval(strcat('Get_Cell_',str_in,'(handles,start_frame,Vs)') )'   ;
        if findstr(Stat,'D1 on top')==1
            Y_data(ii+1).cdata=Y;
        elseif findstr(Stat,'D2 on top')==1
            Y_data(ii+2).cdata=Y;
        end
        start_frame=D2;
        Y=eval(strcat('Get_Cell_',str_in,'(handles,start_frame,Vs)') )'   ;
        if findstr(Stat,'D1 on top')==1
            Y_data(ii+2).cdata=Y;
        elseif findstr(Stat,'D2 on top')==1
            Y_data(ii+1).cdata=Y;
        end
        
        Div_Cells_str=get(handles.Div_Cells,'string');
        n_tag= char(Div_Cells_str(n));
        D1_tag= char(Div_Cells_str(D1));
        D2_tag= char(Div_Cells_str(D2));
        %  if get(handles.subplot_on,'value')==1
        subplot( 1 , size(str_plot,1)+1,ii+1);
        %  end
        plot(  1:length(Y_data(ii+1).cdata) ,  Y_data(ii+1).cdata ,'MarkerFaceColor','g','MarkerEdgeColor','g','Marker','square', 'LineStyle','none');
        xlabel(Vs)
        ylabel(str_in)
        hold on
        plot( 1:length(Y_data(ii+2).cdata) ,  Y_data(ii+2).cdata, 'MarkerFaceColor','r','MarkerEdgeColor','r','Marker','square', 'LineStyle','none');
        title('After division')
        axis tight
        str_legend_D1=strcat('D1- Cell :  ', num2str(D1_tag)) ;
        str_legend_D2=strcat('D2- Cell :  ', num2str(D2_tag)) ;
        legend(str_legend_D1,str_legend_D2 ,2','Location','NorthOutside');
        set(gcf,'Userdata',Y_data)
        
    end
end
