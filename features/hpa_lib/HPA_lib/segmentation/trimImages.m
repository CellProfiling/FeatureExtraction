function [newimgdir] = trimImages(imagedir,namingconvention,outputdir)
%This function checks that each channel has been scanned properly all the
%way. If one channel has not, it throws a warning and then trims all the
%channels to the smallest scanned area. 
%
%INPUTS:
%imagedir - string pointing to the directory where images are
%namingconvention - struct containing the following fields
%   nuclear_channel - suffix for nuclear channel e.g. '_blue.tif'
%   protein_channel - suffix for protein channel e.g. '_green.tif'
%   tubulin_channel - suffix for tubulin channel e.g. '_red.tif'
%   er_channel - suffix for er channel e.g. '_yellow.tif'
%outputdir - string pointing to where results should be saved. 
%OUTPUTS:
%
%Written by: Devin P Sullivan 07,08,2015


%This will be changed back to the original directory if we don't need to
%trim the images to avoid costly file io - ACTUALLY, I think we will just
%take the hit here and copy all the files to the new directory. This is the
%cleanest way I can think to do this right now. I know this is a
%significant performance hit for a rather rare issue, but otherwise we need
%to replace all our original images - ASK EMMA about this. 
newimgdir = [outputdir,filesep,'trimmedimgs'];

if ~isdir(newimgdir)
    mkdir(newimgdir)
end

%first get all the paths 
nucpath = [imagedir,filesep,'*',namingconvention.pattern,'*',namingconvention.nuclear_channel,'*'];
nucfiles = ml_ls(nucpath);
protpath = [imagedir,filesep,'*',namingconvention.pattern,'*',namingconvention.protein_channel,'*']; 
protfiles = ml_ls(protpath);
mtpath = [imagedir,filesep,'*',namingconvention.pattern,'*',namingconvention.tubulin_channel,'*']; 
mtfiles = ml_ls(mtpath);
erpath = [imagedir,'*',namingconvention.er_channel,'*']; 
erfiles = ml_ls(erpath);

if any(strcmpi(namingconvention.blank_channels,'nuc'))
    error('The nuclear channel cannot be blank as it is needed for segmentation!')
end

%Go through all the files and check if any are partially scanned
for i = 1:length(nucfiles)
    %load images
   nucim = imread(nucfiles{i}); 
   protim = imread(protfiles{i});
   mtim = imread(mtfiles{i});
   erim = imread(erfiles{i});
   
   %Check if any are totally empty
   %Nuc
%    if sum(nucim(:))==0
   if quantile(nucim(:),0.999)==0
       error(['There is no fluorescence in the nuclear channel for image ',nucfiles{i},'. This is currently required for segmentation.'])
   end
   %Prot
   if quantile(protim(:),0.999)==0
       warning(['There is no fluorescence in the protein channel for image ',protfiles{i},'. There will be NaNs in some feature values.'])
%        namingconvention.blank_channels = [namingconvention.blank_channels,{'protein'}];
   end
   %Tubulin
   if quantile(mtim(:),0.999)==0
       warning(['There is no fluorescence in the tubulin channel for image ',mtfiles{i},'. There will be NaNs in some feature values.'])
%        namingconvention.blank_channels = [namingconvention.blank_channels,{'tubulin'}];
   end
   %ER
   if quantile(erim(:),0.999)==0
       warning(['There is no fluorescence in the er channel for image ',erfiles{i},'. There will be NaNs in some feature values.'])
%        namingconvention.blank_channels = [namingconvention.blank_channels,{'er'}];
   end
   
   %Next check if any of the channels have partial scans
   %Nuc 
   [xrangenuc,yrangenuc,partialnuc] = checkPartialScan(nucim);
   %Prot 
   [xrangeprot,yrangeprot,partialprot] = checkPartialScan(protim);
   %MT
   [xrangemt,yrangemt,partialmt] = checkPartialScan(mtim);
   %ER
   [xrangeer,yrangeer,partialer] = checkPartialScan(erim);
   
   %Find the smallest dimensions where we have fluorescence 
   xstart = max([min(xrangenuc),min(xrangeprot),min(xrangemt),min(xrangeer)]);
   xend = min([max(xrangenuc),max(xrangeprot),max(xrangemt),max(xrangeer)]);
   ystart = max([min(yrangenuc),min(yrangeprot),min(yrangemt),min(yrangeer)]);
   yend = min([max(yrangenuc),max(yrangeprot),max(yrangemt),max(yrangeer)]);


   %If our start or end is not the full image, make new images and save
   %them somewhere
   if (xstart || ystart)>1 || xend<size(nucim,1) || yend<size(nucim,2)
       newnucim = nucim(ystart:yend,xstart:xend);
       newprotim = nucim(ystart:yend,xstart:xend);
       newmtim = nucim(ystart:yend,xstart:xend);
       newerim = nucim(ystart:yend,xstart:xend);
       
       %Nuc
       [oldpath,nucname,ext] = fileparts(nucfiles{i});
       imwrite(newnucim,[newimgdir,filesep,nucname,ext])
       %Prot
       [oldpath,protname,ext] = fileparts(protfiles{i});
       imwrite(newprotim,[newimgdir,filesep,protname,ext])
       %MT
       [oldpath,mtname,ext] = fileparts(mtfiles{i});
       imwrite(newmtim,[newimgdir,filesep,mtname,ext])
       %ER
       [oldpath,ername,ext] = fileparts(erfiles{i});
       imwrite(newerim,[newimgdir,filesep,ername,ext])
       
   end
   
   
end

newfiles = dir(fullfile([newimgdir,filesep,'*.tif']));
%This if statement protects against copying everything if we didn't have to
%trim any files.
if ~isempty(newfiles)
    %We should really be copying the trimmed back to the original, but I don't
    %want to overwrite the original files
    %copy all the original images without overwriting the new trimmed ones.
    system(['cp -n ',imagedir,' ',newimgdir])
else
    newimgdir = imagedir;
end


