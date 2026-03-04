#!/bin/bash -e
# Copyright (c) 2026 innodisk Crop.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

TARGET="/dev/sde"
CONFIG_FILE="fio_behavior.cfg"
ROUND_TIME=3600
FIO_CMD="fio $CONFIG_FILE --filename=$TARGET --runtime=$ROUND_TIME"

if [ ! -b "$TARGET" ]; then
    echo "missing device $TARGET"
    exit 1
fi

while true; do
    CURRENT_HOUR=$(date +%H)
    CHANCE=$(( $RANDOM % 100 ))

    if [ "$CURRENT_HOUR" -ge 9 ] && [ "$CURRENT_HOUR" -lt 18 ]; then
        echo "核心工作時間 ($CURRENT_HOUR:00)"

        if [ $CHANCE -lt 80 ]; then
            echo ">> 觸發: 日常辦公 (80% 機率)"
            $FIO_CMD --section=daily_office > /dev/null
        elif [ $CHANCE -lt 90 ]; then
            echo ">> 觸發: 系統更新/安裝 (10% 機率)"
            $FIO_CMD --section=software_update > /dev/null
        elif [ $CHANCE -lt 95 ]; then
            echo ">> 警告: 模擬惡意檔案外傳 (5% 機率)"
            $FIO_CMD --section=malicious_copy > /dev/null
        else
            echo ">> 警告: 模擬勒索軟體加密 (5% 機率)"
            $FIO_CMD --section=ransomware > /dev/null
        fi
    else
        echo "非工作時間 ($CURRENT_HOUR:00)"

        if [ $CHANCE -lt 90 ]; then
            echo ">> 觸發: 系統閒置 (90% 機率)"
            $FIO_CMD --section=idle > /dev/null
        else
            echo ">> 觸發: 離峰時段系統自動更新 (10% 機率)"
            $FIO_CMD --section=software_update > /dev/null
        fi
    fi

    echo "完成一輪測試，等待下一小時或設定的週期..."
    sleep 10
done