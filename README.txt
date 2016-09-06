This is the readme document for the Human Protein Atlas project production feature repository.

Major revision history: 
v0.1 - 2015 Elton Rexhepaj, Taraz Buck et al. 
v1.0 - 2016 Devin P. Sullivan: Fixed major bugs including; feature overwriting, datatype conversion, feature name uniqueness.
v2.0 - 06,Sept,2016 Devin P. Sullivan: Implemented full active contour segmentation for nuclei. Prevents merging of nuclei when crowded. 

General Use:
infolder='/path/to/folder/with/imgs/';
outfolder='/path/to/save/results/';
resolution=0.08;%for the production 63x images.(microns/pixel)
spcolor='yellow';%for production. other datasets may use different naming convention for segmentation channel.
[cell_feat, exit_code] = process_img(infolder,outfolder,resolution, spcolor, [],[],[],[],[1,1,1]); 


Outputs:
This saves a features.csv file and a segmentation.png file for each image in the folder. 
