function [xrange,yrange,partial] = checkPartialScan(img)
%
%INPUTS:
%img - 2D image matrix 
%
%OUTPUTS:
%newim - 2D image matrix where blank columns and rows have been eliminated
%
%
%Written by: Devin P Sullivan 07,08,2015


partial = 0;

%make sure that the nuclear channel is fully scanned. If not, trim the
%image to the last scanned line. Note this may be verticle or horizontal
%depending on the microscope, but generally should be horizontal.
nucx = sum(img,1);
nucy = sum(img,2);
xrange = nucx>0;
yrange = nucy>0;
xstart = find(xrange,1,'first');
if xstart~=1
%    warning('no fluorescence in beginning of x image. Skipping to second column with fluorescence.')
    %here we use the 2nd column instead of the first since there was an
    %error in acquisition and we want to be sure to eliminate the last
    %incorrectly scanned one.
    xstart = xstart+1;
    partial = 1;
end

xend = find(xrange,1,'last');
if xend~=size(img,2)
%     warning('no fluorescence in end of x image. Skipping to second to last column with fluorescence.')
    %here we use the 2nd to last column instead of the first since there was an
    %error in acquisition and we want to be sure to eliminate the last
    %incorrectly scanned one.
    xend = xend-1;
    partial = 1;
end
ystart = find(yrange,1,'first');
if ystart~=1
%     warning('no fluorescence in beginning of y image. Skipping to second column with fluorescence.')
    %here we use the 2nd column instead of the first since there was an
    %error in acquisition and we want to be sure to eliminate the last
    %incorrectly scanned one.
    ystart = ystart+1;
    partial = 1;
end

yend = find(yrange,1,'last');
if yend~=size(img,1)
%     warning('no fluorescence in end of y image. Skipping to second to last column with fluorescence.')
    %here we use the 2nd to last column instead of the first since there was an
    %error in acquisition and we want to be sure to eliminate the last
    %incorrectly scanned one.
    yend = yend-1;
    partial = 1;
end

xrange = [xstart,xend];
yrange = [ystart,yend];
%newim = img(ystart:yend,xstart:xend);
