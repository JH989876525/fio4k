<!--
 Copyright (c) 2025 innodisk Crop.
 
 This software is released under the MIT License.
 https://opensource.org/licenses/MIT
-->

# Requirement
- fio
- gnuplot

# How to run
```bash
./run.sh /dev/sda
```
- Test cases follow CrystalDiskMark, see [fio.cfg](fio.cfg). Change `runtime` to set the test time (default 60 seconds).
- Logs: `fio_*_bw*.log` (bandwidth) and `fio_result.log` (fio summary).

# How to show
```bash
./show.sh   # print the average speed table
./draw.sh   # draw charts to plot_fio_*.png
```
- Only support single device test

# How to clean
```bash
./clean.sh
```
