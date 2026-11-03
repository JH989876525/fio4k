#!/usr/bin/gnuplot
# Copyright (c) 2023 innodisk Crop.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# reset all setting for a new picture
reset

# 字體設定
set terminal png size 1024,600 font "Times_New_Roman,10"
# 設定分隔符號
set datafile separator ','

# setup basic setting of this picture
set xlabel "Time(ms)"
set ylabel "Speed(KiB/s)"

# setup the parameters of axes of this picture
set xtics nomirror
set ytics nomirror
set xrange [0:*]
set yrange [0:]
set grid

# job names, must match write_bw_log=fio_<job> in fio.cfg
SEQ = "SEQ1M_Q8T1_READ SEQ1M_Q8T1_WRITE SEQ1M_Q1T1_READ SEQ1M_Q1T1_WRITE"
RND = "RND4K_Q32T1_READ RND4K_Q32T1_WRITE RND4K_Q1T1_READ RND4K_Q1T1_WRITE"

# fio appends the job number to the log name: fio_<job>_bw.<N>.log
logf(n) = system(sprintf("ls fio_%s_bw*.log 2>/dev/null | head -n 1", n))

# 畫圖-summary
set key bottom right
set title "FIO sequential test"
set output "plot_fio_seq.png"
plot for [n in SEQ] logf(n) using 1:2 with lines title n

set title "FIO random test"
set output "plot_fio_rnd.png"
plot for [n in RND] logf(n) using 1:2 with lines title n

ALL = SEQ." ".RND

# 畫圖-each
set key off
do for [n in ALL] {
    set title "FIO ".n." test"
    set output "plot_fio_".n.".png"
    plot logf(n) using 1:2 with lines
}
