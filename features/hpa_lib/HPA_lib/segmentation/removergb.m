function img = removergb(img,channel_select) 

if nargin<2
    channel_select = [];
end

if size(img,3)>1
    
    if isempty(channel_select)
        %find signal channel
        channel_select = logical(squeeze(sum(sum(img,1),2)));
        if sum(channel_select)>1
            error('More than one channel with data and no channel requested');
        end
        img = squeeze(img(:,:,channel_select));
    else
        img = img(:,:,channel_select);
    end
    
end
