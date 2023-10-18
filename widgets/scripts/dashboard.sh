#!/bin/env bash

# This simply serves as a toggle for the dashboard window

[[ $(eww windows | grep "dashboard") == "*dashboard" ]] && eww close dashboard || eww open dashboard
