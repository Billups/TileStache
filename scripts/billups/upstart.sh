#!/bin/bash
set -xe

eval "$(pyenv init -)"

if [ -z "`pyenv versions | sed -n '/2.7/p' | xargs -r`" ]; then
    pyenv install 2.7
fi

pyenv local 2.7

exec env PYTHONPATH=./vendor bin/gunicorn -c gunicorn.py "TileStache:WSGITileServer('tilestache.cfg')"
