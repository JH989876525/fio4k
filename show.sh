#!/bin/bash
# Copyright (c) 2026 innodisk Corp.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# print the average bandwidth of every fio_<TEST>_{READ,WRITE}_bw.<N>.log as a table

# job names in the order of fio.cfg, fall back to alphabetical order of logs
TESTS=$(grep -oP '^\[\K\w+(?=_(READ|WRITE)\])' fio.cfg 2>/dev/null | awk '!s[$0]++')

if ! ls fio_*_bw*.log >/dev/null 2>&1; then
    echo "no fio_*_bw*.log found, run ./run.sh <devices> first" >&2
    exit 1
fi

# average bandwidth(KiB/s, column 2) of the log -> MB/s, "-" if no log
avg() {
    local f
    f=$(ls fio_"$1"_"$2"_bw*.log 2>/dev/null | head -n 1)
    [ -n "$f" ] && awk -F, '{s+=$2; n++} END {if (n) printf "%.2f", s/n*1024/1e6; else printf "-"}' "$f" || echo -n "-"
}

# colors only when writing to a terminal
if [ -t 1 ]; then
    BOLD=$'\e[1m'; CYAN=$'\e[36m'; GREEN=$'\e[32m'; YELLOW=$'\e[33m'; RST=$'\e[0m'
else
    BOLD=; CYAN=; GREEN=; YELLOW=; RST=
fi

line() { printf '%s\n' "${CYAN}+--------------------+--------------+--------------+${RST}"; }

# row <name style> <name> <read style> <read> <write style> <write>
# pad first, then color, so escape codes do not break the alignment
row() {
    printf '%s| %s%-18s%s | %s%12s%s | %s%12s%s |%s\n' \
        "${CYAN}" "$1" "$2" "${RST}${CYAN}" "$3" "$4" "${RST}${CYAN}" "$5" "$6" "${RST}${CYAN}" "${RST}"
}

line
row "${BOLD}" "Test" "${BOLD}${GREEN}" "Read(MB/s)" "${BOLD}${YELLOW}" "Write(MB/s)"
line
for t in $TESTS; do
    row "${BOLD}" "$t" "${GREEN}" "$(avg "$t" READ)" "${YELLOW}" "$(avg "$t" WRITE)"
done
line
