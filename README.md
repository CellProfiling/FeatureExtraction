HPA Cell Atlas Production Feature Extraction
===============================

This code extracts SLF quantitative image features for fluorescent microscopy images. This code was a collaboration between Murphy lab (murphylab.web.cmu.edu) and the HPA Cell Atlas (proteinatlas.org/humancell). Explanations for SLF features can be found here (murphylab.web.cmu.edu/services/SLF/features.html).

## Requirements 
This code requires MATLAB2016 or later
Your images must contain at least a nuclear channel. This is required for nuclear and cell segmentation
  - A cell marker is recommended, however in the absence of a cell marker the code will use Voronoi segmentation 

## Running the code
See *example_scripts* directory for an example setup and detailed documentation.

Don't forget to add the repository path to your MATLAB workspace before running the code. 
This can be done with 
>>addpath(genpath('/path/to/my/FeatureExtraction/'));

where the string argument is the path to where the FeatureExtraction code is on your machine. 

## License
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Major revision history
v0.1 - 2015 Elton Rexhepaj, Taraz Buck et al. 
v1.0 - 2016 Devin P. Sullivan: Fixed major bugs including; feature overwriting, datatype conversion, feature name uniqueness.
v2.0 - 06,Sept,2016 Devin P. Sullivan: Implemented active contour segmentation for nuclei. Prevents merging of nuclei when crowded.
v3.0 - 2017 Devin P. Sullivan updated code to run on zipped images. Moved from private bitbucket to public repo on github
