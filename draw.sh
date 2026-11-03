#!/bin/bash
# Copyright (c) 2023 innodisk Crop.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

if ! ls fio_*_bw*.log >/dev/null 2>&1; then
    echo "no fio_*_bw*.log found, run ./run.sh <devices> first" >&2
    exit 1
fi

gnuplot plot_bw.plt
