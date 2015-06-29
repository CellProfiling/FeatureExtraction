#!/bin/bash
#PBS -N train_classifier_using_cyclin -l nodes=1:ppn=1
##PBS -l walltime=50:00:00
##PBS -l walltime=200:00:00
#PBS -l walltime=2000:00:00
#PBS -q model1
##PBS -l mppmem=unlimited
#PBS -l mppmem=16g
##PBS -l mppmem=24g
##PBS -l mppmem=36g
cd $PBS_O_WORKDIR

/usr/local/bin/matlab -nosplash -nodisplay -nodesktop -r "try; train_classifier_using_cyclin; catch err; err, err.message, for m=1:length(err.stack), err.stack(m), end, end; exit"

