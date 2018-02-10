function [nucfiles, skipimage] = preprocessImages(imagedir,namingconvention,outputdir)
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
%
%Edited by:
%D. P. Sullivan 08,02,2018 - major refactor to allow flexible channels
%structure. this also gets rid of some of the copy-pasta nature of the code

nucseg_val = 1;% - this is a fixed parameter indicating as part of the channels update 08,02,2018
numchannels = size(namingconvention.channels,1);
%This is the quantile used to check if a channel is blank. In the future it
%could be useful to have it adjusted per-channel
blank_quantile = repmat(0.999,numchannels,1);

%This will be changed back to the original directory if we don't need to
%trim the images to avoid costly file io - ACTUALLY, I think we will just
%take the hit here and copy all the files to the new directory. This is the
%cleanest way I can think to do this right now. I know this is a
%significant performance hit for a rather rare issue, but otherwise we need
%to replace all our original images - ASK EMMA about this.
newimgdir = [outputdir,filesep,'failedimages'];

if ~isdir(newimgdir)
    mkdir(newimgdir)
end


nucseg_inds = cell2mat(cellfun(@(x) ~isempty(x)&&x==nucseg_val,namingconvention.channels(:,2),'UniformOutput',0));
%DPS 08/10/15 - As a result of talking with Emma, we will not trim images
%but rather throw them out or mark them as follows.
%Create an index of images skipped.
%Also code if we have a partial scan using the number 2
%If any column is labeled as blank use NaN
currpath = [imagedir,'*',namingconvention.pattern,'*',namingconvention.channels{nucseg_inds,1},'*'];
nucfiles = ml_ls(currpath);

skipimage = sparse(length(nucfiles),numchannels);

for currchannel = 1:numchannels
    %first get all the paths
    % nucpath = [imagedir,filesep,'*',namingconvention.pattern,'*',namingconvention.nuclear_channel,'*'];
    currpath = [imagedir,'*',namingconvention.pattern,'*',namingconvention.channels{currchannel,1},'*'];
    currfiles = ml_ls(currpath);
    
    if any(namingconvention.blank_channels.*nucseg_inds)
        error('The nuclear segmentation channel cannot be blank as it is needed for segmentation!')
    end
    
    %DPS 11/08/15 - adding return for if no images are found in the folder
    %DPS 08/02/18 - now using paired structure to determine which channel is
    %used in what segmenations, 0/empty=none, 1=nucleus, 2=cell
    if isempty(currfiles) && ~namingconvention.blank_channels(currchannel)
        warning(['No images found with the specified naming convention for the directory ',imagedir])
        skipimage = inf;
        return
    end
    
    %Go through all the files and check if any are partially scanned
    for i = 1:length(currfiles)
        %load image
        currim = readmyimg(currfiles{i},namingconvention.channels{currchannel,2},namingconvention);
        
        %check if rgb - some of the old images are stored as rgb instead of
        %grey
        currim = removergb(currim);
        
        %Check if any are totally empty
        if quantile(currim(:),blank_quantile(currchannel))==0
            warning(['There is no fluorescence in the ',...
                namingconvention.channels{currchannel,1},' channel for image ',currfiles{i},'. There will be NaNs in some feature values.'])
            skipimage(i,currchannel) = 1;
        end
        
        %Next check if any of the channels have partial scans
        %xrange and yrange can be used for trimming in the future
        [xrangeim,yrangeim,partialim] = checkPartialScan(currim);
        if partialim && ~skipimage(i,1)
            skipimage(i,currchannel) = 2;
        end
        
        %DPS 10/08/2015 - After talking to Emma, we decided to just discard
        %partially scanned images rather than trim them.
        %    %Find the smallest dimensions where we have fluorescence
        %    xstart = max([min(xrangenuc),min(xrangeprot),min(xrangemt),min(xrangeer)]);
        %    xend = min([max(xrangenuc),max(xrangeprot),max(xrangemt),max(xrangeer)]);
        %    ystart = max([min(yrangenuc),min(yrangeprot),min(yrangemt),min(yrangeer)]);
        %    yend = min([max(yrangenuc),max(yrangeprot),max(yrangemt),max(yrangeer)]);
        %
        %
        %    %If our start or end is not the full image, make new images and save
        %    %them somewhere
        %    if (xstart || ystart)>1 || xend<size(nucim,1) || yend<size(nucim,2)
        %        newnucim = nucim(ystart:yend,xstart:xend);
        %        newprotim = nucim(ystart:yend,xstart:xend);
        %        newmtim = nucim(ystart:yend,xstart:xend);
        %        newerim = nucim(ystart:yend,xstart:xend);
        %
        %        %Nuc
        %        [oldpath,nucname,ext] = fileparts(nucfiles{i});
        %        imwrite(newnucim,[newimgdir,filesep,nucname,ext])
        %        %Prot
        %        [oldpath,protname,ext] = fileparts(protfiles{i});
        %        imwrite(newprotim,[newimgdir,filesep,protname,ext])
        %        %MT
        %        [oldpath,mtname,ext] = fileparts(mtfiles{i});
        %        imwrite(newmtim,[newimgdir,filesep,mtname,ext])
        %        %ER
        %        [oldpath,ername,ext] = fileparts(erfiles{i});
        %        imwrite(newerim,[newimgdir,filesep,ername,ext])
        %
        %    end
        
        
    end
    
    %DPS 10/08/15 - Since we are no longer trimming images, this is
    %unnecessary.
    % newfiles = dir(fullfile([newimgdir,filesep,'*.tif']));
    %This if statement protects against copying everything if we didn't have to
    %trim any files.
    % if ~isempty(newfiles)
    %     %We should really be copying the trimmed back to the original, but I don't
    %     %want to overwrite the original files
    %     %copy all the original images without overwriting the new trimmed ones.
    %     system(['cp -n ',imagedir,' ',newimgdir])
    % else
    %     newimgdir = imagedir;
    % end
end

end

function myimg = readmyimg(imgpath,seg_channel,namingconvention,imgsize)

%[~,filepath,ext] = fileparts(imgpath);
if nargin<2 || isempty(seg_channel)
    seg_channel = 0;
end
if nargin<4 || isempty(imgsize)
    imgsize = [2048, 2048];
end

if any(strcmpi(namingconvention.blank_channels,seg_channel))
    if seg_channel==1
        error('Blank channel requested for nuclear segmentation. The current code does not support blank nuclear channels.');
    end
    %         skipimage(i,1) = NaN;
    myimg = nan(imgsize);
else
    myimg = ml_readimage(imgpath);
    
end

end

