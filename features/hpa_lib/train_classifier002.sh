#!/bin/bash
#PBS -N train_classifier002 -l nodes=1:ppn=1
#PBS -l walltime=2000:00:00
#PBS -q model1
####PBS -l mppmem=16g
###PBS -l mppmem=24g
#PBS -l mem=16g
##PBS -l mem=24g
cd $PBS_O_WORKDIR

/usr/local/bin/matlab -nosplash -nodisplay -nodesktop -r "try; train_classifier002; catch err; err, err.message, for m=1:length(err.stack), err.stack(m), end, end; exit"

