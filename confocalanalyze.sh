#!/bin/bash

# Usage: confocalanalyze.sh <filename> <magnification> <color: yellow or magenta>
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pid=$$
basedir=/tmp/IFanalyze

if [ $# -ne 3 ]
then
	echo "Missing or extra arguments, 3 needed"
	exit 120
fi

filename=$1
magnification=$2
special_color=$3

rm -rf $basedir/${pid}
mkdir -p $basedir/${pid}/In/in
mkdir -p $basedir/${pid}/Out
ln -s -t $basedir/${pid}/In/in ${filename}*.tif

# Call the script
/usr/local/bin/matlab -nodisplay -nodesktop -nosplash -r "cd $dir/features; try; [arr exit_status] = process_img('${basedir}/${pid}/In','${basedir}/${pid}/Out', $magnification, '$special_color'); catch; exit(122); end; exit(exit_status);"

exitstatus=$?
if [ $exitstatus -eq 0 ]
then
	mv ${basedir}/${pid}/Out/segmentation.png "${filename}segmentation.png"

	if [ -f ${basedir}/${pid}/Out/features.csv ];
	then
		mv ${basedir}/${pid}/Out/features.csv "${filename}features.csv"
		rm -rf $basedir/${pid}
		exit 0
	else
		exit 1
	fi
else
	exit $exitstatus
fi
