#!/bin/bash
# Copyright (c) 2023 innodisk Crop.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

DEV=${1:-/dev/sde}

sudo fio fio.cfg -filename="${DEV}"