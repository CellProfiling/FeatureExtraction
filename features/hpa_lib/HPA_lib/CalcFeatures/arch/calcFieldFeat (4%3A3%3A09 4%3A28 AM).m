function fieldFeatCalc

addpath ./lib/system/
addpath ./lib/features/
addpath ./lib/segmentation/output/
addpath /home/jnewberg/CVS/SLIC
setcvspath('/home/jnewberg/CVS/SLIC/')

fsetnames = {...
    'overlapField', ...
    'nonObjFluorField', ...
    'objField', ...
    'mutualInfo16Field', ...
    'texture64Field', ...
    'texture64x2Field', ...
    'texture64x4Field', ...
    'tasField', ...
    'texture16Field', ...
    'texture32Field', ...
    'texture128Field', ...
    'texture256Field', ...
    'texture16x2Field', ...
    'texture32x2Field', ...
    'texture128x2Field', ...
    'texture256x2Field', ...
    'texture16x4Field', ...
    'texture32x4Field', ...
    'texture64x4Field', ...
    'texture128x4Field', ...
    'texture256x4Field', ...
    'mutualInfo32Field', ...
    'mutualInfo64Field', ...
    'edgeField' ...
};

%     'skelField'... takes toooooo long
% fsetnames = {'overlapField'};


fsetnames = {...
    'overlapField', ...
    'nonObjFluorField', ...
    'objField', ...
    'mutualInfo16Field', ...
    'texture64Field', ...
    'texture64x2Field', ...
    'texture64x4Field', ...
    'tasField' ...
};

fsetnames = {'nonObjFluorField'};


rootdir = '/images/HPA/images/IFconfocal/';
filetype = 'tif';
greparg = ' | grep green';

ind = find(rootdir=='/');
rootdir_ = rootdir;
rootdir_(ind) = '_';

uout = unixfind( rootdir, filetype, greparg);
readlist = listmatlabformat( uout);

uout_nuc = findreplacestring( uout, 'green','blue');
uout_tub = findreplacestring( uout, 'green','red');
uout_er = findreplacestring( uout, 'green','yellow');
readlist_nuc = listmatlabformat( uout_nuc);
readlist_tub = listmatlabformat( uout_tub);
readlist_er = listmatlabformat( uout_er);


for i=1:length(readlist)
    prot = [];
    nuc = [];
    tub = [];
    er = [];
    prot_ds2 = [];
    nuc_ds2 = [];
    tub_ds2 = [];
    er_ds2 = [];
    thr_prot_ds2 = [];
    fg_prot_ds2 = [];
    thr_nuc_ds2 = [];
    fg_nuc_ds2 = [];
    thr_tub_ds2 = [];
    fg_tub_ds2 = [];
    thr_er_ds2 = [];
    fg_er_ds2 = [];
    for zed = 1:length(fsetnames)
        mout = findreplacestring( readlist{i}, '/', '_');
        mout = findreplacestring( mout, '.tif', ['_' fsetnames{zed} '.mat']);
        writepath = findreplacestring( mout, rootdir_, ['./data/features/field/']);
        
        if exist(writepath,'file')
            continue;
        end

        tmpfile = writepath;
        tmpfile(find(tmpfile=='/')) = [];
        tmpfile(find(tmpfile=='.')) = [];
        tmpfile = ['./tmp/' tmpfile '.txt'];

        if exist(tmpfile,'file')
            continue;
        end
        fid = fopen(tmpfile,'w');

        if isempty(prot)
            prot = imread(readlist{i});
            sprot = size(prot);
        end

        % load additional channels
        switch fsetnames{zed}
          case {'mutualInfo16Field','mutualInfo32Field','mutualInfo64Field',...
              'overlapField','objField','nonObjFluorField'}
            if isempty(nuc)
                nuc = imread(readlist_nuc{i});
            end
            if isempty(tub)
                tub = imread(readlist_tub{i});
            end
            if isempty(er)
                er = imread(readlist_er{i});
            end
          otherwise
        end

        % downsample images
        switch fsetnames{zed}
          case {'texture16x2Field','texture32x2Field','texture64x2Field', ...
                'texture128x2Field','texture256x2Field', ...
                'overlapField', 'edgeField','nonObjFluorField',...
                'objField', 'skelField'}
            if isempty(prot_ds2)
                prot_ds2 = imresize(prot,[sprot(1) sprot(2)]/2);
            end
            if isempty(nuc_ds2)
                if ~isempty(nuc)
                    nuc_ds2 = imresize(nuc,[sprot(1) sprot(2)]/2);
                end
            end
            if isempty(tub_ds2)
                if ~isempty(tub)
                    tub_ds2 = imresize(tub,[sprot(1) sprot(2)]/2);
                end
            end
            if isempty(er_ds2)
                if ~isempty(er)
                    er_ds2 = imresize(er,[sprot(1) sprot(2)]/2);
                end
            end
          otherwise
        end

        % threshold images
        switch fsetnames{zed}
          case {'overlapField', 'edgeField','nonObjFluorField',...
                'objField', 'skelField'}
            if isempty(thr_prot_ds2)
                if ~isempty(prot_ds2)
                    thr_prot_ds2 = graythresh(prot_ds2(prot_ds2>0))*255;
                    fg_prot_ds2 = prot_ds2;
                    fg_prot_ds2(prot_ds2<=thr_prot_ds2) = 0;
                end
            end
          otherwise
        end
        
        % threshold other channels
        switch fsetnames{zed}
          case {'objField','nonObjFluorField'}
            if isempty(thr_nuc_ds2)
                if ~isempty(nuc_ds2)
                    thr_nuc_ds2 = graythresh(nuc_ds2(nuc_ds2>0))*255;
                    fg_nuc_ds2 = nuc_ds2;
                    fg_nuc_ds2(nuc_ds2<=thr_nuc_ds2) = 0;
                end
            end
            if isempty(thr_tub_ds2)
                if ~isempty(tub_ds2)
                    thr_tub_ds2 = graythresh(tub_ds2(tub_ds2>0))*255;
                    fg_tub_ds2 = tub_ds2;
                    fg_tub_ds2(tub_ds2<=thr_tub_ds2) = 0;
                end
            end
            if isempty(thr_er_ds2)
                if ~isempty(er_ds2)
                    thr_er_ds2 = graythresh(er_ds2(er_ds2>0))*255;
                    fg_er_ds2 = er_ds2;
                    fg_er_ds2(er_ds2<=thr_er_ds2) = 0;
                end
            end
          otherwise
        end



        switch fsetnames{zed}
          case 'tasField'
            [names, feats, slfnames] = ml_tas( prot,0);

          case 'tasx2Field'
            [names, feats, slfnames] = ml_tas( prot_ds2,0);
            
          case {'mutualInfo16Field','mutualInfo32Field','mutualInfo64Field'}
            nuc = loadChannel( readlist_nuc{i}, nuc);
            tub = loadChannel( readlist_tub{i}, nuc);
            er = loadChannel( readlist_er{i}, nuc);
            
            NBINS = str2double( fsetnames{zed}(end-6:end-5));
            NBINS(2) = NBINS(1);

            prot_re = reshape(prot,[sprot(1)*sprot(2) 1]);
            nuc_re = reshape(nuc,[sprot(1)*sprot(2) 1]);
            tub_re = reshape(tub,[sprot(1)*sprot(2) 1]);
            er_re = reshape(er,[sprot(1)*sprot(2) 1]);

            feats1 = mutualinformation( [prot_re nuc_re], NBINS);
            feats2 = mutualinformation( [prot_re tub_re], NBINS);
            feats3 = mutualinformation( [prot_re er_re], NBINS);

            feats1(1,2) = corr2( prot_re, nuc_re);
            feats2(1,2) = corr2( prot_re, tub_re);
            feats3(1,2) = corr2( prot_re, er_re);

            feats = [feats1 feats2 feats3];
            str = [ '_' num2str(NBINS(1)) '_graylevels'];
            names = {['nuc:mutual_information' str],['nuc:correlation' str], ...
                ['tub:mutual_information' str],['tub:correlation' str], ...
                ['er:mutual_information' str],['er:correlation' str]};
            slfnames = repmat({''},[1 length(names)]);
            
          case {'texture16Field','texture32Field','texture64Field', ...
                'texture128Field','texture256Field'}
            GLEVELS = str2double( fsetnames{zed}(end-7:end-5));
            if isnan(GLEVELS)
                GLEVELS = str2double( fsetnames{zed}(end-6:end-5));
            end
            [feats,names,slfnames] = features_texture( prot, GLEVELS);
            
          case {'texture16x2Field','texture32x2Field','texture64x2Field', ...
                'texture128x2Field','texture256x2Field'}
            GLEVELS = str2double( fsetnames{zed}(end-9:end-7));
            if isnan(GLEVELS)
                GLEVELS = str2double( fsetnames{zed}(end-8:end-7));
            end
            [feats,names,slfnames] = features_texture( prot_ds2, GLEVELS);
            
            for m=1:length(names)
                names{m} = [names{m} '_2x_downsampled'];
            end

          case {'texture16x4Field','texture32x4Field','texture64x4Field', ...
                'texture128x4Field','texture256x4Field'}
            GLEVELS = str2double( fsetnames{zed}(end-9:end-7));
            if isnan(GLEVELS)
                GLEVELS = str2double( fsetnames{zed}(end-8:end-7));
            end
            prot_ds4 = imresize(prot, [sprot(1) sprot(2)]);
            [feats,names,slfnames] = features_texture( prot_ds4, GLEVELS);
            
            for m=1:length(names)
                names{m} = [names{m} '_4x_downsampled'];
            end
            
          case 'overlapField'
            nuc = loadChannel( readlist_nuc{i}, nuc);
            tub = loadChannel( readlist_tub{i}, nuc);
            er = loadChannel( readlist_er{i}, nuc);

            [feats1,names1] = features_overlap( prot_ds2, nuc_ds2, 'nuc');
            [feats2,names2] = features_overlap( prot_ds2, tub_ds2, 'tub');
            [feats3,names3] = features_overlap( prot_ds2, er_ds2, 'er');

            feats = [feats1 feats2 feats3];
            names = [names1 names2 names3];
            slfnames = repmat({''},[1 length(names)]);
            
          case 'edgeField'
            [names,feats,slfnames] = ml_imgedgefeatures( double(fg_prot_ds2));
            
          case 'nonObjFluorField'
            nuc = loadChannel( readlist_nuc{i}, nuc);
            tub = loadChannel( readlist_tub{i}, nuc);
            er = loadChannel( readlist_er{i}, nuc);

            prot_int = sum(fg_prot_ds2(:));
            bg_prot_ds2 = prot_ds2;
            bg_prot_ds2(prot_ds2>thr_prot_ds2) = 0;
            bg_int = sum(bg_prot_ds2(:));
            bg_prot_fg_nuc_int = bg_prot_ds2;
            bg_prot_fg_nuc_int(fg_nuc_ds2==0) = 0;
            bg_prot_fg_tub_int = bg_prot_ds2;
            bg_prot_fg_tub_int(fg_tub_ds2==0) = 0;
            bg_prot_fg_er_int = bg_prot_ds2;
            bg_prot_fg_er_int(fg_er_ds2==0) = 0;

            feats = zeros(1,4);
            feats(1) = bg_int / (prot_int + bg_int);
            feats(2) = sum(bg_prot_fg_nuc_int(:)) / sum(fg_nuc_ds2(:));
            feats(3) = sum(bg_prot_fg_tub_int(:)) / sum(fg_tub_ds2(:));
            feats(4) = sum(bg_prot_fg_er_int(:)) / sum(fg_er_ds2(:));

            names = {'non_object_fluorescence', ...
                'nuc:non_object_fluorescence_int_to_nuc_fg_int', 'tub:non_object_fluorescence_int_to_tub_fg_int', 'er:non_object_fluorescence_int_to_er_fg_int'};
            slfnames = {'7.79','','',''};
            
          case 'objField'
            nuc = loadChannel( readlist_nuc{i}, nuc);
            tub = loadChannel( readlist_tub{i}, nuc);
            er = loadChannel( readlist_er{i}, nuc);

            bwl = bwlabel(fg_prot_ds2>0,8);
            bwl_nuc = bwlabel(fg_nuc_ds2>0,8);
            bwl_tub = bwlabel(fg_tub_ds2>0,8);
            bwl_er = bwlabel(fg_er_ds2>0,8);
            
            props = regionprops(bwl,'Area');
            stats = zeros(length(props),1);
            for j = 1:length(props)
                stats(j,:) = props(j).Area;
            end
            stats(stats<3) = [];
            
            feats = zeros(1,6);
            feats(1) = mean(stats);
            feats(2) = var(stats);
            feats(3) = max(stats)/min(stats);
            feats(4) = length(stats)/max(bwl_nuc(:));
            feats(5) = length(stats)/max(bwl_tub(:));
            feats(6) = length(stats)/max(bwl_er(:));
            
            names = {'Avg. # pixels per obj.','Var. of # pixels per obj.','Ratio of size of largest obj. to smallest', ...
                'nuc: # prot objs to nuc objs', 'tub: # prot objs to tub objs', 'er: # prot objs to er objs'};
            slfnames = {'SLF1.3','SLF1.4','SLF1.5', '', '', ''};
                        
          case 'skelField'
            imageproc = double(fg_prot_ds2);
            imageproc = imageproc / max(imageproc(:));
            [names,feats,slfnames] = ml_imgskelfeats( imageproc);
            
          otherwise
            error('improper feature set specified');
        end
        impath = readlist{i};

        % saving results
        save( writepath,'feats','names','slfnames','impath');

        fclose(fid);
        delete(tmpfile);
    end
end

return


% The image loading helper function
function img = loadChannel( impath, img)

if isempty(img)
    img = imread(impath);
end

return


