#!/bin/bash
# 
# Created on Wed Jun 12 08:44:37 IST 2019
#
#
SCF_INPUT=$1
SYS_NAME=$2
KPATH_FILE=$3
NQ1=$4
NQ2=$5
NQ3=$6
#
export SCF_INPUT
export SYS_NAME
export KPATH_FILE
export NQ1
export NQ2
export NQ3

#
export numargs=$#
#
if [ $numargs -ne 6 ] ; then
    echo "Usage :: run_phonon_disp.sh [SCF_INPUT] [SYS_NAME] [KPATH_FILE] [NQ1] [NQ2] [NQ3]"
    exit 1;
fi
#
cat > $SYS_NAME.ph_disp.$NQ1.$NQ2.$NQ3.in << EOF
$SYS_NAME.ph_disp.$NQ1.$NQ2.$NQ3.in
&inputph
   $(grep outdir $SCF_INPUT)
   $(grep prefix $SCF_INPUT)
    epsil = .true.
    ldisp = .true.
      nq1 = $NQ1
      nq2 = $NQ2
      nq3 = $NQ3 
   fildyn = '$SYS_NAME.ph_disp.$NQ1.$NQ2.$NQ3.dynmat',
   tr2_ph = 1.0d-14,
/
EOF


cat > $SYS_NAME.ph_q2r.$NQ1.$NQ2.$NQ3.in << EOF
&input
    fildyn = '$SYS_NAME.ph_disp.$NQ1.$NQ2.$NQ3.dynmat',
      zasr = 'simple'
     flfrc = '$SYS_NAME.$NQ1.$NQ2.$NQ3.fc'
/
EOF

cat > $SYS_NAME.ph_matdyn_disp.$NQ1.$NQ2.$NQ3.in << EOF
&input
               asr = 'simple',
             flfrc = '$SYS_NAME.$NQ1.$NQ2.$NQ3.fc'
             flfrq = '$SYS_NAME.$NQ1.$NQ2.$NQ3.freq.disp.dat'
    q_in_band_form = .true. 
 /
EOF
cat $KPATH_FILE|tail -n +2 >> $SYS_NAME.ph_matdyn_disp.$NQ1.$NQ2.$NQ3.in

cat >  $SYS_NAME.ph_matdyn_dos.$NQ1.$NQ2.$NQ3.in << EOF
 &input
                asr = 'simple'
              flfrc = '$SYS_NAME.$NQ1.$NQ2.$NQ3.fc'
              flfrq = '$SYS_NAME.$NQ1.$NQ2.$NQ3.freq.dos.dat'
                dos = .true.,
              fldos = '$SYS_NAME.$NQ1.$NQ2.$NQ3.dos.dat'
             deltaE = 1,
                nk1 = 20,
                nk2 = 20,
                nk3 = 20
 /
EOF



