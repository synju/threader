#!/bin/bash

set -e # Exit on error

sudo cp threader.py threader
sudo chmod +x threader
sudo cp threader /usr/local/bin/

echo "Installation successful!"
