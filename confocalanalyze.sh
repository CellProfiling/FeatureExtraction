#!/bin/bash

# Usage: confocalanalyze.sh <filename> <resolution> <color: yellow or magenta>
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pid=$$
basedir=/tmp/IFanalyze

if [ $# -ne 8 ]
then
	echo "Missing or extra arguments, 8 needed"
	exit 120
fi

filename=$1
resolution=$2
special_color=$3
datadir=$4
override=$5
runcellcycle=$6
pattern=$7
mstype=$8

outnameprefix=`basename ${filename}`
analyzedir=${basedir}/${pid}

rm -rf ${analyzedir}
mkdir -p ${analyzedir}/In/in
mkdir -p ${analyzedir}/Out
cp -t ${analyzedir}/In/in ${filename}*.tif
ret=$?
if [ $ret -ne 0 ]
then
	cp -t ${analyzedir}/In/in ${filename}*.tif.gz
	ret=$?
	if [ $ret -ne 0 ]
	then
		exit 122
	fi
	gunzip ${analyzedir}/In/in/*.tif.gz
fi

# Call the script
/usr/local/bin/matlab -nodisplay -nodesktop -nosplash -singleCompThread -r "cd $dir; featextraction('$dir', '$analyzedir', $resolution, '$special_color', $override, $runcellcycle, '$pattern', '$mstype');"


exitstatus=$?

if [ $exitstatus -eq 0 -o $exitstatus -eq 123 ]
then
	mkdir --mode=775 -p $datadir
	cp "${analyzedir}/Out/in/in_segmentation.png.gz" "${datadir}/${outnameprefix}segmentation.png.gz"
	if [ -f ${analyzedir}/Out/in/in_features.csv ]
	then
		mv ${analyzedir}/Out/in/in_features.csv "${analyzedir}/Out/in/${outnameprefix}features.csv"
		gzip -f "${analyzedir}/Out/in/${outnameprefix}features.csv"
		cp "${analyzedir}/Out/in/${outnameprefix}features.csv.gz" "${datadir}/${outnameprefix}features.csv.gz"
		ex=$?
		if [ $ex -ne 0 ]
		then
			exitstatus=5
		fi
	else
		exitstatus=1
	fi
fi

if [ $exitstatus -eq 0 -a $runcellcycle -eq 1 ]
then
	if [ -f ${analyzedir}/Out/in/in_ccPred.csv ];
	then
		set -e
		cp ${analyzedir}/Out/in/in_ccPred.csv "${datadir}/${outnameprefix}ccPred.csv"
		cp ${analyzedir}/Out/in/in_var.csv "${datadir}/${outnameprefix}var.csv"
		set +e
	else
		exitstatus=123
	fi
fi

if [ $exitstatus -eq 0 -o $exitstatus -eq 123 ]
then
	chmod 664 "${datadir}/${outnameprefix}"*
fi

rm -rf ${analyzedir}
exit $exitstatus
