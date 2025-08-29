#!/bin/bash
# Copyright (c) 2023 innodisk Crop.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

DEVS=$(IFS=:; echo "$*")

echo "DEVS=${DEVS}"

fio fio.cfg -filename="${DEVS}"
