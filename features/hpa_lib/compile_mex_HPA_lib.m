old_dir = pwd;

[pathstr, name, ext] = fileparts(mfilename('fullpath'))

cd(pathstr)
cd HPA_lib/segmentation/watershed
try
    mex watershed_meyer.cpp neighborhood.cpp
catch me
    cd(old_dir)
    rethrow(me)
end

cd(pathstr)
cd HPA_lib/SLICfeatures/source
try
    mex ml_texture.c cvip_pgmtexture.c -I./Include/ -outdir ../matlab/mex/
    mex ml_hitmiss.c -I./Include/ -outdir ../matlab/mex/
    mex ml_moments_1.c -I./Include/ -outdir ../matlab/mex/
    mex ml_Znl.cpp -I./Include/ -outdir ../matlab/mex/
catch me
    cd(old_dir)
    rethrow(me)
end

cd(old_dir)
