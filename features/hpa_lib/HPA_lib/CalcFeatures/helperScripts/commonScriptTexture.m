%Change log: 
%2017 08,22     D. Sullivan - added actual slf names


if optimize && protein_channel_blank
% $$$   prot = uint8(zeros(2, 2));
else
prot = single(prot);
prot = uint8(round((prot-min(min(prot)))/(max(max(prot))-min(min(prot)))*255));
% $$$ end
%keyboard
prot_8 = prot*(7/255);
prot_16 = prot*(15/255);
prot_32 = prot*(31/255);
prot_64 = prot*(64/255);
prot_128 = prot*(127/255);

feat_8 = ml_texture( prot_8);
feat_8 = [mean(feat_8(1:13,[1 3]),2); mean(feat_8(1:13,[2 4]),2)]';

feat_16 = ml_texture( prot_16);
feat_16 = [mean(feat_16(1:13,[1 3]),2); mean(feat_16(1:13,[2 4]),2)]';

feat_32 = ml_texture( prot_32);
feat_32 = [mean(feat_32(1:13,[1 3]),2); mean(feat_32(1:13,[2 4]),2)]';

feat_64 = ml_texture( prot_64);
feat_64 = [mean(feat_64(1:13,[1 3]),2); mean(feat_64(1:13,[2 4]),2)]';

feat_128 = ml_texture( prot_128);
feat_128 = [mean(feat_128(1:13,[1 3]),2); mean(feat_128(1:13,[2 4]),2)]';

feat_256 = ml_texture( prot);
feat_256 = [mean(feat_256(1:13,[1 3]),2); mean(feat_256(1:13,[2 4]),2)]';

feats = [feat_8 feat_16 feat_32 feat_64 feat_128 feat_256];

% $$$ if optimize && protein_channel_blank
% $$$   feats(:) = nan;
end

tmp_names = {'Angular second moment','Contrast','Correlation', ...
    'Sum of squares','Inverse difference moment','Sum average', ...
    'Sum variance','Sum entropy','Entropy','Difference variance', ...
    'Difference entropy','Information measure of correlation 1', ...
    'Information measure of correlation 2', ...
    'Angular second moment (diagonal)','Contrast (diagonal)', ...
    'Correlation (diagonal)', 'Sum of squares (diagonal)', ...
    'Inverse difference moment (diagonal)','Sum average (diagonal)', ...
    'Sum variance (diagonal)','Sum entropy (diagonal)', ...
    'Entropy (diagonal)','Difference variance (diagonal)', ...
    'Difference entropy (diagonal)', ...
    'Information measure of correlation 1 (diagonal)', ...
    'Information measure of correlation 2 (diagonal)' ...
    };

GLEVELS = [8 16 32 64 128 256];

names = repmat(tmp_names,[ 1 length(GLEVELS)]);

%D. Sullivan 2017 08,22 - added actual slf names. Moved above to rep-mat the slfnames and match them to the 'names' variable 
% slfnames = repmat({''},[1 length(names)]);
slfnames = {'SLF3.66','SLF3.67','SLF3.68', ...
    'SLF3.69','SLF3.70','SLF3.71', ...
    'SLF3.72','SLF3.73','SLF3.74','SLF3.75', ...
    'SLF3.76','SLF3.77', ...
    'SLF3.78', ...
    'SLF3.66.2diagonal','SLF3.67.2diagonal', ...
    'SLF3.68.2diagonal', 'SLF3.69.2diagonal', ...
    'SLF3.70.2diagonal','SLF3.71.2diagonal', ...
    'SLF3.72.2diagonal','SLF3.73.2diagonal', ...
    'SLF3.74.2diagonal','SLF3.75.2diagonal', ...
    'SLF3.76.2diagonal', ...
    'SLF3.77.2diagonal', ...
    'SLF3.78.2diagonal' ...
    };
slfnames = repmat(slfnames,[1 length(GLEVELS)]);

for tmp_i=1:length(GLEVELS)
    for tmp_j=1:length(tmp_names)
        st = (tmp_i-1)*length(tmp_names);
        names{st+tmp_j} = [names{st+tmp_j} '_' num2str(GLEVELS(tmp_i))]; 
        slfnames{st+tmp_j} = [slfnames{st+tmp_j} '_' num2str(GLEVELS(tmp_i))];
    end
end

if optimize && protein_channel_blank
  feats = nan(1, length(names));
end
