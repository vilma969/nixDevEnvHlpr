#!/bin/bash

echo "Return path to open in VSCode: "
read -r path

code --user-data-dir=/tmp/vscodium-data --no-sandbox $path &