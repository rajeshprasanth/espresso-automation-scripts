#!/bin/bash
#
# Created on Wed Jun 12 14:26:24 IST 2019
# Author: Rajesh Prashanth
#-----------------------------------------------------------------------------------
#
VCRELAX_IN=$1
VCRELAX_OUT=$2
SCF_IN=$3
SCF_OUT=$4
$SYS_NAME=$5
#
export VCRELAX_IN
export VCRELAX_OUT
export SCF_IN
export SCF_OUT
export SYS_NAME
#
export numargs=$#
#
if [ $numargs -ne 5 ] ; then
    echo "Usage :: run_postproc_struct.sh [VCRELAX_IN] [VCRELAX_OUT] [SCF_IN SCF_OUT] [SYS_NAME]"
    exit 1;
fi
#
#--------------------------------------------------------------------------------------------------------
# Extracting coordinates from $VCRELAX_OUT files to XCrySDen (XSF) Format
#--------------------------------------------------------------------------------------------------------
#
pwo2xsf --inicoor $VCRELAX_OUT > $SYS_NAME.initial.xsf
pwo2xsf --optcoor $VCRELAX_OUT > $SYS_NAME.final.xsf
pwo2xsf --animxsf $VCRELAX_OUT > $SYS_NAME.relax.anim.axsf
#
#--------------------------------------------------------------------------------------------------------
# printing XSF files to png/jpeg files
#--------------------------------------------------------------------------------------------------------
#
cat > print_xsf.tcl << EOF
scripting::open --xyz $env(XCRYSDEN_TOPDIR)/examples/XYZ/mol1.xyz


EOF
