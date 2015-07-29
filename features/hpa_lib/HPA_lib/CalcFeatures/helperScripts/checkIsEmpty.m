function emptyflag = checkIsEmpty(img,quant_thresh)
%This function checks if the image is all zeros, or nearly all zeros 
%
%INPUTS: 
%img - an image (any bit-depth and dimension)
%
%OUTPUTS:
%isempty - logical flag stating if the image is empty
%
%Created by: Devin P Sullivan 28,07,2015

if nargin<2 || isempty(quant_thresh)
    disp('No quantile threshold given for checkIsEmpty, using default 0.999')
    quant_thresh = 0.999;
end

emptyflag = (quantile(img(:),quant_thresh)==0);