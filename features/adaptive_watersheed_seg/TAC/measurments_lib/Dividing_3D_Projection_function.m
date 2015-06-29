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
function Dividing_3D_Projection_function(handles,n,D1,D2,Vs) %5
[Data,~,start_ii]=Get_Dividing_stack(handles,n,D1,D2,Vs) ;
max_x=0;
max_y=0;

for ii=1:size(Data,2)
    if max_x<size(Data(ii).cdata,1)
        max_x=size(Data(ii).cdata,1);
    end
    if max_y<size(Data(ii).cdata,2)
        max_y=size(Data(ii).cdata,2);
    end
end
D=zeros(max_x,max_y,ii);
for ii=1:size(Data,2)
    D(end-size(Data(ii).cdata,1)+1:end, end-size(Data(ii).cdata,2)+1:end,ii)=Data(ii).cdata(:,:) ;
end


choice = questdlg('Please select 3D visualization tool:', ...
    'Visualize 3D', ...
    'Matlab vol3d','Fiji 3D viewer','Fiji 3D tool');
switch choice
    case 'Matlab vol3d'
        figure;
        h = vol3d_TACWrapper('cdata',D ,'texture','3D');
        vol3d_TACWrapper(h);
        axis tight; daspect([1 1 1]);
        alphamap('increase');
        alphamap(0.3 .* alphamap);
        colormap jet(64);
        set(gca,'XDir','normal');
        set(gca,'YDir','normal');
        set(gcf,'color','black');
        axis off;
    case 'Fiji 3D viewer'
        if ~IsJava3DInstalled(true)
            return
        end
        % This code was copied from - Hardware accelerated 3D viewer for MATLAB by Jean-Yves Tinevez (updated Updated 13 Aug 2011)
        % http://www.mathworks.com/matlabcentral/fileexchange/32344-hardware-accelerated-3d-viewer-for-matlab
        D=double(D);
        D=uint8(255*(D./max(max(max(D)))));
        try
            addpath('C:\Program Files\Fiji.app\scripts')
        end
        try
            I = squeeze(D);
            [R, G, B] = ind2rgb(I,jet(256));
            R  = uint8(255 * R);
            G  = uint8(255 * G);
            B  = uint8(255 * B);
            J = cat(4, R,G,B);
            Miji(false)
            imp = MIJ.createColor('MRI data', J, false);
            calibration = ij.measure.Calibration();
            calibration.pixelDepth = 2.5;
            imp.setCalibration(calibration);
            universe = ij3d.Image3DUniverse();
            universe.show();
            c = universe.addVoltex(imp);
        end % Hardware accelerated 3D viewer for MATLAB code ends here.
end
