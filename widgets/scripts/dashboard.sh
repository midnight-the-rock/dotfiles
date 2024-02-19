#!/bin/env bash

# This simply serves as a toggle for the dashboard window

if [[ $(eww active-windows | grep "dashboard") ]]; then
    eww close dashboard
else
    eww open dashboard
fi
