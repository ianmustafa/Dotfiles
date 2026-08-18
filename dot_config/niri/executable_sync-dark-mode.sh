#!/bin/bash
MODE=$(gsettings get org.gnome.desktop.interface color-scheme)
gsettings set org.freedesktop.appearance color-scheme "$MODE"
