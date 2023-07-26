#!/usr/bin/gnuplot
# Copyright (c) 2023 innodisk Crop.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# reset all setting for a new picture
reset

# setup basic setting of this picture
set xlabel "Time(ms)"
set ylabel "Speed(KiB/s)"

# setup the parameters of axes of this picture
set xtics nomirror
set ytics nomirror
set xrange [0:60000]
set yrange [0:]

# 字體設定
set terminal png font " Times_New_Roman,10 "
# 設定分隔符號
set datafile separator ','
# 圖例位置
set key bottom right


# 畫圖-summary
set title "FIO test"
set output "plot_fio.png"
plot \
'fio_read_bw.1.log' using 1:2 axes x1y1 with line title 'read', \
'fio_write_bw.2.log' using 1:2 axes x1y1 with line title 'write', \
'fio_rw_bw.3.log' using 1:2 axes x1y1 with line title 'rw', \
'fio_randread_bw.4.log' using 1:2 axes x1y1 with line title 'randread', \
'fio_randwrite_bw.5.log' using 1:2 axes x1y1 with line title 'randwrite', \
'fio_randrw_bw.6.log' using 1:2 axes x1y1 with line title 'randrw'

# 畫圖-each
set key off
set title "FIO read test"
set output "plot_fio_read.png"
plot 'fio_read_bw.1.log' using 1:2 axes x1y1 with line 

set title "FIO write test"
set output "plot_fio_write.png"
plot 'fio_write_bw.2.log' using 1:2 axes x1y1 with line 

set title "FIO rw test"
set output "plot_fio_rw.png"
plot 'fio_rw_bw.3.log' using 1:2 axes x1y1 with line 

set title "FIO randread test"
set output "plot_fio_randread.png"
plot 'fio_randread_bw.4.log' using 1:2 axes x1y1 with line 

set title "FIO randwrite test"
set output "plot_fio_randwrite.png"
plot 'fio_randwrite_bw.5.log' using 1:2 axes x1y1 with line 

set title "FIO randrw test"
set output "plot_fio_randrw.png"
plot 'fio_randrw_bw.6.log' using 1:2 axes x1y1 with line 