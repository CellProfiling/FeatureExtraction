function imgrgb = showrgb(r_img,g_img,b_img)
%small helper to display rgb image

%if not images, load them
if isstr(r_img)
    r_img = imread(r_img);
end
if isstr(g_img)
    g_img = imread(g_img);
end
if isstr(b_img)
    b_img = imread(b_img);
end

imgrgb = zeros(size(r_img,1),size(r_img,2),3);

imgrgb(:,:,1) = double(r_img)./max(double(r_img(:)));
imgrgb(:,:,2) = double(g_img)./max(double(r_img(:)));
imgrgb(:,:,3) = double(b_img)./max(double(r_img(:)));

imshow(imgrgb,[])