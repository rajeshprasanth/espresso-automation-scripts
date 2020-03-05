#!/bin/bash
#
# Created on Thu Jun  6 09:07:59 IST 2019
#
#
# 
DOPING_TYPE=$1
DOPING_CONC_FILE=$2
TEMPERATURE_START=$3
TEMPERATURE_INCR=$4
TEMPERATURE_END=$5
NSCF_FILE_OUT=$6
SYS_NAME=$7
#
export DOPING_TYPE
export DOPING_CONC_FILE
export TEMPERATURE_START
export TEMPERATURE_INCR
export TEMPERATURE_END
export NSCF_FILE_OUT
export SYS_NAME
#
export numargs=$#
#
if [ $numargs -ne 7 ] ; then
    echo "Usage :: transport_calc.sh [DOPING_TYPE] [DOPING_CONC_FILE] [TEMPERATURE_START] [TEMPERATURE_INCR] [TEMPERATURE_END] [NSCF_FILE_OUT] [SYS_NAME]"
    exit 1;
fi

for temperature in $(seq $TEMPERATURE_START $TEMPERATURE_INCR $TEMPERATURE_END); do

    mkdir -p $DOPING_TYPE-$temperature/
    cp $DOPING_CONC_FILE $DOPING_TYPE-$temperature/
    cp $NSCF_FILE_OUT $DOPING_TYPE-$temperature/
    cd $DOPING_TYPE-$temperature/
    qe2boltz.py $SYS_NAME pw 1e7 0 $NSCF_FILE_OUT
    #pwd
    sed -i s/"800.0 50.0"/"$temperature  $temperature"/g *intrans
    sed -i s/TETRA/HISTO/g *intrans
    echo "0 0 0 0 0" >> *intrans
    echo "$(wc -l $DOPING_CONC_FILE|cut -d" " -f1 )" >> *intrans
    gawk {'printf "%G ",$1'} $DOPING_CONC_FILE >> *intrans 
    BoltzTraP BoltzTraP.def > BoltzTraP.out 2> BoltzTraP.err
    cd ..
   
done
