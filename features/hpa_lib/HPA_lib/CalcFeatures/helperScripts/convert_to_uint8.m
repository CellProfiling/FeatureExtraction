function outimg = convert_to_uint8(inimg)
%convert_to_uint8 - Helper function that takes an input image and converts
%it to uint8 for use in the production code for the HPA
%
%INPUTS:
%inimg - an input image
%
%OUTPUTS:
%outimg - a converted uint8 version of inimg
%
%Written By: Devin P Sullivan 17,08,2015

%First check that the conversion needs to be done and if not just return.
if ~isa(inimg,'uint8')
    warning('img is not uint8. Converting. This may cause some loss of data')
    outimg = uint8(double(inimg)./double(max(inimg(:))).*255);
else
    outimg = inimg;
end
