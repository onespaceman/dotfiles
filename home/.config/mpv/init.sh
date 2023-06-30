#! /usr/bin/env bash
dir=$(dirname "$0")

rm -rf $dir/scripts/uosc_shared
wget -P /tmp/ "https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip"
unzip -u /tmp/uosc.zip -d $dir/
rm -f /tmp/uosc.zip
wget -NP $dir/scripts https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.lua
