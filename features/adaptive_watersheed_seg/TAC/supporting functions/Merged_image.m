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
function matrix_out=Merged_image(n,handles) ;
data_file=get(handles.figure1,'userdata');
for ii=1:4%support up to 4 channels
    Track_What(ii)=eval(strcat('get(handles.track_what_',num2str(ii),',''Value',''' )')) ;
    show_tracks(ii)= eval(strcat('get(handles.show_tracks_',num2str(ii),',''Value',''' )')) ;
    show_marks(ii)= eval(strcat('get(handles.show_marks_',num2str(ii),',''Value',''' )')) ;
end

%%%%%%%%%
if get(handles.stack_merged,'value')
    try
        global merged_stack
        matrix_out= merged_stack(n).cdata;
    end
else
    matrix_out=[];
    box_Raw=get(handles.Raw_listbox,'string') ;
    filename=box_Raw(n) ;   set(handles.edit_axes1,'String',filename);
    pathname= data_file(2).cdata;
    Projected_by_Str={'By max',  'By mean', 'z1', 'z2', 'z3', 'z4', 'z5', 'z6', 'z7', 'z7' , 'z9',  'z10'} ;
    
    
    Index=find(Track_What~=5)  ;
    if length(Index)==1
        segmentation_type =eval(strcat('get(handles.segmentation_type_',num2str(Index),',''Value',''' )'));
        Projected_by_Value=eval(strcat('get(handles.Projected_by_',num2str(Index),',''Value',''' )'))    ;
        Projected_by = (Projected_by_Str(Projected_by_Value)) ;
        matrix_out  =  read_image3(pathname,filename,Track_What(Index),segmentation_type(Index), Projected_by)  ;
    else
        
        Nbits=data_file(9).cdata ;
        Xdim=data_file(6).cdata(4) ;
        Ydim=data_file(6).cdata(3) ;
        
        for ii=1:4%support up to 4 channels
            segmentation_type(ii)=eval(strcat('get(handles.segmentation_type_',num2str(ii),',''Value',''' )'));
            Projected_by_Value=eval(strcat('get(handles.Projected_by_',num2str(ii),',''Value',''' )'))    ;
            Projected_by(ii)= (Projected_by_Str(Projected_by_Value)) ;
        end
        
        Blue_factor=get(handles.Blue_factor,'value') ;
        Green_factor=get(handles.Green_factor,'value') ;
        Red_factor=get(handles.Red_factor,'value')  ;
        DIC_temp=[]  ; Red=[]; Green=[]; Blue=[];
        if  Track_What(1)<5
            str_1=data_file(3).cdata( Track_What(1),1) ;
            if char(str_1)~='0' && char(str_1)~='1' %  'first channel is active, and not DIC'
                if char(str_1)=='2'
                    Blue = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Blue_factor);
                elseif char(str_1)=='3'
                    Green = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Green_factor);
                elseif char(str_1)=='4'
                    Green = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Green_factor);
                elseif char(str_1)=='5'
                    Red = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Red_factor);
                elseif char(str_1)=='6'
                    Red = double(read_image3(pathname,filename,Track_What(1),segmentation_type(1), Projected_by(1)) *Red_factor);
                end
            end
        end
        
        if Track_What(2)<5
            str_2=data_file(3).cdata( Track_What(2),1) ;
            if char(str_2)~='0' && char(str_2)~='1' %  'first channel is active, and not DIC'
                if char(str_2)=='2'
                    Blue = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Blue_factor);
                elseif char(str_2)=='3'
                    Green = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Green_factor);
                elseif char(str_2)=='4'
                    Green = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Green_factor);
                elseif char(str_2)=='5'
                    Red = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Red_factor);
                elseif char(str_2)=='6'
                    Red = double(read_image3(pathname,filename,Track_What(2),segmentation_type(2), Projected_by(2)) *Red_factor);
                end
            end
        end
        
        if Track_What(3)<5
            str_3=data_file(3).cdata( Track_What(3),1) ;
            if char(str_3)~='0' && char(str_3)~='1'
                if char(str_3)=='2'
                    Blue = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Blue_factor);
                elseif char(str_3)=='3'
                    Green = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Green_factor);
                elseif char(str_3)=='4'
                    Green = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Green_factor);
                elseif char(str_3)=='5'
                    Red = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Red_factor);
                elseif char(str_3)=='6'
                    Red = double(read_image3(pathname,filename,Track_What(3),segmentation_type(3), Projected_by(3)) *Red_factor);
                end
            end
        end
        
        if Nbits==8
            if isempty(Red)
                Red=uint8(zeros(Xdim,Ydim,1));
            else
                Red=uint8((Red./(max(max(Red))))*255);
            end
            if isempty(Green)
                Green=uint8(zeros(Xdim,Ydim,1));
            else
                Green=uint8((Green./(max(max(Green))))*255) ;
            end
            if isempty(Blue)
                Blue=uint8(zeros(Xdim,Ydim,1));
            else
                Blue=uint8((Blue./(max(max(Blue))))*255);
            end
        elseif  Nbits==16
            if isempty(Red)
                Red=uint16(zeros(Xdim,Ydim,1));
            else
                Red=uint16((Red./(max(max(Red))))*65535);
            end
            if isempty(Green)
                Green=uint16(zeros(Xdim,Ydim,1));
            else
                Green=uint16((Green./(max(max(Green))))*65535) ;
            end
            if isempty(Blue)
                Blue=uint16(zeros(Xdim,Ydim,1));
            else
                Blue=uint16((Blue./(max(max(Blue))))*65535);
            end
        elseif  Nbits==32
            if isempty(Red)
                Red=uint32(zeros(Xdim,Ydim,1));
            else
                Red=uint32((Red./(max(max(Red))))*2^32);
            end
            if isempty(Green)
                Green=uint32(zeros(Xdim,Ydim,1));
            else
                Green=uint32((Green./(max(max(Green))))*2^32) ;
            end
            if isempty(Blue)
                Blue=uint32(zeros(Xdim,Ydim,1));
            else
                Blue=uint32((Blue./(max(max(Blue))))*2^32);
            end
        end
        if Track_What(4)<5
            str_4=data_file(3).cdata( Track_What(4),1)   ;
            Use_DIC_Option= get( handles.Use_DIC_Option ,'Value');
            if char(str_4)=='1' && Use_DIC_Option==1
                matrix_temp = double(read_image3(pathname,filename,Track_What(4),segmentation_type(4), Projected_by(4)));
                if Nbits==8
                    I= uint8(~(Green./Green+Red./Red+Blue./Blue)).*uint8(( matrix_temp./(max(max( matrix_temp))))*255);
                elseif Nbits==16
                    I= uint16(~(Green./Green+Red./Red+Blue./Blue)).*uint16(( matrix_temp./(max(max( matrix_temp))))*65535);
                elseif Nbits==32
                    I= uint32(~(Green./Green+Red./Red+Blue./Blue)).*uint32(( matrix_temp./(max(max( matrix_temp))))*2^32);
                end
                try
                    matrix_out = cat(3, Red+I , Green+I, Blue+I );
                end
            end
            
        else
            matrix_out = cat(3, Red , Green , Blue );
        end
    end
end
