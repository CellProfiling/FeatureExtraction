function [feats,names,slfnames] = commonScriptIntensityStats(protstruct,tubstruct,erstruct,nucstruct,maskstruct)
%D. Sullivan - modified this from the feature for total protein intensity

fsetname = 'IntensityStats:'

%%%
%initialize total intensity stats
totintfeats = zeros(1, 4);
%Compute features
totintfeats(1) = sum(protstruct.channel(:));
totintfeats(2) = sum(tubstruct.channel(:));
totintfeats(3) = sum(erstruct.channel(:));
totintfeats(4) = sum(nucstruct.channel(:));

%Remove this check. If blank it should return a 0. 
% if optimize && protein_channel_blank
%   feats(:) = nan;
% end
totintnames = {...
  [fsetname,'prot(green) total intensity'],...
  [fsetname,'tub(red) total intensity'],...
  [fsetname,'er(yellow) total intensity'],...
  [fsetname,'nuc(blue) total intensity']...
        };
%%%
   
%%%
%Do average int feats
avintfeats = zeros(1,4);
avintfeats(1) = totintfeats(1)./sum(maskstruct.channel(:));
avintfeats(2) = totintfeats(2)./sum(maskstruct.channel(:));
avintfeats(3) = totintfeats(3)./sum(maskstruct.channel(:));
avintfeats(4) = totintfeats(4)./sum(maskstruct.channel(:));

avintnames = {...
    [fsetname,'prot(green) av intensity'],...
    [fsetname,'tub(red) av intensity'],...
    [fsetname,'er(yellow) av intensity'],...
    [fsetname,'nuc(blue) av intensity']...
    };

%concatenate our features
feats = [totintfeats,avintfeats];
names = [totintnames,avintnames];
    
slfnames = repmat({''}, 1, length(feats));
