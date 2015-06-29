function [r_image] = contrast_stretch(image)
  r_image = (image - min(image(:))) ./ (max(image(:)) - min(image(:)));
  %r_image = (double(image) - min(image(:))) ./ (max(image(:)) - min(image(:)));
