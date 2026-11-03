#!/bin/bash
# Copyright (c) 2023 innodisk Crop.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

DEVS=$(IFS=:; echo "$*")

echo "DEVS=${DEVS}"

# remove logs of previous run, so draw.sh only plots this run
rm -f fio_*_bw*.log fio_result.log

# per-job bandwidth logs (fio_<JOB>_bw.<N>.log) are written by write_bw_log in fio.cfg
fio fio.cfg -filename="${DEVS}" --output=fio_result.log 2>&1
fio_rc=$?
cat fio_result.log
exit ${fio_rc}
