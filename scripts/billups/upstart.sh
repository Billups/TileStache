#!/bin/bash
set -e

eval "$(pyenv init -)"

if [ -z "`pyenv versions | sed -n '/2.7.13/p' | xargs -r`" ]; then
    pyenv install 2.7.13
fi

pyenv local 2.7.13

exec env PYTHONPATH=./vendor gunicorn/gunicorn -c gunicorn/config.py "TileStache:WSGITileServer('tilestache.cfg')"
