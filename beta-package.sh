#!/bin/bash
# Sample cmd to run in terminal
# sh beta-package.sh
releasenotesurl="https://www.litepae.io/"

echo "====== Creating beta package ======="
sfdx force:package:beta:version:create -p "Lite Pae UP Ext" -x --releasenotesurl "$releasenotesurl" -c|| exit 1
echo "====== Done ======"