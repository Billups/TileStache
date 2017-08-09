#!/bin/sh

/usr/sbin/nginx -c /etc/nginx/nginx.conf & \
exec gunicorn -c gunicorn/config.py "TileStache:WSGITileServer('tilestache.cfg')"
