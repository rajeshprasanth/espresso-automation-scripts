#!/bin/bash
#
#echo "POSCAR"
#echo "1.000000"
#grep -A 3 CELL_PARAMETERS $1|tail -n 3
#echo "Sb Mg"
#echo "2 3"
#echo "Direct(5) [A2B3] "
#grep -A 5 ATOMIC_POSITIONS $1|tail -n 5|gawk {'print $2,$3,$4,$1'}

usage() {
	echo "Usage : qe2poscar [scf_inputfile] [POSCAR_label]"
}
#
export scf_inputfile=$1
export POSCAR_label=$2


if [ $# -ne 2 ] ; then
	usage
	exit 1;
fi

nat=`grep nat $scf_inputfile|gawk -F= {'print $2'}|xargs`
ntyp=`grep ntyp $scf_inputfile|gawk -F= {'print $2'}|xargs`

cat > $POSCAR_label << EOF
$POSCAR_label
1.000000
$(grep -A 3 CELL_PARAMETERS $scf_inputfile|tail -n 3)
$(grep -A $nat ATOMIC_POSITIONS $scf_inputfile|tail -n $nat|gawk {'print $1'}|uniq -c|gawk {'print $2'}|xargs)
$(grep -A $nat ATOMIC_POSITIONS $scf_inputfile|tail -n $nat|gawk {'print $1'}|uniq -c|gawk {'print $1'}|xargs)
DIRECT
$(grep -A $nat ATOMIC_POSITIONS $scf_inputfile|tail -n $nat|gawk {'print $2,$3,$4,$1'})
EOF
