#!/bin/bash
#
# Created on Sun May 12 07:32:11 IST 2019
#

usage() {
	echo "Usage : genpdos.sh [scf_inputfile] [system_name]"
}
#
export scf_inputfile=$1
export system_name=$2

if [ $# -ne 2 ] ; then
	usage
	exit 1;
fi

cat > $system_name.projwfc.in << EOF
&projwfc
    $(grep outdir $scf_inputfile),
    Emin = -100.0
    Emax=100.0
    DeltaE=0.1
    lsym = .true.
    filproj = '$system_name.pdos.dat'
/
EOF
