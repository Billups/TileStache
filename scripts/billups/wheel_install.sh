#!/bin/bash

WHEEL_DIR=$PWD/wheel

if [ "$#" -gt 0 ]; then
    WHEEL_DIR=$1
fi

echo "Installing wheel files to $WHEEL_DIR..."

pip wheel --no-deps -r requirements.txt --wheel-dir=$WHEEL_DIR
pip install --no-deps -t vendor -r requirements.txt --upgrade --use-wheel --no-index --find-links=$WHEEL_DIR
