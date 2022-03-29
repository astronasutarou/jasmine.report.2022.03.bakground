#!/usr/bin/env gnuplot

set terminal pdfcairo size 16cm,9cm font 'Ubuntu,12'
set output 'histogram.pdf'

set datafile sep comma

set xr [5e-18:2e-12]
set yr [1e0:3e6]
set log x
set log y
set xtics format ''
set ytics format '10^{% L}'
unset label

set lmargin 8
set tmargin 1
set bmargin 1
set rmargin 1

array fname = [\
    '../data/hst_11671_04_wfc3_ir_f127m_drz.csv', \
    '../data/hst_11671_05_wfc3_ir_f127m_drz.csv', \
    '../data/hst_11671_06_wfc3_ir_f127m_drz.csv', \
    '../data/hst_12182_46_wfc3_ir_f127m_drz.csv', \
    '../data/hst_12182_47_wfc3_ir_f127m_drz.csv', \
    '../data/hst_12182_48_wfc3_ir_f127m_drz.csv', \
    '../data/hst_12182_a6_wfc3_ir_f127m_drz.csv', \
    '../data/hst_12182_a7_wfc3_ir_f127m_drz.csv' ]
array object = [\
    'Arches', 'Quintuplet', 'SGRA', \
    'MW-NSC-V35', 'MW-NSC-V43', 'MW-NSC-V38-COPY-1', \
    'MW-NSC-V37', 'MW-NSC-V41' ]

do for [n=1:8] {
    fn=fname[n]
    on=object[n]
    set multiplot
    set size 1,0.45
    set origin 0,0.55
    set xtics format ''
    stats [0:1e6][0:1e8] fn u 2:($1*$2) name 'F127M' nooutput
    p127M = F127M_max_y/F127M_max_x
    p127M_L = floor(log10(p127M))
    p127M_l = p127M/10**p127M_L
    set arrow 1 from p127M,1 to p127M,1e6 nohead dt (12,4) lc rgb 'coral'
    set label 3 sprintf('%.2f{\327}10^{%d}', p127M_l, p127M_L) \
        left at p127M,1e6 offset 0.5,-0.3
    plot fn u 1:2 w histeps \
        t sprintf('%s F127M', on)
    set origin 0,0.12
    set xtics format '% h'
    unit = '(J&,s^{-1}&,m^{-2}&,{\265}m^{-1}&,arcsec^{-2})'
    set label 1 sprintf('Energy Flux Density %s', unit) \
        center at screen 0.5,0.0 offset 0,1 font ',16'
    set label 2 'Number of Pixels' \
        center at screen 0.0,0.5 offset 1,0 rot by 90 font ',16'
    stats [0:1e6][0:1e8]  fn u 3:($1*$3) name 'F139M' nooutput
    p139M = F139M_max_y/F139M_max_x
    p139M_L = floor(log10(p139M))
    p139M_l = p139M/10**p139M_L
    set arrow 1 from p139M,1 to p139M,1e6 nohead dt (12,4) lc rgb 'coral'
    set label 3 sprintf('%.2f{\327}10^{%d}', p139M_l, p139M_L) \
        left at p139M,1e6 offset 0.5,-0.3
    plot fn u 1:3 lc 2 w histeps \
        t sprintf('%s F139M', on)
    unset multiplot
    print p127M, p139M
}

unset output
print F139M_max_y/F139M_max_x
