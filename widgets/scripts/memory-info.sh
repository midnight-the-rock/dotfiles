#!/bin/env bash

used_memory="$(free -m | grep "Mem:" | awk '{ print $3 }')"
total_memory="$(free -m | grep "Mem:" | awk '{ print $2 }')"

awk "BEGIN { print ($used_memory / $total_memory) * 100 }"
