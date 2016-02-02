function [feats,names,slfnames] = commonScriptlIntensity(protstruct,tubstruct,erstruct,nucstruct)
%D. Sullivan - modified this from the feature for total protein intensity

%initialize
feats = zeros(1, 4);
%Compute features
feats(1) = sum(protstruct.channel(:));
feats(2) = sum(tubstruct.channel(:));
feats(3) = sum(erstruct.channel(:));
feats(4) = sum(nucstruct.channel(:));

%Remove this check. If blank it should return a 0. 
% if optimize && protein_channel_blank
%   feats(:) = nan;
% end
names = {...
  'TotalIntensity:prot(green) total intensity'...
  'TotalIntensity:tub(red) total intensity'...
  'TotalIntensity:er(yellow) total intensity'...
  'TotalIntensity:nuc(blue) total intensity'...
        };

slfnames = repmat({''}, 1, length(feats));
