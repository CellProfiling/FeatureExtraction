function imgrgb = showrgb(r_img,g_img,b_img,show)
%small helper to display rgb image

if nargin<4
    show = 1;
end

%if not images, load them
if ischar(r_img)
    r_img = imread(r_img);
elseif iscell(r_img)
    r_imgtmp = double(imread(r_img{1}));
    for i = 2:length(r_img)
        r_imgtmp = r_imgtmp+double(imread(r_img{i}));
    end
    r_img = r_imgtmp;
end
if ischar(g_img)
    g_img = imread(g_img);
elseif iscell(g_img)
    g_imgtmp = double(imread(g_img{1}));
    for i = 2:length(g_img)
        g_imgtmp = g_imgtmp+double(imread(g_img{i}));
    end
    g_img = g_imgtmp;
end
if ischar(b_img)
    b_img = imread(b_img);
elseif iscell(b_img)
    b_imgtmp = double(imread(b_img{1}));
    for i = 2:length(b_img)
        b_imgtmp = b_imgtmp+double(imread(b_img{i}));
    end
    b_img = b_imgtmp;
end
%fill missing channels
%missing r
if isempty(r_img)
    if ~isempty(g_img)
        r_img = zeros(size(g_img));
    else
        r_img = zeros(size(b_img));
    end
end
%missing g
if isempty(g_img)
    if ~isempty(r_img)
        g_img = zeros(size(r_img));
    else
        g_img = zeros(size(b_img));
    end
end
%missing b
if isempty(b_img)
    if ~isempty(r_img)
        b_img = zeros(size(r_img));
    else
        b_img = zeros(size(g_img));
    end
end


imgrgb = zeros(size(r_img,1),size(r_img,2),3);

imgrgb(:,:,1) = double(r_img)./max(double(r_img(:)));
imgrgb(:,:,2) = double(g_img)./max(double(g_img(:)));
imgrgb(:,:,3) = double(b_img)./max(double(b_img(:)));
%imgrgb(:,:,3) = double(b_img)./(quantile(double(b_img(:)),0.99));

if show
    imshow(imgrgb,[])
end

if nargout==0
    imgrgb = [];
end