%Change log: 
%2017,08,22     D. Sullivan - added slfnames to this function.


% $$$ [feats1,names1] = features_overlap( tmp_prot, tmp_prot_fg, tmp_nuc_fg, 'nuc');
% $$$ [feats2,names2] = features_overlap( tmp_prot, tmp_prot_fg, tmp_tub_fg, 'tub');
% $$$ [feats3,names3] = features_overlap( tmp_prot, tmp_prot_fg, tmp_er_fg, 'er');
% $$$ 
% $$$ [feats4,names4] = features_overlap( tmp_prot, tmp_prot_large_fg, tmp_nuc_fg, 'nuc_large');
% $$$ [feats5,names5] = features_overlap( tmp_prot, tmp_prot_large_fg, tmp_tub_fg, 'tub_large');
% $$$ [feats6,names6] = features_overlap( tmp_prot, tmp_prot_large_fg, tmp_er_fg, 'er_large');
% $$$ 
% $$$ [feats7,names7] = features_overlap( tmp_prot, tmp_prot_mfg, tmp_nuc_fg, 'nuc_mthr');
% $$$ [feats8,names8] = features_overlap( tmp_prot, tmp_prot_mfg, tmp_tub_fg, 'tub_mthr');
% $$$ [feats9,names9] = features_overlap( tmp_prot, tmp_prot_mfg, tmp_er_fg, 'er_mthr');
% $$$ 
% $$$ [feats10,names10] = features_overlap( tmp_prot, tmp_prot_large_mfg, tmp_nuc_fg, 'nuc_mthr_large');
% $$$ [feats11,names11] = features_overlap( tmp_prot, tmp_prot_large_mfg, tmp_tub_fg, 'tub_mthr_large');
% $$$ [feats12,names12] = features_overlap( tmp_prot, tmp_prot_large_mfg, tmp_er_fg, 'er_mthr_large');


% $$$ if optimize && (protein_channel_blank || nuclear_channel_blank)
% $$$   [feats1,names1] = features_overlap( [], [], [], 'nuc');
% $$$ else
% $$$   [feats1,names1] = features_overlap( tmp_prot, tmp_prot_fg, tmp_nuc_fg, 'nuc');
% $$$ end
% $$$ if optimize && (protein_channel_blank || tubulin_channel_blank)
% $$$   [feats2,names2] = features_overlap( [], [], [], 'tub');
% $$$ else
% $$$   [feats2,names2] = features_overlap( tmp_prot, tmp_prot_fg, tmp_tub_fg, 'tub');
% $$$ end
% $$$ if optimize && (protein_channel_blank || er_channel_blank)
% $$$   [feats3,names3] = features_overlap( [], [], [], 'er');
% $$$ else
% $$$   [feats3,names3] = features_overlap( tmp_prot, tmp_prot_fg, tmp_er_fg, 'er');
% $$$ end


% Use empty arrays as indices for optimization in the case of blank
% channels:
condition1 = ~(optimize && (protein_channel_blank || nuclear_channel_blank));
condition2 = ~(optimize && (protein_channel_blank || tubulin_channel_blank));
condition3 = ~(optimize && (protein_channel_blank || er_channel_blank));
c1r = 1:size(tmp_prot, 1)*condition1;
c1c = 1:size(tmp_prot, 2)*condition1;
c2r = 1:size(tmp_prot, 1)*condition2;
c2c = 1:size(tmp_prot, 2)*condition2;
c3r = 1:size(tmp_prot, 1)*condition3;
c3c = 1:size(tmp_prot, 2)*condition3;
[feats1,names1,slfnames1] = features_overlap( tmp_prot(c1r, c1c), tmp_prot_fg(c1r, c1c), tmp_nuc_fg(c1r, c1c), 'nuc');
[feats2,names2,slfnames2] = features_overlap( tmp_prot(c2r, c2c), tmp_prot_fg(c2r, c2c), tmp_tub_fg(c2r, c2c), 'tub');
[feats3,names3,slfnames3] = features_overlap( tmp_prot(c3r, c3c), tmp_prot_fg(c3r, c3c), tmp_er_fg(c3r, c3c), 'er');

[feats4,names4,slfnames4] = features_overlap( tmp_prot(c1r, c1c), tmp_prot_large_fg(c1r, c1c), tmp_nuc_fg(c1r, c1c), 'nuc_large');
slfnames4 = cellfun(@(x) [x,'.2'],slfnames4,'UniformOutput',false);
[feats5,names5,slfnames5] = features_overlap( tmp_prot(c2r, c2c), tmp_prot_large_fg(c2r, c2c), tmp_tub_fg(c2r, c2c), 'tub_large');
slfnames5 = cellfun(@(x) [x,'.2'],slfnames5,'UniformOutput',false);
[feats6,names6,slfnames6] = features_overlap( tmp_prot(c3r, c3c), tmp_prot_large_fg(c3r, c3c), tmp_er_fg(c3r, c3c), 'er_large');
slfnames6 = cellfun(@(x) [x,'.2'],slfnames6,'UniformOutput',false);

[feats7,names7,slfnames7] = features_overlap( tmp_prot(c1r, c1c), tmp_prot_mfg(c1r, c1c), tmp_nuc_fg(c1r, c1c), 'nuc_mthr');
slfnames7 = cellfun(@(x) [x,'.3'],slfnames7,'UniformOutput',false);
[feats8,names8,slfnames8] = features_overlap( tmp_prot(c2r, c2c), tmp_prot_mfg(c2r, c2c), tmp_tub_fg(c2r, c2c), 'tub_mthr');
slfnames8 = cellfun(@(x) [x,'.3'],slfnames8,'UniformOutput',false);
[feats9,names9,slfnames9] = features_overlap( tmp_prot(c3r, c3c), tmp_prot_mfg(c3r, c3c), tmp_er_fg(c3r, c3c), 'er_mthr');
slfnames9 = cellfun(@(x) [x,'.3'],slfnames9,'UniformOutput',false);

[feats10,names10,slfnames10] = features_overlap( tmp_prot(c1r, c1c), tmp_prot_large_mfg(c1r, c1c), tmp_nuc_fg(c1r, c1c), 'nuc_mthr_large');
slfnames10 = cellfun(@(x) [x,'.4'],slfnames10,'UniformOutput',false);
[feats11,names11,slfnames11] = features_overlap( tmp_prot(c2r, c2c), tmp_prot_large_mfg(c2r, c2c), tmp_tub_fg(c2r, c2c), 'tub_mthr_large');
slfnames11 = cellfun(@(x) [x,'.4'],slfnames11,'UniformOutput',false);
[feats12,names12,slfnames12] = features_overlap( tmp_prot(c3r, c3c), tmp_prot_large_mfg(c3r, c3c), tmp_er_fg(c3r, c3c), 'er_mthr_large');
slfnames12 = cellfun(@(x) [x,'.4'],slfnames12,'UniformOutput',false);



if optimize && (protein_channel_blank || nuclear_channel_blank)
  feats1(:) = nan;
  feats4(:) = nan;
  feats7(:) = nan;
  feats10(:) = nan;
end
if optimize && (protein_channel_blank || tubulin_channel_blank)
  feats2(:) = nan;
  feats5(:) = nan;
  feats8(:) = nan;
  feats11(:) = nan;
end
if optimize && (protein_channel_blank || er_channel_blank)
  feats3(:) = nan;
  feats6(:) = nan;
  feats9(:) = nan;
  feats12(:) = nan;
end


feats = [feats1 feats2 feats3 feats4 feats5 feats6 feats7 feats8 feats9 feats10 feats11 feats12];
names = [names1 names2 names3 names4 names5 names6 names7 names8 names9 names10 names11 names12];
slfnames = [slfnames1 slfnames2 slfnames3 slfnames4 slfnames5 slfnames6 slfnames7 slfnames8,...
    slfnames9 slfnames10 slfnames11 slfnames12];

tmp_idx = 3:4:length(feats);

feats(tmp_idx(4:end)) = [];
names(tmp_idx(4:end)) = [];
slfnames(tmp_idx(4:end)) = [];
%D. Sullivan 2017,08,22 added actual slfnames to this function
% slfnames = repmat({''},[1 length(names)]);
