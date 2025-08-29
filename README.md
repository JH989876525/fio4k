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
./run.sh /dev/sda /dev/sdb /dev/sdc /dev/sdd
```
- Modify `runtime` in [fio.cfg](fio.cfg) to change testing time, default 60 secound.

# How to draw
```bash
./draw.sh
```
- Only support single device test