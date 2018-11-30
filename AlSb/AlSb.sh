#!/bin/bash
#
#
#

#
# arg 1 -> alat
# arg 2 -> functionals
#
gen_func_nsm_nvdw() {
alat=$1
for func in "pz" "pbe"; do
cat > AlSb-scf-$func-nsm-nvdw.in << EOF
&CONTROL
	       title = 'AlSb-$alat-$func-nsm-nvdw'
         calculation = 'scf'
        restart_mode = 'from_scratch'
              outdir = './AlSb-$alat-$func-nsm-nvdw'
	  pseudo_dir = '/usr/share/espresso/pseudo/'
	   verbosity = 'high'
       etot_conv_thr = 1.0D-8 
       forc_conv_thr = 1.0D-6 
	     tstress = .true.
             tprnfor = .true.
/

&SYSTEM
               ibrav = 2
                   A = $alat
                 nat = 2
                ntyp = 2
             ecutwfc = 60
             ecutrho = 720
/

&ELECTRONS
            conv_thr = 1.0D-12
    electron_maxstep = 5000
    diago_cg_maxiter = 5000
     diagonalization = 'cg'
/

ATOMIC_SPECIES
Al   26.981   Al.$func-n-rrkjus_psl.1.0.0.UPF 
Sb  121.760   Sb.$func-dn-rrkjus_psl.1.0.0.UPF

ATOMIC_POSITIONS {crystal}
Al 0.00000 0.00000 0.00000
Sb 0.25000 0.25000 0.25000

K_POINTS {automatic}
9 9 9  0 0 0
EOF
done
}



gen_func_nsm_vdw() {
alat=$1
for func in "pz" "pbe"; do
cat > AlSb-scf-$func-nsm-vdw.in << EOF
&CONTROL
	       title = 'AlSb-$alat-$func-nsm-vdw'
         calculation = 'scf'
        restart_mode = 'from_scratch'
              outdir = './AlSb-$alat-$func-nsm-vdw'
	  pseudo_dir = '/usr/share/espresso/pseudo/'
	   verbosity = 'high'
       etot_conv_thr = 1.0D-8 
       forc_conv_thr = 1.0D-6 
	     tstress = .true.
             tprnfor = .true.
/

&SYSTEM
               ibrav = 2
                   A = $alat
                 nat = 2
                ntyp = 2
             ecutwfc = 60
             ecutrho = 720
           input_dft = 'vdW-DF'
/

&ELECTRONS
            conv_thr = 1.0D-12
    electron_maxstep = 5000
    diago_cg_maxiter = 5000
     diagonalization = 'cg'
/

ATOMIC_SPECIES
Al   26.981   Al.$func-n-rrkjus_psl.1.0.0.UPF 
Sb  121.760   Sb.$func-dn-rrkjus_psl.1.0.0.UPF

ATOMIC_POSITIONS {crystal}
Al 0.00000 0.00000 0.00000
Sb 0.25000 0.25000 0.25000

K_POINTS {automatic}
9 9 9  0 0 0
EOF
done
}



gen_func_sm_nvdw() {
alat=$1
for func in "pz" "pbe"; do
cat > AlSb-scf-$func-sm-nvdw.in << EOF
&CONTROL
	       title = 'AlSb-$alat-$func-sm-nvdw'
         calculation = 'scf'
        restart_mode = 'from_scratch'
              outdir = './AlSb-$alat-$func-sm-nvdw'
	  pseudo_dir = '/usr/share/espresso/pseudo/'
	   verbosity = 'high'
       etot_conv_thr = 1.0D-8 
       forc_conv_thr = 1.0D-6 
	     tstress = .true.
             tprnfor = .true.
/

&SYSTEM
               ibrav = 2
                   A = $alat
                 nat = 2
                ntyp = 2
             ecutwfc = 60
             ecutrho = 720
         occupations = 'smearing'
            smearing = 'm-v'
             degauss = 0.030
/

&ELECTRONS
            conv_thr = 1.0D-12
    electron_maxstep = 5000
    diago_cg_maxiter = 5000
     diagonalization = 'cg'
/

ATOMIC_SPECIES
Al   26.981   Al.$func-n-rrkjus_psl.1.0.0.UPF 
Sb  121.760   Sb.$func-dn-rrkjus_psl.1.0.0.UPF

ATOMIC_POSITIONS {crystal}
Al 0.00000 0.00000 0.00000
Sb 0.25000 0.25000 0.25000

K_POINTS {automatic}
9 9 9  0 0 0
EOF
done
}



gen_func_sm_vdw() {
alat=$1
for func in "pz" "pbe"; do
cat > AlSb-scf-$func-sm-vdw.in << EOF
&CONTROL
	       title = 'AlSb-$alat-$func-sm-vdw'
         calculation = 'scf'
        restart_mode = 'from_scratch'
              outdir = './AlSb-$alat-$func-sm-vdw'
	  pseudo_dir = '/usr/share/espresso/pseudo/'
	   verbosity = 'high'
       etot_conv_thr = 1.0D-8 
       forc_conv_thr = 1.0D-6 
	     tstress = .true.
             tprnfor = .true.
/

&SYSTEM
               ibrav = 2
                   A = $alat
                 nat = 2
                ntyp = 2
             ecutwfc = 60
             ecutrho = 720
         occupations = 'smearing'
            smearing = 'm-v'
             degauss = 0.030
           input_dft = 'vdW-DF'
/

&ELECTRONS
            conv_thr = 1.0D-12
    electron_maxstep = 5000
    diago_cg_maxiter = 5000
     diagonalization = 'cg'
/

ATOMIC_SPECIES
Al   26.981   Al.$func-n-rrkjus_psl.1.0.0.UPF 
Sb  121.760   Sb.$func-dn-rrkjus_psl.1.0.0.UPF

ATOMIC_POSITIONS {crystal}
Al 0.00000 0.00000 0.00000
Sb 0.25000 0.25000 0.25000

K_POINTS {automatic}
9 9 9  0 0 0
EOF
done
}


gen_func_nsm_nvdw 6.3233
gen_func_nsm_vdw 6.3233
gen_func_sm_nvdw 6.3233
gen_func_sm_vdw 6.3233
